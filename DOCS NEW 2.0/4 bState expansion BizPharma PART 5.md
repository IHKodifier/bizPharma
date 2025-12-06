# bizPharma - States Expansion Design Brief (Part 5)

## Document Information

**Version**: 1.0  
**Date**: December 2024  
**Document**: Part 5 of States Expansion Series  
**Scope**: Inventory Operations  
**Coverage**: Stock Adjustments → Cycle Counts → Transfers → GRN → Audit Trails → Batch Operations  
**Platforms**: Mobile, Tablet, Desktop, Web  
**Themes**: Light & Dark (explicitly documented for each state)  
**Granularity**: Detailed with micro-interactions, animations, and platform variations

---

## What This Document Covers

This is **Part 5** focusing on:

1. ✅ Stock Adjustments & Corrections
2. ✅ Cycle Count Operations
3. ✅ Inter-Location Transfers
4. ✅ Goods Receiving (GRN)
5. ✅ Stock Movement Audit Trail
6. ✅ Batch Operations Management
7. ✅ Expiry Alert Actions
8. ✅ Inventory Valuation

**Previous Documents**:  
- **Part 1**: Landing Page, Authentication Flows  
- **Part 2**: Business Onboarding & Configuration  
- **Part 3**: POS & Inventory Setup  
- **Part 4**: Live POS Operations

**Next Document (Part 6)**: Reporting & Analytics

---

## Design System References

Building upon:
- **Part 1-4**: All previous patterns
- **Style Guide**: `/mnt/project/4_a_Style_Guide__bizPharma.md`
- **Feature Stories**: `/mnt/project/3__Feature_Stories_bizPharma.md`
- **Architecture**: `/mnt/project/2__High_Level_Architecture_bizPharma.md`

---

# 7. STOCK ADJUSTMENTS & CORRECTIONS

## 7.1 Stock Adjustment - Access & Overview

### State 7.1.1: Stock Adjustment Page - Desktop

**Access**: Inventory → Stock Adjustments

**Page Layout (Desktop 1280px+)**:
```
Header Section:
  - Height: 80px
  - Padding: 20px 24px
  - Background: Surface color
  - Border bottom: 1px solid outline
  
  Content:
    - Title: "Stock Adjustments", 28px Inter Semibold
    - Description: "Manually adjust inventory quantities and values"
    - Actions (right side):
      - "+ New Adjustment" button: Primary, 48px height
      - "Adjustment History" button: Outlined, 48px height
      - Filter icon: Opens filter panel

Main Content (Two-Panel Layout):
  
  Left Panel: Product Selection (40% width)
    - Background: Light surface tint
    - Padding: 24px
    - Border right: 1px solid outline
    
    Search Bar:
      - Height: 48px
      - Icon: Search, 20px, left
      - Placeholder: "Search products by name, barcode, or SKU..."
      - Autofocus: Yes
    
    Category Filter:
      - Dropdown: "All Categories"
      - Shows: Product count per category
    
    Location Filter:
      - Dropdown: "All Locations"
      - Important: Adjustments are location-specific
    
    Product List:
      - Scrollable area
      - Virtual scrolling for performance (1000+ items)
      
      Product Card:
        - Height: 88px
        - Padding: 12px 16px
        - Border: 1px solid outline
        - Border radius: 8px
        - Margin: 8px bottom
        - Cursor: pointer
        - Hover: Background tint, border primary
        
        Layout:
          - Product image: Left, 64x64px, rounded 8px
          - Product info: Center-left, flex 1
            - Name: 14px Inter Medium, 2 lines max
            - SKU/Barcode: 12px mono font, gray
            - Category: 12px, gray
          
          - Stock info: Right
            - Current stock: 18px Inter Semibold
              - Color: Green (>min), Yellow (=min), Red (<min)
            - Location: 12px, gray
            - "In X locations" if multi-location
        
        Selected state:
          - Border: 2px solid primary
          - Background: Primary/5% tint
          - Checkmark: Top-right, 20px, green

  Right Panel: Adjustment Entry (60% width)
    - Background: Surface color
    - Padding: 24px
    
    Empty State (no product selected):
      - Centered content
      - Icon: Box with arrows, 80px, gray
      - Title: "Select a Product", 20px Inter Semibold
      - Subtitle: "Choose a product from the list to adjust its stock"
      - Animation: Gentle float (±4px, 3s loop)
    
    Adjustment Form (product selected):
      Header:
        - Product name: 24px Inter Semibold
        - Product image: 80x80px, top-right
      
      Current Stock Section:
        - Card: Light background, 16px padding
        - Location: Display prominently
        - Current quantity: Large, 32px Inter Bold, primary color
        - Unit of measure: Next to quantity
        - Value: "PKR X,XXX" (quantity × cost), 16px
        - Last updated: Timestamp, 13px gray
      
      Adjustment Type (Radio group):
        1. Increase Stock
           - Icon: Plus circle, green
           - Description: "Add units (e.g., found items, correction)"
        
        2. Decrease Stock
           - Icon: Minus circle, red
           - Description: "Remove units (e.g., damaged, stolen)"
        
        3. Set Exact Quantity
           - Icon: Equal sign, blue
           - Description: "Set to specific count (e.g., after physical count)"
      
      Quantity Input:
        - Height: 56px
        - Large font: 24px
        - Autofocus: Yes when type selected
        - Validation: Real-time
        
        For Increase/Decrease:
          - Placeholder: "Enter quantity to add/remove"
          - Min: 1
          - Shows: "New stock will be: [calculated]"
        
        For Set Exact:
          - Placeholder: "Enter exact quantity"
          - Min: 0
          - Shows: "Difference: +X or -X"
      
      Reason Dropdown (Required):
        - Label: "Reason for Adjustment*"
        - Options:
          - "Physical count discrepancy"
          - "Damaged goods"
          - "Expired products"
          - "Theft/Loss"
          - "Found inventory"
          - "System error correction"
          - "Supplier return"
          - "Customer return (no receipt)"
          - "Transfer not recorded"
          - "Opening balance correction"
          - "Other" (text input required)
      
      Notes (Optional):
        - Text area: 96px height
        - Placeholder: "Additional details (optional)"
        - Max: 500 characters
        - Counter: Shows remaining
      
      Batch Selection (if pharmacy with batch tracking):
        - Dropdown: "Select Batch"
        - Shows: All batches for this product at location
        - Each option:
          - Batch number
          - Expiry date
          - Current quantity in this batch
        - Required if batch tracking enabled
      
      Value Impact (Auto-calculated):
        - Card: Border, 16px padding
        - Shows:
          - Cost per unit: PKR X.XX
          - Adjustment quantity: ±N units
          - Value change: ±PKR XXX
          - New total value: PKR XXX
        - Color-coded: Green (increase), Red (decrease)
      
      Attachment (Optional):
        - Upload area
        - Text: "Attach photo or document (optional)"
        - Accepts: Images, PDF
        - Use cases: Damaged goods photo, physical count sheet
      
      Authorization (if required):
        - Shows if: Adjustment value > threshold OR reason is sensitive
        - Manager PIN: 4-digit input
        - Or: Approval request (notification sent)

Footer (Sticky Bottom):
  - Height: 80px
  - Background: Surface color
  - Border top: 1px solid outline
  - Shadow: Elevation 2
  
  Buttons:
    - Cancel: Outlined, left
    - Save as Draft: Text button, center-left
    - Submit Adjustment: Filled primary, right, 48px height
      - Disabled until: Product + type + quantity + reason
      - Loading state: Spinner + "Submitting..."
```

**Light Theme Styling**:
```
Header:
  - Background: #FFFFFF
  - Title: #0F4C4C
  - Description: #44474E

Left Panel:
  - Background: #F8F9FA
  - Search border: #D1D4D9, focus #0F4C4C
  
  Product Cards:
    - Background: #FFFFFF
    - Border: 1px solid #E8EAED
    - Hover: Border #0F4C4C, background #F8F9FA
    - Selected: Border 2px #0F4C4C, background rgba(15, 76, 76, 0.05)
    
    Stock levels:
      - Green: #4CAF50 (above min)
      - Yellow: #FFA000 (at min)
      - Red: #F44336 (below min)

Right Panel:
  - Background: #FFFFFF
  
  Empty state:
    - Icon: #9E9E9E
    - Title: #44474E
  
  Current Stock Card:
    - Background: #F8F9FA
    - Border: 1px solid #E8EAED
    - Quantity: #0F4C4C
  
  Adjustment Types:
    - Increase: Icon #4CAF50, background #E8F5E9
    - Decrease: Icon #F44336, background #FFEBEE
    - Set Exact: Icon #2196F3, background #E3F2FD
    - Selected: Border 2px matching icon color
  
  Value Impact Card:
    - Increase: Border #4CAF50, background #E8F5E9
    - Decrease: Border #F44336, background #FFEBEE

Footer:
  - Background: #FFFFFF
  - Border: 1px solid #E8EAED
```

**Dark Theme Styling**:
```
Header:
  - Background: #2A2A2A
  - Title: #C5E64D
  - Description: #C7C7C7

Left Panel:
  - Background: #1E1E1E
  - Search border: #404040, focus #C5E64D
  
  Product Cards:
    - Background: #2A2A2A
    - Border: 1px solid #404040
    - Hover: Border #C5E64D, background #333333
    - Selected: Border 2px #C5E64D, background rgba(197, 230, 77, 0.1)
    
    Stock levels:
      - Green: #66BB6A
      - Yellow: #FFA726
      - Red: #EF5350

Right Panel:
  - Background: #2A2A2A
  
  Empty state:
    - Icon: #666666
    - Title: #C7C7C7
  
  Current Stock Card:
    - Background: #1E1E1E
    - Border: 1px solid #404040
    - Quantity: #C5E64D
  
  Adjustment Types:
    - Increase: Icon #66BB6A, background #1B5E20
    - Decrease: Icon #EF5350, background #B71C1C
    - Set Exact: Icon #42A5F5, background #0D47A1
  
  Value Impact Card:
    - Increase: Border #66BB6A, background #1B5E20
    - Decrease: Border #EF5350, background #B71C1C

Footer:
  - Background: #2A2A2A
  - Border: 1px solid #404040
```

---

### State 7.1.2: Submit Adjustment - Processing

**Trigger**: User clicks "Submit Adjustment" with valid data

**Processing Flow**:
```
Button State Changes:
  1. Normal → Loading
     - Text: "Submit Adjustment" → "Submitting..."
     - Icon: None → Spinner (16px)
     - Disabled: Yes
     - Opacity: 0.9
  
  2. Validation (500ms):
     - Check: All required fields
     - Check: Authorization (if needed)
     - Check: Inventory not locked
     - Check: User permissions
  
  3. Processing (1-2s):
     - Create: Adjustment record
     - Update: Stock levels
     - Update: Inventory value
     - Create: Audit log entry
     - Update: Batch quantity (if applicable)
     - Trigger: Low stock alerts (if crossed threshold)
  
  4. Success:
     - Button: Changes to checkmark
     - Duration: 500ms
     - Then: Transition to success state
```

**Success Modal**:
```
Modal:
  - Width: 480px
  - Center screen
  - Cannot dismiss (must click button)

Content:
  - Checkmark icon: 80px, green
  - Animation: Draws from center (800ms)
  - Title: "Adjustment Submitted", 24px Inter Bold
  - Reference: "Adjustment #ADJ001", 16px, gray
  
  Summary card:
    - Product: Name + image
    - Adjustment: "+50 units" or "-25 units"
    - New stock: "150 units"
    - Value change: "+PKR 5,000"
    - Location: Display location name
  
  Actions:
    - "View Details": Text link
    - "Adjust Another Product": Outlined button
    - "Done": Primary button (returns to inventory)

Auto-Updates:
  - Inventory list: New stock level updates
  - Dashboard widgets: Stock count refreshes
  - Alerts: New low stock alerts if triggered
```

---

### State 7.1.3: Bulk Stock Adjustment

**Access**: Inventory → Select Multiple Products → Bulk Actions → Adjust Stock

