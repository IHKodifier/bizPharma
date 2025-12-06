# bizPharma - States Expansion Design Brief (Part 3)

## Document Information

**Version**: 1.0  
**Date**: December 2024  
**Document**: Part 3 of States Expansion Series  
**Scope**: POS & Inventory Setup  
**Coverage**: First-Time Setup → Product Management → Category Organization → Stock Configuration → Customer Tiers  
**Platforms**: Mobile, Tablet, Desktop, Web  
**Themes**: Light & Dark (explicitly documented for each state)  
**Granularity**: Detailed with micro-interactions, animations, and platform variations

---

## What This Document Covers

This is **Part 3** focusing on:

1. ✅ First-Time Dashboard Landing
2. ✅ Product Management
   - Add Product (Manual Entry)
   - Bulk Product Import
   - Product Editing & Deletion
3. ✅ Category Management
   - Category Creation
   - Hierarchical Categories
   - Category Assignment
4. ✅ Barcode Management
   - Barcode Scanning
   - Barcode Generation
   - Duplicate Handling
5. ✅ Stock Level Configuration
   - Initial Stock Entry
   - Min/Max Levels
   - Reorder Points
6. ✅ Batch & Expiry Setup (Pharmacy-Specific)
   - Batch Tracking Configuration
   - Expiry Warning Levels
   - FEFO Settings
7. ✅ Customer Tier Setup
   - Tier Creation
   - Pricing Rules
   - Credit Management

**Previous Documents**:  
- **Part 1**: Landing Page, Authentication Flows  
- **Part 2**: Business Onboarding & Configuration  

**Next Document (Part 4)**: Live POS Operations

---

## Design System References

Building upon:
- **Part 1**: Authentication patterns
- **Part 2**: Onboarding flows
- **Style Guide**: `/mnt/project/4_a_Style_Guide__bizPharma.md`
- **Feature Stories**: `/mnt/project/3__Feature_Stories_bizPharma.md`
- **Architecture**: `/mnt/project/2__High_Level_Architecture_bizPharma.md`

---

# 5. FIRST-TIME DASHBOARD & SETUP PROMPTS

## 5.1 Dashboard First Load (Post-Onboarding)

### State 5.1.1: Empty Dashboard - Desktop

**Trigger**: User completes onboarding, lands on dashboard for first time (no sample data)

**Visual Layout - Desktop (1280px+)**:
```
Screen Structure:
  - Top Navigation Bar: 64px height
  - Left Sidebar: 240px width (collapsible)
  - Main Content Area: Flex 1
  - Background: Theme surface color

Top Navigation:
  - Logo: Left, 120px width
  - Business Name: Next to logo, 16px Inter Medium
  - Search Bar: Center, 400px width (grayed out, "Search products...")
  - Notification Bell: Right side, badge if new
  - User Avatar: Far right, dropdown menu
  - Theme Toggle: Sun/Moon icon, transitions between light/dark

Left Sidebar:
  - Navigation items (vertical list):
    1. Dashboard (active)
    2. POS
    3. Inventory
    4. Procurement
    5. Customers
    6. Reports
    7. Settings
  
  Each Item:
    - Icon: 24px, left
    - Label: 14px Inter Medium
    - Height: 48px
    - Padding: 12px 16px
    - Active: Primary background color (10% opacity), left border 4px
    - Hover: Background tint
    - Ripple on click

Main Content Area:
  - Header Section: 120px height
    - Greeting: "Welcome, [User Name]!" 28px Inter Semibold
    - Date/Time: "Saturday, December 06, 2024" 14px Inter Regular, gray
    - Quick Actions: Row of 3 buttons
      - "Make a Sale" (primary)
      - "Add Product" (secondary)
      - "View Reports" (text button)

  Empty State Section:
    - Centered content, max-width 600px
    - Icon: Large empty box/clipboard, 120px, gray
    - Title: "Let's set up your inventory"
    - 24px Inter Semibold, primary color
    - Description: "Add products to start managing sales and stock"
    - 16px Inter Regular, secondary color, margin 16px top
    
    - Action Cards (3 cards, horizontal row):
      Card 1: "Add Your First Product"
        - Icon: Plus circle, 40px, primary
        - Title: 18px Inter Semibold
        - Description: "Manually add product details"
        - CTA: "Add Product" button
        - Hover: Lift + shadow
      
      Card 2: "Import Products"
        - Icon: Upload, 40px, secondary color
        - Title: "Bulk Import"
        - Description: "Upload CSV with multiple products"
        - CTA: "Import File"
        - Hover: Lift + shadow
      
      Card 3: "Learn More"
        - Icon: Book/play, 40px, tertiary
        - Title: "Watch Tutorial"
        - Description: "5-minute video guide"
        - CTA: "Watch Now"
        - Hover: Lift + shadow

  Stats Overview (Placeholder):
    - Row of 4 stat cards
    - Each: 200px width, 120px height
    - Background: Surface with border
    - Content: "—" (no data yet)
    - Labels: "Total Products", "Total Sales", "Low Stock Items", "Revenue Today"
```

**Light Theme Styling**:
```
Top Nav:
  - Background: #FFFFFF
  - Border bottom: 1px solid #E8EAED
  - Shadow: 0px 1px 3px rgba(0, 0, 0, 0.06)

Sidebar:
  - Background: #F8F9FA
  - Border right: 1px solid #E8EAED
  
  Active Item:
    - Background: rgba(15, 76, 76, 0.1) (#0F4C4C with 10% opacity)
    - Left border: 4px solid #0F4C4C
    - Text: #0F4C4C
  
  Hover Item:
    - Background: #FFFFFF

Main Content:
  - Background: #F8F9FA

Header:
  - Greeting: #0F4C4C
  - Date: #44474E

Empty State:
  - Icon: #9E9E9E
  - Title: #0F4C4C
  - Description: #44474E

Action Cards:
  - Background: #FFFFFF
  - Border: 1px solid #E8EAED
  - Border radius: 12px
  - Padding: 24px
  - Shadow: 0px 1px 3px rgba(0, 0, 0, 0.06)
  
  Hover:
    - Transform: translateY(-4px)
    - Shadow: 0px 4px 12px rgba(0, 0, 0, 0.1)
    - Border: 2px solid #0F4C4C

Stat Cards:
  - Background: #FFFFFF
  - Border: 1px solid #E8EAED
  - Value: #9E9E9E (gray for "—")
  - Label: #44474E
```

**Dark Theme Styling**:
```
Top Nav:
  - Background: #2A2A2A
  - Border bottom: 1px solid #404040
  - Shadow: 0px 1px 3px rgba(0, 0, 0, 0.3)

Sidebar:
  - Background: #1E1E1E
  - Border right: 1px solid #404040
  
  Active Item:
    - Background: rgba(197, 230, 77, 0.1)
    - Left border: 4px solid #C5E64D
    - Text: #C5E64D
  
  Hover Item:
    - Background: #2A2A2A

Main Content:
  - Background: #1E1E1E

Header:
  - Greeting: #C5E64D
  - Date: #C7C7C7

Empty State:
  - Icon: #666666
  - Title: #C5E64D
  - Description: #C7C7C7

Action Cards:
  - Background: #2A2A2A
  - Border: 1px solid #404040
  
  Hover:
    - Border: 2px solid #C5E64D
    - Shadow: 0px 4px 12px rgba(197, 230, 77, 0.15)

Stat Cards:
  - Background: #2A2A2A
  - Border: 1px solid #404040
  - Value: #666666
  - Label: #C7C7C7
```

**Dashboard Entry Animation**:
```dart
class DashboardFirstLoad extends StatefulWidget {
  @override
  _DashboardFirstLoadState createState() => _DashboardFirstLoadState();
}

class _DashboardFirstLoadState extends State<DashboardFirstLoad>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _staggerController;
  
  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    
    _staggerController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _fadeController.forward();
    Future.delayed(Duration(milliseconds: 300), () {
      _staggerController.forward();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildTopNav(),
      body: Row(
        children: [
          // Sidebar slides in from left
          AnimatedBuilder(
            animation: _fadeController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(-50 * (1 - _fadeController.value), 0),
                child: Opacity(
                  opacity: _fadeController.value,
                  child: child,
                ),
              );
            },
            child: _buildSidebar(),
          ),
          
          // Main content fades in with stagger
          Expanded(
            child: AnimatedBuilder(
              animation: _staggerController,
              builder: (context, child) {
                return Column(
                  children: [
                    // Header
                    _buildAnimatedElement(
                      widget: dashboardHeader,
                      delay: 0.0,
                      animation: _staggerController,
                    ),
                    
                    // Empty state
                    _buildAnimatedElement(
                      widget: emptyStateSection,
                      delay: 0.2,
                      animation: _staggerController,
                    ),
                    
                    // Action cards
                    _buildAnimatedElement(
                      widget: actionCardsRow,
                      delay: 0.4,
                      animation: _staggerController,
                    ),
                    
                    // Stats placeholder
                    _buildAnimatedElement(
                      widget: statsRow,
                      delay: 0.6,
                      animation: _staggerController,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAnimatedElement({
    required Widget widget,
    required double delay,
    required Animation<double> animation,
  }) {
    final elementAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(
          delay,
          (delay + 0.3).clamp(0.0, 1.0),
          curve: Curves.easeOut,
        ),
      ),
    );
    
    return FadeTransition(
      opacity: elementAnimation,
      child: Transform.translate(
        offset: Offset(0, 30 * (1 - elementAnimation.value)),
        child: widget,
      ),
    );
  }
}
```

