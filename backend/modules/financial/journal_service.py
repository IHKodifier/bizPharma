"""
Journal Entry Service

Auto-generates journal entries for financial transactions.
Implements double-entry bookkeeping.
"""

from typing import List
from datetime import datetime
import uuid

from .schemas import (
    JournalEntryResponse,
    JournalEntryLine,
    FinancialEntryType,
    TransactionType
)


class JournalService:
    """
    Automated journal entry generation service
    
    Creates double-entry bookkeeping entries for transactions.
    Ensures debits = credits (balanced entries).
    """
    
    # Chart of Accounts (simplified)
    ACCOUNTS = {
        "1000": "Cash",
        "1200": "Accounts Receivable",
        "1300": "Inventory",
        "2000": "Accounts Payable",
        "3000": "Owner's Equity",
        "4000": "Sales Revenue",
        "5000": "Cost of Goods Sold",
        "6000": "Operating Expenses",
    }
    
    async def create_sale_entry(
        self,
        transaction_id: str,
        amount: float,
        cost_of_goods: float
    ) -> JournalEntryResponse:
        """
        Generate journal entry for a sale
        
        Dr Cash/AR             [amount]
            Cr Sales Revenue           [amount]
        Dr COGS                [cost]
            Cr Inventory               [cost]
        """
        lines = [
            # Revenue entry
            JournalEntryLine(
                account_code="1000",
                account_name=self.ACCOUNTS["1000"],
                entry_type=FinancialEntryType.DEBIT,
                amount=amount,
                description="Cash from sale"
            ),
            JournalEntryLine(
                account_code="4000",
                account_name=self.ACCOUNTS["4000"],
                entry_type=FinancialEntryType.CREDIT,
                amount=amount,
                description="Sales revenue"
            ),
            # Cost entry
            JournalEntryLine(
                account_code="5000",
                account_name=self.ACCOUNTS["5000"],
                entry_type=FinancialEntryType.DEBIT,
                amount=cost_of_goods,
                description="Cost of goods sold"
            ),
            JournalEntryLine(
                account_code="1300",
                account_name=self.ACCOUNTS["1300"],
                entry_type=FinancialEntryType.CREDIT,
                amount=cost_of_goods,
                description="Inventory reduction"
            ),
        ]
        
        return self._build_entry(
            transaction_type=TransactionType.SALE,
            transaction_id=transaction_id,
            lines=lines
        )
    
    async def create_purchase_entry(
        self,
        transaction_id: str,
        amount: float
    ) -> JournalEntryResponse:
        """
        Generate journal entry for a purchase
        
        Dr Inventory           [amount]
            Cr Cash/AP                 [amount]
        """
        lines = [
            JournalEntryLine(
                account_code="1300",
                account_name=self.ACCOUNTS["1300"],
                entry_type=FinancialEntryType.DEBIT,
                amount=amount,
                description="Inventory purchased"
            ),
            JournalEntryLine(
                account_code="2000",
                account_name=self.ACCOUNTS["2000"],
                entry_type=FinancialEntryType.CREDIT,
                amount=amount,
                description="Accounts payable"
            ),
        ]
        
        return self._build_entry(
            transaction_type=TransactionType.PURCHASE,
            transaction_id=transaction_id,
            lines=lines
        )
    
    async def create_payment_entry(
        self,
        transaction_id: str,
        amount: float
    ) -> JournalEntryResponse:
        """
        Generate journal entry for payment to supplier
        
        Dr Accounts Payable    [amount]
            Cr Cash                    [amount]
        """
        lines = [
            JournalEntryLine(
                account_code="2000",
                account_name=self.ACCOUNTS["2000"],
                entry_type=FinancialEntryType.DEBIT,
                amount=amount,
                description="Payment to supplier"
            ),
            JournalEntryLine(
                account_code="1000",
                account_name=self.ACCOUNTS["1000"],
                entry_type=FinancialEntryType.CREDIT,
                amount=amount,
                description="Cash payment"
            ),
        ]
        
        return self._build_entry(
            transaction_type=TransactionType.PAYMENT,
            transaction_id=transaction_id,
            lines=lines
        )
    
    def _build_entry(
        self,
        transaction_type: TransactionType,
        transaction_id: str,
        lines: List[JournalEntryLine]
    ) -> JournalEntryResponse:
        """Build journal entry response and verify balance"""
        
        # Calculate totals
        total_debits = sum(
            line.amount for line in lines 
            if line.entry_type == FinancialEntryType.DEBIT
        )
        total_credits = sum(
            line.amount for line in lines 
            if line.entry_type == FinancialEntryType.CREDIT
        )
        
        # Verify balanced (debits = credits)
        balanced = abs(total_debits - total_credits) < 0.01  # Allow 1 cent rounding
        
        return JournalEntryResponse(
            journal_id=f"JE-{uuid.uuid4().hex[:8].upper()}",
            transaction_type=transaction_type,
            transaction_id=transaction_id,
            total_amount=total_debits,  # or total_credits (should be equal)
            lines=lines,
            balanced=balanced
        )