**Bulk Adjustment Modal**:
```
Modal:
  - Width: 800px
  - Max height: 80vh
  - Scrollable content

Header:
  - Title: "Bulk Stock Adjustment"
  - Product count: "[N] products selected"
  - Close: X button

Adjustment Mode (Radio buttons):
  1. Same Adjustment for All
     - Apply identical change to all products
     - Input: Single quantity + type
     - Reason: Same for all
  
  2. Individual Adjustments
     - Different change per product
     - Table view with editable cells

Mode 1: Same Adjustment (Simple)
  - Adjustment type: Increase/Decrease/Set Exact
  - Quantity: Number input
  - Reason: Dropdown (same as single adjustment)
  - Preview: Shows all products with new quantities
  - Warning: "This will adjust [N] products"

Mode 2: Individual (Advanced)
  - Table view:
    - Columns: Product, Current Stock, Adjustment Type, Quantity, New Stock, Reason
    - Each row: Editable cells
    - Copy down: Button to copy first row to all
    - Validation: Per-row validation
  
  - Bulk actions toolbar:
    - "Copy values down": Copies first filled row to empty rows
    - "Clear all": Resets all inputs
    - "Import from CSV": Upload adjustments

Footer:
  - Summary:
    - Products to adjust: N
    - Total value change: PKR XXX
    - Validation status: "X products ready, Y need attention"
  
  - Actions:
    - Cancel: Outlined
    - Submit All: Primary
      - Disabled if: Any validation errors
      - Shows: Progress during batch processing
```

---

## 7.2 Cycle Count Operations

### State 7.2.1: Cycle Count - Overview & Scheduling

**Access**: Inventory → Cycle Counts

**Cycle Count Management Page**:
```
Page Layout (Desktop):
  
  Header:
    - Title: "Cycle Counts"
    - Description: "Regular physical inventory counts"
    - Actions:
      - "+ Schedule Count": Primary button
      - "Active Counts": Badge showing ongoing counts
      - Settings icon: Count preferences

  Two-Tab Interface:
    Tab 1: Scheduled Counts
    Tab 2: Count History

Tab 1: Scheduled Counts

  Calendar View (Default):
    - Month calendar with scheduled counts marked
    - Each day: Shows count badges if scheduled
    - Click day: Shows counts scheduled for that day
    - Color coding:
      - Blue: Scheduled (upcoming)
      - Green: In progress
      - Gray: Completed
      - Red: Overdue

  List View (Toggle):
    - Sortable table
    - Columns:
      - Count name
      - Location
      - Schedule date
      - Frequency (One-time, Daily, Weekly, Monthly)
      - Products: Count
      - Status: Badge
      - Assigned to: User name
      - Actions: Start, Edit, Delete
    
    - Filters:
      - Status: All, Scheduled, In Progress, Completed, Overdue
      - Location: Dropdown
      - Assigned to: User dropdown
      - Date range: Picker

  Count Card (in list):
    - Height: 120px
    - Border: 1px solid outline
    - Border radius: 12px
    - Padding: 20px
    
    Content:
      - Count icon: 40px, left, blue
      - Count name: 18px Inter Semibold
      - Scheduled date: 14px, gray, icon + text
      - Location: 14px, gray, icon + text
      - Progress bar: If in progress
        - Shows: X of Y products counted
        - Color: Primary
      
      - Status badge: Top-right
        - Scheduled: Blue
        - In Progress: Green, with "X% complete"
        - Completed: Green with checkmark
        - Overdue: Red with "N days overdue"
      
      - Assigned user: Avatar + name, bottom
      
      - Actions (bottom-right):
        - "Start Count": Primary (if scheduled)
        - "Continue": Primary (if in progress)
        - "View Report": Outlined (if completed)
        - More menu: Edit, Delete, Duplicate
```

---

### State 7.2.2: Schedule New Cycle Count

**Trigger**: User clicks "+ Schedule Count"

**Schedule Count Modal (Wizard - 3 Steps)**:
```
Modal:
  - Width: 700px
  - Max height: 80vh
  - Scrollable

Step 1: Count Configuration
  
  Count Name:
    - Input: Text field
    - Placeholder: "e.g., Monthly Full Count - Main Warehouse"
    - Max: 100 characters
    - Required: Yes
  
  Count Type (Radio cards):
    1. Full Count
       - Icon: All boxes
       - Description: "Count all products in location"
       - Typical use: Monthly/Quarterly
    
    2. Cycle Count
       - Icon: Rotating arrows
       - Description: "Count rotating subset of products"
       - Typical use: Daily/Weekly
       - Shows: "Count X products per day"
    
    3. Spot Check
       - Icon: Magnifying glass
       - Description: "Count specific high-value or suspicious items"
       - Typical use: As needed
    
    4. ABC Analysis Count
       - Icon: Letters A, B, C
       - Description: "Count by value classification"
       - Options: Count A items (high value) more frequently
  
  Location Selection:
    - Dropdown: Select location
    - Required: Yes
    - Shows: Product count at location
    - Multiple: Can select multiple for same count

  Continue: Enabled when name + type + location selected

Step 2: Product Selection (unless Full Count)
  
  Selection Method (Tabs):
    Tab 1: By Category
      - Tree view: Categories with product counts
      - Checkboxes: Select entire categories
      - Expandable: Show products in category
    
    Tab 2: By Value
      - Slider: Min-Max value range
      - Shows: Products in range (live filter)
      - Sort: By value descending
    
    Tab 3: Manual Selection
      - Search: Product name/SKU
      - List: All products with checkboxes
      - Filters: Category, stock level, last counted
    
    Tab 4: Random Sample
      - Input: Number of products to randomly select
      - Percentage: Or percentage of total (e.g., 10%)
      - Preview: Shows which products will be selected
      - Regenerate: Button to get new random sample

  Selected Products Summary:
    - Count: "X products selected"
    - Total value: "PKR XXX,XXX"
    - Expected time: "~2 hours" (based on avg count time)
  
  Continue: Enabled when ≥1 product selected

Step 3: Schedule & Assign
  
  Schedule Type (Radio):
    1. One-time
       - Date picker: Select date
       - Time: Optional (default: Any time during day)
    
    2. Recurring
       - Frequency: Daily, Weekly, Monthly, Quarterly
       - Start date: When to begin
       - End: Never / After N occurrences / On date
       - For Weekly: Select days (Mon, Tue, etc.)
       - For Monthly: Select day of month
  
  Assign To:
    - User dropdown: Select counter/warehouse staff
    - Multiple: Can assign to multiple users (team count)
    - Or: "Self" if current user will count
  
  Notifications:
    - Checkboxes:
      - ☑ Notify assignee 1 day before
      - ☑ Notify assignee on count day
      - ☐ Send reminder if not started by noon
      - ☑ Notify manager when completed
  
  Instructions (Optional):
    - Text area: Special instructions for counters
    - Placeholder: "e.g., Focus on high-value items first"
    - Max: 500 characters

Footer:
  - Back: Returns to previous step
  - Cancel: Exits wizard
  - Schedule Count: Primary (on step 3)
    - Creates count schedule
    - Sends notifications
    - Returns to cycle count page
```

---

### State 7.2.3: Perform Cycle Count - Mobile Optimized

**Context**: Mobile/tablet is primary device for counting (portable)

**Count Interface - Mobile (<768px)**:
```
Full-Screen Interface:
  
  Header (Fixed Top):
    - Height: 56px
    - Background: Primary color
    - Content:
      - Back arrow: Left, exits count (with confirmation)
      - Count name: Center, 16px white, truncated
      - Progress: Right, "15/50", white
    
    Progress Bar:
      - Below header, 4px height
      - Color: Success green
      - Width: Percentage of products counted

  Product List:
    - Scrollable, infinite scroll
    - Sorted: Alphabetically or by bin location
    
    Product Card:
      - Height: Auto (min 100px)
      - Background: Surface color
      - Border: 1px solid outline
      - Border radius: 12px
      - Margin: 12px horizontal, 8px vertical
      - Padding: 16px
      
      States:
        - Not counted: Normal appearance
        - Counted: Green left border (4px), checkmark top-right
        - Discrepancy: Yellow left border, warning icon
        - Missing: Red left border, alert icon
      
      Content:
        - Product image: Top-left, 64x64px
        - Product name: 16px Inter Medium, wrap 2 lines
        - SKU/Barcode: 13px mono, gray
        - Bin location: 13px, gray, icon + text
        
        - Expected quantity: 18px Inter Semibold
          - Label: "Expected:" 13px gray above
          - Color: Primary
        
        - Count input: Large, prominent
          - Height: 56px
          - Placeholder: "Enter counted quantity"
          - Type: Number
          - Keyboard: Numeric (mobile)
          - Focus: Auto-focuses on tap
        
        - Batch selector (if applicable):
          - Dropdown: "Select batch if multiple"
          - Shows after quantity entered
        
        - Quick actions:
          - Barcode scan: Icon button (opens scanner)
          - Mark as missing: Link (sets qty to 0)
          - Skip: Link (move to next)
      
      Variance Indicator:
        - Shows: If counted qty ≠ expected
        - Badge: "+5" or "-3", color-coded
          - Green: Small overages (<10% or <5 units)
          - Yellow: Medium variances (10-20% or 5-10 units)
          - Red: Large variances (>20% or >10 units)
        - Tap: Shows variance details

  Bottom Action Bar (Sticky):
    - Height: 72px + safe area
    - Background: Surface color
    - Shadow: Elevation 4
    - Border top: 1px solid outline
    
    Stats:
      - Counted: "15 of 50"
      - Discrepancies: "3 items" (if any)
      - Missing: "1 item" (if any)
    
    Buttons:
      - Save Progress: Outlined, left
        - Saves current counts
        - Allows resuming later
      - Complete Count: Primary, right
        - Enabled when: All products counted
        - Or: Shows "X products remaining"
        - If clicked with remaining: Confirmation dialog

Barcode Scanner:
  - Full-screen camera overlay (same as POS scanner)
  - Scans product barcode
  - Auto-fills product card
  - Focuses count input
  - Can scan multiple products sequentially

Skip/Filter Options:
  - Filter button: Top-right of header (next to progress)
  - Filter drawer:
    - Show: All / Counted / Uncounted / Discrepancies / Missing
    - Sort: Alpha / By location / By value / By variance
    - Search: Product name/SKU
```

**Count Entry Animation**:
```dart
class CountEntryCard extends StatefulWidget {
  final Product product;
  final int expectedQty;
  final Function(int) onCounted;
  
  @override
  _CountEntryCardState createState() => _CountEntryCardState();
}

class _CountEntryCardState extends State<CountEntryCard>
    with SingleTickerProviderStateMixin {
  late TextEditingController _controller;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isCounted = false;
  int? _countedQty;
  
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    
    _animationController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }
  
  void _handleCountSubmit() {
    final qty = int.tryParse(_controller.text);
    if (qty != null) {
      setState(() {
        _isCounted = true;
        _countedQty = qty;
      });
      
      // Pulse animation on count completion
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
      
      // Haptic feedback
      HapticFeedback.mediumImpact();
      
      // Callback
      widget.onCounted(qty);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final variance = _countedQty != null
        ? _countedQty! - widget.expectedQty
        : 0;
    
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceColor,
          border: Border(
            left: BorderSide(
              color: _getBorderColor(),
              width: 4,
            ),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.product.imageUrl ?? defaultImageUrl,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        widget.product.sku,
                        style: TextStyle(
                          fontSize: 13,
                          color: secondaryTextColor,
                          fontFamily: 'Courier New',
                        ),
                      ),
                    ],
                  ),
                ),
                if (_isCounted)
                  Icon(
                    Icons.check_circle,
                    color: successColor,
                    size: 24,
                  ),
              ],
            ),
            
            SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Expected:',
                        style: TextStyle(
                          fontSize: 13,
                          color: secondaryTextColor,
                        ),
                      ),
                      Text(
                        '${widget.expectedQty}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Count',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                    ),
                    onSubmitted: (_) => _handleCountSubmit(),
                  ),
                ),
              ],
            ),
            
            if (_isCounted && variance != 0)
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _getVarianceColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getVarianceIcon(),
                        size: 16,
                        color: _getVarianceColor(),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Variance: ${variance > 0 ? '+' : ''}$variance',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _getVarianceColor(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  Color _getBorderColor() {
    if (!_isCounted) return borderColor;
    
    final variance = _countedQty! - widget.expectedQty;
    if (variance == 0) return successColor;
    if (variance.abs() <= 5 || variance.abs() / widget.expectedQty <= 0.1) {
      return warningColor;
    }
    return errorColor;
  }
  
  Color _getVarianceColor() {
    final variance = (_countedQty ?? 0) - widget.expectedQty;
    if (variance == 0) return successColor;
    if (variance.abs() <= 5 || variance.abs() / widget.expectedQty <= 0.1) {
      return warningColor;
    }
    return errorColor;
  }
  
  IconData _getVarianceIcon() {
    final variance = (_countedQty ?? 0) - widget.expectedQty;
    if (variance == 0) return Icons.check;
    if (variance.abs() <= 5) return Icons.warning_amber;
    return Icons.error;
  }
}
```

