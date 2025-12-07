"""
Location Setup Service

Handles location/store management.
"""

from typing import List, Optional
from datetime import datetime
import uuid

from ..schemas import (
    LocationCreate,
    LocationResponse
)


class LocationService:
    """
    Location management service
    """
    
    async def create_location(
        self,
        business_id: str,
        data: LocationCreate
    ) -> LocationResponse:
        """
        Create new location
        """
        # TODO: Create in Data Connect
        return LocationResponse(
            location_id=str(uuid.uuid4()),
            business_id=business_id,
            created_at=datetime.utcnow(),
            active=True,
            **data.model_dump(exclude={'operating_hours'})
        )
    
    async def get_locations(self, business_id: str) -> List[LocationResponse]:
        """
        Get all business locations
        """
        # TODO: Query Data Connect
        # Mock data
        return [
            LocationResponse(
                location_id="LOC-MAIN",
                business_id=business_id,
                name="Main Store",
                type="STORE",
                address="123 Pharma St",
                city="Karachi",
                state="Sindh",
                country="Pakistan",
                is_primary=True,
                created_at=datetime.utcnow()
            ),
            LocationResponse(
                location_id="LOC-WAREHOUSE",
                business_id=business_id,
                name="Central Warehouse",
                type="WAREHOUSE",
                address="456 Industrial Area",
                city="Karachi",
                state="Sindh",
                country="Pakistan",
                is_primary=False,
                created_at=datetime.utcnow()
            )
        ]
