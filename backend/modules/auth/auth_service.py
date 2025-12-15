"""
Authentication Service

Handles user registration, login, and Firebase user management via backend.
Backend creates and manages Firebase users for enhanced security.
"""

from firebase_admin import auth
from typing import Optional, Dict
import uuid

from config.firebase_config import firebase_config
from datetime import date
from core.dataconnect_client import data_connect_client

CREATE_BUSINESS_AND_ADMIN_MUTATION = """
mutation CreateBusinessAndAdmin(
  $businessId: UUID!
  $businessName: String!
  $userEmail: String!
  $userFirstName: String!
  $userLastName: String!
  $userMobile: String!
  $userProfilePhoto: String
  $authUid: String!
  $today: Date!
) @auth(level: PUBLIC) @transaction {
  business_insert(data: {
    id: $businessId
    name: $businessName
    tier: TRIAL
    subscriptionStartDate: $today
  })
  user_insert(data: {
    id: $authUid
    businessId: $businessId
    email: $userEmail
    firstName: $userFirstName
    lastName: $userLastName
    mobile: $userMobile
    profilePhoto: $userProfilePhoto
    role: BUSINESS_ADMIN
  })
}
"""


class AuthService:
    """
    Centralized authentication service
    
    Backend creates Firebase users and manages authentication.
    More secure than client-side Firebase Auth.
    Works with AppCheck for API protection.
    """
    
    async def register_user(
        self,
        email: str,
        password: str,
        first_name: str,
        last_name: str,
        phone: str,
        business_name: str,
        profile_photo: Optional[str] = None
    ) -> Dict:
        """
        Register new user via backend
        
        Steps:
        1. Create Firebase user
        2. Set custom claims (business_id, role)
        3. Create user in Data Connect
        4. Return custom token
        
        Args:
            email: User email
            password: User password (plain text, Firebase will hash)
            first_name: First name
            last_name: Last name
            phone: Phone number
            business_name: Business/pharmacy name
            
        Returns:
            Dict with user info and custom token
        """
        
        try:
            # Step 1: Create Firebase user
            firebase_user = auth.create_user(
                email=email,
                password=password,
                display_name=f"{first_name} {last_name}",
                email_verified=False  # Will send verification email
            )
            
            # Step 2: Generate business ID
            business_id = str(uuid.uuid4())
            
            # Step 3: Set custom claims
            auth.set_custom_user_claims(firebase_user.uid, {
                'business_id': business_id,
                'role': 'admin',  # First user is always admin
                'tier': 'trial'   # Start with trial tier
            })
            
            # Step 4: Create user in Data Connect
            await data_connect_client.execute_graphql(
                query=CREATE_BUSINESS_AND_ADMIN_MUTATION,
                operation_name="CreateBusinessAndAdmin",
                variables={
                    "businessId": business_id,
                    "businessName": business_name,
                    "userEmail": email,
                    "userFirstName": first_name,
                    "userLastName": last_name,
                    "userMobile": phone,
                    "userProfilePhoto": profile_photo,
                    "authUid": firebase_user.uid,
                    "today": str(date.today())
                }
            )
            
            # Step 5: Generate custom token for client
            custom_token = auth.create_custom_token(firebase_user.uid)
            
            # Step 6: Send verification email
            verification_link = auth.generate_email_verification_link(email)
            # TODO: Send email via your email service
            
            return {
                'uid': firebase_user.uid,
                'email': email,
                'first_name': first_name,
                'last_name': last_name,
                'business_id': business_id,
                'business_name': business_name,
                'custom_token': custom_token.decode('utf-8'),
                'email_verified': False,
                'verification_link': verification_link
            }
        
        except auth.EmailAlreadyExistsError:
            raise ValueError("Email already registered")
        except Exception as e:
            raise RuntimeError(f"Registration failed: {str(e)}")
    
    async def verify_password(
        self,
        email: str,
        password: str
    ) -> Dict:
        """
        Verify user credentials and generate token
        
        NOTE: Firebase Admin SDK doesn't have password verification.
        Options:
        1. Use Firebase REST API to verify password
        2. Use custom password storage (not recommended)
        3. Client signs in with Firebase, sends token to backend
        
        For now, returning error - will implement REST API approach.
        """
        # TODO: Implement Firebase REST API password verification
        # https://firebase.google.com/docs/reference/rest/auth#section-sign-in-email-password
        
        raise NotImplementedError(
            "Password verification via backend requires Firebase REST API. "
            "Use client-side sign-in and send ID token to backend, or implement REST API."
        )
    
    async def get_user_profile(self, uid: str) -> Dict:
        """
        Get user profile from Firebase and Data Connect
        
        Args:
            uid: Firebase user ID
            
        Returns:
            User profile with custom claims
        """
        try:
            # Get Firebase user
            firebase_user = auth.get_user(uid)
            
            # Get custom claims
            claims = firebase_user.custom_claims or {}
            
            # TODO: Get additional data from Data Connect
            # user_data = await get_user_from_database(uid)
            
            return {
                'uid': firebase_user.uid,
                'email': firebase_user.email,
                'display_name': firebase_user.display_name,
                'phone': firebase_user.phone_number,
                'email_verified': firebase_user.email_verified,
                'business_id': claims.get('business_id'),
                'role': claims.get('role'),
                'tier': claims.get('tier'),
                'created_at': firebase_user.user_metadata.creation_timestamp
            }
        
        except auth.UserNotFoundError:
            raise ValueError("User not found")
    
    async def send_password_reset(self, email: str) -> str:
        """
        Send password reset email
        
        Args:
            email: User email
            
        Returns:
            Password reset link
        """
        try:
            reset_link = auth.generate_password_reset_link(email)
            # TODO: Send email via your email service
            return reset_link
        
        except auth.UserNotFoundError:
            raise ValueError("Email not found")
    
    async def verify_id_token(self, id_token: str) -> Dict:
        """
        Verify Firebase ID token
        
        Args:
            id_token: Firebase ID token from client
            
        Returns:
            Decoded token with user info
        """
        try:
            decoded_token = auth.verify_id_token(id_token)
            return decoded_token
        except Exception as e:
            raise ValueError(f"Invalid token: {str(e)}")