**Action Card Hover Animation**:
```dart
class ActionCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;
  
  @override
  _ActionCardState createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  bool _isHovered = false;
  
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _isHovered ? -4 : 0, 0),
          decoration: BoxDecoration(
            color: surfaceColor,
            border: Border.all(
              color: _isHovered ? primaryColor : borderColor,
              width: _isHovered ? 2.0 : 1.0,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: _isHovered ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 4),
                blurRadius: 12,
              ),
            ] : [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                offset: Offset(0, 1),
                blurRadius: 3,
              ),
            ],
          ),
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                widget.icon,
                size: 40,
                color: _isHovered ? primaryColor : iconColor,
              ),
              SizedBox(height: 16),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: _isHovered ? primaryColor : titleColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 14,
                  color: secondaryTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

### State 5.1.2: Dashboard with Sample Data - Desktop

**Differences from Empty State**:
```
Main Content Area:
  - No empty state section
  - Stats cards show actual data (not "—")
  - Recent activity feed appears
  - Quick actions remain at top

Stats Cards (Populated):
  Card 1: Total Products
    - Value: "50", 32px Inter Semibold, primary color
    - Label: "Total Products", 14px
    - Change: "+50 from yesterday", 12px, success color
    - Icon: Box, 24px, top-right
  
  Card 2: Total Sales
    - Value: "PKR 25,340", 32px
    - Label: "Today's Sales"
    - Change: "+12% from yesterday", success
    - Icon: TrendingUp, 24px
  
  Card 3: Low Stock Items
    - Value: "3", 32px, warning color
    - Label: "Items Below Min Stock"
    - Change: "Reorder needed", warning color
    - Icon: AlertTriangle, 24px
  
  Card 4: Revenue
    - Value: "PKR 125,670", 32px
    - Label: "This Month"
    - Change: "+8% from last month", success
    - Icon: DollarSign, 24px

Recent Activity Feed:
  - Title: "Recent Activity", 18px Inter Semibold
  - List of 5 most recent actions:
    - Sale completed: "Sale #001 - PKR 1,200"
    - Product added: "Product: Panadol 500mg added"
    - Stock alert: "Low stock: Product X"
  - Each item: 48px height, icon left, time stamp right
  - "View All" link at bottom

Chart Section (if sample data):
  - Sales trend: Line chart, 7 days
  - Height: 300px
  - Interactive: Hover shows values
```

---

### State 5.1.3: Dashboard - Tablet & Mobile

**Tablet Adjustments (768px - 1279px)**:
```
Sidebar:
  - Collapsible: Icon only mode (64px width)
  - Labels appear on hover as tooltip
  - Or hidden completely with hamburger menu

Stats Cards:
  - 2x2 grid (instead of 1x4 row)
  - Full width in pairs

Action Cards:
  - 2 cards per row (instead of 3)
  - Third card wraps to next row
```

**Mobile Layout (<768px)**:
```
Top Nav:
  - Height: 56px
  - Hamburger menu: Left (opens sidebar as drawer)
  - Logo: Center
  - Avatar: Right
  - Search: Hidden, shows on tap (full-screen search)

Sidebar:
  - Drawer: Slides in from left
  - Full overlay: Semi-transparent backdrop
  - Width: 280px
  - Close: X button top-right or tap backdrop

Main Content:
  - Padding: 16px (reduced from 24px)
  - Header:
    - Greeting: 20px (reduced from 28px)
    - Quick actions: Vertical stack (not row)

Stats Cards:
  - Vertical stack (not grid)
  - Full width each
  - Height: 100px
  - Swipeable carousel (optional)

Action Cards:
  - Vertical stack
  - Full width each
  - Height: Auto
  - Spacing: 12px

Empty State Icon:
  - Size: 80px (reduced from 120px)
```

---

## 5.2 Product Management - Add Product

### State 5.2.1: Add Product - Form Entry (Desktop)

**Trigger**: User clicks "Add Product" button from dashboard or inventory page

**Access Points**:
1. Dashboard → "Add Product" action card
2. Inventory page → "+ Add Product" button (top-right)
3. Quick actions menu → "Add Product"

**Form Layout - Desktop**:
```
Modal Dialog (centered):
  - Width: 800px
  - Max-height: 90vh (scrollable)
  - Background: Surface color
  - Border radius: 16px
  - Shadow: 0px 8px 32px rgba(0, 0, 0, 0.12)
  - Backdrop: Semi-transparent (rgba(0, 0, 0, 0.6))

Header:
  - Height: 64px
  - Padding: 20px 24px
  - Border bottom: 1px solid outline color
  - Title: "Add Product", 20px Inter Semibold
  - Close button: X icon, 24px, top-right

Form Content:
  - Padding: 24px
  - Scrollable area
  - Two-column layout (on desktop)
  - Left column: Primary fields
  - Right column: Secondary fields + preview

Footer (Sticky):
  - Height: 72px
  - Padding: 16px 24px
  - Border top: 1px solid outline color
  - Background: Surface color
  - Buttons:
    - Cancel: Outlined, left
    - Save Draft: Text button, center-left
    - Add Product: Filled primary, right

Form Sections (Accordion Style):

Section 1: Basic Information (Expanded by default)
  Left Column:
    1. Product Name* (required)
       - Input: Text field
       - Height: 48px
       - Placeholder: "e.g., Panadol 500mg"
       - Max length: 100 chars
       - Counter: "0/100"
       - Validation: Real-time on blur
    
    2. Generic Name
       - Input: Text field
       - Placeholder: "e.g., Paracetamol"
       - Helper: "For pharmacy items only"
       - Conditional: Shows if business type = Pharmacy
    
    3. Category* (required)
       - Input: Searchable dropdown
       - Placeholder: "Select or create category"
       - Options: Existing categories + "Create New"
       - Height: 48px
    
    4. Sub-Category
       - Input: Dropdown (depends on Category)
       - Disabled until category selected
       - Options: Filtered by parent category
  
  Right Column:
    5. Product Image
       - Upload area: 200x200px square
       - Dashed border: 2px, primary color
       - Icon: Camera, 48px, center
       - Text: "Click or drag to upload"
       - Supported: JPG, PNG (max 5MB)
       - Preview: Shows uploaded image
       - Remove button: X icon, top-right (on hover)

Section 2: Identification
  Left Column:
    1. Barcode / SKU*
       - Input: Text field with scan button
       - Scan button: Icon (barcode), right side
       - Action: Opens camera for scanning
       - Generate button: Below field
       - Text: "Generate barcode", primary color link
    
    2. Manufacturer
       - Input: Searchable dropdown
       - Options: Existing + "Add New"
    
    3. Brand
       - Input: Text field
       - Placeholder: "e.g., GSK, Pfizer"

Section 3: Pharmacy-Specific (Conditional)
  Shows only if: Business type = Pharmacy
  
  1. Salt Composition
     - Input: Text field
     - Placeholder: "e.g., Paracetamol 500mg"
  
  2. Dosage Form*
     - Input: Dropdown
     - Options: Tablet, Capsule, Syrup, Injection, Cream, Ointment, Drops, etc.
  
  3. Strength
     - Input: Text field
     - Placeholder: "e.g., 500mg, 10mg/ml"
  
  4. Pack Size
     - Input: Text field
     - Placeholder: "e.g., 10 tablets, 100ml bottle"
  
  5. Prescription Required
     - Input: Toggle switch
     - Default: Off
     - Label: "Requires prescription"
  
  6. Controlled Substance
     - Input: Toggle switch
     - If enabled: Shows schedule dropdown
     - Options: Schedule I, II, III, IV, V

Section 4: Pricing & Stock
  Two-column grid:
  
  Left:
    1. Unit of Measure*
       - Dropdown: Piece, Box, Pack, Kg, Liter, etc.
       - Default: Piece
    
    2. Base Price* (PKR)
       - Number input
       - Prefix: "PKR" inside field
       - Placeholder: "0.00"
       - Validation: > 0
    
    3. Purchase Cost
       - Number input
       - Prefix: "PKR"
       - Helper: "Cost from supplier (for margin calc)"
  
  Right:
    4. Tax Category
       - Dropdown: Standard, Reduced, Zero-Rated, Exempt
       - Default: Standard
    
    5. Minimum Stock Level*
       - Number input
       - Placeholder: "e.g., 10"
       - Helper: "Alert when stock falls below this"
    
    6. Reorder Point
       - Number input
       - Placeholder: "e.g., 20"
       - Helper: "When to reorder (≥ min stock)"

Section 5: Supplier & Procurement
  1. Primary Supplier
     - Searchable dropdown
     - Options: Existing suppliers + "Add New"
     - Optional
  
  2. Lead Time (Days)
     - Number input
     - Placeholder: "e.g., 7"
     - Helper: "Days from PO to delivery"
  
  3. Minimum Order Quantity (MOQ)
     - Number input
     - Placeholder: "e.g., 50"
     - Helper: "Supplier's minimum order"
```

**Light Theme Styling**:
```
Modal:
  - Background: #FFFFFF
  - Shadow: 0px 8px 32px rgba(0, 0, 0, 0.12)

Header:
  - Background: #FFFFFF
  - Border: 1px solid #E8EAED
  - Title: #0F4C4C
  - Close button: #44474E, hover #0F4C4C

Form Fields:
  - Border: 1px solid #D1D4D9 (default)
  - Focus: 2px solid #0F4C4C
  - Background: #FFFFFF
  - Text: #1C1C1C
  - Placeholder: #9E9E9E

Sections:
  - Header background: #F8F9FA
  - Border: 1px solid #E8EAED
  - Expand icon: #44474E

Image Upload:
  - Border: 2px dashed #0F4C4C
  - Background: #F8F9FA
  - Icon: #0F4C4C
  - Text: #44474E

Footer:
  - Background: #FFFFFF
  - Border: 1px solid #E8EAED
  - Cancel: Border #D1D4D9, text #44474E
  - Save Draft: Text #0F4C4C
  - Add Product: Background #0F4C4C, text #FFFFFF
```

**Dark Theme Styling**:
```
Modal:
  - Background: #2A2A2A
  - Shadow: 0px 8px 32px rgba(0, 0, 0, 0.5)

Header:
  - Background: #2A2A2A
  - Border: 1px solid #404040
  - Title: #C5E64D
  - Close button: #C7C7C7, hover #C5E64D

Form Fields:
  - Border: 1px solid #404040
  - Focus: 2px solid #C5E64D
  - Background: #333333
  - Text: #E5E5E5
  - Placeholder: #666666