---

### State 7.2.4: Complete Cycle Count - Review & Reconcile

**Trigger**: User clicks "Complete Count" after counting all products (or with confirmation if incomplete)

**Review Screen**:
```
Full-Screen (Mobile) or Panel (Desktop):
  
  Header:
    - Title: "Review Count Results"
    - Count name: Subtitle
    - Date completed: Timestamp

  Summary Cards (Horizontal scroll on mobile):
    Card 1: Total Products
      - Icon: Box, blue
      - Number: "50" large
      - Label: "Products counted"
    
    Card 2: Matched
      - Icon: Check, green
      - Number: "45" large
      - Percentage: "90%"
      - Label: "Exact matches"
    
    Card 3: Discrepancies
      - Icon: Warning, yellow
      - Number: "4" large
      - Percentage: "8%"
      - Label: "Need review"
    
    Card 4: Missing
      - Icon: Alert, red
      - Number: "1" large
      - Percentage: "2%"
      - Label: "Not found"
    
    Card 5: Value Impact
      - Icon: Currency, primary
      - Number: "+PKR 5,420"
      - Label: "Net variance value"
      - Color: Green (gain) or Red (loss)

  Variance List (Grouped Tabs):
    Tab 1: All Items (50)
    Tab 2: Discrepancies Only (4)
    Tab 3: Missing (1)
    Tab 4: Matched (45)

  Item Display:
    - Table (desktop) or Cards (mobile)
    - Sortable by: Variance, Value, Name
    - Filterable by: Variance size, Category
    
    Columns/Fields:
      - Product: Name + image
      - Expected: Quantity
      - Counted: Quantity
      - Variance: Difference (color-coded)
      - Variance %: Percentage
      - Value impact: PKR amount
      - Reason: Dropdown (for discrepancies)
      - Actions: Accept / Recount / Adjust

  Discrepancy Actions:
    For each discrepancy item:
      1. Accept Count
         - Updates system qty to counted qty
         - Creates adjustment record
         - Requires reason selection
      
      2. Recount
         - Marks for recount
         - Keeps in pending state
         - Sends back to count screen
      
      3. Investigate
         - Marks for investigation
         - Assigns to manager
         - Generates investigation task
      
      4. Override
         - Manually set quantity
         - Requires manager PIN
         - Must provide detailed reason

  Reason Codes (for accepting discrepancies):
    - Dropdown for each item
    - Options:
      - "Count error corrected"
      - "Location transfer not recorded"
      - "Theft/Loss confirmed"
      - "Damaged/Expired (removed)"
      - "System error"
      - "Supplier shortage"
      - "Found inventory"
      - "Other" (text input)

Footer Actions:
  - Back to Count: Outlined (return to counting)
  - Save Review: Text button (save progress)
  - Generate Report: Outlined (preview report)
  - Complete & Apply: Primary
    - Applies all accepted adjustments
    - Creates audit log
    - Sends notifications
    - Locks count (can't edit after)
```

---

### State 7.2.5: Cycle Count Report

**Generated after count completion**

**Report Layout**:
```
PDF/Printable Report:
  
  Header:
    - Business logo
    - Report title: "Cycle Count Report"
    - Count name
    - Location: Name + address
    - Date: Completed date
    - Performed by: User names
    - Review by: Manager name (if approved)

  Executive Summary:
    - Total products: Count
    - Products matched: Count + %
    - Discrepancies: Count + %
    - Missing items: Count + %
    - Net variance: ±N units
    - Value impact: ±PKR XXX
    - Accuracy rate: XX.X%

  Variance Analysis:
    Table:
      Product | Expected | Counted | Variance | Value | Reason | Action
      (rows for all discrepancies)

  Action Items:
    - Products requiring recount: List
    - Items for investigation: List
    - Adjustments applied: Summary

  Inventory Impact:
    - Products increased: Count + total units
    - Products decreased: Count + total units
    - Total value change: PKR XXX

  Signatures:
    - Counter: Name + signature line
    - Reviewer: Name + signature line
    - Date: Line

  Footer:
    - Report ID: Unique identifier
    - Generated: Timestamp
    - Page: X of Y
```

---

## 7.3 Inter-Location Transfers

### State 7.3.1: Transfer Request - Initiate

**Access**: Inventory → Transfers → + New Transfer

**Transfer Request Form (Desktop)**:
```
Full-Page Form:
  
  Header:
    - Title: "Create Transfer Request"
    - Breadcrumb: Inventory > Transfers > New
    - Actions:
      - Cancel: Link
      - Save Draft: Outlined
      - Submit Request: Primary

  Form Sections:

  Section 1: Transfer Details
    - Card: Border, padding 24px
    
    Transfer Type (Radio):
      1. Regular Transfer
         - Standard inter-location transfer
         - Requires approval (if configured)
      
      2. Emergency Transfer
         - Urgent, expedited processing
         - May bypass some approvals
         - Reason required
      
      3. Stock Balancing
         - Automated by system recommendations
         - Pre-filled quantities
    
    From Location* (Required):
      - Dropdown: All locations
      - Shows: Current stock levels
      - Default: Current user's primary location
      - Validation: Must have stock to transfer
    
    To Location* (Required):
      - Dropdown: All locations except 'From'
      - Hierarchical: Shows relationships
      - Validation: Cannot be same as 'From'
    
    Expected Transfer Date:
      - Date picker
      - Default: Tomorrow
      - Min: Today
      - Max: 30 days ahead
    
    Priority (Radio):
      - Normal (default)
      - High
      - Urgent
    
    Reason/Purpose:
      - Text area
      - Placeholder: "Reason for transfer (e.g., stock balancing, store opening)"
      - Optional but recommended

  Section 2: Items to Transfer
    - Card: Border, padding 24px
    
    Add Products Button:
      - "+ Add Products": Primary, top-right
      - Opens: Product selector modal
    
    Selected Products Table:
      - Empty state: "No products added. Click 'Add Products' to begin."
      
      Table Columns:
        - Image: 48x48px
        - Product: Name + SKU
        - Available Stock: At 'From' location
        - Transfer Quantity: Editable input
          - Max: Available stock
          - Validation: Real-time
        - Unit of Measure: Display
        - Batch (if applicable): Dropdown selector
        - Value: Qty × Cost per unit
        - Actions: Remove (trash icon)
      
      Footer Row:
        - Total items: Count
        - Total quantity: Sum
        - Total value: PKR XXX

    Product Selector Modal:
      - Width: 700px
      - Search: Product name/SKU/barcode
      - Location filter: Shows stock at 'From' location
      - List: Available products
      - Each product:
        - Checkbox: Select
        - Name + SKU
        - Stock available: Large display
        - Quick quantity input: Optional
      - Footer:
        - Selected count: "X products selected"
        - Add to Transfer: Primary button

  Section 3: Shipping Details (Optional)
    - Card: Border, padding 24px
    
    Shipping Method:
      - Dropdown:
        - "Company Vehicle"
        - "Third-party Courier"
        - "Pickup by Receiving Location"
        - "Other"
    
    Tracking Number:
      - Text input
      - Optional
      - For courier services
    
    Driver/Contact:
      - Text input
      - Phone number input
      - Optional
    
    Special Instructions:
      - Text area
      - Max: 500 characters
      - Examples: "Fragile items", "Refrigeration required"

  Section 4: Attachments (Optional)
    - Card: Border, padding 24px
    
    Upload Area:
      - Drag & drop zone
      - Or click to browse
      - Accepts: Images, PDF, Excel
      - Use cases: Transfer request form, packing list
      - Max: 5 files, 10MB each
    
    Uploaded Files List:
      - Each: Filename, size, remove button

Footer (Sticky):
  - Validation summary:
    - Shows: Errors/warnings
    - Example: "2 products exceed available stock"
  
  - Actions:
    - Cancel: Link, left
    - Save Draft: Outlined
    - Submit Request: Primary, right
      - Disabled until: From + To + ≥1 product + validations pass
      - Loading: Shows during submission
```

**Submit Success**:
```
Success modal (similar to other operations):
  - Checkmark animation
  - Title: "Transfer Request Created"
  - Transfer ID: "TRF001"
  - Status: "Pending Approval" or "Approved" (depending on workflow)
  - Actions:
    - View Transfer: Opens detail view
    - Create Another: Resets form
    - Done: Returns to transfer list
```

---

### State 7.3.2: Transfer Approval (Manager View)

**Access**: Transfers → Pending Approvals

**Approval Queue**:
```
Page Layout:
  
  Header:
    - Title: "Transfer Approvals"
    - Badge: Count of pending approvals
    - Filter: All / High Priority / Overdue

  Transfer Cards (List):
    Each card: 140px height
    
    Content:
      - Transfer ID: Bold, 16px, top-left
      - Status badge: "Pending Approval", yellow, top-right
      - Priority badge: If High/Urgent, red, next to status
      
      - Route: "Main Warehouse → Store #1"
      - Requested by: User name + avatar
      - Date requested: Timestamp
      - Expected transfer: Date
      
      - Items: "5 products, PKR 12,500 total value"
      - Preview images: First 3 product images (48px each)
      
      - Quick stats:
        - Stock check: "✓ All items available" (green) or "⚠ 2 items low stock" (yellow)
      
      - Actions (bottom-right):
        - View Details: Outlined
        - Approve: Green button
        - Reject: Red outlined button

Detail View (Modal or Side Panel):
  - Opens when: "View Details" clicked
  
  Header:
    - Transfer ID
    - Route display
    - Status
  
  Sections:
    1. Request Information
       - Requested by, date, reason, priority
    
    2. Items Table
       - Same columns as request form
       - Additional column: Stock check (available vs needed)
    
    3. Approver Notes
       - Text area: Add notes
       - Optional
    
    4. History
       - Timeline: Request created, approvers notified, etc.
  
  Footer Actions:
    - Reject with Reason: Red outlined
      - Opens: Rejection reason modal
      - Text area: Required
      - Common reasons: Quick select buttons
    
    - Request Changes: Yellow outlined
      - Opens: Change request form
      - Specify: What needs to be changed
      - Sends back to requester
    
    - Approve: Green primary
      - Confirmation: "Approve transfer of PKR 12,500?"
      - Optional: Add approval notes
      - Action: Updates status, notifies sender and receiver

Bulk Actions:
  - Select multiple: Checkboxes on cards
  - Toolbar appears: "X transfers selected"
  - Actions:
    - Approve All: Green
    - Reject All: Red
    - Request Changes: Yellow
```

---

### State 7.3.3: Transfer Packing & Dispatch

**Access**: Transfers → In Progress → [Transfer] → Pack Items

