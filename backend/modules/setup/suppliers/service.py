"""
Supplier Setup Service

Handles supplier management.
"""

from typing import List, Optional
from datetime import datetime
import uuid

from ..schemas import (
    SupplierCreate,
    SupplierResponse
)


class SupplierService:
    """
    Supplier management service
    """
    
    async def create_supplier(
        self,
        business_id: str,
        data: SupplierCreate
    ) -> SupplierResponse:
        """
        Create new supplier
        """
        # TODO: Create in Data Connect
        return SupplierResponse(
            supplier_id=str(uuid.uuid4()),
            business_id=business_id,
            created_at=datetime.utcnow(),
            active=True,
            rating=5.0,
            **data.model_dump()
        )
    
    async def get_suppliers(
        self,
        business_id: str,
        active_only: bool = True
    ) -> List[SupplierResponse]:
        """
        Get all business suppliers
        """
        # TODO: Query Data Connect
        # Mock data
        return [
            SupplierResponse(
                supplier_id="SUP-001",
                business_id=business_id,
                supplier_name="Global Pharma Distributors",
                contact_person="Ahmed Khan",
                email="orders@globalpharma.com",
                phone="+923001112233",
                payment_terms="NET30",
                created_at=datetime.utcnow(),
                active=True,
                rating=4.8,
                supplier_name_alias=None
            ),
            SupplierResponse(
                supplier_id="SUP-002",
                business_id=business_id,
                supplier_name="Local Meds Supply",
                contact_person="Bilal Ahmed",
                email="sales@localmeds.com",
                phone="+923214445566",
                payment_terms="CASH",
                created_at=datetime.utcnow(),
                active=True,
                rating=4.5,
                supplier_name_alias=None
            )
        ]