Sections:
  - Header background: #1E1E1E
  - Border: 1px solid #404040
  - Expand icon: #C7C7C7

Image Upload:
  - Border: 2px dashed #C5E64D
  - Background: #1E1E1E
  - Icon: #C5E64D
  - Text: #C7C7C7

Footer:
  - Background: #2A2A2A
  - Border: 1px solid #404040
  - Cancel: Border #404040, text #C7C7C7
  - Save Draft: Text #C5E64D
  - Add Product: Background #C5E64D, text #2C3500
```

**Modal Entrance Animation**:
```dart
class AddProductModal extends StatefulWidget {
  @override
  _AddProductModalState createState() => _AddProductModalState();
}

class _AddProductModalState extends State<AddProductModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    
    _controller.forward();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                width: 800,
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildHeader(),
                    Expanded(
                      child: _buildForm(),
                    ),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
```

---

### State 5.2.2: Product Form - Field Interactions

**Product Name Field - Focus State**:
```
Visual Changes:
  - Border: 1px → 2px solid primary color
  - Border width transition: 200ms ease-out
  - Label: Floats up if not already (Material style)
  - Character counter: Appears (fades in)

Animation:
```dart
AnimatedContainer(
  duration: Duration(milliseconds: 200),
  decoration: BoxDecoration(
    border: Border.all(
      color: isFocused ? focusColor : borderColor,
      width: isFocused ? 2.0 : 1.0,
    ),
    borderRadius: BorderRadius.circular(8),
  ),
  child: TextField(
    onChanged: (value) => setState(() => charCount = value.length),
    decoration: InputDecoration(
      labelText: 'Product Name',
      border: InputBorder.none,
      suffixText: '$charCount/100',
      suffixStyle: TextStyle(
        fontSize: 12,
        color: secondaryTextColor,
      ),
    ),
  ),
)
```

**Category Dropdown - Interaction**:
```
Click/Tap:
  - Border: 2px solid primary (focus)
  - Dropdown panel: Slides down (200ms)
  - Options list: Fade in with stagger (each item 50ms delay)
  - Backdrop: Appears on mobile (semi-transparent)

Dropdown Panel:
  - Position: Below field (or above if near bottom)
  - Width: Same as field width
  - Max height: 320px (scrollable)
  - Background: Surface color
  - Border: 1px solid outline color
  - Border radius: 8px
  - Shadow: 0px 4px 16px rgba(0, 0, 0, 0.12)
  - Z-index: 1000

Search Input (inside dropdown):
  - Sticky top
  - Height: 40px
  - Placeholder: "Search categories..."
  - Icon: Search, 18px, left
  - Clear button: X, appears when typing

Category Options:
  - Each item: 44px height
  - Hover: Background tint
  - Selected: Background primary tint + checkmark
  - Icon: Folder, 20px, left
  - Text: 14px Inter Regular
  - Sub-categories: Indented 24px, smaller font (13px)

"Create New Category" Option:
  - Always at bottom (sticky)
  - Icon: Plus circle, 20px
  - Text: "+ Create New Category", primary color
  - Hover: Background tint
  - Click: Opens create category modal
```

**Image Upload - Interaction**:
```
Default State:
  - Dashed border: 2px, primary color
  - Background: Light tint
  - Icon: Camera, 48px
  - Text: "Click or drag to upload"
  - Hover: Border solid, background darker tint

Drag Over State:
  - Border: Solid 3px, primary color
  - Background: Primary color with 0.1 opacity
  - Icon: Upload arrow, 48px
  - Text: "Drop image here"
  - Scale: 1.02 (slight expand)

Uploading State:
  - Progress spinner: 40px, center
  - Text: "Uploading... 45%"
  - Progress bar: Linear, bottom (3px height)

Upload Complete:
  - Image preview: Fills area (200x200px)
  - Overlay (on hover): Semi-transparent
  - Actions (on hover):
    - Remove: X icon, top-right, red
    - Replace: Upload icon, center
  - Border: 1px solid success color (green)

Upload Error:
  - Border: 2px solid error color (red)
  - Icon: Alert triangle, 40px, red
  - Text: "Upload failed - try again"
  - Retry button: Below text
```

**Barcode Scan Button**:
```
Visual:
  - Position: Inside barcode field, right side
  - Icon: Barcode scanner, 20px
  - Size: 36x36px (circular)
  - Background: Primary color (filled)
  - Text color: White
  - Hover: Background lightens

Click Action:
  - Opens camera overlay (full screen on mobile)
  - Or QR/barcode scanner widget (desktop)
  - See State 5.3 for detailed scanning flow
```

**Toggle Switch (Prescription Required, Controlled Substance)**:
```
Default (Off):
  - Track: 48px width, 24px height
  - Track color: #E8EAED (light) / #404040 (dark)
  - Thumb: 20px diameter circle, white
  - Thumb position: Left

Transition (200ms):
  - Thumb slides right
  - Track color changes to primary
  - Smooth easing curve

Active (On):
  - Track color: Primary color
  - Thumb position: Right
  - Thumb color: White (light) / Surface color (dark)

Label:
  - Text: 14px Inter Medium
  - Position: Right of toggle (8px spacing)
  - Color: Updates on state change

Animation:
```dart
AnimatedContainer(
  duration: Duration(milliseconds: 200),
  curve: Curves.easeInOut,
  width: 48,
  height: 24,
  decoration: BoxDecoration(
    color: isOn ? primaryColor : trackColorOff,
    borderRadius: BorderRadius.circular(12),
  ),
  child: AnimatedAlign(
    duration: Duration(milliseconds: 200),
    curve: Curves.easeInOut,
    alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      width: 20,
      height: 20,
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
    ),
  ),
)
```

---

### State 5.2.3: Form Validation - Real-Time

**Product Name Validation**:
```
Validation Rules:
  1. Required (cannot be empty)
  2. Minimum 3 characters
  3. Maximum 100 characters
  4. No special characters: <, >, {, }

Validation Triggers:
  - On blur (lose focus)
  - On form submit
  - Real-time character count

Error State (Empty):
  - Trigger: User clicks submit with empty field
  - Border: 2px solid #DC3545 (error red)
  - Error icon: Alert circle, 16px, right side of field
  - Error message: Below field
    - Icon: Error circle, 14px, left
    - Text: "Product name is required"
    - Style: 12px Inter Regular, error color
    - Animation: Slides down (200ms)
  - Field shake: 3 times, 400ms total (elastic curve)

Success State (Valid):
  - Border: 2px solid #28A745 (success green)
  - Success icon: Checkmark circle, 16px, right
  - Icon animation: Scale from 0 to 1 (300ms elastic)
  - No message (success indicated by icon only)

Warning State (Too Long):
  - When approaching limit: Character count turns orange (90/100)
  - At limit: Character count red, "Maximum length reached"
  - Can't type more characters (input blocked)
```

**Barcode Duplicate Check**:
```
Validation:
  - Checks on blur if barcode entered
  - API call: Check if barcode exists in database
  - Debounced: 500ms delay after typing stops

Checking State:
  - Small spinner: Right side of field
  - Text: "Checking..." (below field, gray)

Duplicate Found:
  - Border: 2px solid warning color (orange/yellow)
  - Warning icon: Alert triangle, 16px
  - Warning message: "This barcode already exists for [Product Name]"
  - Action buttons:
    - "View Product": Text link, opens product in new tab
    - "Use Anyway": Checkbox below message
  - Form submit: Blocked until "Use Anyway" checked

Available:
  - Border: 2px solid success color
  - Checkmark: 16px, right side
  - Message: "Barcode available" (brief, 2s, then fades)
```

**Price Validation**:
```
Rules:
  - Must be > 0
  - Can have decimals (up to 2 places)
  - Cannot be negative

Error States:
  - Zero or negative: "Price must be greater than 0"
  - Invalid format: "Please enter a valid price"

Visual:
  - Currency prefix: "PKR" inside field (left side, gray)
  - Decimal handling: Auto-formats to 2 places on blur
  - Example: User types "100" → Displays "100.00"

Validation Animation:
```dart
TextFormField(
  keyboardType: TextInputType.numberWithOptions(decimal: true),
  inputFormatters: [
    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
  ],
  decoration: InputDecoration(
    prefixIcon: Padding(
      padding: EdgeInsets.only(left: 16, right: 8),
      child: Center(
        widthFactor: 0.0,
        child: Text(
          'PKR',
          style: TextStyle(fontSize: 14, color: secondaryTextColor),
        ),
      ),
    ),
    prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Price is required';
    }
    final price = double.tryParse(value);
    if (price == null || price <= 0) {
      return 'Price must be greater than 0';
    }
    return null;
  },
)
```

**Min Stock vs Reorder Point Validation**:
```
Business Rule:
  - Reorder Point must be >= Minimum Stock Level
  - Ideally: Reorder Point > Min Stock (to avoid stockouts)

Validation:
  - Real-time: When either field changes
  - If Reorder Point < Min Stock:
    - Warning message: "Reorder point should be ≥ minimum stock"
    - Color: Warning orange
    - Not blocking (can still save, just warns)

Visual Relationship:
  - Helper text shows calculated relationship:
    - Min Stock: 10, Reorder Point: 20
    - Helper: "Will reorder when 20 units remain (2x min stock)"
```

---

### State 5.2.4: Section Accordion - Expand/Collapse

**Section Header**:
```
Visual:
  - Height: 48px
  - Background: Section header color
  - Border: 1px solid outline color
  - Border radius: 8px (top corners)
  - Padding: 12px 16px
  - Cursor: pointer

Content:
  - Title: 16px Inter Semibold, left
  - Required indicator: "* Required" text, 12px, gray, next to title (if section has required fields)
  - Expand icon: Chevron, 20px, right
    - Down (v) when collapsed
    - Up (^) when expanded
    - Rotates 180° on toggle

Hover:
  - Background: Lighter/darker tint
  - Border: Thicker or color change
```