**Packing Interface (Mobile-Optimized)**:
```
Context: Warehouse staff packing items for transfer

Full-Screen Mobile Interface:
  
  Header:
    - Title: "Pack Transfer"
    - Transfer ID: TRF001
    - Route: From → To locations
    - Items: "0 of 5 packed"
  
  Progress Bar:
    - Below header
    - Shows: Packed items / Total items
    - Color: Primary → Success when complete

  Item Packing List:
    - Vertical scrolling cards
    
    Each Product Card:
      - Height: Auto (min 120px)
      - Border: 1px solid outline
      - Border radius: 12px
      - Padding: 16px
      - Margin: 12px horizontal, 8px vertical
      
      States:
        - Not packed: Normal
        - Packed: Green left border (4px), checkmark
        - Partial: Yellow left border, "2 of 5 packed"
      
      Content:
        - Product image: 72x72px, left
        - Product name: 16px Inter Medium
        - SKU: 13px mono, gray
        
        - Quantity to pack: Large, 24px Inter Bold
          - Label: "Qty:" 14px gray
          - Shows: Required quantity
        
        - Batch selector: Dropdown (if multiple batches)
          - Shows: Available batches at this location
          - Required if batch tracking enabled
        
        - Barcode scan button: Large, prominent
          - Icon: Barcode, 32px
          - Text: "Scan to Pack"
          - Tap: Opens scanner
        
        - Manual pack button: Outlined
          - Text: "Mark as Packed"
          - Tap: Marks full qty as packed
        
        - Packed quantity: Shows after packing
          - Editable: Tap to adjust
          - Max: Required quantity
        
        - Notes field: Optional
          - Expandable text area
          - Use: Special handling notes

  Barcode Scanning Flow:
    1. Tap "Scan to Pack" → Camera opens
    2. Scan product barcode → Verifies match
    3. If match: Auto-marks as packed, haptic feedback, checkmark animation
    4. If no match: Error, "Wrong product scanned"
    5. Scanner stays open for next item
    6. Can cancel scanner any time

  Packing Actions (Floating):
    - Print Packing Slip: FAB, bottom-left
      - Generates: PDF packing list
      - Connects: Bluetooth printer
    
    - Generate Labels: FAB, bottom-right
      - Creates: Box labels with barcode
      - Contents: Transfer ID + box number

  Bottom Action Bar:
    - Height: 72px + safe area
    - Background: Surface
    - Shadow: Elevation 4
    
    Progress:
      - "4 of 5 items packed"
      - Progress percentage: 80%
    
    Buttons:
      - Save Progress: Outlined
      - Complete Packing: Primary
        - Enabled when: All items packed
        - Or: Confirmation if partial

Complete Packing:
  - Confirmation modal:
    - Title: "Complete Packing?"
    - Summary: Items packed, total boxes
    - Shipping details: Pre-filled or input now
    - Tracking number: Optional input
    - Photos: Optional upload (packed boxes)
  
  - Action: "Confirm & Dispatch"
    - Updates: Transfer status to "In Transit"
    - Reduces: Stock at From location
    - Generates: Packing slip & labels
    - Notifies: Receiving location
    - Creates: Audit log entry
```

---

### State 7.3.4: Transfer Receipt & Verification

**Access**: Transfers → In Transit → [Transfer] → Receive Items

**Receiving Interface (Mobile-Optimized)**:
```
Context: Receiving location verifying delivered items

Full-Screen Mobile Interface:
  
  Header:
    - Title: "Receive Transfer"
    - Transfer ID: TRF001
    - From location: Display
    - Shipped date: Display
    - Items: "0 of 5 verified"

  Shipment Info Card:
    - Expandable card at top
    - Shows when expanded:
      - Tracking number
      - Shipped date/time
      - Driver/courier info
      - Special instructions
      - Packing slip: View/download button

  Item Verification List:
    - Similar layout to packing list
    
    Each Product Card:
      - Product image, name, SKU
      - Expected quantity: "5 units"
      - Batch: Shows batch from sending location
      
      - Verification section:
        - "Quantity Received" input
          - Large, 56px height
          - Placeholder: "Enter received qty"
          - Default: Same as expected (can adjust)
        
        - Condition check (Radio):
          - ☑ Good Condition (default)
          - ☐ Damaged
          - ☐ Expired
          - ☐ Wrong Item
        
        - Barcode scan: Opens scanner for verification
        - Photo button: Take photo if damaged
        
      - Discrepancy handling:
        - If received ≠ expected: Shows warning
        - Reason dropdown: Required if discrepancy
          - "Short shipment"
          - "Damaged in transit"
          - "Wrong item sent"
          - "Expired product"
          - "Other" (text input)
        
        - Damage photo: Upload if applicable
        
      - Accept/Reject toggle:
        - Accept: Adds to inventory
        - Reject: Does not add, creates return

  Verification Actions:
    - Scan all: Opens scanner in continuous mode
      - Scans multiple products sequentially
      - Auto-verifies each scanned item
      - Keeps scanner open until cancelled

  Bottom Action Bar:
    - Progress: "3 of 5 verified"
    - Discrepancies: "1 item" (if any, yellow badge)
    
    Buttons:
      - Save Progress: Outlined
      - Complete Receipt: Primary
        - Enabled when: All items verified
        - Or: Confirmation if incomplete

Complete Receipt:
  - Review screen:
    - Summary: Received vs expected
    - Discrepancies list: Details
    - Accepted items: Will be added to inventory
    - Rejected items: Will be flagged for return
    
    - Signature (Optional):
      - Digital signature pad
      - Receiver signs to accept delivery
    
    - Photos: Review uploaded damage photos
    
    - Notes: Final notes about receipt
  
  - Confirm button:
    - Updates: Transfer status to "Completed"
    - Adds: Accepted items to inventory
    - Creates: Discrepancy report (if any)
    - Notifies: Sending location of completion
    - Generates: Receipt confirmation document
```

---

### State 7.3.5: Transfer with Discrepancies - Resolution

**Trigger**: Transfer completed with discrepancies (qty mismatch, damaged items, etc.)

**Discrepancy Resolution Screen**:
```
Access: Transfers → Completed with Issues → [Transfer]

Page Layout:
  
  Header:
    - Title: "Transfer Discrepancy"
    - Transfer ID: TRF001
    - Status badge: "Requires Resolution", orange
    - Alert: "Action needed within 7 days"

  Transfer Summary:
    - Route: From → To
    - Shipped: Date
    - Received: Date
    - Total items: Count
    - Items with issues: Count, red

  Discrepancy Details (Grouped):
    
    Group 1: Quantity Shortages
      - Table or cards
      - Each item:
        - Product name
        - Expected: X units
        - Received: Y units
        - Short: Z units (red)
        - Value: PKR XXX
        - Reason: Dropdown selection from receiver
        - Resolution: Dropdown (see below)
    
    Group 2: Damaged Items
      - Each item:
        - Product name
        - Quantity damaged: N units
        - Damage description: Text
        - Photos: Thumbnails (click to enlarge)
        - Value: PKR XXX
        - Resolution: Dropdown
    
    Group 3: Wrong Items
      - Each item:
        - Expected product: Name
        - Received product: Name (if identified)
        - Quantity: N units
        - Resolution: Dropdown

  Resolution Options (Per Item Dropdown):
    1. Adjust & Accept
       - Accept shortage/damage
       - Adjust inventory accordingly
       - Write off value
    
    2. Request Replacement
       - Create return transfer request
       - Sender sends replacement
       - Timeline: Specify expected date
    
    3. Refund/Credit
       - Don't replace
       - Adjust accounts
       - Issue credit note
    
    4. Investigate
       - Flag for investigation
       - Assign to manager
       - Delay resolution
    
    5. Dispute
       - Formal dispute process
       - Requires detailed explanation
       - Escalates to management

  Resolution Actions:
    - By Sender (From location):
      - View discrepancy report
      - Accept responsibility
      - Dispute findings
      - Arrange replacement
      - Process refund
    
    - By Receiver (To location):
      - Confirm discrepancy details
      - Accept resolution
      - Provide additional evidence
    
    - By Manager:
      - Review both sides
      - Make final decision
      - Approve adjustments
      - Close discrepancy

  Resolution Timeline:
    - Day 0: Discrepancy reported
    - Day 1-3: Investigation period
    - Day 4-7: Resolution implementation
    - Day 7: Auto-escalation if unresolved

  Complete Resolution:
    - All items: Have resolution selected
    - Approvals: Manager approval (if required)
    - Actions:
      - Create: Adjustment records
      - Create: Return transfers (if applicable)
      - Update: Inventory values
      - Close: Discrepancy ticket
      - Archive: Transfer with notes
```

---

## 7.4 Goods Receiving (GRN)

### State 7.4.1: GRN Entry - Against Purchase Order

**Access**: Procurement → Purchase Orders → [PO] → Receive Goods

**Context**: Receiving goods ordered from supplier

**GRN Entry Form (Desktop)**:
```
Full-Page Interface:
  
  Header:
    - Title: "Goods Receipt Note"
    - PO Reference: "PO #PO001"
    - Supplier: Name + contact
    - Expected delivery: Date (from PO)

  PO Summary Card:
    - Background: Info tint
    - Border: 1px solid info color
    - Padding: 20px
    - Content:
      - PO number + date
      - Supplier details
      - Total PO value: PKR XXX
      - Items: Count
      - Status: Partially received / Fully received

  Receiving Details:
    Form fields:
      - Receipt Date*: Date picker (default: today)
      - Receipt Time: Time picker (default: now)
      - Received By*: User dropdown (default: current user)
      - Receiving Location*: Dropdown (warehouse/store)
      - Delivery Note #: Text input (from supplier)
      - Vehicle/Driver: Text input (optional)

  Items to Receive:
    Table view:
      
      Columns:
        1. Product: Name + image (64px)
        2. Ordered Quantity: From PO
        3. Previously Received: Sum of past GRNs (if partial delivery)
        4. Outstanding: Ordered - Received
        5. Receiving Now*: Input field
           - Default: Outstanding quantity
           - Max: Outstanding
           - Validation: ≤ Outstanding
        6. Unit Price: From PO (display only)
        7. Batch # (if pharmacy): Input/dropdown
        8. Expiry Date (if pharmacy): Date picker
        9. Condition: Dropdown
           - Good
           - Damaged (qty damaged field appears)
           - Expired
        10. Bin Location: Dropdown (where to store)
        11. Subtotal: Qty × Price
      
      Row Actions:
        - Scan barcode: Opens scanner
        - Mark as received: Quick action (full outstanding qty)
        - Not received: Removes from this GRN
      
      Footer Row:
        - Total receiving: N items, PKR XXX
        - Total damaged: N items (if any)

  Batch Entry (for pharmacy items):
    - Modal or inline expansion
    - For each product line:
      - Multiple batches: Can receive same product in different batches
      - Add batch button: "+Add Another Batch"
      - Each batch:
        - Batch number*: Text input
        - Manufacturing date: Date picker (optional)
        - Expiry date*: Date picker (required)
        - Quantity*: Input (sum must = receiving quantity)
      - Batch total: Must equal receiving quantity
      - Validation: Sum of batch qtys = receiving qty

  Discrepancy Handling:
    - Shows if: Receiving qty ≠ Outstanding qty
    - Banner: Yellow warning
    - Text: "Discrepancy detected for [N] items"
    - Required fields per discrepancy:
      - Reason: Dropdown
        - "Supplier short-shipped"
        - "Damaged in transit"
        - "Wrong item sent"
        - "Quality issue"
        - "Partial delivery (more to come)"
        - "Other"
      - Notes: Text area (optional)
      - Photo: Upload (optional, for damage)

  Quality Check (Optional):
    - Toggle: "Perform quality inspection"
    - If enabled:
      - Checklist per item or overall:
        - ☐ Packaging intact
        - ☐ Labels correct
        - ☐ Temperature maintained (if applicable)
        - ☐ No visible damage
        - ☐ Quantities match
        - ☐ Expiry dates acceptable
      - Overall QC result: Pass / Fail
      - QC performed by: User
      - QC notes: Text area

  Attachments:
    - Upload area: Delivery note, packing slip, photos
    - Drag & drop or click to browse
    - Max: 10 files, 5MB each

Footer Actions:
  - Cancel: Link
  - Save Draft: Outlined (saves as partial GRN)
  - Complete Receipt: Primary
    - Validation: All required fields filled
    - Confirmation: If discrepancies exist
```

---

### State 7.4.2: GRN Review - 3-Way Matching

**Trigger**: After GRN submitted, system performs 3-way matching

