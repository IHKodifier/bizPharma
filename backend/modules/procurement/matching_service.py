"""
3-Way Matching Service

Implements invoice matching logic: PO vs GRN vs Supplier Invoice.
Detects quantity and price variances with configurable tolerance levels.
"""

from typing import List, Dict, Optional
from decimal import Decimal

from .schemas import (
    Variance,
    VarianceType,
    VarianceSeverity,
    MatchingStatus,
    MatchingResponse
)


class MatchingService:
    """
    3-Way Matching Service
    
    Compares Purchase Order, Goods Receipt, and Supplier Invoice to detect:
    - Quantity variances (GRN vs Invoice)
    - Price variances (PO vs Invoice)
    - Unordered items (items in invoice but not in PO)
    """
    
    # Configuration
    TOLERANCE_PERCENTAGE = 2.0  # Auto-approve if variance < 2%
    HIGH_VARIANCE_THRESHOLD = 1000.0  # PKR amount for HIGH severity
    MEDIUM_VARIANCE_THRESHOLD = 500.0  # PKR amount for MEDIUM severity
    
    async def perform_matching(
        self,
        purchase_order_id: str,
        goods_receipt_id: str,
        invoice_id: str,
        user_id: Optional[str] = None
    ) -> MatchingResponse:
        """
        Perform 3-way matching between PO, GRN, and Invoice
        
        Args:
            purchase_order_id: Purchase order ID
            goods_receipt_id: Goods receipt note ID
            invoice_id: Supplier invoice ID
            user_id: User performing the matching
            
        Returns:
            MatchingResponse with status, variances, and recommendation
        """
        
        variances = []
        
        # TODO: Fetch actual data from Firebase Data Connect
        # For now, using mock data structure
        
        # Mock PO data
        po_items = {
            "PROD-001": {"quantity": 100, "unit_price": 50.0},
            "PROD-002": {"quantity": 50, "unit_price": 120.0},
        }
        
        # Mock GRN data
        grn_items = {
            "PROD-001": {"quantity": 98, "batch": "BATCH-A"},  # 2 units short
            "PROD-002": {"quantity": 50, "batch": "BATCH-B"},
        }
        
        # Mock Invoice data
        invoice_items = {
            "PROD-001": {"quantity": 98, "unit_price": 51.0},  # Price variance
            "PROD-002": {"quantity": 50, "unit_price": 120.0},
            "PROD-003": {"quantity": 10, "unit_price": 200.0},  # Unordered item!
        }
        
        # Step 1: Check for quantity variances (GRN vs Invoice)
        for product_id, invoice_item in invoice_items.items():
            grn_qty = grn_items.get(product_id, {}).get("quantity", 0)
            invoice_qty = invoice_item["quantity"]
            
            if grn_qty != invoice_qty:
                variance_amt = abs(grn_qty - invoice_qty) * invoice_item["unit_price"]
                variance_pct = abs(grn_qty - invoice_qty) / max(grn_qty, invoice_qty) * 100
                
                variances.append(Variance(
                    type=VarianceType.QUANTITY,
                    product_id=product_id,
                    grn_quantity=grn_qty,
                    invoice_quantity=invoice_qty,
                    variance_amount=variance_amt,
                    variance_percentage=variance_pct,
                    severity=self._determine_severity(variance_amt)
                ))
        
        # Step 2: Check for price variances (PO vs Invoice)
        for product_id, invoice_item in invoice_items.items():
            po_price = po_items.get(product_id, {}).get("unit_price", 0)
            invoice_price = invoice_item["unit_price"]
            
            if po_price > 0 and po_price != invoice_price:
                variance_amt = abs(po_price - invoice_price) * invoice_item["quantity"]
                variance_pct = abs(po_price - invoice_price) / po_price * 100
                
                variances.append(Variance(
                    type=VarianceType.PRICE,
                    product_id=product_id,
                    po_price=po_price,
                    invoice_price=invoice_price,
                    variance_amount=variance_amt,
                    variance_percentage=variance_pct,
                    severity=self._determine_severity(variance_amt)
                ))
        
        # Step 3: Check for unordered items (in invoice but not in PO)
        for product_id in invoice_items.keys():
            if product_id not in po_items:
                invoice_item = invoice_items[product_id]
                variance_amt = invoice_item["quantity"] * invoice_item["unit_price"]
                
                variances.append(Variance(
                    type=VarianceType.UNORDERED_ITEM,
                    product_id=product_id,
                    invoice_quantity=invoice_item["quantity"],
                    invoice_price=invoice_item["unit_price"],
                    variance_amount=variance_amt,
                    variance_percentage=100.0,  # 100% variance (not ordered at all)
                    severity=VarianceSeverity.HIGH
                ))
        
        # Calculate total variance
        total_variance = sum(v.variance_amount for v in variances)
        
        # Determine status and recommendation
        return self._make_decision(variances, total_variance, user_id)
    
    def _determine_severity(self, variance_amount: float) -> VarianceSeverity:
        """Determine variance severity based on amount"""
        if variance_amount >= self.HIGH_VARIANCE_THRESHOLD:
            return VarianceSeverity.HIGH
        elif variance_amount >= self.MEDIUM_VARIANCE_THRESHOLD:
            return VarianceSeverity.MEDIUM
        else:
            return VarianceSeverity.LOW
    
    def _make_decision(
        self,
        variances: List[Variance],
        total_variance: float,
        user_id: Optional[str]
    ) -> MatchingResponse:
        """Make approval decision based on variances"""
        
        if not variances:
            return MatchingResponse(
                status=MatchingStatus.AUTO_APPROVED,
                variances=[],
                total_variance_amount=0.0,
                recommendation="Perfect match! All quantities and prices match exactly. Safe to approve for payment.",
                auto_approved=True,
                matched_by=user_id
            )
        
        # Check if all variances are within tolerance
        if self._all_within_tolerance(variances):
            high_severity_count = sum(1 for v in variances if v.severity == VarianceSeverity.HIGH)
            
            return MatchingResponse(
                status=MatchingStatus.AUTO_APPROVED,
                variances=variances,
                total_variance_amount=total_variance,
                recommendation=f"Minor variances within {self.TOLERANCE_PERCENTAGE}% tolerance. Total variance: PKR {total_variance:.2f}. Safe to auto-approve.",
                auto_approved=True,
                matched_by=user_id
            )
        
        # Requires manual review
        high_variances = [v for v in variances if v.severity == VarianceSeverity.HIGH]
        medium_variances = [v for v in variances if v.severity == VarianceSeverity.MEDIUM]
        
        recommendation_parts = []
        if high_variances:
            recommendation_parts.append(f"{len(high_variances)} HIGH severity variance(s)")
        if medium_variances:
            recommendation_parts.append(f"{len(medium_variances)} MEDIUM severity variance(s)")
        
        recommendation = f"Manual review required. {' and '.join(recommendation_parts)}. Total variance: PKR {total_variance:.2f}. Investigate discrepancies before approval."
        
        return MatchingResponse(
            status=MatchingStatus.REQUIRES_REVIEW,
            variances=variances,
            total_variance_amount=total_variance,
            recommendation=recommendation,
            auto_approved=False,
            matched_by=user_id
        )
    
    def _all_within_tolerance(self, variances: List[Variance]) -> bool:
        """Check if all variances are within acceptable tolerance"""
        return all(
            abs(v.variance_percentage) <= self.TOLERANCE_PERCENTAGE 
            for v in variances
        )