**Expand/Collapse Animation**:
```dart
class AccordionSection extends StatefulWidget {
  final String title;
  final bool isRequired;
  final Widget content;
  final bool initiallyExpanded;
  
  @override
  _AccordionSectionState createState() => _AccordionSectionState();
}

class _AccordionSectionState extends State<AccordionSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  bool _isExpanded = false;
  
  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
      value: _isExpanded ? 1.0 : 0.0,
    );
    
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }
  
  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: _toggleExpanded,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: sectionHeaderColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Row(
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: titleColor,
                    ),
                  ),
                  if (widget.isRequired)
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        '* Required',
                        style: TextStyle(
                          fontSize: 12,
                          color: secondaryTextColor,
                        ),
                      ),
                    ),
                  Spacer(),
                  AnimatedRotation(
                    duration: Duration(milliseconds: 300),
                    turns: _isExpanded ? 0.5 : 0.0, // 180° rotation
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: iconColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Content (animated)
          SizeTransition(
            sizeFactor: _expandAnimation,
            axisAlignment: -1.0, // Top-aligned expansion
            child: Container(
              padding: EdgeInsets.all(16),
              child: widget.content,
            ),
          ),
        ],
      ),
    );
  }
}
```

---

### State 5.2.5: Save Product - Success Flow

**Trigger**: User clicks "Add Product" with all required fields valid

**Button Loading State**:
```
Visual Changes:
  - Button: Disabled (can't re-click)
  - Text: "Adding Product..."
  - Spinner: 16px circular progress, left of text
  - Background: Maintains color but slightly dimmed (opacity 0.9)

Light Theme:
  - Background: #0F4C4C (opacity 0.9)
  - Spinner: #FFFFFF
  - Text: #FFFFFF

Dark Theme:
  - Background: #C5E64D (opacity 0.9)
  - Spinner: #2C3500
  - Text: #2C3500

Animation:
```dart
FilledButton(
  onPressed: isLoading ? null : _handleSubmit,
  style: FilledButton.styleFrom(
    backgroundColor: isLoading
        ? primaryColor.withOpacity(0.9)
        : primaryColor,
  ),
  child: isLoading
      ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(onPrimaryColor),
              ),
            ),
            SizedBox(width: 12),
            Text('Adding Product...'),
          ],
        )
      : Text('Add Product'),
)
```

**Success Sequence**:
```
1. Form data submitted (500ms simulated)
2. Product created in database
3. Modal shows success state (1.5s)
4. Modal closes with scale-out animation (300ms)
5. If on inventory page: List updates with new product
6. Toast notification: "Product added successfully"
7. Optional: Ask "Add another product?"
```

**Success State (Inside Modal)**:
```
Replaces form content:
  - Checkmark icon: 80px, success color
  - Animation: Draws from center (800ms)
  - Title: "Product Added!", 24px Inter Semibold, success color
  - Product name: "[Product Name]" below title, 16px, gray
  - Barcode: Shows generated/entered barcode
  - Message: "Product is now in your inventory"

Actions (Bottom):
  - "Add Another Product" button: Outlined, resets form
  - "View Product" button: Text link, opens product detail
  - Auto-close: After 3 seconds if no action
  - Or "Close" button: Returns to previous screen
```

**Toast Notification**:
```
Position: Bottom center (desktop), top (mobile)
  - Width: Auto (max 400px)
  - Height: 56px
  - Background: Success color
  - Text: White, 14px Inter Medium
  - Icon: Checkmark circle, 20px, left
  - Border radius: 8px
  - Shadow: 0px 4px 12px rgba(0, 0, 0, 0.15)
  - Padding: 16px 20px

Animation:
  - Slides up from bottom (desktop) or down from top (mobile)
  - Duration: 300ms
  - Auto-dismiss: After 4 seconds (fade out)
  - Swipe to dismiss: Swipe up (mobile)

Light Theme:
  - Background: #28A745
  - Text: #FFFFFF

Dark Theme:
  - Background: #4ADE80
  - Text: #003912
```

**Inventory List Update**:
```
If user on inventory page:
  - New product: Animates into list at top
  - Animation: Slides in from right + fade (400ms)
  - Highlight: Brief success color tint (2s fade out)
  - List: Re-sorts if needed (alphabetical, etc.)
```

---

### State 5.2.6: Save Draft - Partial Save

**Trigger**: User clicks "Save Draft" button

**Purpose**: Save partially completed form for later

**Draft Save Flow**:
```
1. Validates minimum required fields:
   - Product Name (required)
   - Category (required)
   - At least one identifier (barcode or SKU)

2. If minimum met:
   - Saves as draft with status = "DRAFT"
   - Shows success message
   - Modal closes
   - Draft appears in inventory with "Draft" badge

3. If minimum not met:
   - Error toast: "Please fill in product name, category, and barcode/SKU to save draft"
   - Highlights missing fields (red borders)
```

**Draft Badge (in Inventory List)**:
```
Visual:
  - Badge: Pill shape, 60px width, 20px height
  - Text: "Draft", 11px Inter Medium
  - Background: Warning color with 0.2 opacity
  - Text color: Warning color (darker)
  - Position: Next to product name

Light Theme:
  - Background: rgba(255, 193, 7, 0.2)
  - Text: #856404
  - Border: 1px solid #FFC107

Dark Theme:
  - Background: rgba(251, 242, 36, 0.2)
  - Text: #FDE68A
  - Border: 1px solid #FBF24
```

**Resume Draft**:
```
Access: Click draft product in inventory list

Action:
  - Opens Add Product modal
  - Title changes: "Edit Draft - [Product Name]"
  - Form pre-filled with saved data
  - Footer buttons:
    - Delete Draft: Outlined error color, left
    - Save Draft: Text button, center
    - Publish Product: Filled primary, right
  - Validation: Same as regular add
```

---

### State 5.2.7: Add Product - Mobile Layout

**Mobile Adaptation (<768px)**:
```
Presentation: Full-screen (not modal)
  - Header: Fixed top, 56px height
  - Content: Scrollable
  - Footer: Fixed bottom, with safe area

Header:
  - Back arrow: Left, closes form
  - Title: "Add Product", centered, 18px
  - Save icon: Right (floppy disk), saves draft

Form Layout:
  - Single column (no left/right split)
  - Padding: 16px horizontal
  - Field height: 52px (larger touch targets)
  - Spacing: 16px between fields

Section Headers:
  - Full width
  - Height: 44px
  - Tap to expand/collapse

Image Upload:
  - Full width (not fixed 200px)
  - Aspect ratio: 16:9 or 1:1
  - Height: Auto based on width

Footer Buttons:
  - Stack vertically
  - Add Product: Full width, 52px height, bottom
  - Save Draft: Full width, 48px height, above
  - Cancel: Text button, top of footer
  - Spacing: 12px between

Keyboard Handling:
  - Auto-scroll to focused field
  - Field not obscured by keyboard
  - "Done" button on keyboard: Moves to next field
  - Last field "Done": Submits form (if valid)

Barcode Scan:
  - Tapping barcode field: Shows options modal
    - "Scan with Camera"
    - "Enter Manually"
    - "Generate Barcode"
  - Camera scan: Full-screen overlay
```

---

## 5.3 Barcode Scanning & Generation

### State 5.3.1: Barcode Scan - Camera Overlay (Mobile)

**Trigger**: User taps "Scan Barcode" button or barcode field on mobile

**Full-Screen Camera Interface**:
```
Layout:
  - Camera feed: Full screen (below status bar, above controls)
  - Overlay: Semi-transparent dark overlay with clear scanning window
  - Controls: Bottom bar, 96px height with safe area

Scanning Window:
  - Center screen
  - Size: 280px width, 140px height (rectangular)
  - Border: 4px, primary color (animated)
  - Border animation: Pulsing (opacity 0.6 → 1.0 → 0.6, 2s loop)
  - Corners: Enhanced (thicker lines at corners, "L" shapes)
  - Background: Clear (camera visible)

Helper Elements:
  - Instruction text (above window):
    - "Align barcode within frame"
    - 16px Inter Medium, white
    - Background: Semi-transparent black (for contrast)
    - Padding: 8px 16px
    - Border radius: 20px (pill shape)
  
  - Scan line (inside window):
    - Horizontal line: 2px height, primary color
    - Animated: Moves from top to bottom (1.5s loop)
    - Glow effect: Blur shadow

Bottom Controls:
  - Background: rgba(0, 0, 0, 0.8)
  - Height: 96px + safe area
  
  Controls (horizontal row):
    - Flash toggle: Left
      - Icon: Flash on/off, 28px
      - Size: 56px circle
      - Background: rgba(255, 255, 255, 0.2)
      - Active: Primary color fill
    
    - Cancel button: Center
      - Text: "Cancel", 16px Inter Medium
      - Style: Outlined white
      - Height: 48px, min width: 120px
    
    - Manual entry: Right
      - Text: "Enter Manually"
      - Style: Text button, white
      - Icon: Keyboard, 20px

Light Theme Overlay:
  - Overlay tint: rgba(0, 0, 0, 0.6)
  - Scanning window border: #0F4C4C
  - Scan line: #0F4C4C with glow
  - Controls background: rgba(255, 255, 255, 0.95)
  - Controls text: #1C1C1C

Dark Theme Overlay:
  - Overlay tint: rgba(0, 0, 0, 0.8)
  - Scanning window border: #C5E64D
  - Scan line: #C5E64D with glow
  - Controls background: rgba(42, 42, 42, 0.95)
  - Controls text: #E5E5E5
```

**Scan Line Animation**:
```dart
class ScanLineAnimation extends StatefulWidget {
  @override
  _ScanLineAnimationState createState() => _ScanLineAnimationState();
}

