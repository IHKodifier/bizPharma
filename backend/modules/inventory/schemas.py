"""
Pydantic schemas for inventory module
"""

from pydantic import BaseModel, Field
from typing import Optional, List
from datetime import datetime, date
from enum import Enum


class ExpiryAlertLevel(str, Enum):
    """Expiry alert severity"""
    CRITICAL = "CRITICAL"  # < 30 days
    WARNING = "WARNING"    # 30-90 days
    ATTENTION = "ATTENTION"  # 90-180 days
    OK = "OK"             # > 180 days


class BatchInfo(BaseModel):
    """Product batch information"""
    batch_id: str
    product_id: str
    product_name: Optional[str] = None
    quantity: int
    manufacturing_date: date
    expiry_date: date
    days_to_expiry: int
    alert_level: ExpiryAlertLevel


class FEFOSelectionRequest(BaseModel):
    """Request to select batch using FEFO"""
    product_id: str
    location_id: str
    quantity_needed: int


class FEFOSelectionResponse(BaseModel):
    """FEFO batch selection result"""
    product_id: str
    batches_selected: List[BatchInfo]
    total_quantity: int
    fully_allocated: bool
    shortage: int = Field(description="Quantity short if not fully allocated")


class ExpiryDashboardResponse(BaseModel):
    """Expiry dashboard statistics"""
    critical_batches: int  # < 30 days
    warning_batches: int   # 30-90 days
    attention_batches: int # 90-180 days
    total_value_at_risk: float
    items: List[BatchInfo]


class StockAdjustmentRequest(BaseModel):
    """Request to adjust stock levels"""
    product_id: str
    location_id: str
    batch_id: str
    quantity_change: int = Field(description="Positive for increase, negative for decrease")
    reason: str


class StockAdjustmentResponse(BaseModel):
    """Stock adjustment result"""
    success: bool
    message: str
    new_quantity: int