**3-Way Match Screen (Manager/Accountant View)**:
```
Access: Procurement → GRN → Pending Matching → [GRN]

Page Layout:
  
  Header:
    - Title: "3-Way Match"
    - GRN #: Reference
    - PO #: Reference
    - Invoice #: If available
    - Match Status: Badge
      - "Matched" (green)
      - "Mismatched" (yellow)
      - "Disputed" (red)

  Three-Column Comparison:
    
    Column 1: Purchase Order
      - Header: "PO #PO001"
      - Date: PO date
      - Each product:
        - Name
        - Ordered qty
        - Unit price
        - Total
      - PO Total: PKR XXX

    Column 2: Goods Receipt
      - Header: "GRN #GRN001"
      - Date: Receipt date
      - Each product:
        - Name
        - Received qty
        - Unit price (from PO)
        - Total
        - Batch info (if applicable)
      - GRN Total: PKR XXX

    Column 3: Supplier Invoice
      - Header: "Invoice #INV001"
      - Date: Invoice date
      - Status: "Not yet received" or shows invoice
      - Each product:
        - Name
        - Invoiced qty
        - Unit price
        - Total
      - Invoice Total: PKR XXX
  
  Variance Detection:
    - Automatic highlighting:
      - Green: Matches (PO = GRN = Invoice)
      - Yellow: Minor variance (<5% or <PKR 100)
      - Red: Major variance (≥5% or ≥PKR 100)
    
    - Variance types:
      1. Quantity Variance
         - PO qty ≠ GRN qty
         - Example: Ordered 100, received 95
      
      2. Price Variance
         - PO price ≠ Invoice price
         - Example: PO PKR 100, Invoice PKR 105
      
      3. Missing Items
         - Item on PO/Invoice but not in GRN
      
      4. Extra Items
         - Item in GRN but not on PO

  Variance Details (Expandable per item):
    - Click item with variance → Details panel
    - Shows:
      - Variance type
      - Variance amount: ±N units or ±PKR XXX
      - Variance percentage: X.X%
      - Possible reasons: Auto-suggested
      - Resolution options: Dropdown
      - Notes: Text area

  Resolution Options:
    1. Accept Variance
       - Within tolerance: Auto-approve
       - Above tolerance: Requires approval
       - Reason: Required
      - Action: Proceed with payment

    2. Reject Invoice
       - Send back to supplier
       - Request corrected invoice
       - Delay payment
    
    3. Adjust PO
       - Amend PO to match actual delivery
       - Update PO prices if negotiated
       - Requires authorization
    
    4. Partial Approval
       - Approve matched items
       - Hold disputed items for investigation
    
    5. Escalate
       - Flag for manager review
       - Require supplier clarification

  Tolerance Settings:
    - Display current tolerance levels:
      - Quantity: ±2% or ±5 units
      - Price: ±3% or ±PKR 100
      - Total value: ±5% or ±PKR 500
    - Within tolerance: Auto-approve
    - Outside tolerance: Manual review required

  Match Summary:
    - Total items: Count
    - Matched: Count (green)
    - Minor variances: Count (yellow)
    - Major variances: Count (red)
    - Overall match: Pass / Review Required / Fail

Footer Actions:
  - Reject All: Red outlined
  - Request Clarification: Yellow outlined
  - Approve with Exceptions: Primary yellow
  - Approve All: Green primary
    - Enabled when: All items resolved
    - Action: Approves for payment processing
```

---

### State 7.4.3: GRN without PO (Direct Receipt)

**Context**: Small purchases, returns, or transfers without formal PO

**Direct GRN Form**:
```
Similar to PO-based GRN but with differences:

Header:
  - Title: "Direct Goods Receipt"
  - No PO reference

Supplier/Source:
  - Manual selection: Supplier dropdown
  - Or: Transfer/Return receipt
  - Or: "Other" (e.g., donation, found items)

Product Entry:
  - Not pre-filled (no PO items)
  - Must add products manually:
    - Search/scan products
    - Add to receipt
    - Enter quantities
    - Enter prices (editable)
    - Enter batch/expiry

  - "+ Add Product" button prominent
  - Product selector modal

Valuation:
  - Price per unit: Manual entry
  - Or: Use last purchase price
  - Or: Use average cost
  - Justification: Why this price

Authorization:
  - Always requires approval (no PO to verify against)
  - Manager PIN or approval workflow
  - Value threshold: Higher scrutiny for large amounts

Use Cases:
  - Emergency purchases
  - Petty cash purchases
  - Returns from customers (no receipt)
  - Transfers (informal)
  - Found inventory
  - Donations

Workflow: Still creates GRN but flags as "No PO"
```

---

## 7.5 Stock Movement Audit Trail

### State 7.5.1: Audit Trail - Main View

**Access**: Inventory → Audit Trail / History

**Audit Trail Dashboard (Desktop)**:
```
Page Layout:
  
  Header:
    - Title: "Inventory Audit Trail"
    - Description: "Complete history of all inventory movements"
    - Export: Button to export filtered results to CSV/Excel

  Filter Panel (Left Sidebar, 280px):
    
    Date Range:
      - Preset options:
        - Today
        - Yesterday  
        - Last 7 days
        - Last 30 days
        - Last 90 days
        - Custom range (date pickers)
      - Default: Last 30 days
    
    Movement Type (Checkboxes):
      - ☑ Sales (POS transactions)
      - ☑ Purchases (GRN)
      - ☑ Adjustments (manual)
      - ☑ Transfers (inter-location)
      - ☑ Returns (customer/supplier)
      - ☑ Cycle Counts
      - ☑ Write-offs
      - ☑ System corrections
    
    Product Filter:
      - Search: Product name/SKU
      - Category: Dropdown
      - Batch: Input (if pharmacy)
    
    Location Filter:
      - All locations (default)
      - Specific location: Dropdown
      - Include transfers: Checkbox
    
    User Filter:
      - All users (default)
      - Specific user: Dropdown
      - Role filter: Manager, Cashier, etc.
    
    Value Range:
      - Min value: PKR input
      - Max value: PKR input
      - Show only high-value (>PKR X): Checkbox
    
    Flags/Alerts:
      - Show only discrepancies: Checkbox
      - Show only unauthorized: Checkbox
      - Show only negative stock: Checkbox
      - Show only high-value: Checkbox

  Main Content Area:
    
    Summary Cards (Top, horizontal):
      Card 1: Total Movements
        - Number: "1,247" (in date range)
        - Icon: Activity
      
      Card 2: Net Stock Change
        - Number: "+350 units"
        - Green if positive, red if negative
        - Icon: Trending up/down
      
      Card 3: Value Impact
        - Number: "+PKR 45,230"
        - Net value change
        - Icon: Currency
      
      Card 4: Discrepancies
        - Number: "12"
        - Count of flagged movements
        - Icon: Alert
        - Click: Filters to discrepancies only

    Movement Timeline:
      - View toggle: List / Timeline / Calendar
      
      List View (Default):
        - Table with virtual scrolling
        
        Columns:
          1. Timestamp: Date + time, sortable
          2. Movement Type: Icon + label, color-coded
          3. Product: Name + image thumbnail
          4. Quantity: ±N units, color-coded
          5. Location: From → To (if transfer)
          6. Reference: Transaction/GRN/Adjustment ID (clickable)
          7. User: Who performed action
          8. Value: PKR amount
          9. Reason/Notes: Truncated text, expandable
          10. Status: Badge (completed, pending, flagged)
        
        Row Actions:
          - View details: Eye icon
          - View document: If available (receipt, GRN, etc.)
          - Flag: If suspicious
          - Export: Single row export
        
        Row Styling:
          - Normal: Default surface color
          - Flagged: Yellow left border (4px)
          - High-value: Blue tint background
          - Unauthorized: Red left border
          - Hover: Lift with shadow

      Timeline View:
        - Visual timeline (vertical)
        - Groups by date: Today, Yesterday, Last Week, etc.
        - Each movement: Card with key info
        - Expandable: Click to see details
        - Animations: Fade in as scroll

      Calendar View:
        - Month calendar
        - Each day: Shows movement count
        - Heat map: Color intensity by activity level
        - Click day: Shows movements for that day

  Movement Detail Panel (Right Slide-in):
    - Triggered: Click any movement
    - Width: 400px
    - Slides from right with backdrop
    
    Content:
      - Movement type: Large icon + label
      - Timestamp: Full date/time
      - Reference ID: Large, copyable
      
      - Product details:
        - Image: 120x120px
        - Name: 20px bold
        - SKU/Barcode: Mono font
        - Category: Badge
      
      - Quantity details:
        - Before: N units
        - Change: ±X units (color-coded)
        - After: N units
        - Stock level indicator: Visual bar
      
      - Location:
        - If single location: Display name
        - If transfer: From → To with arrow
      
      - Value information:
        - Unit cost: PKR X.XX
        - Total value: PKR XXX
      
      - Batch information (if applicable):
        - Batch number
        - Expiry date
        - Manufacturing date
      
      - User information:
        - Performed by: Avatar + name
        - Role: Badge
        - Timestamp: Full
        - IP address: If tracked
        - Device: If tracked
      
      - Related documents:
        - Receipt: Link to POS receipt
        - GRN: Link to goods receipt
        - Adjustment record: Link
        - Approval: Link to approval record
      
      - Reason/Notes:
        - Full text display
        - Attachments: If any
      
      - Audit metadata:
        - Created: Timestamp
        - Modified: If applicable
        - Approved by: If applicable
        - Flags: If any
      
      - Actions:
        - View full transaction: Opens full detail
        - Export: PDF/CSV
        - Flag as suspicious: Button
        - Add note: Text area + save

Bulk Operations:
  - Select multiple: Checkboxes on rows
  - Toolbar appears: "X movements selected"
  - Actions:
    - Export selected: CSV/Excel
    - Flag selected: Bulk flag
    - Compare: Side-by-side comparison
```

**Light Theme Styling**:
```
Filter Panel:
  - Background: #F8F9FA
  - Border: 1px solid #E8EAED
  
  Section headers: #44474E, 14px Medium
  Checkboxes: Primary when checked
  Inputs: White background, #D1D4D9 border

Summary Cards:
  - Background: #FFFFFF
  - Border: 1px solid #E8EAED
  - Shadow: Elevation 1
  
  Numbers: #0F4C4C (primary), 32px Bold
  Icons: Primary color, 40px
  
  Value change colors:
    - Positive: #4CAF50
    - Negative: #F44336

Movement Table:
  - Header: #F8F9FA background, #44474E text
  - Rows: Alternating #FFFFFF / #FAFBFC
  - Borders: #E8EAED
  - Hover: #F8F9FA background, shadow increase
  
  Movement type colors:
    - Sale: #2196F3 (blue)
    - Purchase: #4CAF50 (green)
    - Adjustment: #FFA000 (amber)
    - Transfer: #9C27B0 (purple)
    - Return: #F44336 (red)
  
  Flags:
    - Normal: None
    - Flagged: #FFA000 left border
    - Unauthorized: #F44336 left border
    - High-value: #E3F2FD background

Detail Panel:
  - Background: #FFFFFF
  - Shadow: Elevation 3
  - Section dividers: #E8EAED
```

**Dark Theme Styling**:
```
Filter Panel:
  - Background: #1E1E1E
  - Border: 1px solid #404040
  
  Section headers: #C7C7C7, 14px Medium
  Inputs: #2A2A2A background, #404040 border

Summary Cards:
  - Background: #2A2A2A
  - Border: 1px solid #404040
  - Shadow: Elevation 1
  
  Numbers: #C5E64D (primary), 32px Bold
  
  Value change colors:
    - Positive: #66BB6A
    - Negative: #EF5350

Movement Table:
  - Header: #1E1E1E background, #C7C7C7 text
  - Rows: Alternating #2A2A2A / #333333
  - Borders: #404040
  - Hover: #333333 background
  
  Movement type colors:
    - Sale: #42A5F5
    - Purchase: #66BB6A
    - Adjustment: #FFA726
    - Transfer: #AB47BC
    - Return: #EF5350

Detail Panel:
  - Background: #2A2A2A
  - Shadow: Elevation 3
```

---

### State 7.5.2: Audit Trail - Anomaly Detection

**System Feature**: Automated detection of suspicious patterns