class _ScanLineAnimationState extends State<ScanLineAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: ScanLinePainter(
            progress: _animation.value,
            color: primaryColor,
          ),
          size: Size(280, 140), // Scanning window size
        );
      },
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ScanLinePainter extends CustomPainter {
  final double progress;
  final Color color;
  
  ScanLinePainter({required this.progress, required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    
    // Calculate Y position (top to bottom)
    final y = size.height * progress;
    
    // Draw line
    canvas.drawLine(
      Offset(0, y),
      Offset(size.width, y),
      paint,
    );
    
    // Draw glow effect
    final glowPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8);
    
    canvas.drawLine(
      Offset(0, y),
      Offset(size.width, y),
      glowPaint,
    );
  }
  
  @override
  bool shouldRepaint(ScanLinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
```

**Scan Success State**:
```
Trigger: Barcode detected and recognized

Sequence:
  1. Scan line stops moving
  2. Window border flashes green (3 pulses, 300ms each)
  3. Success checkmark: Appears in center (scale animation)
  4. Haptic feedback: Success vibration
  5. Sound: Brief beep (optional, user preference)
  6. Barcode value displayed: Below window, 18px mono font
  7. Confirmation buttons appear:
     - "Use This Barcode": Primary button
     - "Scan Again": Outlined button
  8. Auto-confirm: After 2 seconds if no action
  9. Camera overlay closes
  10. Form field populated with scanned barcode
```

**Scan Error State**:
```
Trigger: Invalid/unrecognizable barcode

Visual:
  - Window border flashes red (2 pulses)
  - Error message: "Barcode not recognized"
  - 14px, red, below window
  - Haptic feedback: Error vibration

Options:
  - "Try Again": Continues scanning
  - "Enter Manually": Switches to manual input
  - Auto-retry: Keeps scanning automatically
```

---

### State 5.3.2: Barcode Scan - Desktop Widget

**Desktop Implementation** (since no camera typically):
```
Option 1: USB Barcode Scanner
  - Field listens for keyboard input
  - Scanner acts as keyboard (types barcode + Enter)
  - No special UI needed
  - Auto-fills field when scanned

Option 2: Webcam Scanning
  - Click "Scan" button opens widget
  - Widget: 400px width, 300px height modal
  - Shows webcam feed in small window
  - Same scanning frame as mobile (scaled down)
  - Works like mobile version but in modal

Option 3: Manual Entry Prompted
  - Button click shows tooltip:
    - "Connect a USB barcode scanner or enter manually"
  - Focuses field for typing
```

---

### State 5.3.3: Barcode Generation

**Trigger**: User clicks "Generate Barcode" link below barcode field

**Generation Modal**:
```
Modal Dialog:
  - Width: 480px
  - Center screen
  - Background: Surface color
  - Border radius: 16px

Header:
  - Title: "Generate Barcode", 20px Inter Semibold
  - Close button: X, top-right

Content:
  - Barcode Type Selector:
    - Radio cards (3 options):
      1. EAN-13 (European Article Number)
         - Description: "13-digit standard barcode"
         - Common for retail products
      2. Code 128
         - Description: "Compact, alphanumeric"
         - Good for internal use
      3. QR Code
         - Description: "2D barcode with more data"
         - Can store product URL
    - Each card: 140px height, icon + description
  
  - Preview Section:
    - Generated barcode: Large display, 300px width
    - Barcode value: Below image, 18px mono font
    - Regenerate button: If random generation
  
  - Options:
    - "Use custom value": Checkbox
      - If checked: Shows text input for custom barcode
      - Validates: Correct format for selected type
    - "Add to product": Checkbox (default checked)

Footer:
  - "Generate Another": Text button, left
  - "Use This Barcode": Primary button, right

Light Theme:
  - Modal background: #FFFFFF
  - Radio cards: #FFFFFF with border
  - Selected card: #E0F2F2 background, #0F4C4C border
  - Barcode preview: White background (important for scanning)

Dark Theme:
  - Modal background: #2A2A2A
  - Radio cards: #2A2A2A with border
  - Selected card: #2C3500 background, #C5E64D border
  - Barcode preview: #FFFFFF background (always light for scanability)
```

**Barcode Preview Component**:
```dart
class BarcodePreview extends StatelessWidget {
  final String value;
  final BarcodeType type;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white, // Always white for scanning
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Barcode image (generated via package)
          BarcodeWidget(
            barcode: _getBarcodeFormat(type),
            data: value,
            width: 300,
            height: 80,
            drawText: false,
          ),
          
          SizedBox(height: 12),
          
          // Barcode value text
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Courier New', // Monospace
              fontWeight: FontWeight.w500,
              color: Colors.black, // Always dark on white bg
            ),
          ),
        ],
      ),
    );
  }
  
  Barcode _getBarcodeFormat(BarcodeType type) {
    switch (type) {
      case BarcodeType.EAN13:
        return Barcode.ean13();
      case BarcodeType.CODE128:
        return Barcode.code128();
      case BarcodeType.QR:
        return Barcode.qrCode();
      default:
        return Barcode.code128();
    }
  }
}
```

**Generation Success**:
```
Sequence:
  1. User selects type and options
  2. Clicks "Use This Barcode"
  3. Modal closes (scale out, 300ms)
  4. Product form barcode field: Populates with generated value
  5. Success indicator: Green checkmark appears
  6. Preview: Small barcode thumbnail shows in field (optional)
```

---

## 5.4 Category Management

### State 5.4.1: Create Category - Inline Modal

**Trigger**: User clicks "+ Create New Category" in category dropdown

**Modal Type**: Small overlay dialog (not full-screen)

**Desktop Layout**:
```
Modal Dialog:
  - Width: 420px
  - Position: Center screen (or near category field)
  - Background: Surface color
  - Border radius: 12px
  - Shadow: 0px 8px 24px rgba(0, 0, 0, 0.15)
  - Backdrop: Semi-transparent

Header:
  - Height: 56px
  - Padding: 16px 20px
  - Border bottom: 1px solid outline color
  - Title: "Create Category", 18px Inter Semibold
  - Close: X button, top-right

Form Content:
  - Padding: 20px
  
  Fields:
    1. Category Name* (required)
       - Input: Text field
       - Height: 48px
       - Placeholder: "e.g., Pain Relief, Antibiotics"
       - Max length: 50 characters
       - Counter: "0/50"
       - Validation: Real-time on blur
       - No special characters
    
    2. Parent Category (optional)
       - Dropdown: Shows existing categories
       - Option: "None (Top Level)"
       - Allows hierarchical organization
       - Disabled if no categories exist yet
    
    3. Category Icon (optional)
       - Icon picker: Grid of icons
       - Default icons: 20 medical/retail icons
       - Selected icon: Highlighted with border
       - Size: 32px display, 24px grid items
    
    4. Description (optional)
       - Text area: 72px height
       - Placeholder: "Category description (optional)"
       - Max length: 200 characters
       - Counter: "0/200"

Footer:
  - Height: 64px
  - Padding: 12px 20px
  - Border top: 1px solid outline color
  - Buttons:
    - Cancel: Outlined, 40px height
    - Create: Filled primary, 40px height
  - Layout: Space-between
```

**Light Theme**:
```
Modal:
  - Background: #FFFFFF
  - Shadow: 0px 8px 24px rgba(0, 0, 0, 0.15)

Header:
  - Background: #FFFFFF
  - Border: 1px solid #E8EAED
  - Title: #0F4C4C
  - Close: #44474E, hover #0F4C4C

Fields:
  - Border: 1px solid #D1D4D9
  - Focus: 2px solid #0F4C4C
  - Background: #FFFFFF
  - Text: #1C1C1C
  - Placeholder: #9E9E9E

Icon Picker:
  - Grid background: #F8F9FA
  - Icon: #44474E
  - Selected: Border 2px #0F4C4C, background #E0F2F2
  - Hover: Background #FFFFFF

Footer:
  - Background: #FFFFFF
  - Border: 1px solid #E8EAED
```

**Dark Theme**:
```
Modal:
  - Background: #2A2A2A
  - Shadow: 0px 8px 24px rgba(0, 0, 0, 0.5)

Header:
  - Background: #2A2A2A
  - Border: 1px solid #404040
  - Title: #C5E64D
  - Close: #C7C7C7, hover #C5E64D

Fields:
  - Border: 1px solid #404040
  - Focus: 2px solid #C5E64D
  - Background: #333333
  - Text: #E5E5E5
  - Placeholder: #666666

Icon Picker:
  - Grid background: #1E1E1E
  - Icon: #C7C7C7
  - Selected: Border 2px #C5E64D, background #2C3500
  - Hover: Background #333333

Footer:
  - Background: #2A2A2A
  - Border: 1px solid #404040
```

**Icon Picker Grid**:
```dart
class IconPicker extends StatefulWidget {
  final IconData? selectedIcon;
  final Function(IconData) onSelect;
  
  @override
  _IconPickerState createState() => _IconPickerState();
}

