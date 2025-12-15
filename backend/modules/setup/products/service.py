"""
Product Setup Service

Handles product catalog management.
"""

from typing import List, Optional
from datetime import datetime
import uuid

from ..schemas import (
    ProductCreate,
    ProductResponse
)


class ProductService:
    """
    Product catalog management service
    """
    
    async def create_product(
        self,
        business_id: str,
        data: ProductCreate
    ) -> ProductResponse:
        """
        Create new product
        """
        # TODO: Create in Data Connect
        return ProductResponse(
            product_id=str(uuid.uuid4()),
            business_id=business_id,
            created_at=datetime.utcnow(),
            active=True,
            current_stock=data.initial_stock,
            **data.model_dump(exclude={'initial_stock'})
        )
    
    async def search_products(
        self,
        business_id: str,
        query: Optional[str] = None
    ) -> List[ProductResponse]:
        """
        Search products catalog
        """
        # TODO: Query Data Connect
        # Mock data
        return [
            ProductResponse(
                product_id="PROD-001",
                business_id=business_id,
                name="Panadol Extra",
                generic_name="Paracetamol + Caffeine",
                sku="PND-EXT-500",
                category="Pain Relief",
                uom="BOX",
                cost_price=450.0,
                selling_price=550.0,
                current_stock=150,
                created_at=datetime.utcnow(),
                active=True
            ),
            ProductResponse(
                product_id="PROD-002",
                business_id=business_id,
                name="Augmentin 625mg",
                generic_name="Amoxicillin + Clavulanic Acid",
                sku="AUG-625",
                category="Antibiotics",
                uom="STRIP",
                cost_price=280.0,
                selling_price=340.0,
                current_stock=50,
                created_at=datetime.utcnow(),
                active=True
            )
        ]
