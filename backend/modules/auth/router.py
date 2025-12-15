"""
Authentication Router

FastAPI endpoints for user authentication via backend.
Backend creates and manages Firebase users for enhanced security.
"""

from fastapi import APIRouter, HTTPException, status
from typing import Dict

from .schemas import (
    RegisterRequest,
    LoginRequest,
    AuthResponse,
    UserProfileResponse,
    PasswordResetRequest
)
from .auth_service import AuthService


router = APIRouter()
auth_service = AuthService()


@router.post("/register", response_model=AuthResponse)
async def register_user(request: RegisterRequest):
    """
    Register new user via backend
    
    Backend creates Firebase user and returns custom token.
    More secure than client-side Firebase Auth.
    
    Steps:
    1. Backend creates Firebase user
    2. Sets custom claims (business_id, role)
    3. Creates user in Data Connect
    4. Returns custom token for client
    
    Client then uses custom token to sign in to Firebase.
    """
    try:
        result = await auth_service.register_user(
            email=request.email,
            password=request.password,
            first_name=request.first_name,
            last_name=request.last_name,
            phone=request.phone,
            business_name=request.business_name,
            profile_photo=request.profile_photo
        )
        
        return AuthResponse(
            success=True,
            message="User registered successfully. Please verify your email.",
            user={
                'uid': result['uid'],
                'email': result['email'],
                'first_name': result['first_name'],
                'last_name': result['last_name'],
                'business_id': result['business_id'],
                'business_name': result['business_name']
            },
            id_token=result['custom_token'],
            expires_in=3600
        )
    
    except ValueError as e:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=str(e)
        )
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Registration failed: {str(e)}"
        )


@router.post("/login", response_model=AuthResponse)
async def login_user(request: LoginRequest):
    """
    Login user via backend
    
    NOTE: Currently not fully implemented.
    
    Recommended approach:
    1. Client signs in with Firebase (client-side)
    2. Client sends ID token to /verify-token
    3. Backend verifies and returns user profile
    
    Alternative: Implement Firebase REST API for password verification.
    """
    try:
        # This will raise NotImplementedError
        result = await auth_service.verify_password(
            email=request.email,
            password=request.password
        )
        
        return AuthResponse(
            success=True,
            message="Login successful",
            user=result,
            id_token=result.get('token')
        )
    
    except NotImplementedError as e:
        raise HTTPException(
            status_code=status.HTTP_501_NOT_IMPLEMENTED,
            detail=str(e)
        )
    except ValueError as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=str(e)
        )


@router.post("/verify-token")
async def verify_token(id_token: str):
    """
    Verify Firebase ID token
    
    Use this after client signs in with Firebase.
    Verifies token and returns user profile.
    """
    try:
        decoded_token = await auth_service.verify_id_token(id_token)
        
        return {
            'success': True,
            'message': 'Token valid',
            'user': decoded_token
        }
    
    except ValueError as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=str(e)
        )


@router.post("/password-reset")
async def request_password_reset(request: PasswordResetRequest):
    """
    Send password reset email
    
    Generates password reset link and sends email.
    """
    try:
        reset_link = await auth_service.send_password_reset(request.email)
        
        return {
            'success': True,
            'message': 'Password reset email sent',
            'reset_link': reset_link  # Remove in production, only send via email
        }
    
    except ValueError as e:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=str(e)
        )


@router.get("/profile/{uid}", response_model=UserProfileResponse)
async def get_user_profile(uid: str):
    """
    Get user profile by UID
    
    Returns Firebase user data and custom claims.
    """
    try:
        profile = await auth_service.get_user_profile(uid)
        
        return UserProfileResponse(
            uid=profile['uid'],
            email=profile['email'],
            first_name=profile.get('display_name', '').split()[0] if profile.get('display_name') else '',
            last_name=profile.get('display_name', '').split()[-1] if profile.get('display_name') else '',
            phone=profile.get('phone'),
            email_verified=profile['email_verified'],
            created_at=profile['created_at'],
            business_id=profile.get('business_id'),
            role=profile.get('role')
        )
    
    except ValueError as e:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=str(e)
        )
