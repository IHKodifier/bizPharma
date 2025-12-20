"""
setup_initialization.py
"""
import uuid
from typing import Dict
from firebase_admin import auth
from datetime import datetime
from .schemas import SetupInitializeRequest, BusinessProfileResponse
from ..shared.dataconnect_client import DataConnectClient

async def initialize_business(user_id: str, data: SetupInitializeRequest) -> BusinessProfileResponse:
    """
    Initialize new business for user
    1. Generate business_id
    2. Create business and user records in Cloud SQL via Data Connect
    3. Set custom claims for user (business_id, role=admin)
    """
    business_id = str(uuid.uuid4())

    # Create Data Connect client
    dataconnect_client = DataConnectClient()

    # Create business and admin user in Cloud SQL
    try:
        await dataconnect_client.create_business_and_admin(
            id_token=data.id_token,
            business_id=business_id,
            business_name=data.business_name,
            user_email=data.email or "user@example.com",
            user_first_name=data.first_name,
            user_last_name=data.last_name,
            user_mobile=data.phone,
            auth_uid=user_id,
            user_profile_photo=data.profile_photo
        )
    except Exception as e:
        print(f"❌ ONBOARDING ERROR: {str(e)}")
        raise Exception(f"Failed to create business records: {str(e)}")

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