class _IconPickerState extends State<IconPicker> {
  final List<IconData> availableIcons = [
    Icons.medical_services,
    Icons.medication,
    Icons.vaccines,
    Icons.local_pharmacy,
    Icons.healing,
    Icons.favorite,
    Icons.psychology,
    Icons.sanitizer,
    Icons.face_retouching_natural,
    Icons.child_care,
    Icons.elderly,
    Icons.visibility,
    Icons.hearing,
    Icons.ac_unit,
    Icons.wb_sunny,
    Icons.nutrition,
    Icons.fitness_center,
    Icons.spa,
    Icons.hot_tub,
    Icons.night_shelter,
  ];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: gridBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: availableIcons.length,
        itemBuilder: (context, index) {
          final icon = availableIcons[index];
          final isSelected = icon == widget.selectedIcon;
          
          return InkWell(
            onTap: () => widget.onSelect(icon),
            borderRadius: BorderRadius.circular(6),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: isSelected ? selectedBackgroundColor : Colors.transparent,
                border: Border.all(
                  color: isSelected ? primaryColor : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                icon,
                size: 24,
                color: isSelected ? primaryColor : iconColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
```

**Create Success**:
```
Sequence:
  1. User fills name (required) + optional fields
  2. Clicks "Create"
  3. Button shows loading (spinner + "Creating...")
  4. Category created (300ms)
  5. Success animation: Green checkmark (400ms)
  6. Modal closes (scale out, 200ms)
  7. Product form category dropdown: New category auto-selected
  8. Toast: "Category '[Name]' created"
```

---

### State 5.4.2: Category Management Page

**Access**: Settings → Inventory → Manage Categories

**Desktop Layout**:
```
Page Structure:
  - Page header: "Product Categories", 28px Inter Semibold
  - Action buttons: Top-right
    - "+ Add Category": Primary button
    - Import/Export: Icon buttons

Content Area:
  Left Panel (320px width):
    - Category tree view
    - Hierarchical list (parent/child relationships)
    - Drag-and-drop reordering
    - Search: Text input at top
  
  Right Panel (Flex 1):
    - Category details (when selected)
    - Empty state: "Select a category to view details"

Category Tree Item:
  - Height: 44px
  - Indentation: 24px per level
  - Icon: Category icon, 20px, left
  - Name: 14px Inter Medium
  - Product count: "(12)", 13px gray, right
  - Actions (on hover):
    - Edit: Pencil icon, 16px
    - Delete: Trash icon, 16px
    - Add sub-category: Plus icon, 16px
  - Drag handle: Left side (6 dots icon)

Category Details Panel:
  When category selected:
  
  Header:
    - Icon: Large, 48px
    - Name: 24px Inter Semibold
    - Edit button: Top-right
  
  Stats Cards (3 cards, horizontal):
    1. Total Products: [N]
    2. In Stock: [N] / [Total]
    3. Low Stock: [N] products
  
  Products List:
    - Table: All products in this category
    - Columns: Image, Name, Stock, Price, Actions
    - Pagination: 20 per page
    - Filter: Search products within category
  
  Actions Section:
    - "Add Product to Category": Button
    - "Delete Category": Danger button (if 0 products)
    - "Merge with Another Category": Text link
```

**Drag-and-Drop Reordering**:
```dart
class DraggableCategoryItem extends StatelessWidget {
  final Category category;
  final Function(Category) onReorder;
  
  @override
  Widget build(BuildContext context) {
    return Draggable<Category>(
      data: category,
      feedback: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 280,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(0, 4),
                blurRadius: 12,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(category.icon, size: 20),
              SizedBox(width: 12),
              Text(
                category.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _buildCategoryTile(category),
      ),
      child: DragTarget<Category>(
        onWillAccept: (data) => data != category,
        onAccept: (data) => onReorder(data),
        builder: (context, candidateData, rejectedData) {
          final bool isHovering = candidateData.isNotEmpty;
          
          return AnimatedContainer(
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isHovering
                  ? primaryColor.withOpacity(0.1)
                  : Colors.transparent,
              border: Border(
                top: isHovering
                    ? BorderSide(color: primaryColor, width: 2)
                    : BorderSide.none,
              ),
            ),
            child: _buildCategoryTile(category),
          );
        },
      ),
    );
  }
}
```

---

### State 5.4.3: Delete Category Confirmation

**Trigger**: User clicks delete icon on category with 0 products

**Confirmation Dialog**:
```
Modal:
  - Width: 480px
  - Center screen
  
Header:
  - Icon: Warning triangle, 48px, warning color
  - Title: "Delete '[Category Name]'?", 20px Inter Semibold

Content:
  - Message: "This action cannot be undone."
  - If has sub-categories:
    - Additional text: "This category has [N] sub-categories. They will also be deleted."
    - List: Shows sub-category names (max 3, then "+ N more")
  
  - Reassurance: "No products will be affected."

Footer:
  - Cancel: Outlined button
  - Delete: Filled error color button
  - Text input confirmation (if >5 sub-categories):
    - "Type DELETE to confirm"
    - Delete button: Disabled until text matches
```

**Delete with Products - Blocking**:
```
If category has products:
  - Delete button: Disabled
  - Message: "Cannot delete category with [N] products"
  - Actions offered:
    1. "Move products to another category"
       - Opens dropdown to select target category
       - "Move [N] Products" button
    2. "Delete products too"
       - Requires typing "DELETE ALL"
       - Very destructive, requires extra confirmation
```

---

## 5.5 Stock Level Configuration

### State 5.5.1: Initial Stock Entry - Wizard

**Access**: Settings → Inventory → Set Initial Stock Levels

**Purpose**: Bulk entry of opening stock for multiple products

**Wizard Layout - Desktop**:
```
Full-page wizard (like onboarding):
  - Progress: "Step 1 of 3", "Step 2 of 3", "Step 3 of 3"
  - Navigation: Back, Continue buttons

Step 1: Select Products
  - Title: "Select products to set stock levels"
  - Description: "Choose which products to add opening stock for"
  
  Product List:
    - Checkbox column: Multi-select
    - Columns: Image, Name, Category, Current Stock (if any)
    - Filter: By category
    - Search: Product name/barcode
    - "Select All" checkbox: Header
    - Selected count: "12 products selected"
  
  Continue: Enabled when ≥1 product selected

Step 2: Enter Stock Levels
  - Title: "Enter stock quantities for selected products"
  - Description: "Set opening stock and location for each product"
  
  Product Cards (Vertical List):
    Each card shows:
      - Product image: 64x64px, left
      - Product name: 16px Inter Medium
      - Category: 13px gray, below name
      
      Right side inputs (horizontal row):
        1. Location: Dropdown
           - Default: Head Office
           - Options: All locations
        
        2. Quantity*: Number input
           - Width: 120px
           - Placeholder: "0"
           - Validation: ≥ 0
        
        3. Batch Number (optional, if pharmacy):
           - Width: 140px
           - Placeholder: "e.g., BATCH001"
        
        4. Expiry Date (optional, if pharmacy):
           - Date picker
           - Width: 140px
           - Format: DD/MM/YYYY
      
      Remove button: X icon, top-right (removes from wizard)
  
  Bulk Actions (Top):
    - "Apply to all" dropdown:
      - Set same location for all
      - Set same batch for all (if applicable)
    - "Add another location": Creates duplicate entries for multi-location
  
  Continue: Enabled when all quantities filled

Step 3: Review & Confirm
  - Title: "Review stock entries"
  - Description: "Verify details before adding to inventory"
  
  Summary Table:
    - Columns: Product, Location, Quantity, Batch, Expiry, Total Value
    - Total Value: Calculated from purchase cost × quantity
    - Grouped by: Location (collapsible sections)
  
  Summary Cards (3 cards):
    1. Total Products: [N]
    2. Total Quantity: [Sum]
    3. Total Value: PKR [Sum]
  
  Final Actions:
    - "Add to Inventory": Primary button
    - "Save as Draft": Text link
    - "Export List": Button (saves as CSV for record)
```

**Step 2 Product Card Component**:
```dart
class StockEntryCard extends StatelessWidget {
  final Product product;
  final Function(StockEntry) onUpdate;
  final Function() onRemove;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              product.imageUrl ?? defaultImageUrl,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          
          SizedBox(width: 16),
          
          // Product info
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  product.category.name,
                  style: TextStyle(
                    fontSize: 13,
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(width: 16),
          
          // Input fields
          Expanded(
            flex: 3,
            child: Row(
              children: [
                // Location dropdown
                SizedBox(
                  width: 140,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                    ),
                    items: locations.map((loc) {
                      return DropdownMenuItem(
                        value: loc.id,
                        child: Text(loc.name),
                      );
                    }).toList(),
                    onChanged: (value) => onUpdate(
                      StockEntry(locationId: value),
                    ),
                  ),
                ),
                
                SizedBox(width: 12),
                
                // Quantity input
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Quantity*',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => onUpdate(
                      StockEntry(quantity: int.tryParse(value)),
                    ),
                  ),
                ),
                
                SizedBox(width: 12),
                
                // Batch number (conditional)
                if (isPharmacy)
                  SizedBox(
                    width: 140,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Batch',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => onUpdate(
                        StockEntry(batchNumber: value),
                      ),
                    ),
                  ),
                
                if (isPharmacy)
                  SizedBox(width: 12),
                
