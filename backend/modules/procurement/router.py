"""
Procurement Router

FastAPI endpoints for procurement operations including 3-way matching and approvals.
"""

from fastapi import APIRouter, Depends, HTTPException, status
from typing import Dict

from core.security import get_current_user, require_permissions
from .schemas import (
    MatchingRequest,
    MatchingResponse,
    ApprovalRequest,
    ApprovalResponse
)
from .matching_service import MatchingService


router = APIRouter()
matching_service = MatchingService()


@router.post("/invoices/match", response_model=MatchingResponse)
async def perform_invoice_matching(
    request: MatchingRequest,
    current_user: Dict = Depends(get_current_user)
):
    """
    Perform 3-way matching for invoice approval
    
   Compares:
    - Purchase Order vs Goods Receipt vs Supplier Invoice
    
    Detects:
    - Quantity variances
    - Price variances
    - Unordered items
    
    Returns auto-approval decision if variances are within tolerance (2%).
    """
    user_id = current_user.get('uid')
    
    try:
        result = await matching_service.perform_matching(
            purchase_order_id=request.purchase_order_id,
            goods_receipt_id=request.goods_receipt_id,
            invoice_id=request.invoice_id,
            user_id=user_id
        )
        
        return result
    
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Matching failed: {str(e)}"
        )


@router.post("/requisitions/approve", response_model=ApprovalResponse)
async def approve_requisition(
    request: ApprovalRequest,
    current_user: Dict = require_permissions("procurement:approve")
):
    """
    Approve or reject a purchase requisition
    
    Requires: procurement:approve permission
    """
    # TODO: Implement approval logic via Firebase Data Connect
    # Update requisition status in database
    
    return ApprovalResponse(
        success=True,
        message=f"Requisition {request.document_id} {'approved' if request.approved else 'rejected'}",
        new_status="APPROVED" if request.approved else "REJECTED"
    )


@router.post("/purchase-orders/approve", response_model=ApprovalResponse)
async def approve_purchase_order(
    request: ApprovalRequest,
    current_user: Dict = require_permissions("procurement:approve")
):
    """
    Approve or reject a purchase order
    
    Requires: procurement:approve permission
    """
    # TODO: Implement PO approval logic
    
    return ApprovalResponse(
        success=True,
        message=f"Purchase Order {request.document_id} {'approved' if request.approved else 'rejected'}",
        new_status="APPROVED" if request.approved else "REJECTED"
    )


@router.get("/dashboard-stats")
async def get_procurement_stats(
    current_user: Dict = Depends(get_current_user)
):
    """
    Get procurement dashboard statistics
    
    Returns summary of pending approvals, active POs, etc.
    """
    # TODO: Query Firebase Data Connect for actual stats
    
    return {
        "pending_requisitions": 5,
        "pending_pos": 3,
        "pending_invoices": 8,
        "total_variance_amount": 15234.50,
        "auto_approved_today": 12,
        "requires_review": 3
    }
