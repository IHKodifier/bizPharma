"""
Pydantic schemas for financial module
"""

from pydantic import BaseModel, Field
from typing import Optional, List
from datetime import datetime
from enum import Enum


class FinancialEntryType(str, Enum):
    """Type of financial entry"""
    DEBIT = "DEBIT"
    CREDIT = "CREDIT"


class TransactionType(str, Enum):
    """Transaction types that trigger journal entries"""
    SALE = "SALE"
    PURCHASE = "PURCHASE"
    PAYMENT = "PAYMENT"
    RECEIPT = "RECEIPT"
    ADJUSTMENT = "ADJUSTMENT"


class JournalEntryRequest(BaseModel):
    """Request to create journal entry"""
    transaction_type: TransactionType
    transaction_id: str
    amount: float
    description: Optional[str] = None


class JournalEntryLine(BaseModel):
    """Single line in journal entry"""
    account_code: str
    account_name: str
    entry_type: FinancialEntryType
    amount: float
    description: Optional[str] = None


class JournalEntryResponse(BaseModel):
    """Auto-generated journal entry"""
    journal_id: str
    transaction_type: TransactionType
    transaction_id: str
    total_amount: float
    lines: List[JournalEntryLine]
    created_at: datetime = Field(default_factory=datetime.utcnow)
    balanced: bool = Field(description="Debits equal credits")


class TaxCalculationRequest(BaseModel):
    """Request to calculate tax"""
    subtotal: float
    tax_rate: float = Field(ge=0, le=100, description="Tax percentage")
    location_id: str


class TaxCalculationResponse(BaseModel):
    """Tax calculation result"""
    subtotal: float
    tax_rate: float
    tax_amount: float
    total: float