                // Expiry date (conditional)
                if (isPharmacy)
                  SizedBox(
                    width: 140,
                    child: DatePickerField(
                      labelText: 'Expiry',
                      onSelect: (date) => onUpdate(
                        StockEntry(expiryDate: date),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          SizedBox(width: 12),
          
          // Remove button
          IconButton(
            icon: Icon(Icons.cancel, color: errorColor),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
```

**Add to Inventory - Processing**:
```
Sequence:
  1. User clicks "Add to Inventory"
  2. Validation: All required fields filled
  3. Button: Shows loading state
  4. Progress modal: Shows processing
     - "Adding stock for [N] products..."
     - Progress bar: 0% → 100%
     - Current product: "Processing: [Product Name]"
  5. Batch processing: 10 products at a time
  6. Success screen:
     - Checkmark animation
     - Summary: "[N] products added to inventory"
     - "View Inventory" button: Goes to inventory list
     - "Add More Stock" button: Restarts wizard
```

---

### State 5.5.2: Min/Max Stock Levels - Bulk Edit

**Access**: Inventory → Select Multiple → Bulk Actions → Set Stock Levels

**Bulk Edit Modal**:
```
Modal:
  - Width: 600px
  - Center screen

Header:
  - Title: "Set Stock Levels - [N] Products"
  - Close button

Content:
  - Two modes (Toggle):
    1. Individual: Edit each product separately (table view)
    2. Apply to All: Set same values for all selected

Mode 1: Individual Edit
  Table:
    - Columns: Product Name, Current Min, New Min, Current Reorder, New Reorder
    - Each row: Editable number inputs
    - Validation: Reorder ≥ Min
    - Highlight: Changed values (yellow background)

Mode 2: Apply to All
  Form:
    - Minimum Stock Level: Number input
    - Reorder Point: Number input
    - Warning: "This will overwrite existing values for all [N] products"
    - Checkbox: "I understand"

Footer:
  - "Calculate from Sales Data": Text button
    - Auto-calculates based on average daily sales
    - Formula: Min = Avg daily sales × Lead time × Safety factor
  - Cancel: Outlined
  - Save: Primary button
```

**Calculate from Sales Data**:
```
If clicked:
  - Modal: "Calculating optimal stock levels..."
  - Analysis: Last 90 days sales data
  - Algorithm:
    1. Average daily sales per product
    2. Lead time from supplier (default: 7 days)
    3. Safety factor (default: 1.5×)
    4. Min Stock = Daily sales × Lead time × Safety factor
    5. Reorder Point = Min Stock × 1.5
  
  - Results preview:
    - Table: Product, Current Min/Reorder, Suggested Min/Reorder, Difference
    - Accept all: Apply to all products
    - Individual: Checkboxes per product to accept
```

---

### State 5.5.3: Low Stock Alerts Configuration

**Access**: Settings → Inventory → Stock Alerts

**Configuration Page**:
```
Page Layout:
  - Title: "Stock Alert Settings"
  - Description: "Configure when and how you receive low stock notifications"

Section 1: Alert Triggers
  - Title: "When to trigger alerts"
  
  Options (Radio group):
    1. Below Minimum Stock
       - Description: "Alert when stock < minimum level"
       - Default: Selected
    
    2. Below Reorder Point
       - Description: "Alert when stock < reorder point"
    
    3. Custom Threshold
       - Description: "Alert at specific stock level"
       - Shows number input if selected
       - Placeholder: "e.g., 5 units"

Section 2: Notification Methods
  - Title: "How to receive alerts"
  
  Checkboxes (Multiple selection):
    ☐ Dashboard Banner
       - Shows persistent banner on dashboard
    ☐ Email Notifications
       - Send email to specified addresses
       - Input: Email list (comma-separated)
    ☐ Push Notifications
       - Mobile/desktop push notifications
    ☐ SMS Alerts
       - Send SMS to specified numbers
       - Input: Phone numbers
       - Note: "Charges may apply"

Section 3: Alert Frequency
  - Title: "How often to send alerts"
  
  Dropdown:
    - Real-time (immediate)
    - Daily Summary (8 AM)
    - Weekly Summary (Monday 8 AM)
    - Only once (until restocked)

Section 4: Product Filters
  - Title: "Which products to monitor"
  
  Options:
    - All products (default)
    - By category: Multi-select dropdown
    - By supplier: Multi-select dropdown
    - Custom selection: Opens product picker

Section 5: Test Alert
  - Button: "Send Test Alert"
  - Action: Sends sample alert via selected methods
  - Confirmation: "Test alert sent successfully"

Footer:
  - Save Settings: Primary button
  - Reset to Defaults: Text link
```

---

## 5.6 Batch & Expiry Management (Pharmacy-Specific)

### State 5.6.1: Batch Configuration Settings

**Access**: Settings → Inventory → Batch & Expiry Settings

**Configuration Page (Pharmacy Only)**:
```
Page Layout:
  - Title: "Batch & Expiry Management"
  - Description: "Configure how batch tracking and expiry warnings work"

Section 1: Batch Tracking
  - Title: "Batch Tracking Options"
  
  Toggle: Enable Batch Tracking
    - Default: On (for pharmacy)
    - Description: "Track inventory by batch numbers and expiry dates"
    - Warning if disabled: "This will disable FEFO and expiry alerts"
  
  If enabled:
    - Required for all products: Toggle
      - If on: Batch number required when receiving stock
      - If off: Optional, but recommended
    
    - Auto-generate batch numbers: Toggle
      - Format: [PREFIX]-[DATE]-[SEQUENCE]
      - Prefix input: "e.g., BATCH"
      - Example: "BATCH-20241206-001"

Section 2: Expiry Warning Levels
  - Title: "When to warn about expiring products"
  - Description: "Set multiple warning levels for different time periods"
  
  Warning Levels (Dynamic list, max 5):
    Default Levels:
      1. Critical: 30 days before expiry
         - Color: Red
         - Action: Block sale (toggle)
      
      2. Warning: 60 days before expiry
         - Color: Orange
         - Action: Show warning at POS (toggle)
      
      3. Notice: 90 days before expiry
         - Color: Yellow
         - Action: Display in reports (toggle)
    
    Add Level: "+ Add Warning Level" button
      - Days before expiry: Number input
      - Color: Color picker
      - Actions: Checkboxes (Block, Warn, Report)
      - Remove: X button

Section 3: FEFO Enforcement
  - Title: "First Expiry, First Out (FEFO)"
  
  Toggle: Enforce FEFO at POS
    - Default: On
    - Description: "Automatically select batch with nearest expiry when selling"
  
  If enabled:
    - Allow manual override: Toggle
      - If on: Cashier can select different batch
      - Requires: Manager approval (toggle)
      - Log overrides: Toggle (audit trail)

Section 4: Expired Stock Handling
  - Title: "What to do with expired products"
  
  Options (Radio group):
    1. Mark as Expired (default)
       - Stock becomes unavailable for sale
       - Remains in inventory for accounting
    
    2. Move to Quarantine
       - Transfers to virtual "Quarantine" location
       - Can be disposed or returned to supplier
    
    3. Auto-Generate Return Request
       - Creates supplier return request automatically
       - Requires supplier return policy setup

Section 5: Notifications
  - Title: "Expiry alert notifications"
  
  Checkboxes:
    ☐ Daily expiry summary email
       - Time: Dropdown (8 AM, 12 PM, 5 PM)
    ☐ Real-time alerts for critical expiry
    ☐ Weekly expiry forecast report
    ☐ Monthly expired stock value report

Footer:
  - Save Settings: Primary button
  - Preview Alerts: Button (shows sample alerts)
```

---

### State 5.6.2: Batch Entry During Stock Receipt

**Context**: When receiving stock with batch tracking enabled

**Enhanced GRN (Goods Receipt Note) Form**:
```
Added to each product line item:

Batch Information Section:
  - Batch Number*: Text input
    - Placeholder: "e.g., BATCH001 or LOT12345"
    - Max length: 50 chars
    - Validation: Unique per product
    - Auto-generate button: If enabled in settings
  
  - Manufacturing Date: Date picker
    - Optional
    - Format: DD/MM/YYYY
    - Validation: Must be <= today
  
  - Expiry Date*: Date picker
    - Required (for pharmacy)
    - Format: DD/MM/YYYY
    - Validation: Must be > today
    - Warning: If < 90 days from today
      - "Batch expires soon. Accept anyway?"
      - Checkbox: "I understand"
  
  - Cost per Unit: Number input
    - Optional (can differ from standard cost)
    - Prefix: PKR
    - Used for batch-specific profit tracking

Visual Indicators:
  - Expiry date field colors:
    - > 6 months: Green tint
    - 3-6 months: Yellow tint
    - < 3 months: Red tint + warning icon
  
  - Real-time expiry calculation:
    - Shows: "Expires in: 145 days" below date picker
    - Updates as date changes
```

**Batch Quick Entry**:
```
If receiving multiple products with same batch:
  - "Apply to all" button:
    - Copies batch number and dates to all items
    - Option: "Use same batch for products from this supplier"
    - Saves time for bulk receipts
```

---

### State 5.6.3: Expiry Dashboard Widget

**Location**: Main dashboard, prominent widget

**Widget Layout**:
```
Card:
  - Width: 400px (desktop), full width (mobile)
  - Height: 320px
  - Title: "Expiring Products", 18px Inter Semibold
  - Subtitle: "Next 90 days", 13px gray

Content Sections (Tabs):
  Tab 1: Critical (< 30 days)
    - Color theme: Red
    - Count badge: "5 products", red background
  
  Tab 2: Warning (30-60 days)
    - Color theme: Orange
    - Count badge: "12 products"
  
  Tab 3: Notice (60-90 days)
    - Color theme: Yellow
    - Count badge: "23 products"

Product List (per tab):
  - Max 5 items shown
  - Each item: 56px height
    - Product image: 40x40px, left
    - Product name: 14px Inter Medium
    - Batch number: 12px gray, below name
    - Expiry date: 13px, right, color-coded
    - Days remaining: "15 days", 13px bold, right
    - Value at risk: "PKR 2,400", 12px gray
  
  - Scroll: If >5 items
  - "View All" link: Bottom

Actions:
  - Icon buttons (top-right):
    - Refresh: Reload data
    - Export: Download list as CSV
    - Settings: Open expiry settings

Empty State (if no expiring products):
  - Icon: Green checkmark, 48px
  - Text: "No products expiring in next 90 days"
  - Subtext: "All batches have healthy expiry dates"
```

**Widget Animation (Dashboard Load)**:
```dart
// Stagger animation for product list items
class ExpiryListAnimation extends StatefulWidget {
  final List<ExpiringProduct> products;
  
  @override
  _ExpiryListAnimationState createState() => _ExpiryListAnimationState();
}

class _ExpiryListAnimationState extends State<ExpiryListAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _controller.forward();
  }
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        final delay = index * 0.1; // 100ms delay between items
        
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final progress = (((_controller.value - delay).clamp(0.0, 0.3)) / 0.3);
            
            return Opacity(
              opacity: progress,
              child: Transform.translate(
                offset: Offset(30 * (1 - progress), 0),
                child: child,
              ),
            );
          },
          child: _buildProductItem(widget.products[index]),
        );
      },
    );
  }
}
```

---

### State 5.6.4: FEFO Override at POS

**Context**: During POS sale, when multiple batches available

**Batch Selection Override UI**:
```
Trigger: Product added to cart with multiple batches

Modal Overlay (POS):
  - Width: 500px
  - Position: Center of POS screen
  - Background: Surface color
  - Border radius: 12px

Header:
  - Title: "Select Batch"
  - Product name: Below title, bold
  - Default batch: "FEFO: [Batch] (Exp: [Date])" highlighted

Batch List:
  - Radio group: All available batches
  - Each batch option:
    - Radio button: Left
    - Batch number: Bold, 14px
    - Expiry date: 13px, color-coded by urgency
    - Available quantity: "32 units", 12px gray
    - Recommended badge: "FEFO" on nearest expiry
  
  - Visual ranking:
    1. FEFO (nearest expiry): Green checkmark + badge
    2. Next expiring: Orange dot
    3. Others: Gray dot

