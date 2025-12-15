"""
Financial Router

FastAPI endpoints for financial operations.
"""

from fastapi import APIRouter, Depends, HTTPException, status
from typing import Dict

from core.security import get_current_user
from .schemas import (
    JournalEntryRequest,
    JournalEntryResponse,
    TaxCalculationRequest,
    TaxCalculationResponse,
    TransactionType
)
from .journal_service import JournalService


router = APIRouter()
journal_service = JournalService()


@router.post("/journal-entries/generate", response_model=JournalEntryResponse)
async def generate_journal_entry(
    request: JournalEntryRequest,
    current_user: Dict = Depends(get_current_user)
):
    """
    Auto-generate journal entry for a transaction
    
    Supports: SALE, PURCHASE, PAYMENT transactions
    Implements double-entry bookkeeping (debits = credits)
    """
    try:
        if request.transaction_type == TransactionType.SALE:
            # For sales, need cost of goods (TODO: get from transaction)
            cost_of_goods = request.amount * 0.6  # Mock: 60% cost
            result = await journal_service.create_sale_entry(
                transaction_id=request.transaction_id,
                amount=request.amount,
                cost_of_goods=cost_of_goods
            )
        
        elif request.transaction_type == TransactionType.PURCHASE:
            result = await journal_service.create_purchase_entry(
                transaction_id=request.transaction_id,
                amount=request.amount
            )
        
        elif request.transaction_type == TransactionType.PAYMENT:
            result = await journal_service.create_payment_entry(
                transaction_id=request.transaction_id,
                amount=request.amount
            )
        
        else:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"Unsupported transaction type: {request.transaction_type}"
            )
        
        return result
    
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Journal entry generation failed: {str(e)}"
        )


@router.post("/tax/calculate", response_model=TaxCalculationResponse)
async def calculate_tax(
    request: TaxCalculationRequest,
    current_user: Dict = Depends(get_current_user)
):
    """
    Calculate tax for a transaction
    
    Returns subtotal, tax amount, and total.
    """
    tax_amount = request.subtotal * (request.tax_rate / 100)
    total = request.subtotal + tax_amount
    
    return TaxCalculationResponse(
        subtotal=request.subtotal,
        tax_rate=request.tax_rate,
        tax_amount=tax_amount,
        total=total
    )


@router.get("/accounts")
async def get_chart_of_accounts(current_user: Dict = Depends(get_current_user)):
    """Get simplified chart of accounts"""
    return {"accounts": journal_service.ACCOUNTS}