**Anomaly Detection Dashboard**:
```
Access: Audit Trail → Anomalies (tab)

Page Layout:
  
  Header:
    - Title: "Detected Anomalies"
    - Active alerts: Badge count
    - Settings: Configure detection rules

  Alert Severity Filter:
    - High: Red (immediate attention)
    - Medium: Yellow (review soon)
    - Low: Blue (informational)
    - Dismissed: Gray (archived)

  Anomaly Types:
    
    1. Rapid Consecutive Adjustments
       - Detection: Same product adjusted >3 times in 24 hours
       - Red flag: Multiple adjustments by same user
       - Alert: "Product X adjusted 5 times today"
    
    2. Large Value Adjustments
       - Detection: Adjustment value >PKR X threshold
       - Alert: "High-value adjustment: PKR 50,000"
       - Requires: Manager review
    
    3. Off-Hours Activity
       - Detection: Stock movements outside business hours
       - Alert: "Adjustment at 3:00 AM by User Y"
       - Risk: Unauthorized access
    
    4. Negative Stock Creation
       - Detection: Adjustment/sale creating negative inventory
       - Alert: "Product went negative: -15 units"
       - Requires: Immediate correction
    
    5. Unusual User Activity
       - Detection: User performs actions outside their typical pattern
       - Alert: "Cashier performed 10 adjustments (avg: 1/day)"
       - Risk: Possible theft or error
    
    6. Deleted Transactions
       - Detection: Transaction voided/deleted
       - Alert: "Sale voided: PKR 15,000 by User X"
       - Requires: Manager approval + reason
    
    7. Price Changes During Sale
       - Detection: Product price modified mid-transaction
       - Alert: "Price reduced 50% during sale"
       - Risk: Discount abuse
    
    8. Batch Expiry Override
       - Detection: Near-expiry batch bypassed (not FEFO)
       - Alert: "Newer batch used despite expired batch available"
       - Risk: Write-off increase
    
    9. Location Transfer Loops
       - Detection: Product transferred A→B→A in short time
       - Alert: "Circular transfer detected"
       - Risk: Concealing theft
    
    10. Bulk Product Deletions
        - Detection: Multiple products deleted simultaneously
        - Alert: "15 products deleted by User X"
        - Requires: Manager approval

  Anomaly Card (for each detected):
    - Height: 140px
    - Border: 1px solid, color by severity
    - Border radius: 12px
    - Padding: 20px
    
    Content:
      - Severity badge: Top-right
      - Anomaly type: 18px bold, icon
      - Description: 14px, what was detected
      - Details: Key info (product, user, value, time)
      - Risk level: Low / Medium / High / Critical
      - Detected: Timestamp
      
      - Actions:
        - Investigate: Opens investigation form
        - Dismiss: With reason
        - Escalate: To manager
        - View audit log: All related movements

  Investigation Form (Modal):
    - Opens when: "Investigate" clicked
    
    Content:
      - Anomaly summary: Restate the issue
      - Related movements: Timeline of relevant actions
      - User history: Past similar anomalies
      - Product history: Pattern for this product
      
      - Investigation fields:
        - Investigator: Current user (auto)
        - Findings: Text area (required)
        - Action taken: Dropdown
          - "False positive - no action"
          - "User error - retrained"
          - "Policy violation - warned"
          - "Potential fraud - escalated"
          - "System error - fixed"
          - "Other"
        - Corrective actions: Text area
        - Follow-up required: Checkbox
        
      - Evidence attachments:
        - Upload: Screenshots, documents
      
      - Actions:
        - Save investigation: Records findings
        - Close anomaly: Marks as resolved
        - Escalate: Sends to upper management
        - Create report: Generates investigation report

  Anomaly Statistics:
    - Dashboard widget showing:
      - Anomalies per day: Line chart
      - By type: Pie chart
      - By severity: Bar chart
      - By user: Top 10 list
      - Resolution time: Average days

  Settings (Configure Detection):
    - Thresholds:
      - Large adjustment value: PKR input
      - Multiple adjustments: Count + hours
      - Off-hours window: Time range
      - Discount threshold: Percentage
    
    - Notification rules:
      - Who to notify: User roles
      - Immediate: For high/critical
      - Daily digest: For low/medium
      - Weekly summary: For trends
    
    - Auto-actions:
      - Block transaction: If critical
      - Require approval: If high
      - Log only: If low
```

---

### State 7.5.3: Audit Trail - Compliance Reporting

**Context**: Generate audit reports for regulatory compliance

**Compliance Report Generator**:
```
Access: Audit Trail → Generate Compliance Report

Report Configuration:
  
  Report Type (Dropdown):
    1. Tax Audit Report
       - All sales transactions
       - Tax collected and paid
       - Input/output tax reconciliation
    
    2. Controlled Substances Report
       - All controlled drug dispensing
       - Prescription records
       - Batch tracking
    
    3. Inventory Valuation Report
       - Opening stock
       - Purchases
       - Sales
       - Adjustments
       - Closing stock
       - Value reconciliation
    
    4. Stock Movement Summary
       - All movements by category
       - Location transfers
       - Adjustments with reasons
    
    5. User Activity Report
       - Per-user transaction log
       - Adjustments performed
       - Approvals given
       - Anomalies flagged
    
    6. Variance Analysis Report
       - Cycle count variances
       - Adjustment frequency
       - Write-offs and losses
    
    7. Custom Audit Report
       - User defines parameters
       - Select specific fields
       - Custom date range

  Date Range:
    - Fiscal year: Dropdown
    - Quarter: Q1/Q2/Q3/Q4
    - Month: Dropdown
    - Custom: Date pickers
  
  Location:
    - All locations
    - Specific location
    - Multiple selection
  
  Level of Detail:
    - Summary: High-level aggregates
    - Detailed: Transaction-level
    - Comprehensive: With supporting docs
  
  Output Format:
    - PDF: For printing/signing
    - Excel: For analysis
    - CSV: For data import
    - JSON: For system integration

  Report Options:
    - Include product images: Checkbox
    - Include user signatures: Checkbox
    - Include supporting documents: Checkbox
    - Include audit log: Checkbox
    - Encrypt report: Checkbox (password protected)

  Generate Button:
    - Primary, large
    - Processing: Shows progress bar
    - Time estimate: "~2 minutes"

Generated Report:
  - Report ID: Unique identifier
  - Generated: Timestamp
  - Generated by: User
  - Period: Date range
  - Location: Specified locations
  
  Actions:
    - Download: Immediate download
    - Email: Send to specified addresses
    - Archive: Store for future access
    - Share: Generate secure link (24hr expiry)
    - Print: Direct print dialog

Report Structure (PDF):
  
  Cover Page:
    - Business logo + name
    - Report title
    - Period covered
    - Generated date
    - Confidential watermark
  
  Table of Contents:
    - Clickable links to sections
  
  Executive Summary:
    - Key metrics
    - Significant findings
    - Compliance status
  
  Detailed Sections:
    - By report type
    - Tables with data
    - Charts/graphs
    - Supporting notes
  
  Appendices:
    - Raw data tables
    - Supporting documents
    - Methodology notes
  
  Certification:
    - Prepared by: Signature line
    - Reviewed by: Signature line
    - Approved by: Signature line
    - Date: Lines for each
  
  Footer:
    - Page numbers: "Page X of Y"
    - Report ID: On each page
    - Generated timestamp
```

---

## 7.6 Batch Operations Management

### State 7.6.1: Batch Master List

**Access**: Inventory → Batches

**Batch Management Dashboard (Desktop)**:
```
Page Layout:
  
  Header:
    - Title: "Batch Management"
    - Description: "Track and manage product batches"
    - Actions:
      - Filter/Sort: Icon
      - Export: CSV/Excel

  Filter Panel (Top, collapsible):
    
    Expiry Status (Pills/Chips):
      - All Batches (default)
      - Active (>90 days to expiry)
      - Expiring Soon (30-90 days)
      - Near Expiry (<30 days)
      - Expired
      - Recalled
    
    Date Range:
      - Expiry date: From-To pickers
      - Manufacturing date: From-To pickers
      - Received date: From-To pickers
    
    Product/Category:
      - Search: Product name
      - Category: Dropdown
    
    Location:
      - All locations
      - Specific location
    
    Supplier:
      - All suppliers
      - Specific supplier
    
    Quick Filters (Checkboxes):
      - ☐ Show only with stock (qty >0)
      - ☐ Show high-value batches only (>PKR X)
      - ☐ Show problem batches (quality issues)
      - ☐ Show batches for discount

  Batch List:
    - Table view (desktop) / Cards (mobile)
    
    Columns:
      1. Batch Number: Bold, large, copyable
      2. Product: Name + image thumbnail
      3. Supplier: Name
      4. Manufacturing Date: Date format
      5. Expiry Date: Date format, color-coded
         - Green: >90 days away
         - Yellow: 30-90 days
         - Orange: 7-30 days
         - Red: <7 days or expired
      6. Days to Expiry: Number, color-coded
      7. Quantity: Current stock in batch
      8. Location: Where stored
      9. Value: Qty × Cost = PKR XXX
      10. Status: Badge
          - Active (green)
          - Expiring Soon (yellow)
          - Expired (red)
          - Recalled (red)
          - Discounted (blue)
          - Depleted (gray)
      11. Actions: Icons
          - View details: Eye
          - Print label: Printer
          - Mark for discount: Tag
          - Recall: Alert
    
    Sorting:
      - Default: Expiry date (nearest first)
      - Clickable column headers
      - Ascending/descending toggle
    
    Batch Card (Mobile):
      - Height: 160px
      - Border: 2px left, color by status
      
      Content:
        - Batch number: Top, 16px bold
        - Product: Name + 48px image
        - Expiry: Large display with icon
        - Days remaining: Bold, color-coded
        - Quantity: "125 units in stock"
        - Location: With pin icon
        - Actions: Bottom row icons

  Batch Detail Panel (Click any batch):
    - Slides from right or opens modal
    - Width: 500px (desktop)
    
    Content:
      - Product image: 160x160px top
      - Product name: 24px bold
      - Batch number: 20px, copyable
      
      Tabs:
        Tab 1: Batch Information
          - Batch number
          - Manufacturing date
          - Expiry date
          - Days to expiry: Countdown
          - Supplier: Name + contact
          - Purchase order: Link to PO
          - Received date
          - Received by: User
          - Quality check: Pass/Fail status
        
        Tab 2: Stock & Location
          - Total quantity: Large display
          - Available: Sellable quantity
          - Reserved: For transfers/orders
          - By location: Breakdown
            - Location name
            - Quantity
            - Bin location
            - Last movement
          - Stock movements: Mini timeline
        
        Tab 3: Transactions
          - All transactions using this batch
          - Sales: Count + total qty sold
          - Returns: Count + qty returned
          - Adjustments: List
          - Transfers: In/Out
          - Current stock: Calculated
        
        Tab 4: Profitability
          - Purchase cost: PKR XXX per unit
          - Total cost: Qty × Cost
          - Sold quantity: N units
          - Sold value: PKR XXX
          - Remaining value: PKR XXX
          - Profit/loss: If batch depleted
          - Margin: Percentage
        
        Tab 5: Quality & Compliance
          - Quality check: Results
          - Inspected by: User + date
          - Test results: If applicable
          - Certifications: Uploads
          - Adverse events: Count + details
          - Recall status: Active/None
          - Pharmacovigilance: Notes
      
      Actions (Footer):
        - Print Batch Label: Generates barcode label
        - Mark for Discount: Adds discount tag
        - Initiate Recall: Opens recall process
        - Export Details: PDF report
        - Edit: Modify batch info (limited fields)
```

---

### State 7.6.2: Batch Label Printing

**Trigger**: "Print Label" action on batch

**Label Printing Interface**:
```
Modal: Label Design & Print
  
  Width: 700px
  
  Label Preview (Left, 60%):
    - Visual preview of label
    - Actual size: Toggle (100% / Fit to screen)
    
    Label Content:
      - Business logo: Top center
      - Product name: Large, bold
      - Batch number: Larger, barcode format
      - Manufacturing date: MM/YYYY
      - Expiry date: MM/YYYY, bold, red if <90 days
      - Quantity: N units
      - Barcode: Code 128 or QR code
      - Price: If configured
      - Instructions: If configured (e.g., "Store in cool, dry place")
    
    Label Size Options:
      - Small: 40mm × 25mm (shelf labels)
      - Medium: 60mm × 40mm (carton labels)
      - Large: 100mm × 60mm (pallet labels)
      - Custom: Manual dimensions

  Options (Right, 40%):
    
    Label Template:
      - Dropdown: Select saved templates
      - Templates:
        - "Shelf Label"
        - "Storage Label"
        - "Expiry Alert Label"
        - "Discount Label"
        - Custom templates
    
    Fields to Include (Checkboxes):
      - ☑ Business logo
      - ☑ Product name
      - ☑ Batch number
      - ☑ Manufacturing date
      - ☑ Expiry date
      - ☑ Barcode
      - ☐ Price
      - ☐ Supplier name
      - ☐ Storage instructions
      - ☐ Quantity
    
    Print Quantity:
      - Number input: How many labels
      - Default: 1
      - Max: 100 per print job
    
    Printer Selection:
      - Dropdown: Available printers
      - Options:
        - Bluetooth label printer
        - Network thermal printer
        - Standard inkjet/laser
        - PDF (save to file)
    
    Print Settings:
      - Label stock: Type of label paper
      - Color: B&W / Color
      - Quality: Draft / Normal / High

  Footer Actions:
    - Save Template: Saves current config
    - Cancel: Close modal
    - Preview PDF: Opens PDF preview
    - Print: Sends to printer
      - Shows: Print progress
      - Success: "X labels printed"
```

---

### State 7.6.3: Batch Recall Process

**Trigger**: Quality issue, contamination, regulatory order