Override Reason (if not FEFO):
  - Dropdown: "Why override FEFO?"
  - Options:
    - Customer request
    - Damaged/defective nearest batch
    - Quality preference
    - Other (text input)
  - Required if: Not selecting FEFO batch

Manager Approval (if configured):
  - PIN input: 4-digit manager PIN
  - Required if: Override reason is customer preference
  - Validation: Real-time PIN check

Footer:
  - Cancel: Returns to FEFO selection
  - Confirm Selection: Proceeds with chosen batch
    - Disabled until: Reason + PIN (if required) provided
```

---

## 5.7 Customer Tier Setup

### State 5.7.1: Customer Tier Management Page

**Access**: Settings → Customers → Manage Tiers

**Page Layout - Desktop**:
```
Page Header:
  - Title: "Customer Tiers", 28px Inter Semibold
  - Description: "Configure customer categories and pricing rules"
  - "+ Add Tier" button: Top-right, primary

Content: Two-panel layout

Left Panel (Tier List):
  - Width: 320px
  - Background: Slight tint
  
  Tier Cards (Vertical list):
    Default Tiers (Non-editable):
      1. Walk-in Customer
         - Icon: Person, 32px
         - Description: "Default tier, no discounts"
         - Customer count: "(245 customers)"
         - Badge: "Default"
      
      2. Platinum
      3. Diamond
      4. Gold
      5. Silver
      6. Bronze
    
    Custom Tiers:
      - Can add more
      - User-defined names
      - Full edit/delete control
  
  Each Tier Card:
    - Height: 88px
    - Padding: 16px
    - Border: 1px solid outline
    - Border radius: 8px
    - Margin: 12px bottom
    - Cursor: pointer
    - Selected: Primary border, background tint
    - Hover: Lift shadow

Right Panel (Tier Details):
  - When tier selected: Shows configuration
  - Empty state: "Select a tier to configure"

Tier Configuration Form:
  Section 1: Basic Information
    - Tier Name: Text input
      - Max 30 chars
      - Unique validation
    
    - Tier Icon: Icon picker
      - Same as category icons
      - Default icons for customer types
    
    - Tier Color: Color picker
      - For visual distinction in UI
      - Shows preview badge

  Section 2: Pricing Rules
    - Discount Type: Radio group
      1. Percentage Discount
         - Input: 0-100%
         - Applied to: All products (default) OR Selected categories
      2. Fixed Price Per Product
         - Opens product selector
         - Set custom price per product
      3. No Discount
         - Base prices apply
    
    - If Percentage:
      - Discount %: Number input
      - Apply to: Dropdown (All / By Category)
      - Preview: "10% off = PKR 90 (was PKR 100)"
    
    - If Fixed Price:
      - Product table: Name, Base Price, Tier Price, Savings
      - Bulk edit: "Apply [X]% off to selected"
      - Import: CSV with product_id, tier_price

  Section 3: Credit Management
    - Allow Credit Sales: Toggle
      - If on: Shows credit settings
    
    - Default Credit Limit: Number input
      - Prefix: PKR
      - Can be overridden per customer
    
    - Payment Terms: Dropdown
      - Net 15, Net 30, Net 60, Custom
      - Custom: Number of days input
    
    - Auto-approval: Toggle
      - If off: Requires manager approval for credit

  Section 4: Tier Upgrade Rules (Indicative)
    - Description: "Suggested criteria for upgrading customers"
    - Note: "Not automatically enforced"
    
    - Purchase threshold: Number input
      - "Suggest upgrade after PKR [X] total purchases"
    
    - Time period: Dropdown
      - Last 30 days, Last 90 days, Lifetime
    
    - Minimum purchases: Number
      - "Require at least [X] separate purchases"

Footer Actions:
  - Delete Tier: Error button, left (if custom tier)
  - Reset to Default: Text link (if default tier modified)
  - Save Changes: Primary button, right
```

---

### State 5.7.2: Add Customer Tier - Modal

**Trigger**: Click "+ Add Tier" button

**Modal**:
```
Dialog:
  - Width: 600px
  - Center screen

Header:
  - Title: "Create Customer Tier"
  - Close: X button

Form Content:
  - All fields from tier configuration
  - Wizard-style (optional): 3 steps
    1. Basic Info (Name, Icon, Color)
    2. Pricing Rules
    3. Credit Settings

Templates (Optional Step 0):
  - "Start from template" option
  - Pre-defined templates:
    1. VIP Customers (10% off, high credit)
    2. Wholesale (15% off, net 30)
    3. Loyalty Members (5% off, standard credit)
    4. Walk-in (no discount, no credit)
  - "Start from scratch": Custom configuration

Footer:
  - Back: If multi-step
  - Cancel: Outlined
  - Create Tier: Primary
    - Or "Continue" if multi-step
```

---

### State 5.7.3: Assign Customer to Tier

**Context**: When creating/editing customer

**Tier Assignment UI**:
```
In Customer Form:
  - Field: Customer Tier
  - Type: Dropdown with visual cards
  - Default: Walk-in Customer

Dropdown Options (Enhanced):
  - Each tier: Card view (not simple list)
  - Card shows:
    - Tier icon + color badge: Left
    - Tier name: Bold
    - Discount info: "10% off all products"
    - Credit info: "PKR 5,000 credit limit"
  - Selected tier: Checkmark right

Below dropdown:
  - Preview pricing: "Sample product pricing for this tier"
  - Shows: 3 example products with before/after prices
  - Example:
    - Panadol 500mg: PKR 100 → PKR 90 (10% off)
    - Augmentin 625mg: PKR 450 → PKR 405 (10% off)

Override Options:
  - Custom discount: Checkbox
    - "Override tier discount for this customer"
    - Shows: Percentage input
    - Warning: "This overrides tier-level pricing"
  
  - Custom credit limit: Checkbox
    - "Override tier credit limit"
    - Shows: Amount input
    - Default: Tier's default limit
```

---

### State 5.7.4: Tier Performance Dashboard

**Access**: Reports → Customer Analytics → Tier Performance

**Dashboard Layout**:
```
Page: Full width, multi-section

Section 1: Tier Overview (Cards Row)
  - 6 cards (one per default tier)
  - Each card:
    - Tier name + icon
    - Customer count: Large number
    - Revenue: "PKR [X] this month"
    - Growth: "+12% vs last month" (green/red)
    - Average order value: "PKR [X]"
    - Click: Drills into tier details

Section 2: Revenue by Tier (Chart)
  - Type: Stacked bar chart OR Pie chart (toggle)
  - X-axis: Months (last 12)
  - Y-axis: Revenue (PKR)
  - Bars: Color-coded by tier
  - Legend: Right side
  - Interactive: Hover shows breakdown

Section 3: Tier Comparison Table
  - Columns:
    - Tier Name
    - Customers (#)
    - Avg. Purchase Frequency (per month)
    - Avg. Order Value (PKR)
    - Total Revenue (PKR)
    - Profit Margin (%)
    - Credit Utilization (%)
  - Sortable: Click column headers
  - Export: CSV button

Section 4: Upgrade Suggestions
  - Title: "Customers eligible for tier upgrade"
  - List: Customers meeting upgrade criteria
  - Each row:
    - Customer name
    - Current tier
    - Suggested tier
    - Criteria met: "Spent PKR 50,000 in last 90 days"
    - Actions:
      - "Upgrade" button: Opens confirmation
      - "Dismiss" link: Hides suggestion

Section 5: Tier Profitability Analysis
  - Insight cards:
    - Most profitable tier: [Tier Name]
    - Highest volume tier: [Tier Name]
    - Best retention: [Tier Name]
    - Recommendation: "Consider increasing discounts for Bronze to boost loyalty"
```

---

### State 5.7.5: Bulk Tier Assignment

**Access**: Customers → Select Multiple → Bulk Actions → Assign Tier

**Bulk Assignment Modal**:
```
Modal:
  - Width: 600px
  - Center screen

Header:
  - Title: "Assign Tier - [N] Customers"
  - Description: "Change tier for selected customers"

Content:
  - Current Distribution:
    - Shows: Breakdown of selected customers by current tier
    - Example:
      - Walk-in: 12 customers
      - Silver: 5 customers
      - Bronze: 3 customers
  
  - New Tier Selection:
    - Large dropdown: Select target tier
    - Shows tier details (discount, credit)
  
  - Confirmation:
    - Warning if downgrading tier:
      - "You're downgrading [N] customers. This may affect their credit limits."
    - Checkbox: "I understand this affects pricing and credit"

  - Reason (Optional):
    - Text area: "Reason for tier change"
    - Max 200 chars
    - Helpful for audit trail

Footer:
  - Cancel: Outlined
  - Assign Tier: Primary
    - Shows loading during bulk update
    - Progress: "Updating [X] of [N] customers..."
```

---

## Summary

**Part 3 Coverage Complete**:
- ✅ First-Time Dashboard Landing (3 states)
- ✅ Product Management - Add Product (7 states)
- ✅ Barcode Scanning & Generation (3 states)
- ✅ Category Management (3 states)
- ✅ Stock Level Configuration (3 states)
- ✅ Batch & Expiry Setup (4 states - Pharmacy)
- ✅ Customer Tier Setup (5 states)

**Total States Documented**: 28 comprehensive states across all platforms and themes

**Key Accomplishments**:
- Complete product addition workflow (manual + bulk)
- Advanced barcode handling (scan + generate)
- Hierarchical category management with drag-drop
- Intelligent stock level configuration
- Pharmacy-specific batch/expiry tracking
- Flexible customer tier system with pricing rules

**Next Document (Part 4)**: Live POS Operations
- Real-time sale transactions
- Product search & selection
- Cart management & modifications
- Payment processing (multiple methods)
- Receipt generation & delivery
- Returns & exchanges
- Multi-counter operations
- Offline mode handling

---

**Document Complete**: Part 3 - POS & Inventory Setup

**File Location**: `/mnt/user-data/outputs/bizPharma_States_Expansion_PART_3.md`