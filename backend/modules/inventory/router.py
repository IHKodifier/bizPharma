"""
Inventory Router

FastAPI endpoints for inventory operations.
"""

from fastapi import APIRouter, Depends, HTTPException, status
from typing import Dict, Optional

from core.security import get_current_user
from .schemas import (
    FEFOSelectionRequest,
    FEFOSelectionResponse,
    ExpiryDashboardResponse,
    StockAdjustmentRequest,
    StockAdjustmentResponse
)
from .batch_service import BatchService


router = APIRouter()
batch_service = BatchService()


@router.post("/batches/fefo-select", response_model=FEFOSelectionResponse)
async def select_batches_fefo(
    request: FEFOSelectionRequest,
    current_user: Dict = Depends(get_current_user)
):
    """
    Select product batches using FEFO logic
    
    FEFO = First Expiry, First Out
    Critical for pharmacy operations to minimize waste.
    
    Returns batches in order of expiry date (earliest first).
    Excludes expired batches automatically.
    """
    try:
        result = await batch_service.select_batches_fefo(
            product_id=request.product_id,
            location_id=request.location_id,
            quantity_needed=request.quantity_needed
        )
        
        return result
    
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"FEFO selection failed: {str(e)}"
        )


@router.get("/expiry/dashboard", response_model=ExpiryDashboardResponse)
async def get_expiry_dashboard(
    location_id: Optional[str] = None,
    current_user: Dict = Depends(get_current_user)
):
    """
    Get expiry monitoring dashboard
    
    Returns:
    - Critical batches (< 30 days)
    - Warning batches (30-90 days)
    - Attention batches (90-180 days)
    - Total value at risk
    - Detailed batch list sorted by expiry
    """
    try:
        result = await batch_service.get_expiry_dashboard(location_id)
        return result
    
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Dashboard fetch failed: {str(e)}"
        )


@router.post("/stock/adjust", response_model=StockAdjustmentResponse)
async def adjust_stock(
    request: StockAdjustmentRequest,
    current_user: Dict = Depends(get_current_user)
):
    """
    Adjust stock levels (cycle count, damage, theft, etc.)
    
    Use positive quantity_change to increase,
    negative to decrease.
    """
    # TODO: Update InventoryLevel table via Firebase Data Connect
    # Mock response
    return StockAdjustmentResponse(
        success=True,
        message=f"Stock adjusted for batch {request.batch_id}. Reason: {request.reason}",
        new_quantity=100 + request.quantity_change  # Mock
    )


@router.get("/dashboard-stats")
async def get_inventory_stats(current_user: Dict = Depends(get_current_user)):
    """Get inventory dashboard statistics"""
    # TODO: Query real data from database
    return {
        "total_products": 1250,
        "total_value": 2475000.0,
        "low_stock_items": 15,
        "out_of_stock_items": 3,
        "expiring_soon": 8,
        "total_batches": 3420
    }
