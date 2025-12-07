"""
Pydantic schemas for pricing module

Request and response models for pricing endpoints.
"""

from pydantic import BaseModel, Field
from typing import Optional, List
from enum import Enum
from datetime import datetime


class PricingRule(str, Enum):
    """Type of pricing rule applied"""
    CUSTOMER_OVERRIDE = "CUSTOMER_OVERRIDE"
    TIER_PRICING = "TIER_PRICING"
    VOLUME_DISCOUNT = "VOLUME_DISCOUNT"
    PROMOTIONAL_DISCOUNT = "PROMOTIONAL_DISCOUNT"
    BASE_PRICE = "BASE_PRICE"


class CustomerTier(str, Enum):
    """Customer tier classification"""
    PLATINUM = "PLATINUM"
    GOLD = "GOLD"
    SILVER = "SILVER"
    BRONZE = "BRONZE"
    REGULAR = "REGULAR"


class PriceCalculationRequest(BaseModel):
    """Request to calculate customer-specific price"""
    product_id: str
    customer_id: str
    location_id: str
    quantity: int = Field(ge=1, description="Quantity to purchase")
    
    class Config:
        json_schema_extra = {
            "example": {
                "product_id": "PROD-001",
                "customer_id": "CUST-1234",
                "location_id": "LOC-MAIN",
                "quantity": 50
            }
        }


class PriceCalculationResponse(BaseModel):
    """Response with calculated price"""
    product_id: str
    customer_id: str
    quantity: int
    
    # Pricing details
    base_price: float = Field(description="Base unit price")
    final_price: float = Field(description="Final unit price after discounts")
    total_amount: float = Field(description="Total amount for quantity")
    
    # Applied discounts
    pricing_rule: PricingRule
    discount_percentage: Optional[float] = None
    discount_amount: Optional[float] = None
    
    # Additional info
    customer_tier: Optional[CustomerTier] = None
    savings: float = Field(description="Total savings vs base price")
    
    # Metadata
    calculated_at: datetime = Field(default_factory=datetime.utcnow)


class BulkPriceRequest(BaseModel):
    """Request to calculate prices for multiple products"""
    customer_id: str
    location_id: str
    items: List[dict] = Field(description="List of {product_id, quantity}")


class BulkPriceResponse(BaseModel):
    """Response with prices for multiple products"""
    customer_id: str
    items: List[PriceCalculationResponse]
    total_amount: float
    total_savings: float


class DiscountRule(BaseModel):
    """Discount rule configuration"""
    product_id: Optional[str] = None
    min_quantity: int
    discount_percentage: float
    valid_from: datetime
    valid_to: datetime
    active: bool = True
