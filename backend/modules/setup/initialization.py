"""
setup_initialization.py
"""
import uuid
from typing import Dict
from firebase_admin import auth
from datetime import datetime
from ..schemas import SetupInitializeRequest, BusinessProfileResponse

async def initialize_business(user_id: str, data: SetupInitializeRequest) -> BusinessProfileResponse:
    """
    Initialize new business for user
    1. Generate business_id
    2. Set custom claims for user (business_id, role=admin)
    3. (Mock) Create business record
    """
    business_id = str(uuid.uuid4())
    
    # Set custom claims so subsequent requests work
    # This is REAL logic, not mock
    auth.set_custom_user_claims(user_id, {
        'business_id': business_id,
        'role': 'admin',
        'tier': 'free'
    })
    
    return BusinessProfileResponse(
        business_id=business_id,
        business_name=data.business_name,
        email=data.email or "user@example.com",
        phone=data.phone,
        created_at=datetime.utcnow(),
        updated_at=datetime.utcnow(),
        status="active",
        subscription_tier="free"
    )
