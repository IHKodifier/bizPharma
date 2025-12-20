"""
Security and Authentication

Provides Firebase token verification, user authentication, and role-based access control.
"""

from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from typing import Optional, List, Dict
from firebase_admin import auth

from config.firebase_config import firebase_config
from config.settings import settings


# HTTP Bearer token security scheme
# Use auto_error=False to allow manual handling of missing tokens (e.g. for debug bypass)
security = HTTPBearer(auto_error=False)


async def verify_firebase_token(
    credentials: Optional[HTTPAuthorizationCredentials] = Depends(security)
) -> Dict:
    """
    Verify Firebase ID token from Authorization header
    
    Args:
        credentials: HTTP Bearer credentials containing the token
        
    Returns:
        Dict: Decoded token data containing user information
        
    Raises:
        HTTPException: If token is invalid, expired, or verification fails
    """
    if not credentials:
        # No token provided
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Not authenticated",
            headers={"WWW-Authenticate": "Bearer"},
        )

    token = credentials.credentials
    
    try:
        # Verify token with Firebase Admin SDK
        # When FIREBASE_AUTH_EMULATOR_HOST is set (in DEV), this automatically connects to the emulator.
        decoded_token = auth.verify_id_token(token)
        
        return decoded_token
    
    except (auth.InvalidIdTokenError, auth.ExpiredIdTokenError, auth.RevokedIdTokenError) as e:
        detail_msg = "Invalid authentication token"
        if isinstance(e, auth.ExpiredIdTokenError):
            detail_msg = "Authentication token has expired"
        elif isinstance(e, auth.RevokedIdTokenError):
            detail_msg = "Authentication token has been revoked"

        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=detail_msg,
            headers={"WWW-Authenticate": "Bearer"},
        )
    
    except Exception as e:
        print(f"❌ AUTH ERROR: {type(e).__name__}: {str(e)}")
        
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=f"Authentication failed: {str(e)}",
            headers={"WWW-Authenticate": "Bearer"},
        )


async def get_current_user(
    token_data: Dict = Depends(verify_firebase_token)
) -> Dict:
    """
    Extract current user information from verified token
    
    Args:
        token_data: Decoded Firebase token
        
    Returns:
        Dict: User information including uid, email, email_verified
    """
    return {
        'uid': token_data.get('uid'),
        'email': token_data.get('email'),
        'email_verified': token_data.get('email_verified', False),
        'name': token_data.get('name'),
        'picture': token_data.get('picture'),
    }


async def get_optional_user(
    credentials: Optional[HTTPAuthorizationCredentials] = Depends(
        HTTPBearer(auto_error=False)
    )
) -> Optional[Dict]:
    """
    Get user if authenticated, None otherwise (for optional authentication)
    
    Args:
        credentials: Optional HTTP Bearer credentials
        
    Returns:
        Optional[Dict]: User information if authenticated, None otherwise
    """
    if not credentials:
        return None
    
    try:
        token_data = await verify_firebase_token(credentials)
        return await get_current_user(token_data)
    except HTTPException:
        return None


class RBACChecker:
    """
    Role-Based Access Control checker
    
    Verifies that the current user has required permissions to access a resource.
    """
    
    def __init__(self, required_permissions: List[str]):
        """
        Initialize RBAC checker
        
        Args:
            required_permissions: List of permission strings required (e.g., ["inventory:read", "inventory:write"])
        """
        self.required_permissions = required_permissions
    
    async def __call__(
        self,
        current_user: Dict = Depends(get_current_user)
    ) -> Dict:
        """
        Check if user has required permissions
        
        Args:
            current_user: Current authenticated user
            
        Returns:
            Dict: User information if authorized
            
        Raises:
            HTTPException: If user lacks required permissions
        """
        # TODO: Fetch user roles and permissions from database
        # For now, allowing all authenticated users
        # 
        # Implementation plan:
        # 1. Query user_roles table via Firebase Data Connect
        # 2. Get all permissions for user's roles
        # 3. Check if required_permissions ⊆ user_permissions
        # 4. Raise 403 if insufficient permissions
        
        user_uid = current_user.get('uid')
        
        # Placeholder: In production, query database for user permissions
        # user_permissions = await fetch_user_permissions(user_uid)
        # 
        # if not all(perm in user_permissions for perm in self.required_permissions):
        #     raise HTTPException(
        #         status_code=status.HTTP_403_FORBIDDEN,
        #         detail=f"Insufficient permissions. Required: {self.required_permissions}"
        #     )
        
        return current_user


def require_permissions(*permissions: str):
    """
    Decorator factory for requiring specific permissions
    
    Usage:
        @router.get("/inventory")
        async def get_inventory(user = Depends(require_permissions("inventory:read"))):
            ...
    
    Args:
        *permissions: Permission strings required
        
    Returns:
        Dependency: FastAPI dependency for permission checking
    """
    return Depends(RBACChecker(list(permissions)))
