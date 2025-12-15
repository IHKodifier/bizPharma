"""
Authentication Schemas

Request and response models for authentication endpoints.
"""

from pydantic import BaseModel, EmailStr, Field
from typing import Optional
from datetime import datetime


class RegisterRequest(BaseModel):
    """User registration request"""
    email: EmailStr
    password: str = Field(min_length=6, description="Minimum 6 characters")
    first_name: str = Field(min_length=1)
    last_name: str = Field(min_length=1)
    phone: str
    business_name: str
    profile_photo: Optional[str] = None
    
    class Config:
        json_schema_extra = {
            "example": {
                "email": "admin@pharmacy.com",
                "password": "SecurePass123",
                "first_name": "John",
                "last_name": "Doe",
                "phone": "+923001234567",
                "business_name": "ABC Pharmacy"
            }
        }


class LoginRequest(BaseModel):
    """User login request"""
    email: EmailStr
    password: str
    
    class Config:
        json_schema_extra = {
            "example": {
                "email": "admin@pharmacy.com",
                "password": "SecurePass123"
            }
        }


class AuthResponse(BaseModel):
    """Authentication response with token and user info"""
    success: bool
    message: str
    user: Optional[dict] = None
    id_token: Optional[str] = None
    refresh_token: Optional[str] = None
    expires_in: Optional[int] = None


class UserProfileResponse(BaseModel):
    """User profile information"""
    uid: str
    email: str
    first_name: str
    last_name: str
    phone: Optional[str] = None
    email_verified: bool
    created_at: datetime
    business_id: Optional[str] = None
    business_name: Optional[str] = None
    role: Optional[str] = None


class PasswordResetRequest(BaseModel):
    """Password reset request"""
    email: EmailStr


class PasswordChangeRequest(BaseModel):
    """Password change request"""
    old_password: str
    new_password: str = Field(min_length=6)