**Recall Initiation Screen**:
```
Access: Batch Details → Initiate Recall

Modal: Batch Recall
  Width: 800px
  Cannot dismiss (must complete or cancel)
  
  Header:
    - Title: "Initiate Batch Recall"
    - Batch: Number + product name
    - Warning icon: 48px, red
    - Alert: "This is a serious action"

  Recall Details Form:
    
    Recall Type* (Radio, required):
      1. Voluntary Recall
         - Company-initiated
         - Quality concern
      
      2. Regulatory Recall
         - Ordered by authority
         - Regulation reference required
      
      3. Supplier Recall
         - Supplier-initiated
         - Upstream issue

    Recall Severity* (Radio, required):
      1. Class I - Critical
         - Serious health hazard
         - Potential death/injury
         - Action: Immediate removal
      
      2. Class II - Moderate
         - Temporary health problem
         - Low risk of injury
         - Action: Rapid removal
      
      3. Class III - Minor
         - No health consequence
         - Violation of regulations
         - Action: Routine removal

    Reason* (Required):
      - Dropdown:
        - "Contamination detected"
        - "Subpotent/Superpotent"
        - "Mislabeling"
        - "Packaging defect"
        - "Stability failure"
        - "Adverse reactions reported"
        - "Manufacturing error"
        - "Foreign material found"
        - "Other" (text input required)
    
    Detailed Description*:
      - Text area: 200-1000 characters
      - What is the specific issue?
      - Why is recall necessary?
      - What are the risks?
    
    Regulatory Reference:
      - Text input: If regulatory recall
      - Authority: Dropdown (FDA, WHO, local)
      - Reference number: Text input
    
    Affected Scope:
      - This batch only: Radio (default)
      - Multiple batches: Opens batch selector
      - Entire product line: Checkbox
    
    Recall Strategy:
      - Recall level:
        - Consumer level (end users)
        - Retail level (pharmacies, stores)
        - Wholesale level (distributors)
      
      - Actions to take:
        - ☑ Stop all sales immediately
        - ☑ Quarantine remaining stock
        - ☑ Notify customers who purchased
        - ☑ Arrange returns/refunds
        - ☑ Issue public notice
        - ☑ Report to authorities
    
    Timeline:
      - Recall initiated: Auto (now)
      - Customer notification: Date picker (default: today)
      - Recall deadline: Date picker (e.g., 30 days)
    
    Communication Plan:
      - Customer notification method:
        - ☑ Email (if addresses available)
        - ☑ SMS (if phone numbers available)
        - ☑ WhatsApp
        - ☑ In-store posters
        - ☐ Media announcement
        - ☐ Website notice
      
      - Notification message:
        - Pre-filled template
        - Editable text area
        - Preview: Button to see message
    
    Responsible Person:
      - Dropdown: Select recall coordinator
      - Default: Current user
      - Role: Manager/Quality Officer

  Affected Sales Display:
    - System automatically retrieves:
      - Number of units sold from this batch
      - Number of customers affected
      - Sales locations
      - Date range of sales
    
    - Table:
      - Customer name (if available)
      - Purchase date
      - Quantity purchased
      - Contact: Email/phone status
      - Notification: Status badge
    
    - Export: CSV of affected customers

  Footer Actions:
    - Cancel: Link (confirmation required)
    - Save Draft: Outlined (saves recall but doesn't activate)
    - Initiate Recall: Red primary
      - Confirmation dialog: "Are you absolutely sure?"
      - Requires: Manager PIN or approval
      - Action: Activates recall immediately
```

**Post-Recall Actions**:
```
Automatic System Actions:
  1. Batch Status: Changes to "RECALLED" (red)
  2. Sales Block: Batch cannot be sold at POS
  3. Stock Quarantine: Moved to quarantine location (virtual)
  4. Notifications: Sent to all specified channels
  5. Audit Log: Detailed entry created
  6. Alert Dashboard: Prominent recall alert
  7. Reports: Recall report generated
  8. Regulatory: Submission to authorities (if configured)

Recall Management Dashboard:
  - Access: Quality → Active Recalls
  
  Recall Card:
    - Red border, prominent
    - Recall ID + Batch number
    - Product: Name + image
    - Initiated: Date
    - Severity: Class I/II/III badge
    - Affected: N units, M customers
    - Status: In Progress / Completed
    
    - Progress tracking:
      - Customers notified: X of Y
      - Products returned: X of Y units
      - Refunds processed: PKR XXX
    
    - Actions:
      - View details: Full recall info
      - Update status: Mark progress
      - Customer communications: Resend notices
      - Close recall: Mark complete

  Recall Completion:
    - Completion form:
      - Units recovered: Count
      - Units outstanding: Count
      - Reason if incomplete: Text area
      - Disposition of recovered units:
        - Destroyed: Date + method
        - Returned to supplier
        - Quarantined for investigation
      - Financial impact: Total cost
      - Lessons learned: Text area
      - Preventive actions: Text area
    
    - Completion report:
      - Generated automatically
      - Includes all recall data
      - Ready for regulatory submission
    
    - Archive: Recall moved to history
```

---

## 7.7 Expiry Alert Actions

### State 7.7.1: Expiry Dashboard & Alerts

**Access**: Inventory → Expiring Products

**Expiry Management Dashboard**:
```
Page Layout:
  
  Header:
    - Title: "Expiring Products"
    - Description: "Manage products approaching expiry"
    - Alert badge: Count of items <30 days to expiry

  Alert Level Tabs:
    Tab 1: Critical (<30 days) - Red badge
    Tab 2: Warning (30-60 days) - Yellow badge
    Tab 3: Watch (60-90 days) - Orange badge
    Tab 4: All Products

  Summary Cards (Horizontal):
    Card 1: Expiring This Month
      - Number: "25 batches"
      - Value: "PKR 45,000"
      - Icon: Calendar, red
    
    Card 2: Expiring Next Month
      - Number: "18 batches"
      - Value: "PKR 32,000"
      - Icon: Calendar, yellow
    
    Card 3: Already Expired
      - Number: "5 batches"
      - Value: "PKR 8,000"
      - Icon: Alert, red
      - Status: "Requires action"
    
    Card 4: Discounted Items
      - Number: "12 batches"
      - Value: "PKR 15,000"
      - Icon: Tag, green
      - Status: "Active discount"

  Product List (Table View):
    
    Columns:
      1. Product: Name + image
      2. Batch Number: Clickable link
      3. Expiry Date: Date format
      4. Days Remaining: Number, color-coded
         - Red: <15 days
         - Orange: 15-30 days
         - Yellow: 31-60 days
      5. Quantity: Current stock
      6. Location: Where stored
      7. Value at Risk: PKR amount
      8. Action Status: Badge
         - "No action" (default)
         - "Discounted" (blue)
         - "Return requested" (yellow)
         - "Written off" (red)
         - "Sold out" (green)
      9. Actions: Dropdown
         - Apply discount
         - Request supplier return
         - Write off
         - Mark as damaged
         - Transfer to discount bin
    
    Sorting:
      - Default: Days remaining (ascending)
      - Clickable headers for all columns
    
    Filtering:
      - Location: Dropdown
      - Category: Dropdown
      - Value range: Min-Max inputs
      - Action status: Multi-select

  Bulk Actions:
    - Select multiple: Checkboxes
    - Toolbar: "X products selected"
    - Actions:
      - Apply bulk discount: Opens discount modal
      - Request return: Bulk return request
      - Generate report: Export selected
      - Print labels: Discount labels

  Action Quick Access (Right Panel):
    
    Quick Discount:
      - Input: Discount percentage
      - Preview: New price shown
      - Apply: Button
      - Result: Updates all selected products
    
    Supplier Return:
      - Checkbox: Select supplier
      - Filter: Products by supplier
      - Generate: Return request
      - Email: Auto-send to supplier
    
    Write-off:
      - Reason: Dropdown required
      - Authorization: Manager PIN
      - Confirm: Creates adjustment
      - Audit: Records in system
```

---

### State 7.7.2: Apply Discount for Expiring Products

**Trigger**: User selects product(s) and clicks "Apply Discount"

**Discount Configuration Modal**:
```
Modal: Discount for Expiring Products
  Width: 600px
  
  Header:
    - Title: "Apply Expiry Discount"
    - Products selected: "5 products"
    - Total value: "PKR 45,000"

  Product Preview:
    - List of selected products
    - Each shows: Name, batch, expiry, current price, quantity
    - Scrollable if >5 products

  Discount Configuration:
    
    Discount Type (Radio):
      1. Percentage Discount
         - Input: 10% to 90% slider
         - Recommended: Shows based on days to expiry
           - >60 days: 10-20%
           - 30-60 days: 20-40%
           - 15-30 days: 40-60%
           - <15 days: 60-80%
         - Live preview: Shows new price per product
      
      2. Fixed Amount
         - Input: PKR amount off
         - Preview: New price
      
      3. Buy 1 Get 1
         - Checkbox: Enable BOGO
         - Variant: 50% off second item
      
      4. Bundle Discount
         - Checkbox: Buy multiple units
         - Config: Buy X get Y% off

    Discount Duration:
      - Start: Date picker (default: today)
      - End: Date picker or "Until sold out"
      - Auto-remove: When batch expires

    Customer Tiers:
      - Apply to: Checkboxes
        - ☑ Walk-in customers
        - ☑ All customer tiers
        - ☐ Platinum only
        - ☐ Gold/Silver only
      - Or: "All customers" toggle

    Marketing Options:
      - Show discount badge at POS: Checkbox
      - Banner text: "Expiring soon - Save X%"
      - Label color: Color picker (default: orange)
      - In-store signage: Generate PDF poster

    Reason (Required):
      - Pre-filled: "Near expiry date"
      - Editable: Text area
      - Auto-logged: For audit trail

  Preview Section:
    - Table showing new prices:
      - Product | Current | Discount | New Price | Savings
    - Total discount: PKR XXX across all
    - Estimated revenue: If sold at new price

  Footer Actions:
    - Cancel: Link
    - Preview Labels: Opens label designer
    - Apply Discount: Primary
      - Validation: Ensures discount >0%, ≤90%
      - Action: Updates pricing rules
      - Result: Active at POS immediately
      - Notification: "Discount applied to 5 products"

Post-Application:
  - POS Integration: Discount auto-applies
  - Labels: Can print discount labels
  - Dashboard: Products moved to "Discounted" status
  - Reports: Tracked separately for analysis
  - Removal: Auto-removes when expired or sold out
```

---

### State 7.7.3: Supplier Return Request for Near-Expiry

**Trigger**: User selects products and clicks "Request Supplier Return"

**Return Request Form**:
```
Modal: Supplier Return Request
  Width: 700px
  
  Header:
    - Title: "Request Product Return"
    - Reason: "Near expiry"
    - Products: "8 products, PKR 32,000"

  Supplier Grouping:
    - Auto-groups: Products by supplier
    - Multiple suppliers: Creates separate requests
    
    Each Supplier Section:
      - Supplier name: 20px bold
      - Contact: Email + phone
      - Products: Count + total value
      - Expandable: Click to see product list
      
      Product Table:
        - Product | Batch | Qty | Expiry | Days Remaining | Value
        - Editable quantity: Can adjust qty to return
      
      Return Terms:
        - Check supplier agreement: Auto-loads terms
        - Return policy: Display if on file
        - Return window: "Must be >X days to expiry"
        - Restocking fee: If applicable (%)
        - Credit/Refund: Expected outcome

  Request Details:
    
    Reason (Pre-filled):
      - "Near expiry date"
      - Additional notes: Text area

    Urgency:
      - Normal (default)
      - Urgent (expires in <15 days)

    Preferred Resolution:
      - Credit note: Apply to future purchases
      - Refund: Bank transfer
      - Replacement: Different batch

    Return Method:
      - Supplier pickup: Date/time request
      - Ship to supplier: Tracking info
      - Drop at warehouse: Address

    Documentation:
      - Attach: Purchase invoice
      - Attach: Quality report (if applicable)
      - Attach: Photos of products

  Email Preview:
    - Toggle: "Preview email to supplier"
    - Shows: Auto-generated email
    - Subject: "Return Request - Near Expiry Products"
    - Body: Professional template
      - Company info
      - List of products
      - Reason
      - Request for approval
      - Attachment list
    - Editable: Can modify before sending

  Footer Actions:
    - Cancel: Link
    - Save Draft: Outlined
    - Send Request: Primary
      - Validation: All required fields
      - Action:
        - Sends email to supplier
        - Creates return request record
        - Quarantines products (optional)
        - Awaits supplier response
      - Confirmation: "Return request sent to [Supplier]"

Post-Request Tracking:
  - Status dashboard: Shows pending returns
  - Supplier response: Email integration
  - Approval: Updates status
  - Processing: When supplier agrees
  - Completion: When credit/refund received
```

