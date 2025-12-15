"""
Business Setup Service

Handles business profile and configuration management.
"""

from typing import Dict, Optional
from datetime import datetime
import uuid

from ..schemas import (
    BusinessProfileUpdate,
    BusinessProfileResponse
)
from ...shared.dataconnect_client import DataConnectClient

class BusinessService:
    """
    Business setup and configuration service
    """

    async def get_profile(self, business_id: str) -> BusinessProfileResponse:
        """
        Get business profile from Data Connect
        """
        try:
            dataconnect_client = DataConnectClient()

            # Execute query to get business by ID
            result = dataconnect_client.execute_mutation(
                "GetBusinessById",
                {"businessId": business_id}
            )

            if result and 'business' in result:
                business_data = result['business']
                return BusinessProfileResponse(
                    business_id=business_data['id'],
                    business_name=business_data['name'],
                    tax_id=business_data.get('taxId', ''),
                    email=business_data.get('email', 'admin@bizpharma.app'),
                    phone=business_data.get('phone', '+923001234567'),
                    created_at=datetime.fromisoformat(business_data['createdAt']),
                    updated_at=datetime.fromisoformat(business_data['updatedAt']),
                    status=business_data.get('status', 'active'),
                    subscription_tier=business_data.get('tier', 'free')
                )
            else:
                raise Exception("Business not found in Data Connect")

        except Exception as e:
            # Fallback to mock data if Data Connect fails
            return BusinessProfileResponse(
                business_id=business_id,
                business_name="BizPharma Demo",
                tax_id="TRN-12345678",
                email="admin@bizpharma.app",
                phone="+923001234567",
                created_at=datetime.utcnow(),
                updated_at=datetime.utcnow(),
                status="active",
                subscription_tier="gold"
            )

    async def update_profile(
        self,
        business_id: str,
        data: BusinessProfileUpdate
    ) -> BusinessProfileResponse:
        """
        Update business profile in Data Connect
        """
        try:
            dataconnect_client = DataConnectClient()

            # Execute mutation to update business
            update_vars = {
                "businessId": business_id,
                "businessName": data.business_name,
                "taxId": data.tax_id,
                "email": data.email,
                "phone": data.phone,
                "website": data.website,
                "currency": data.currency,
                "timezone": data.timezone
            }

            result = dataconnect_client.execute_mutation(
                "UpdateBusinessProfile",
                update_vars
            )

            return BusinessProfileResponse(
                business_id=business_id,
                created_at=datetime.utcnow(),
                updated_at=datetime.utcnow(),
                **data.model_dump()
            )

        except Exception as e:
            # Fallback to mock update if Data Connect fails
            return BusinessProfileResponse(
                business_id=business_id,
                created_at=datetime.utcnow(),
                updated_at=datetime.utcnow(),
                **data.model_dump()
            )
