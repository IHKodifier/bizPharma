"""
Pydantic schemas for procurement module

Request and response models for procurement endpoints.
"""

from pydantic import BaseModel, Field
from typing import List, Optional
from datetime import datetime
from enum import Enum


class MatchingStatus(str, Enum):
    """Invoice matching status"""
    AUTO_APPROVED = "AUTO_APPROVED"
    REQUIRES_REVIEW = "REQUIRES_REVIEW"
    REJECTED = "REJECTED"


class VarianceType(str, Enum):
    """Type of variance in matching"""
    QUANTITY = "QUANTITY"
    PRICE = "PRICE"
    UNORDERED_ITEM = "UNORDERED_ITEM"


class VarianceSeverity(str, Enum):
    """Severity level of variance"""
    LOW = "LOW"
    MEDIUM = "MEDIUM"
    HIGH = "HIGH"


class Variance(BaseModel):
    """Represents a variance found during matching"""
    type: VarianceType
    product_id: str
    product_name: Optional[str] = None
    
    # Quantity variance
    po_quantity: Optional[float] = None
    grn_quantity: Optional[float] = None
    invoice_quantity: Optional[float] = None
    
    # Price variance
    po_price: Optional[float] = None
    invoice_price: Optional[float] = None
    
    # Calculated fields
    variance_amount: float = Field(description="Absolute variance amount")
    variance_percentage: float = Field(description="Percentage variance")
    severity: VarianceSeverity


class MatchingRequest(BaseModel):
    """Request to perform 3-way matching"""
    purchase_order_id: str = Field(description="PO ID to match")
    goods_receipt_id: str = Field(description="GRN ID to match")
    invoice_id: str = Field(description="Supplier invoice ID to match")
    
    class Config:
        json_schema_extra = {
            "example": {
                "purchase_order_id": "PO-2024-001",
                "goods_receipt_id": "GRN-2024-005",
                "invoice_id": "INV-SUPPLIER-123"
            }
        }


class MatchingResponse(BaseModel):
    """Response from 3-way matching"""
    status: MatchingStatus
    variances: List[Variance]
    total_variance_amount: float
    recommendation: str
    auto_approved: bool
    
    # Metadata
    matched_at: datetime = Field(default_factory=datetime.utcnow)
    matched_by: Optional[str] = None


class ApprovalRequest(BaseModel):
    """Request to approve a requisition or PO"""
    document_id: str
    approved: bool
    notes: Optional[str] = None


class ApprovalResponse(BaseModel):
    """Response after approval"""
    success: bool
    message: str
    new_status: str