---

## 7.8 Inventory Valuation

### State 7.8.1: Valuation Method Selection

**Access**: Inventory → Valuation → Settings

**Valuation Method Configuration**:
```
Page Layout:
  
  Header:
    - Title: "Inventory Valuation Settings"
    - Description: "Configure how inventory cost is calculated"
    - Warning: "Changing methods affects financial reports"

  Valuation Method (Radio Cards):
    
    Card 1: FIFO (First In, First Out)
      - Icon: Arrow forward
      - Description: "Cost based on oldest purchase first"
      - Use case: "Standard for most businesses"
      - Pros:
        - Most intuitive
        - Matches physical flow (especially for perishables)
        - Higher profit in rising price environment
      - Cons:
        - Higher tax liability in inflation
      - Example:
        - Buy 10 @ PKR 100 = PKR 1,000
        - Buy 10 @ PKR 120 = PKR 1,200
        - Sell 10: COGS = PKR 1,000 (oldest first)
      - Status: ☑ Currently active

    Card 2: LIFO (Last In, First Out)
      - Icon: Arrow backward
      - Description: "Cost based on newest purchase first"
      - Use case: "Tax optimization in inflation"
      - Pros:
        - Lower profit (higher COGS) in inflation
        - Tax advantages
        - Matches current costs
      - Cons:
        - Not allowed in many countries
        - Doesn't match physical flow
      - Example:
        - Buy 10 @ PKR 100 = PKR 1,000
        - Buy 10 @ PKR 120 = PKR 1,200
        - Sell 10: COGS = PKR 1,200 (newest first)
      - Status: ☐ Select

    Card 3: Weighted Average Cost (WAC)
      - Icon: Balance scale
      - Description: "Cost is average of all purchases"
      - Use case: "Consistent pricing, commodity items"
      - Pros:
        - Smooths price fluctuations
        - Simple to calculate
        - Stable COGS
      - Cons:
        - May not reflect actual unit costs
      - Example:
        - Buy 10 @ PKR 100 = PKR 1,000
        - Buy 10 @ PKR 120 = PKR 1,200
        - Avg cost: (1,000+1,200) / 20 = PKR 110
        - Sell 10: COGS = PKR 1,100
      - Status: ☐ Select

    Card 4: Specific Identification
      - Icon: Fingerprint
      - Description: "Track actual cost of each unit"
      - Use case: "High-value, unique items"
      - Pros:
        - Most accurate
        - Matches actual costs
      - Cons:
        - Complex tracking
        - Not practical for high-volume
      - Example: Each unit tracked individually
      - Status: ☐ Select

  Per-Product Override:
    - Checkbox: "Allow per-product valuation methods"
    - If enabled:
      - High-value items: Can use Specific Identification
      - Fast-moving items: Can use FIFO
      - Commodities: Can use WAC
      - Set at: Product level in inventory settings

  Change Impact Analysis:
    - Button: "Simulate Method Change"
    - Opens calculator showing:
      - Current inventory value: PKR XXX,XXX
      - Value under new method: PKR XXX,XXX
      - Difference: ±PKR XXX
      - Impact on: COGS, Profit, Tax
      - Recommendation: Based on business type

  Effective Date:
    - Date picker: When to apply new method
    - Options:
      - Start of fiscal year (recommended)
      - Start of month
      - Today (immediate)
    - Warning: "Mid-period changes affect comparability"

  Authorization:
    - Requires: CFO or Business Owner approval
    - Approval method: Digital signature or PIN
    - Audit: Change logged with reason

Footer Actions:
  - Cancel: Link
  - Save Changes: Primary
    - Confirmation: "Change valuation method?"
    - Impact summary: Shows again
    - Approval: Required
    - Action: Updates system settings
```

---

### State 7.8.2: Inventory Valuation Report

**Access**: Reports → Inventory → Valuation Report

**Valuation Report Interface**:
```
Page Layout:
  
  Header:
    - Title: "Inventory Valuation Report"
    - As of date: Date picker (default: today)
    - Valuation method: Display current method

  Summary Section:
    
    KPI Cards (Horizontal):
      Card 1: Total Inventory Value
        - Amount: "PKR 2,450,000" (large, bold)
        - Icon: Inventory box
        - Trend: vs last period (±X%)
      
      Card 2: Inventory Turnover
        - Ratio: "4.2x" (annual)
        - Icon: Refresh circle
        - Benchmark: Industry avg
      
      Card 3: Days Inventory
        - Days: "87 days"
        - Icon: Calendar
        - Target: vs goal
      
      Card 4: Carrying Cost
        - Amount: "PKR 45,000" (monthly)
        - Percentage: "2.2% of value"
        - Icon: Currency

  Valuation Breakdown:
    
    By Category (Pie Chart + Table):
      - Visual: Pie chart showing value %
      - Table columns:
        - Category
        - Quantity (units)
        - Value (PKR)
        - % of Total
        - Avg Cost per Unit
        - Turnover Rate
      
      Example rows:
        - Pain Relief: 5,234 units, PKR 450,000, 18%, PKR 86
        - Antibiotics: 2,890 units, PKR 680,000, 28%, PKR 235
        - Vitamins: 8,120 units, PKR 320,000, 13%, PKR 39
    
    By Location (Bar Chart + Table):
      - Visual: Horizontal bar chart
      - Table columns:
        - Location
        - Quantity
        - Value
        - % of Total
        - Space Utilization
      
      Example rows:
        - Main Warehouse: 15,450, PKR 1,200,000, 49%, 75%
        - Store #1: 8,230, PKR 650,000, 27%, 88%
        - Store #2: 6,890, PKR 600,000, 24%, 92%
    
    By Age (Histogram + Table):
      - Visual: Age distribution chart
      - Buckets:
        - 0-30 days: Fresh inventory
        - 31-90 days: Normal
        - 91-180 days: Aging
        - 181-365 days: Slow-moving
        - >365 days: Dead stock
      - Each bucket: Quantity, Value, %

  Detailed Product List:
    - Sortable, filterable table
    - Columns:
      1. Product: Name + image
      2. Category: Name
      3. Location: Primary location
      4. Quantity: On hand
      5. Cost per Unit: PKR
      6. Total Value: Qty × Cost
      7. Last Purchase: Date
      8. Last Sale: Date
      9. Turnover: Times per year
      10. Age: Days in inventory
    
    - Filters:
      - Category: Multi-select
      - Location: Multi-select
      - Value range: Min-Max
      - Age range: Days
      - Turnover: High/Medium/Low
      - Status: Active/Slow-moving/Dead stock
    
    - Sorting: Any column
    - Export: CSV/Excel with all data

  Reconciliation Section:
    
    Opening Balance:
      - Date: Start of period
      - Quantity: N units
      - Value: PKR XXX,XXX
    
    Additions:
      - Purchases: Qty, Value
      - Transfers In: Qty, Value
      - Adjustments (positive): Qty, Value
      - Total additions: Sum
    
    Deductions:
      - Sales: Qty, Value (at cost)
      - Transfers Out: Qty, Value
      - Adjustments (negative): Qty, Value
      - Write-offs: Qty, Value
      - Total deductions: Sum
    
    Closing Balance:
      - Date: End of period
      - Calculated: Opening + Additions - Deductions
      - Physical count: If cycle count done
      - Variance: Difference
      - Value: PKR XXX,XXX

  Variance Analysis (if discrepancies):
    - Table showing:
      - Product
      - Book quantity
      - Physical quantity
      - Variance (±)
      - Value impact
      - Possible reason
      - Status: Investigated/Pending

Footer Actions:
  - Export: PDF/Excel buttons
  - Email: Send report
  - Schedule: Set up recurring reports
  - Print: Formatted for printing
```

**Light Theme Styling**:
```
KPI Cards:
  - Background: #FFFFFF
  - Border: 1px solid #E8EAED
  - Shadow: Elevation 1
  - Number: #0F4C4C, 36px Bold
  - Trend indicator:
    - Positive: #4CAF50, up arrow
    - Negative: #F44336, down arrow

Charts:
  - Pie: Distinct colors per category
  - Bar: #0F4C4C primary, #1A6363 secondary
  - Grid lines: #E8EAED
  - Labels: #44474E

Table:
  - Header: #F8F9FA background, #44474E text
  - Rows: Alternating #FFFFFF / #FAFBFC
  - Borders: #E8EAED
  - Hover: #F8F9FA background
```

**Dark Theme Styling**:
```
KPI Cards:
  - Background: #2A2A2A
  - Border: 1px solid #404040
  - Number: #C5E64D, 36px Bold
  - Trend indicator:
    - Positive: #66BB6A
    - Negative: #EF5350

Charts:
  - Colors: Adjusted for dark background
  - Grid lines: #404040
  - Labels: #C7C7C7

Table:
  - Header: #1E1E1E background
  - Rows: Alternating #2A2A2A / #333333
  - Borders: #404040
```

---

### State 7.8.3: Cost Adjustment & Revaluation

**Context**: Adjust inventory costs for errors or market changes

**Cost Adjustment Interface**:
```
Access: Inventory → Valuation → Adjust Costs

Page Layout:
  
  Header:
    - Title: "Inventory Cost Adjustment"
    - Warning: "This affects financial statements"
    - Current method: Display

  Adjustment Type (Radio):
    
    1. Single Product Adjustment
       - Adjust cost of one product
       - Use case: Purchase price error
    
    2. Batch Cost Adjustment
       - Adjust cost of specific batch
       - Use case: Invoice correction
    
    3. Bulk Category Adjustment
       - Adjust costs across category
       - Use case: Market price change
    
    4. Revaluation to Market
       - Adjust to current market prices
       - Use case: NRV (Net Realizable Value)

  Product Selection:
    - Search: Product name/SKU
    - Filter: Category, location
    - Batch: If applicable

  Current Cost Information:
    - Product: Name + image
    - Current cost: PKR X.XX per unit
    - Quantity on hand: N units
    - Current total value: PKR XXX
    - Last updated: Date

  New Cost Entry:
    - New cost per unit*: PKR input
    - Reason* (Required): Dropdown
      - "Purchase invoice correction"
      - "Supplier price adjustment"
      - "Market price change"
      - "Net realizable value adjustment"
      - "Currency fluctuation"
      - "Accounting error"
      - "Other" (text input)
    
    - Effective date: Date picker
      - Default: Today
      - Or: Retroactive (with approval)
    
    - Supporting document: Upload
      - Invoice, price list, etc.

  Impact Analysis (Auto-calculated):
    - Cost change: Old → New
    - Per unit impact: ±PKR X.XX
    - Total inventory impact: ±PKR XXX
    - Percentage change: ±X.X%
    - Effect on:
      - COGS (if retroactive)
      - Profit/Loss
      - Inventory value
      - Tax

  Authorization:
    - Threshold: Adjustments >PKR X require approval
    - Manager PIN: If over threshold
    - CFO approval: If material (>5% of inventory)
    - Reason: Must be detailed

  Footer Actions:
    - Cancel: Link
    - Preview Impact: Shows before/after
    - Apply Adjustment: Primary
      - Validation: All required fields
      - Confirmation: Shows impact summary
      - Action: Updates costs
      - Audit: Detailed log entry
      - Notification: Alerts accounting team
```

---

## Summary - Part 5 Complete

**Part 5 Coverage**:
✅ 7.1 Stock Adjustments (3 states)
✅ 7.2 Cycle Count Operations (5 states)
✅ 7.3 Inter-Location Transfers (5 states)
✅ 7.4 Goods Receiving / GRN (3 states)
✅ 7.5 Stock Movement Audit Trail (3 states)
✅ 7.6 Batch Operations (3 states)
✅ 7.7 Expiry Alert Actions (3 states)
✅ 7.8 Inventory Valuation (3 states)

**Total States in Part 5**: 28 comprehensive states

**Key Design Patterns**:
- Two-panel layouts for selection + action
- Mobile-optimized scanning interfaces
- Multi-step wizards for complex flows
- Real-time validation and calculations
- Manager approval workflows
- Comprehensive audit logging
- Responsive tables with virtual scrolling
- Color-coded status indicators
- Anomaly detection and flagging

---

**End of Part 5 Document**

Next: Part 6 - Reporting & Analytics