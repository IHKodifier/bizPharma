"""
Batch Service

Implements FEFO (First Expiry, First Out) logic and expiry management.
"""

from typing import List, Optional
from datetime import datetime, date, timedelta

from .schemas import (
    BatchInfo,
    FEFOSelectionResponse,
    ExpiryAlertLevel,
    ExpiryDashboardResponse
)


class BatchService:
    """
    Batch and expiry management service
    
    Key features:
    - FEFO (First Expiry, First Out) allocation
    - Expiry alerts with severity levels
    - Batch tracking and monitoring
    """
    
    # Alert thresholds (in days)
    CRITICAL_THRESHOLD = 30
    WARNING_THRESHOLD = 90
    ATTENTION_THRESHOLD = 180
    
    async def select_batches_fefo(
        self,
        product_id: str,
        location_id: str,
        quantity_needed: int
    ) -> FEFOSelectionResponse:
        """
        Select batches using FEFO logic
        
        Selects batches in order of expiry date (earliest first).
        Ensures no expired batches are selected.
        
        Args:
            product_id: Product to select batches for
            location_id: Location/store
            quantity_needed: Quantity required
            
        Returns:
            FEFOSelectionResponse with selected batches
        """
        
        # TODO: Query ProductBatch and InventoryLevel from Firebase Data Connect
        # Mock batch data
        available_batches = [
            {
                "batch_id": "BATCH-001",
                "quantity": 50,
                "mfg_date": date(2024, 1, 1),
                "expiry_date": date(2025, 6, 1),  # Expires in ~6 months
            },
            {
                "batch_id": "BATCH-002",
                "quantity": 100,
                "mfg_date": date(2024, 3, 1),
                "expiry_date": date(2025, 9, 1),  # Expires in ~9 months
            },
            {
                "batch_id": "BATCH-003",
                "quantity": 75,
                "mfg_date": date(2024, 6, 1),
                "expiry_date": date(2026, 12, 1),  # Expires in ~24 months
            },
        ]
        
        # Filter out expired batches
        today = date.today()
        valid_batches = [
            b for b in available_batches 
            if b["expiry_date"] > today
        ]
        
        # Sort by expiry date (FEFO - earliest first)
        sorted_batches = sorted(valid_batches, key=lambda x: x["expiry_date"])
        
        # Select batches to fulfill quantity
        selected = []
        remaining_qty = quantity_needed
        
        for batch_data in sorted_batches:
            if remaining_qty <= 0:
                break
            
            # Calculate how much to take from this batch
            qty_from_batch = min(batch_data["quantity"], remaining_qty)
            
            # Create batch info
            days_to_expiry = (batch_data["expiry_date"] - today).days
            
            batch_info = BatchInfo(
                batch_id=batch_data["batch_id"],
                product_id=product_id,
                quantity=qty_from_batch,
                manufacturing_date=batch_data["mfg_date"],
                expiry_date=batch_data["expiry_date"],
                days_to_expiry=days_to_expiry,
                alert_level=self._get_alert_level(days_to_expiry)
            )
            
            selected.append(batch_info)
            remaining_qty -= qty_from_batch
        
        # Calculate results
        total_allocated = sum(b.quantity for b in selected)
        fully_allocated = total_allocated >= quantity_needed
        shortage = max(0, quantity_needed - total_allocated)
        
        return FEFOSelectionResponse(
            product_id=product_id,
            batches_selected=selected,
            total_quantity=total_allocated,
            fully_allocated=fully_allocated,
            shortage=shortage
        )
    
    async def get_expiry_dashboard(
        self,
        location_id: Optional[str] = None
    ) -> ExpiryDashboardResponse:
        """
        Get expiry dashboard with alert counts
        
        Returns counts and details of batches by expiry severity.
        """
        
        # TODO: Query all batches from database
        # Mock data
        all_batches = [
            {"batch_id": "BATCH-A", "qty": 10, "expiry": date.today() + timedelta(days=15), "value": 1500},
            {"batch_id": "BATCH-B", "qty": 25, "expiry": date.today() + timedelta(days=45), "value": 3750},
            {"batch_id": "BATCH-C", "qty": 50, "expiry": date.today() + timedelta(days=120), "value": 7500},
            {"batch_id": "BATCH-D", "qty": 100, "expiry": date.today() + timedelta(days=365), "value": 15000},
        ]
        
        today = date.today()
        critical = []
        warning = []
        attention = []
        items = []
        
        for batch in all_batches:
            days_to_expiry = (batch["expiry"] - today).days
            alert_level = self._get_alert_level(days_to_expiry)
            
            batch_info = BatchInfo(
                batch_id=batch["batch_id"],
                product_id="PROD-X",  # Mock
                quantity=batch["qty"],
                manufacturing_date=today - timedelta(days=365),  # Mock
                expiry_date=batch["expiry"],
                days_to_expiry=days_to_expiry,
                alert_level=alert_level
            )
            
            items.append(batch_info)
            
            if alert_level == ExpiryAlertLevel.CRITICAL:
                critical.append(batch)
            elif alert_level == ExpiryAlertLevel.WARNING:
                warning.append(batch)
            elif alert_level == ExpiryAlertLevel.ATTENTION:
                attention.append(batch)
        
        total_at_risk = sum(b["value"] for b in critical + warning)
        
        return ExpiryDashboardResponse(
            critical_batches=len(critical),
            warning_batches=len(warning),
            attention_batches=len(attention),
            total_value_at_risk=total_at_risk,
            items=sorted(items, key=lambda x: x.days_to_expiry)
        )
    
    def _get_alert_level(self, days_to_expiry: int) -> ExpiryAlertLevel:
        """Determine alert level based on days to expiry"""
        if days_to_expiry < self.CRITICAL_THRESHOLD:
            return ExpiryAlertLevel.CRITICAL
        elif days_to_expiry < self.WARNING_THRESHOLD:
            return ExpiryAlertLevel.WARNING
        elif days_to_expiry < self.ATTENTION_THRESHOLD:
            return ExpiryAlertLevel.ATTENTION
        else:
            return ExpiryAlertLevel.OK
