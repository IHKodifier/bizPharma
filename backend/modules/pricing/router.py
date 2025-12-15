"""
Pricing Router

FastAPI endpoints for pricing operations.
"""

from fastapi import APIRouter, Depends, HTTPException, status
from typing import Dict, List

from core.security import get_current_user
from .schemas import (
    PriceCalculationRequest,
    PriceCalculationResponse,
    BulkPriceRequest,
    BulkPriceResponse
)
from .pricing_engine import PricingEngine


router = APIRouter()
pricing_engine = PricingEngine()


@router.post("/calculate", response_model=PriceCalculationResponse)
async def calculate_price(
    request: PriceCalculationRequest,
    current_user: Dict = Depends(get_current_user)
):
    """
    Calculate customer-specific price for a product
    
    Applies pricing rules in order of priority:
    1. Customer-specific override
    2. Tier-based pricing (Platinum/Gold/Silver/Bronze)
    3. Volume discounts
    4. Promotional discounts
    5. Base price
    
    Returns detailed pricing breakdown with applied discounts.
    """
    try:
        result = await pricing_engine.calculate_price(
            product_id=request.product_id,
            customer_id=request.customer_id,
            location_id=request.location_id,
            quantity=request.quantity
        )
        
        return result
    
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Price calculation failed: {str(e)}"
        )


@router.post("/calculate-bulk", response_model=BulkPriceResponse)
async def calculate_bulk_prices(
    request: BulkPriceRequest,
    current_user: Dict = Depends(get_current_user)
):
    """
    Calculate prices for multiple products at once
    
    Useful for calculating total cart value or generating quotes.
    """
    try:
        items_response = []
        total_amount = 0.0
        total_savings = 0.0
        
        for item in request.items:
            price_result = await pricing_engine.calculate_price(
                product_id=item.get("product_id"),
                customer_id=request.customer_id,
                location_id=request.location_id,
                quantity=item.get("quantity", 1)
            )
            
            items_response.append(price_result)
            total_amount += price_result.total_amount
            total_savings += price_result.savings
        
        return BulkPriceResponse(
            customer_id=request.customer_id,
            items=items_response,
            total_amount=total_amount,
            total_savings=total_savings
        )
    
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Bulk price calculation failed: {str(e)}"
        )


@router.get("/tiers")
async def get_tier_discounts(current_user: Dict = Depends(get_current_user)):
    """
    Get tier discount configuration
    
    Returns discount percentages for each customer tier.
    """
    return {
        "tiers": {
            "PLATINUM": {"discount": 15.0, "description": "15% on all products"},
            "GOLD": {"discount": 10.0, "description": "10% on all products"},
            "SILVER": {"discount": 5.0, "description": "5% on all products"},
            "BRONZE": {"discount": 2.0, "description": "2% on all products"},
            "REGULAR": {"discount": 0.0, "description": "Standard pricing"}
        }
    }


@router.get("/customer/{customer_id}/tier")
async def get_customer_tier(
    customer_id: str,
    current_user: Dict = Depends(get_current_user)
):
    """
    Get customer's current tier classification
    
    Returns tier and applicable discount percentage.
    """
    # TODO: Query actual customer tier from database
    tier = await pricing_engine._get_customer_tier(customer_id)
    discount = pricing_engine.TIER_DISCOUNTS.get(tier, 0.0)
    
    return {
        "customer_id": customer_id,
        "tier": tier,
        "discount_percentage": discount
    }
