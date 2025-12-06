# bizPharma - States Expansion Design Brief (Part 4)

## Document Information

**Version**: 1.0  
**Date**: December 2024  
**Document**: Part 4 of States Expansion Series  
**Scope**: Live POS Operations  
**Coverage**: Real-Time Sales → Product Search → Cart Management → Payment Processing → Receipts → Returns  
**Platforms**: Mobile, Tablet, Desktop, Web  
**Themes**: Light & Dark (explicitly documented for each state)  
**Granularity**: Detailed with micro-interactions, animations, and platform variations

---

## What This Document Covers

This is **Part 4** focusing on:

1. ✅ POS Home Screen & Launch
2. ✅ Product Search & Selection
3. ✅ Cart Management
4. ✅ Customer Selection & Context
5. ✅ Discounts & Pricing Adjustments
6. ✅ Payment Processing
   - Cash
   - Card
   - Mobile Wallet
   - Credit/On-Account
   - Split Payment
7. ✅ Receipt Generation & Delivery
8. ✅ Returns & Exchanges
9. ✅ Multi-Counter Operations
10. ✅ Offline Mode Handling

**Previous Documents**:  
- **Part 1**: Landing Page, Authentication Flows  
- **Part 2**: Business Onboarding & Configuration  
- **Part 3**: POS & Inventory Setup

**Next Document (Part 5)**: Inventory Operations

---

## Design System References

Building upon:
- **Part 1-3**: All previous patterns
- **Style Guide**: `/mnt/project/4_a_Style_Guide__bizPharma.md`
- **Feature Stories**: `/mnt/project/3__Feature_Stories_bizPharma.md`
- **Architecture**: `/mnt/project/2__High_Level_Architecture_bizPharma.md`

---

# 6. POS HOME SCREEN & LAUNCH

## 6.1 POS Launch - Counter Selection

### State 6.1.1: Counter Selection Screen (Multi-Counter Setup)

**Trigger**: User with Cashier/POS role clicks "POS" in navigation

**Context**: Business has multiple counters configured

**Desktop Layout (1280px+)**:
```
Full-Screen Interface:
  - No header/sidebar (dedicated POS mode)
  - Background: Gradient (primary to primary-dark)
  - Content: Centered, max-width 1200px

Header Section:
  - Logo: Top-left, 80px width
  - Business name: Next to logo, 20px Inter Semibold, white
  - Time/Date: Top-right, 16px Inter Regular, white/80% opacity
  - User info: Below time, 14px, "Logged in as [Name]"

Main Content:
  - Title: "Select Your Counter", 32px Inter Bold, white, centered
  - Subtitle: "Choose which counter you'll operate today", 16px, white/80%
  - Spacing: 24px between title and counter grid

Counter Grid:
  - Layout: 3 columns × dynamic rows
  - Gap: 24px between cards
  - Max items per row: 3
  - Wraps to new row if >3 counters

Counter Card:
  - Width: 360px
  - Height: 200px
  - Background: White/Dark surface
  - Border radius: 16px
  - Padding: 24px
  - Shadow: 0px 4px 16px rgba(0, 0, 0, 0.1)
  - Cursor: pointer

  Content:
    - Counter Icon: Top-left, 48px, primary color
      - Icon: Cash register or numbered badge
    
    - Counter Name: Below icon, 24px Inter Semibold
      - Example: "Counter 1", "Front Desk", "Express Lane"
    
    - Status Indicator: Top-right, 12px badge
      - Available: Green dot + "Available"
      - In Use: Blue dot + "In Use by [Name]"
      - Closed: Red dot + "Closed"
    
    - Session Info (if in use):
      - Started: "Session: 9:30 AM"
      - Sales count: "15 transactions today"
      - Total: "PKR 12,450"
      - Font: 13px Inter Regular, gray
    
    - Action Button (bottom):
      - Available: "Start Session" (primary)
      - In Use (same user): "Resume Session" (primary)
      - In Use (other): Disabled, "Currently occupied"
      - Closed: Disabled, "Counter closed"

Card States:
  - Default: Normal appearance
  - Hover: Lift -4px, shadow increases
  - Pressed: Scale 0.98
  - Disabled: Opacity 0.6, cursor not-allowed
  - Selected (after click): Green border 3px

Bottom Actions:
  - "Settings" icon button: Bottom-left
  - "Logout" text link: Bottom-right
```

**Light Theme Styling**:
```
Background Gradient:
  - Start: #0F4C4C
  - End: #0A3838
  
Counter Card:
  - Background: #FFFFFF
  - Shadow: 0px 4px 16px rgba(0, 0, 0, 0.1)
  - Border: 1px solid #E8EAED
  
  Hover:
    - Transform: translateY(-4px)
    - Shadow: 0px 8px 24px rgba(0, 0, 0, 0.15)
    - Border: 2px solid #0F4C4C
  
Status Badges:
  - Available: Background #E8F5E9, text #2E7D32, dot #4CAF50
  - In Use: Background #E3F2FD, text #1565C0, dot #2196F3
  - Closed: Background #FFEBEE, text #C62828, dot #F44336

Text:
  - Counter name: #0F4C4C
  - Session info: #44474E
  - Disabled text: #9E9E9E

Button (Start Session):
  - Background: #0F4C4C
  - Text: #FFFFFF
  - Hover: #1A6363
```

**Dark Theme Styling**:
```
Background Gradient:
  - Start: #1E1E1E
  - End: #0F0F0F

Counter Card:
  - Background: #2A2A2A
  - Shadow: 0px 4px 16px rgba(0, 0, 0, 0.5)
  - Border: 1px solid #404040
  
  Hover:
    - Border: 2px solid #C5E64D
    - Shadow: 0px 8px 24px rgba(197, 230, 77, 0.2)

Status Badges:
  - Available: Background #1B5E20, text #C8E6C9, dot #66BB6A
  - In Use: Background #0D47A1, text #BBDEFB, dot #42A5F5
  - Closed: Background #B71C1C, text #FFCDD2, dot #EF5350

Text:
  - Counter name: #C5E64D
  - Session info: #C7C7C7
  - Disabled text: #666666

Button (Start Session):
  - Background: #C5E64D
  - Text: #2C3500
  - Hover: #D4ED6A
```

**Counter Card Animation**:
```dart
class CounterCard extends StatefulWidget {
  final Counter counter;
  final Function(Counter) onSelect;
  
  @override
  _CounterCardState createState() => _CounterCardState();
}

class _CounterCardState extends State<CounterCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  
  @override
  void initState() {
    super.initState();
    
    // Pulse animation for available counters
    if (widget.counter.status == CounterStatus.available) {
      _pulseController = AnimationController(
        duration: Duration(seconds: 2),
        vsync: this,
      )..repeat(reverse: true);
      
      _pulseAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
        CurvedAnimation(
          parent: _pulseController,
          curve: Curves.easeInOut,
        ),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.counter.isAvailable || widget.counter.canResume
            ? () => widget.onSelect(widget.counter)
            : null,
        child: AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Transform.scale(
              scale: widget.counter.status == CounterStatus.available
                  ? _pulseAnimation.value
                  : 1.0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeOut,
                transform: Matrix4.translationValues(
                  0,
                  _isHovered ? -4 : 0,
                  0,
                ),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  border: Border.all(
                    color: _isHovered ? primaryColor : borderColor,
                    width: _isHovered ? 2.0 : 1.0,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.1),
                      offset: Offset(0, _isHovered ? 8 : 4),
                      blurRadius: _isHovered ? 24 : 16,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.point_of_sale,
                          size: 48,
                          color: primaryColor,
                        ),
                        _buildStatusBadge(widget.counter.status),
                      ],
                    ),
                    
                    SizedBox(height: 16),
                    
                    Text(
                      widget.counter.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: titleColor,
                      ),
                    ),
                    
                    if (widget.counter.sessionInfo != null)
                      _buildSessionInfo(widget.counter.sessionInfo!),
                    
                    Spacer(),
                    
                    _buildActionButton(widget.counter),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    if (widget.counter.status == CounterStatus.available) {
      _pulseController.dispose();
    }
    super.dispose();
  }
}
```

**Start Session Flow**:
```
User clicks "Start Session" on available counter:

1. Modal appears: "Starting Cash Amount"
   - Title: "Open Cash Drawer"
   - Description: "Enter the starting cash in this drawer"
   - Input: Number field, PKR prefix
   - Placeholder: "e.g., 5000.00"
   - Helper: "Count physical cash in drawer"
   
   - Denomination Helper (expandable):
     - PKR 5000 × [input] = [auto-calc]
     - PKR 1000 × [input] = [auto-calc]
     - PKR 500 × [input] = [auto-calc]
     - PKR 100 × [input] = [auto-calc]
     - PKR 50 × [input] = [auto-calc]
     - Total: [sum], large display
   
   - Buttons:
     - Cancel: Outlined
     - Start Session: Primary (disabled until amount entered)

2. Session created:
   - Loading: "Starting session..." (500ms)
   - Counter card updates: Status → "In Use by [User]"
   - Transition: Screen fades to POS interface (600ms)

3. POS Home loads:
   - Header shows: Counter name, session start time
   - Empty cart ready for first sale
```

---

### State 6.1.2: Direct POS Launch (Single Counter)

**Trigger**: Business has only 1 counter OR user assigned to specific counter

**Behavior**: Skips counter selection, goes directly to starting cash modal

**Flow**:
```
1. User clicks "POS" → Starting cash modal immediately
2. Enter amount → POS Home loads
3. No counter selection screen needed
```

---

### State 6.1.3: Counter Selection - Mobile Layout

**Mobile Adaptation (<768px)**:
```
Full-Screen:
  - Header: 64px height, fixed top
  - Counter list: Scrollable vertical
  - Bottom safe area: Padding 16px

Header:
  - Logo: Left, 80px
  - Time: Right, 14px
  - User: Below header, 13px, centered

Counter Cards:
  - Full width (minus 16px padding each side)
  - Height: 160px (reduced from 200px)
  - Margin: 12px bottom
  - Stack vertically

Card Content:
  - Icon: 40px (reduced from 48px)
  - Counter name: 20px (reduced from 24px)
  - Session info: 12px (reduced from 13px)
  - Status badge: Top-right (same)
  - Button: Full width, 48px height

Bottom Actions:
  - Settings: Floating action button, bottom-right
  - Logout: Top-right header icon
```

---

## 6.2 POS Home Screen

### State 6.2.1: POS Home - Empty Cart (Desktop)

**Layout**: Full-screen dedicated POS interface

**Desktop Structure (1280px+)**:
```
Screen Division:
  - Left Panel: Product search & selection (50%)
  - Right Panel: Cart & checkout (50%)
  - Or: Left 40%, Right 60% (configurable)

Top Bar (Full Width):
  - Height: 64px
  - Background: Primary color
  - Content:
    - Logo: Left, 32px
    - Counter name: Next to logo, "Counter 1", 16px, white
    - Session info: "Session: 9:30 AM", 14px, white/80%
    - Search bar: Center, 400px width (global product search)
    - Time: Right, 16px, white
    - User avatar: Far right, 32px circle, dropdown menu
  
  Search Bar:
    - Background: White/10% (semi-transparent)
    - Border: 1px solid white/20%
    - Border radius: 24px (pill shape)
    - Height: 40px
    - Icon: Search, 20px, left
    - Placeholder: "Search products..." 14px, white/60%
    - Focus: Background solid white, text black
    - Keyboard shortcut: "/" (focus search)

Left Panel: Product Selection
  - Background: Light surface color
  - Padding: 24px
  
  Quick Categories (Top):
    - Horizontal scrollable chips
    - Each chip: 
      - Icon + category name
      - Height: 40px
      - Padding: 12px 20px
      - Border radius: 20px
      - Background: White
      - Selected: Primary color background
    - Examples: "All", "Pain Relief", "Antibiotics", "Vitamins"
  
  Frequent Products Grid:
    - Title: "Frequently Sold", 18px Inter Semibold
    - Grid: 3 columns (desktop), 2 (tablet)
    - Gap: 16px
    
    Product Card:
      - Width: Auto (fills column)
      - Aspect ratio: 1:1.2 (portrait)
      - Background: White
      - Border: 1px solid outline
      - Border radius: 12px
      - Padding: 12px
      - Cursor: pointer
      - Hover: Lift + shadow
      
      Content:
        - Product image: Top, full width, 120px height, cover fit
        - Product name: 14px Inter Medium, 2 lines max, ellipsis
        - Price: 16px Inter Semibold, primary color
        - Stock badge: "50 in stock", 11px, gray, top-right absolute
        - Add button: Bottom, full width, 36px height, "+ Add" text

Right Panel: Cart & Checkout
  - Background: Surface color
  - Border left: 1px solid outline color
  
  Header:
    - Height: 56px
    - Padding: 16px 20px
    - Border bottom: 1px solid outline
    - Content:
      - "Current Sale" title, 18px Inter Semibold
      - "Clear Cart" text button, right, error color

  Empty State (when cart empty):
    - Centered vertically
    - Icon: Shopping cart outline, 80px, gray
    - Title: "Cart is empty", 20px Inter Semibold, gray
    - Subtitle: "Scan or search for products to add", 14px, gray
    - Animation: Gentle float (±4px vertical, 3s loop)

  Footer (Always Visible):
    - Height: Auto
    - Padding: 20px
    - Border top: 1px solid outline
    - Background: White (light) / Darker surface (dark)
    
    Customer Section:
      - Label: "Customer", 13px Inter Medium, gray
      - Selected: "Walk-in Customer", 16px Inter Regular
        - Icon: Person, 20px, left
        - Change button: Text link, right, primary color
    
    Summary:
      - Subtotal: "PKR 0.00", 16px, right-aligned
      - Discount: "PKR 0.00", 14px, gray
      - Tax: "PKR 0.00", 14px, gray
      - Total: "PKR 0.00", 24px Inter Bold, primary color
    
    Checkout Button:
      - Full width
      - Height: 56px
      - Background: Primary color
      - Text: "Checkout", 16px Inter Semibold, white
      - Disabled state: Gray, opacity 0.6
      - Disabled when: Cart empty
```

**Light Theme**:
```
Top Bar:
  - Background: #0F4C4C
  - Text: #FFFFFF
  - Search background: rgba(255, 255, 255, 0.1)
  - Search focus: #FFFFFF, text #1C1C1C

Left Panel:
  - Background: #F8F9FA
  
  Category Chips:
    - Default: Background #FFFFFF, text #44474E, border #E8EAED
    - Selected: Background #0F4C4C, text #FFFFFF
    - Hover: Border #0F4C4C
  
  Product Cards:
    - Background: #FFFFFF
    - Border: 1px solid #E8EAED
    - Name: #1C1C1C
    - Price: #0F4C4C
    - Stock badge: Background #F8F9FA, text #44474E
    - Add button: Background #E0F2F2, text #0F4C4C, hover #0F4C4C (inverted)

Right Panel:
  - Background: #FFFFFF
  - Border: 1px solid #E8EAED
  
  Empty State:
    - Icon: #9E9E9E
    - Title: #44474E
    - Subtitle: #9E9E9E
  
  Footer:
    - Background: #FFFFFF
    - Border: 1px solid #E8EAED
    - Customer text: #1C1C1C
    - Summary text: #44474E
    - Total: #0F4C4C
    - Checkout button: #0F4C4C, hover #1A6363
```

**Dark Theme**:
```
Top Bar:
  - Background: #1E1E1E
  - Text: #E5E5E5
  - Search background: rgba(255, 255, 255, 0.1)
  - Search focus: #333333, text #E5E5E5

Left Panel:
  - Background: #1E1E1E
  
  Category Chips:
    - Default: Background #2A2A2A, text #C7C7C7, border #404040
    - Selected: Background #C5E64D, text #2C3500
    - Hover: Border #C5E64D
  
  Product Cards:
    - Background: #2A2A2A
    - Border: 1px solid #404040
    - Name: #E5E5E5
    - Price: #C5E64D
    - Stock badge: Background #333333, text #C7C7C7
    - Add button: Background #2C3500, text #C5E64D, hover #C5E64D (inverted)

Right Panel:
  - Background: #2A2A2A
  - Border: 1px solid #404040
  
  Empty State:
    - Icon: #666666
    - Title: #C7C7C7
    - Subtitle: #666666
  
  Footer:
    - Background: #2A2A2A
    - Border: 1px solid #404040
    - Customer text: #E5E5E5
    - Summary text: #C7C7C7
    - Total: #C5E64D
    - Checkout button: #C5E64D, text #2C3500, hover #D4ED6A
```

**Empty Cart Animation**:
```dart
class EmptyCartAnimation extends StatefulWidget {
  @override
  _EmptyCartAnimationState createState() => _EmptyCartAnimationState();
}

class _EmptyCartAnimationState extends State<EmptyCartAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;
  
  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    
    _floatAnimation = Tween<double>(begin: -4.0, end: 4.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                size: 80,
                color: emptyStateIconColor,
              ),
              SizedBox(height: 16),
              Text(
                'Cart is empty',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: emptyStateTitleColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Scan or search for products to add',
                style: TextStyle(
                  fontSize: 14,
                  color: emptyStateSubtitleColor,
                ),
              ),
            ],
          ),
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
```

---

### State 6.2.2: POS Home - Tablet Layout

**Tablet Adjustments (768px - 1279px)**:
```
Layout:
  - Can maintain side-by-side OR
  - Stack vertically with tabs

Option 1: Side-by-Side (Landscape)
  - Left: 45%
  - Right: 55%
  - Product grid: 2 columns (reduced from 3)
  - Spacing: Reduced to 16px

Option 2: Tabbed (Portrait/Landscape)
  - Bottom tab bar: "Products" | "Cart"
  - Full screen for each tab
  - Cart badge: Shows item count (red dot)
  - Quick switch: Swipe gesture between tabs
```

---

### State 6.2.3: POS Home - Mobile Layout

**Mobile Full-Screen (<768px)**:
```
Single View with Bottom Sheet:

Main Screen:
  - Top bar: 56px height
    - Logo: Left, 80px
    - Search icon: Right (opens full-screen search)
    - Counter badge: Center-bottom, "Counter 1"
  
  - Category chips: Horizontal scroll, 44px height
  
  - Product grid: 2 columns
    - Full width cards
    - Image: 100px height
    - Add button: Prominent, 44px

  - Floating cart button: Bottom-right
    - Size: 56px diameter FAB
    - Icon: Shopping cart
    - Badge: Item count (if any)
    - Color: Primary
    - Tap: Opens cart bottom sheet

Cart Bottom Sheet:
  - Triggered by: FAB tap OR "View Cart" button
  - Behavior: Slides up from bottom
  - Height: 70% of screen (adjustable by drag)
  - Handle: Top, drag indicator (gray pill)
  
  - Header: "Current Sale", close button
  - Content: Cart items list (scrollable)
  - Footer: Customer + Summary + Checkout button (fixed)
  
  - Dismiss: 
    - Swipe down
    - Tap outside (dim backdrop)
    - Close button

Empty Cart State:
  - Shows in bottom sheet when opened
  - Minimal height (30%)
  - Empty icon + message
  - "Continue Shopping" button closes sheet
```

---

## 6.3 Product Search & Selection

### State 6.3.1: Search - Keyboard Input

**Trigger**: User types in search bar or presses "/" shortcut

**Search Bar Focus State**:
```
Visual Changes:
  - Background: Solid white (light) / #333333 (dark)
  - Border: 2px solid primary color
  - Width: Expands to 500px (from 400px) on desktop
  - Text color: Dark (light theme) / Light (dark theme)
  - Placeholder: Fades out
  - Search icon: Animates (pulse once)

Keyboard Shortcut Indicator:
  - Shows "/" badge in placeholder when unfocused
  - Badge: Small pill, "Ctrl + K" or "/"
  - Disappears on focus
```

**Instant Search Results**:
```
Dropdown Results Panel:
  - Appears: 200ms after first character typed
  - Position: Below search bar (absolute)
  - Width: Same as search bar (expands with it)
  - Max height: 480px
  - Background: Surface color
  - Border: 1px solid outline color
  - Border radius: 12px
  - Shadow: 0px 8px 24px rgba(0, 0, 0, 0.15)
  - Z-index: 1000

Header (Sticky):
  - Height: 40px
  - Background: Surface variant color
  - Text: "Results for '[query]'" 13px, gray
  - Count: "[N] products found", right

Results List:
  - Max items visible: 8
  - Scrollable: Vertical
  - Scroll indicator: Visible if >8 results

Product Result Item:
  - Height: 72px
  - Padding: 12px 16px
  - Border bottom: 1px solid outline/10%
  - Cursor: pointer
  - Hover: Background tint
  
  Layout:
    - Product image: Left, 48x48px, rounded 8px
    - Name: 14px Inter Medium, 2 lines max
      - Search term: Highlighted (bold + primary color)
    - Price: Below name, 13px Inter Regular, primary color
    - Stock badge: Right side, "12 in stock"
      - Color-coded: Green >10, Yellow 5-10, Red <5
    - Category: Below name, 12px, gray
    - Barcode: Below price, 12px mono font, gray

Keyboard Navigation:
  - Arrow Up/Down: Navigate results
  - Enter: Select highlighted item
  - Esc: Close dropdown, clear search
  - Tab: Move to next field (closes dropdown)

Selected State (Keyboard):
  - Background: Primary color 10% opacity
  - Left border: 3px primary color

Loading State:
  - Shows if search takes >200ms
  - Skeleton items: 3 placeholder cards
  - Shimmer animation

Empty State:
  - Icon: Search with X, 48px, gray
  - Text: "No products found for '[query]'"
  - Suggestion: "Try different keywords or check spelling"
  - Action: "Add New Product" button (if has permission)
```

**Search Animation**:
```dart
class SearchResultsDropdown extends StatefulWidget {
  final String query;
  final List<Product> results;
  final Function(Product) onSelect;
  
  @override
  _SearchResultsDropdownState createState() => _SearchResultsDropdownState();
}

class _SearchResultsDropdownState extends State<SearchResultsDropdown>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  int _selectedIndex = 0;
  
  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    
    _controller.forward();
  }
  
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          constraints: BoxConstraints(maxHeight: 480),
          decoration: BoxDecoration(
            color: surfaceColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                offset: Offset(0, 8),
                blurRadius: 24,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.results.length,
                  itemBuilder: (context, index) {
                    return _buildResultItem(
                      widget.results[index],
                      isSelected: index == _selectedIndex,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildResultItem(Product product, {required bool isSelected}) {
    return InkWell(
      onTap: () => widget.onSelect(product),
      onHover: (hovering) {
        if (hovering) {
          setState(() => _selectedIndex = widget.results.indexOf(product));
        }
      },
      child: Container(
        height: 72,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected 
              ? primaryColor.withOpacity(0.1)
              : Colors.transparent,
          border: Border(
            left: isSelected
                ? BorderSide(color: primaryColor, width: 3)
                : BorderSide.none,
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.imageUrl ?? defaultImageUrl,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildHighlightedText(
                    product.name,
                    widget.query,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        product.category.name,
                        style: TextStyle(
                          fontSize: 12,
                          color: secondaryTextColor,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '•',
                        style: TextStyle(color: secondaryTextColor),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'PKR ${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 13,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            _buildStockBadge(product.stockLevel),
          ],
        ),
      ),
    );
  }
  
  Widget _buildHighlightedText(
    String text,
    String query,
    {required TextStyle style},
  ) {
    if (query.isEmpty) {
      return Text(text, style: style);
    }
    
    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final startIndex = lowerText.indexOf(lowerQuery);
    
    if (startIndex == -1) {
      return Text(text, style: style);
    }
    
    final endIndex = startIndex + query.length;
    
    return RichText(
      text: TextSpan(
        style: style.copyWith(color: onSurfaceColor),
        children: [
          TextSpan(text: text.substring(0, startIndex)),
          TextSpan(
            text: text.substring(startIndex, endIndex),
            style: style.copyWith(
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          TextSpan(text: text.substring(endIndex)),
        ],
      ),
    );
  }
}
```

---

### State 6.3.2: Search - Barcode Scan

**Trigger**: User clicks barcode scan button OR barcode scanner input received

**Mobile Camera Scan**:
```
Full-Screen Camera Interface:
  (Same as described in Part 3, State 5.3.1)
  
  - Camera feed: Full screen
  - Scanning frame: Centered, 280x140px
  - Scan line: Animated, primary color
  - Instructions: "Align barcode within frame"
  - Flash toggle: Bottom-left
  - Manual entry: Bottom-right
  - Cancel: Center bottom

Success:
  - Beep + haptic
  - Frame flashes green
  - Checkmark animation
  - Product added to cart automatically
  - Camera closes (300ms)
  - Cart updates with scanned product
```

**Desktop USB Scanner**:
```
Behavior:
  - Search field: Always listening for scanner input
  - Scanner types barcode + Enter automatically
  - Product: Auto-added to cart (no confirmation needed)
  - Toast: "Product added: [Name]" (brief, 2s)
  - Quantity: Defaults to 1, user can adjust in cart
```

**Scan Error Handling**:
```
Barcode Not Found:
  - Toast: "Product not found: [Barcode]"
  - Color: Warning/orange
  - Action button: "Add New Product"
  - Duration: 5s (longer than success toast)

Multiple Barcodes (same product, different batches):
  - Modal: "Select Batch"
  - Shows: All batches with this barcode
  - User: Selects batch (FEFO pre-selected)
  - Adds: Selected batch to cart
```

---

### State 6.3.3: Product Selection from Grid

**Trigger**: User clicks product card in frequent products grid

**Add Animation**:
```
Sequence:
  1. Card: Scale 0.95 (press effect, 100ms)
  2. Card: Returns to 1.0
  3. Product icon: Flies from card to cart icon (400ms curved path)
  4. Cart badge: Pulse + increment count
  5. Cart total: Updates with smooth number count animation
  6. Product card: Shows checkmark (500ms, then fades)

Flying Icon Animation:
```dart
class ProductAddAnimation extends StatefulWidget {
  final Product product;
  final Offset startPosition;
  final Offset endPosition;
  final VoidCallback onComplete;
  
  @override
  _ProductAddAnimationState createState() => _ProductAddAnimationState();
}

class _ProductAddAnimationState extends State<ProductAddAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    
    // Curved path from product to cart
    _positionAnimation = Tween<Offset>(
      begin: widget.startPosition,
      end: widget.endPosition,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    
    // Scale down as it flies
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.8, curve: Curves.easeIn),
      ),
    );
    
    // Fade out near the end
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.7, 1.0, curve: Curves.easeOut),
      ),
    );
    
    _controller.forward().then((_) => widget.onComplete());
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: _positionAnimation.value.dx,
          top: _positionAnimation.value.dy,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.shopping_bag,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
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
```

**Product Card After Add**:
```
Visual Feedback:
  - Checkmark: Appears top-right, 24px, green
  - Animation: Scale from 0 to 1.2 to 1.0 (elastic, 500ms)
  - Stays visible: 2 seconds
  - Then fades out: 300ms
  - Button changes: "+ Add" → "Add More"
```

---

## 6.4 Cart Management

### State 6.4.1: Cart with Items - Desktop

**Cart Panel (Right Side)**:
```
Header:
  - Height: 56px
  - Content: "Current Sale (3 items)"
  - Clear Cart: Button (right)

Cart Items List:
  - Scrollable area
  - Height: Flex (between header and footer)
  - Padding: 0 (items full width)

Cart Item Card:
  - Height: Auto (min 88px)
  - Padding: 16px
  - Border bottom: 1px solid outline/10%
  - Hover: Background tint
  
  Layout: Three-section horizontal
  
  Left Section (Product Info):
    - Width: 50%
    - Product image: 64x64px, rounded 8px
    - Product name: 14px Inter Medium, 2 lines max
    - Details below name:
      - Batch: "Batch: [Number]" 12px gray (if pharmacy)
      - Expiry: "Exp: [Date]" 12px
        - Color: Green (>60 days), Yellow (30-60), Red (<30)
      - Price per unit: "PKR 100.00" 13px gray
  
  Center Section (Quantity Control):
    - Width: 25%
    - Centered vertically
    
    Quantity Stepper:
      - Layout: [ - ] [Number] [ + ]
      - Button size: 32x32px
      - Number display: 40px width, 16px font, centered
      - Buttons: Outlined circle, icon (minus/plus)
      - Min value: 1
      - Max value: Stock available (shows warning if reached)
      - Direct input: Click number to type
  
  Right Section (Price & Actions):
    - Width: 25%
    - Right-aligned
    
    Subtotal:
      - Large: 18px Inter Semibold, primary color
      - Formula: Unit price × Quantity
      - Updates: Real-time as quantity changes
    
    Discount indicator:
      - If applied: "-10%" badge, green, below subtotal
    
    Remove button:
      - Icon: Trash, 20px, error color
      - Size: 32x32px
      - Style: Ghost button
      - Hover: Background error tint
      - Confirmation: None (direct remove)

Batch Selection (if pharmacy + multiple batches):
  - Below product name
  - Dropdown: "Batch: [Current]" clickable
  - Shows: All available batches
  - Each option:
    - Batch number
    - Expiry date (color-coded)
    - Available quantity
    - FEFO badge if applicable
  - Selection: Updates item immediately

Stock Warning (if low):
  - Banner: Orange background, 32px height
  - Icon: Alert triangle, 16px
  - Text: "Only 3 units left in stock"
  - Position: Below item, above next item
```

**Light Theme Cart Items**:
```
Item Card:
  - Background: #FFFFFF
  - Border: 1px solid #E8EAED (bottom only)
  - Hover: Background #F8F9FA

Product Name: #1C1C1C
Details: #44474E
Expiry (green): #4CAF50
Expiry (yellow): #FFA000
Expiry (red): #F44336

Quantity Stepper:
  - Buttons: Border #D1D4D9, icon #44474E
  - Hover: Background #F8F9FA, border #0F4C4C
  - Number: #1C1C1C

Subtotal: #0F4C4C
Discount badge: Background #E8F5E9, text #2E7D32

Remove button:
  - Icon: #DC3545
  - Hover: Background #FFEBEE
```

**Dark Theme Cart Items**:
```
Item Card:
  - Background: #2A2A2A
  - Border: 1px solid #404040
  - Hover: Background #333333

Product Name: #E5E5E5
Details: #C7C7C7
Expiry (green): #66BB6A
Expiry (yellow): #FFA726
Expiry (red): #EF5350

Quantity Stepper:
  - Buttons: Border #404040, icon #C7C7C7
  - Hover: Background #333333, border #C5E64D
  - Number: #E5E5E5

Subtotal: #C5E64D
Discount badge: Background #1B5E20, text #C8E6C9

Remove button:
  - Icon: #FF5252
  - Hover: Background #5C0000
```

**Quantity Stepper Component**:
```dart
class QuantityStepper extends StatelessWidget {
  final int value;
  final int maxValue;
  final Function(int) onChanged;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildButton(
          icon: Icons.remove,
          onPressed: value > 1 ? () => onChanged(value - 1) : null,
        ),
        
        SizedBox(width: 8),
        
        GestureDetector(
          onTap: () => _showQuantityInput(context),
          child: Container(
            width: 40,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              value.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        
        SizedBox(width: 8),
        
        _buildButton(
          icon: Icons.add,
          onPressed: value < maxValue ? () => onChanged(value + 1) : null,
        ),
      ],
    );
  }
  
  Widget _buildButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: 32,
      height: 32,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: CircleBorder(),
          side: BorderSide(color: borderColor),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }
  
  void _showQuantityInput(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => QuantityInputDialog(
        currentValue: value,
        maxValue: maxValue,
        onSubmit: onChanged,
      ),
    );
  }
}
```

---

### State 6.4.2: Cart - Quantity Adjustment

**Direct Input Modal**:
```
Trigger: User clicks quantity number in stepper

Modal Dialog:
  - Width: 320px
  - Center screen (desktop) or bottom sheet (mobile)
  - Background: Surface color
  - Border radius: 16px

Header:
  - Title: "Enter Quantity"
  - Close: X button

Content:
  - Product name: Display for context
  - Current quantity: Shows in faint text
  - Input field:
    - Type: Number
    - Height: 56px
    - Autofocus: Yes
    - Keyboard: Numeric
    - Min: 1
    - Max: Stock available
  
  - Helper text:
    - "Available: [N] units" below field
    - Color: Gray (normal) or Red (if input > available)

  - Numpad (mobile):
    - 3x4 grid
    - Numbers 1-9, 0
    - Backspace key
    - Clear key

Footer:
  - Cancel: Outlined button
  - Update: Primary button
    - Disabled if: Input invalid or > stock
    - Enabled if: Valid quantity

Submit:
  - Updates cart immediately
  - Modal closes (300ms scale out)
  - Cart item updates with smooth animation
```

**Quantity Update Animation**:
```dart
class QuantityUpdateAnimation extends StatefulWidget {
  final int oldValue;
  final int newValue;
  
  @override
  _QuantityUpdateAnimationState createState() =>
      _QuantityUpdateAnimationState();
}

class _QuantityUpdateAnimationState extends State<QuantityUpdateAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    
    _animation = IntTween(
      begin: widget.oldValue,
      end: widget.newValue,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    ) as Animation<double>;
    
    _controller.forward();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          _animation.value.round().toString(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
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
```

---

### State 6.4.3: Cart - Remove Item

**Trigger**: User clicks remove/trash icon on cart item

**Immediate Removal (No Confirmation)**:
```
Animation Sequence:
  1. Item card: Swipe left animation (300ms)
  2. Opacity: 1.0 → 0.0 (fade out)
  3. Height: Current → 0 (collapse)
  4. Items below: Shift up to fill space (200ms)
  5. Cart summary: Updates (numbers animate)

Undo Option:
  - Toast appears immediately after removal
  - Position: Bottom center (desktop) or top (mobile)
  - Background: Neutral/gray
  - Text: "Product removed"
  - Action: "Undo" button (primary color text)
  - Duration: 5 seconds
  - If Undo: Item re-appears in cart with slide-in animation
  - If Timeout: Removal is final
```

**Remove Animation**:
```dart
class RemoveItemAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback onRemoved;
  
  @override
  _RemoveItemAnimationState createState() => _RemoveItemAnimationState();
}

class _RemoveItemAnimationState extends State<RemoveItemAnimation>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _collapseController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _collapseAnimation;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();
    
    // Slide animation
    _slideController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(-1.0, 0),
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.easeInOut,
      ),
    );
    
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      _slideController,
    );
    
    // Collapse animation (runs after slide)
    _collapseController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    
    _collapseAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _collapseController,
        curve: Curves.easeOut,
      ),
    );
  }
  
  void remove() {
    _slideController.forward().then((_) {
      _collapseController.forward().then((_) {
        widget.onRemoved();
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _collapseAnimation,
      axisAlignment: -1.0,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: widget.child,
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    _slideController.dispose();
    _collapseController.dispose();
    super.dispose();
  }
}
```

---

### State 6.4.4: Cart - Clear All Items

**Trigger**: User clicks "Clear Cart" button in cart header

**Confirmation Dialog**:
```
Modal:
  - Width: 400px
  - Center screen

Header:
  - Icon: Warning triangle, 48px, warning color
  - Title: "Clear Cart?", 20px Inter Semibold

Content:
  - Message: "This will remove all [N] items from the cart."
  - Warning: "This action cannot be undone."
  - Item list (if ≤5 items):
    - Shows each product name
    - Bullet list, 14px
  - Or: "[N] items will be removed"

Footer:
  - Cancel: Outlined button
  - Clear Cart: Filled error color button

Clear Action:
  - All items: Animate out simultaneously (stagger 50ms each)
  - Cart: Returns to empty state
  - Toast: "Cart cleared" (brief, 2s)
  - No undo option (confirmed action)
```

---

### State 6.4.5: Cart - Mobile Bottom Sheet

**Mobile Cart Interface**:
```
Bottom Sheet:
  - Trigger: Tap FAB or "View Cart" button
  - Initial height: 70% of screen
  - Draggable: Yes (drag handle at top)
  - Min height: 30% (collapsed)
  - Max height: 95% (expanded)

Handle:
  - Width: 40px
  - Height: 4px
  - Border radius: 2px (pill)
  - Color: Gray
  - Center top, 8px from edge

Header:
  - Height: 56px
  - Fixed at top
  - Content:
    - Title: "Current Sale (3 items)"
    - Close button: X, right
    - Clear cart: Hidden in collapsed, shows in expanded

Content Area:
  - Scrollable list
  - Item cards: Same as desktop but optimized
    - Height: 96px (larger touch targets)
    - Padding: 16px
    - Image: 56x56px

  - Swipe gestures:
    - Swipe left: Reveals remove button (red background)
    - Swipe right: Nothing (or undo if recently removed)

Footer (Sticky Bottom):
  - Height: Auto
  - Background: Surface color
  - Border top: 1px solid outline
  - Shadow: Elevation 4
  - Content:
    - Customer selector: 44px height
    - Price summary: Auto height
    - Checkout button: 52px height

Collapsed State:
  - Shows: Header + first 2 items + footer
  - Drag up: Expands to show all items
  - Scroll: Not available (needs expansion)

Expanded State:
  - Shows: All items
  - Scroll: Independent of sheet drag
  - Drag down: Collapses sheet

Dismiss:
  - Drag down fully: Closes sheet
  - Tap backdrop: Closes sheet
  - Close button: Closes sheet
  - After checkout: Closes automatically
```

---

## 6.5 Customer Selection & Context

### State 6.5.1: Customer Selector - Default Walk-in

**Default State (No Customer Selected)**:
```
Customer Section (Cart Footer):
  - Height: 56px
  - Border: 1px solid outline color
  - Border radius: 8px
  - Padding: 12px 16px
  - Background: Surface variant color
  - Cursor: pointer

Content:
  - Icon: Person outline, 20px, left, gray
  - Text: "Walk-in Customer", 16px Inter Regular
  - Arrow: Chevron down, 16px, right
  - Tap/Click: Opens customer selector

Pricing Context:
  - All prices: Base price (no discount)
  - Credit option: Disabled
```

---

### State 6.5.2: Customer Search & Selection

**Trigger**: User taps customer selector

**Customer Selector Modal (Desktop)**:
```
Modal Dialog:
  - Width: 600px
  - Height: 600px
  - Center screen
  - Background: Surface color
  - Border radius: 16px

Header:
  - Height: 64px
  - Title: "Select Customer", 20px Inter Semibold
  - Close: X button

Search Bar:
  - Height: 48px
  - Margin: 16px (top/sides)
  - Icon: Search, 20px, left
  - Placeholder: "Search by name, phone, or email..."
  - Autofocus: Yes
  - Clear button: X appears when typing

Quick Filters (Below Search):
  - Horizontal chips, scrollable
  - Options:
    - "All Customers" (default)
    - "Walk-in"
    - "Platinum"
    - "Diamond"
    - "Gold"
    - "Silver"
    - "Bronze"
    - "Credit Customers"
  - Selected chip: Primary background

Customer List:
  - Scrollable area
  - Height: Flex (fills remaining space)
  - Max visible: ~8 customers

Customer List Item:
  - Height: 72px
  - Padding: 12px 16px
  - Border bottom: 1px solid outline/10%
  - Cursor: pointer
  - Hover: Background tint
  
  Content:
    - Avatar: Left, 48px circle
      - Initials or icon
      - Background: Tier color
    
    - Customer info: Center
      - Name: 16px Inter Medium
      - Phone: 13px Inter Regular, gray
      - Email: 12px, gray (if available)
    
    - Tier badge: Right side
      - Pill shape
      - Tier name: 12px
      - Tier color background
    
    - Credit info (if credit customer):
      - Below name
      - "Credit: PKR 5,000 available"
      - Color: Green (available) or Red (exceeded)

Walk-in Option:
  - Always first in list
  - Icon: Person, no avatar
  - Name: "Walk-in Customer"
  - Description: "No tier, base pricing"
  - Badge: "Default"

Empty State:
  - Icon: Person search, 64px, gray
  - Text: "No customers found"
  - Subtext: "Try different search terms"
  - Action: "+ Add New Customer" button

Footer:
  - Height: 64px
  - Background: Surface variant
  - Border top: 1px solid outline
  - Content:
    - "+ Add New Customer" button: Filled primary
    - "Clear Selection" link: Text button (if customer already selected)
```

**Mobile Customer Selector**:
```
Full-Screen Modal:
  - Header: 56px, fixed top
    - Back arrow: Left
    - Title: "Select Customer", center
    - Close: X, right
  
  - Search: 52px height, larger input
  - Filters: Horizontal scroll chips, 48px height
  - List: Full screen scrollable
  - Customer cards: 80px height (larger touch targets)
  
  - Footer: Fixed bottom
    - Add customer: Full width, 52px
    - Safe area padding
```

**Customer Selection Impact**:
```
When customer selected:
  1. Customer selector updates:
     - Shows customer name
     - Shows tier badge
     - Shows credit available (if applicable)
  
  2. Cart pricing updates:
     - All item prices: Recalculate with tier discount
     - Prices animate: Old → New (number count)
     - Subtotal: Updates
     - Discount row: Appears showing tier discount amount
  
  3. Payment methods update:
     - "Credit/On-Account" option: Enabled (if applicable)
     - Credit limit: Displayed
  
  4. Visual feedback:
     - Green checkmark animation in selector
     - Customer card: Highlight with tier color
     - Toast: "Customer selected: [Name]" (brief)
```

---

### State 6.5.3: Add New Customer (Quick Add)

**Trigger**: User clicks "+ Add New Customer" in selector

**Quick Add Form**:
```
Modal (Overlay):
  - Width: 480px
  - Centered
  - Title: "Add New Customer"

Form Fields:
  1. Customer Name* (required)
     - Input: Text field
     - Placeholder: "Full name"
  
  2. Phone Number* (required)
     - Input: Phone field with country code
     - Format: +92 XXX XXXXXXX
     - Validation: Valid phone format
  
  3. Email (optional)
     - Input: Email field
     - Validation: Valid email format
  
  4. Customer Tier
     - Dropdown: Select tier
     - Default: Walk-in
     - Shows tier benefits on selection
  
  5. Allow Credit
     - Toggle: On/Off
     - If On: Credit limit input appears
     - Default: Off

Footer:
  - Cancel: Outlined
  - Save & Select: Primary
    - Saves customer
    - Auto-selects in current transaction
    - Returns to POS with customer applied
```

---

## 6.6 Discounts & Pricing Adjustments

### State 6.6.1: Apply Discount - Item Level

**Trigger**: User taps/clicks discount icon on cart item

**Item Discount Modal**:
```
Modal:
  - Width: 420px
  - Center screen

Header:
  - Title: "Apply Discount"
  - Product name: Subtitle

Content:
  - Original price: Display, 16px
  - Current price: Display (after tier discount, if any)
  
  Discount Type Tabs:
    Tab 1: Percentage (%)
      - Input: Number, 0-100
      - Suffix: "%"
      - Preview: "New price: PKR 90 (was PKR 100)"
    
    Tab 2: Fixed Amount (PKR)
      - Input: Number, 0-CurrentPrice
      - Prefix: "PKR"
      - Preview: "New price: PKR 85 (was PKR 100)"
  
  Reason Dropdown:
    - Options:
      - "Promotional discount"
      - "Damaged item"
      - "Near expiry"
      - "Bulk purchase"
      - "Customer loyalty"
      - "Price match"
      - "Manager discretion"
      - "Other" (text input)
    - Required if: Discount > threshold (e.g., 10%)
  
  Manager Approval:
    - Shows if: Discount > approval threshold
    - PIN input: 4-digit manager PIN
    - Or: Request approval (sends notification to manager)

Footer:
  - Cancel: Outlined
  - Apply: Primary
    - Disabled until: Valid discount + reason (if required) + approval (if required)
```

**Discount Applied Visual**:
```
Cart Item Updates:
  - Original price: Strikethrough, gray
  - New price: Larger, green, bold
  - Discount badge: "-15%" or "-PKR 15", green background
  - Discount reason: Small text below price (for audit)

Cart Summary:
  - Item discount row: Adds/updates
    - "[Product Name]: -PKR 15"
  - Total discount: Shows cumulative discounts
```

---

### State 6.6.2: Apply Discount - Transaction Level

**Trigger**: User taps discount icon in cart summary

**Transaction Discount Modal**:
```
Similar to item discount but:
  - Applies to entire cart
  - Shows subtotal before discount
  - Calculates discount on all items proportionally
  - OR: Fixed amount on total

Special Cases:
  - Some items excluded: Option to exclude specific items
  - Tier discounts: Stack or replace tier discounts (configurable)
  - Max discount: Enforces business rules
```

---

### State 6.6.3: Manager Approval Flow

**Remote Approval Request**:
```
When discount requires approval:

Cashier View:
  - Modal: "Awaiting manager approval..."
  - Spinner: Loading animation
  - Details: Shows discount amount and reason
  - Timeout: 2 minutes
  - Actions:
    - "Cancel Request": Returns to discount entry
    - "Enter PIN": If manager available locally

Manager Notification:
  - Push notification: "Discount approval needed"
  - Badge: Red dot on manager's device
  - Details:
    - Counter: "Counter 1"
    - Cashier: "[Name]"
    - Discount: "15% off PKR 1,000"
    - Reason: "[Reason]"
  - Actions:
    - "Approve": Green button
    - "Reject": Red button
    - "Ask Question": Message cashier

Approval Response:
  - Approved: Modal closes, discount applied, toast "Discount approved"
  - Rejected: Modal shows "Discount rejected by [Manager]", retry or cancel options
  - Timeout: Modal shows "Approval timeout", manual PIN entry option
```

---

## 6.7 Payment Processing

### State 6.7.1: Checkout - Payment Method Selection

**Trigger**: User taps "Checkout" button (cart must have items)

**Payment Screen (Desktop)**:
```
Transition:
  - Cart panel: Slides left (exits)
  - Payment panel: Slides in from right (300ms)
  - Or: Cart minimizes to left bar, payment takes full right panel

Payment Panel Layout:
  - Full right panel (same space as cart)
  - Background: Surface color

Header:
  - Height: 64px
  - Title: "Payment", 24px Inter Semibold
  - Back arrow: Left, returns to cart
  - Amount: "Total: PKR 1,250", right, 20px, primary color

Payment Methods Grid:
  - Layout: 2x2 grid (desktop), 1 column (mobile)
  - Gap: 16px
  - Padding: 24px

Method Card:
  - Width: Auto (fills grid cell)
  - Height: 120px
  - Background: Surface color
  - Border: 2px solid outline color
  - Border radius: 12px
  - Padding: 20px
  - Cursor: pointer
  
  States:
    - Default: Normal appearance
    - Hover: Border primary color, lift -2px
    - Selected: Background primary/10%, border primary 3px
    - Disabled: Opacity 0.5, cursor not-allowed
  
  Content:
    - Icon: Top-left, 40px
    - Method name: 18px Inter Semibold
    - Description: 13px Inter Regular, gray
    - Badge: Top-right (if relevant)

Method Options:
  1. Cash
     - Icon: Money/bills, green
     - Name: "Cash"
     - Description: "Payment in cash"
     - Always enabled
  
  2. Card
     - Icon: Credit card, blue
     - Name: "Debit/Credit Card"
     - Description: "Swipe, chip, or tap"
     - Enabled if: Terminal connected OR manual entry allowed
  
  3. Mobile Wallet
     - Icon: Phone/wallet, purple
     - Name: "Mobile Wallet"
     - Description: "JazzCash, Easypaisa, etc."
     - Enabled if: Integration configured
  
  4. Credit/On-Account
     - Icon: Calendar/account, orange
     - Name: "Credit Sale"
     - Description: "Customer pays later"
     - Enabled if: Customer selected AND has credit
     - Shows: "Available: PKR 5,000"
  
  5. Split Payment
     - Icon: Split arrows, teal
     - Name: "Split Payment"
     - Description: "Multiple payment methods"
     - Always enabled if: Total > 0

Selection:
  - Single selection: Cash, Card, Wallet, Credit
  - Or: Split Payment (allows multiple)
  - After selection: Proceeds to method-specific flow
```

---

### State 6.7.2: Cash Payment

**Cash Payment Screen**:
```
Layout: Same panel as method selection

Header:
  - Back arrow: Returns to method selection
  - Title: "Cash Payment"
  - Amount due: "PKR 1,250", large, primary color

Amount Input Section:
  - Label: "Amount Received", 16px Inter Medium
  - Input: Number field
    - Height: 64px
    - Font: 32px Inter Bold
    - Prefix: "PKR"
    - Autofocus: Yes
    - Keyboard: Numeric

Quick Amount Buttons:
  - Common denominations (horizontal row):
    - PKR 500
    - PKR 1,000
    - PKR 2,000
    - PKR 5,000
    - "Exact" (auto-fills exact amount)
  - Each button: 48px height, outlined
  - Tap: Adds to current input value

Change Calculation:
  - Real-time calculation as user types
  - Display:
    - Large area, centered
    - If amount < total: "Insufficient: PKR -X" (red)
    - If amount = total: "Exact amount" (green)
    - If amount > total: "Change: PKR X" (green, very large 48px)
  
  - Animation: Count up/down smoothly when amount changes

Numpad (Optional, Mobile/Touch):
  - 3x4 grid
  - Numbers 1-9, 0, ., Backspace
  - Large touch targets: 64px
  - Haptic feedback on tap

Footer:
  - Cancel: Outlined button, left
  - Complete Sale: Primary button, right
    - Enabled when: Amount ≥ Total
    - Text: "Complete Sale (PKR 1,250)"
```

**Cash Payment Animation**:
```dart
class CashPaymentScreen extends StatefulWidget {
  final double total;
  
  @override
  _CashPaymentScreenState createState() => _CashPaymentScreenState();
}

class _CashPaymentScreenState extends State<CashPaymentScreen>
    with SingleTickerProviderStateMixin {
  double _receivedAmount = 0.0;
  late AnimationController _changeController;
  late Animation<double> _changeAnimation;
  
  @override
  void initState() {
    super.initState();
    
    _changeController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
  }
  
  void _updateAmount(double amount) {
    setState(() {
      final oldChange = _receivedAmount - widget.total;
      _receivedAmount = amount;
      final newChange = _receivedAmount - widget.total;
      
      _changeAnimation = Tween<double>(
        begin: oldChange,
        end: newChange,
      ).animate(
        CurvedAnimation(
          parent: _changeController,
          curve: Curves.easeOut,
        ),
      );
      
      _changeController.forward(from: 0.0);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final change = _receivedAmount - widget.total;
    final isValid = _receivedAmount >= widget.total;
    
    return Column(
      children: [
        _buildHeader(),
        _buildAmountInput(),
        _buildQuickButtons(),
        
        // Change display
        Expanded(
          child: Center(
            child: AnimatedBuilder(
              animation: _changeAnimation,
              builder: (context, child) {
                final displayChange = _changeAnimation.value;
                
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      displayChange < 0
                          ? 'Insufficient'
                          : displayChange == 0
                              ? 'Exact Amount'
                              : 'Change to Return',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: displayChange < 0
                            ? errorColor
                            : successColor,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      displayChange <= 0
                          ? 'PKR ${displayChange.abs().toStringAsFixed(2)}'
                          : 'PKR ${displayChange.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        color: displayChange < 0
                            ? errorColor
                            : successColor,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        
        _buildFooter(isValid),
      ],
    );
  }
}
```

---

### State 6.7.3: Card Payment

**Card Payment Screen**:
```
Layout: Similar to cash payment

Header:
  - Title: "Card Payment"
  - Amount: "PKR 1,250"

Terminal Integration:
  - Status indicator:
    - Connected: Green dot + "Terminal ready"
    - Disconnected: Red dot + "Terminal not connected"
    - Processing: Blue dot + "Processing..."
  
  - Terminal display (if connected):
    - Large icon: Card reader, animated
    - Text: "Waiting for card..."
    - Or: "Processing transaction..."
    - Or: "Transaction successful"
  
  - Manual entry option:
    - Link: "Enter card details manually"
    - Opens: Card details form
      - Card number: 16 digits
      - Expiry: MM/YY
      - CVV: 3 digits
      - Cardholder name

Processing States:
  1. Waiting: "Insert, swipe, or tap card"
     - Animated card icon with pulse
  
  2. Reading: "Reading card..."
     - Spinner + progress
  
  3. Processing: "Processing payment..."
     - Spinner, takes 2-5 seconds
  
  4. Success: "Payment successful!"
     - Green checkmark, scale animation
     - Auto-proceeds to receipt (2s)
  
  5. Failed: "Payment failed"
     - Red X icon
     - Error message: Reason (declined, timeout, etc.)
     - Actions: "Try Again" or "Use Different Method"

Footer:
  - Cancel: Returns to payment methods
  - Retry: Shows only on failure
```

---

### State 6.7.4: Mobile Wallet Payment

**Mobile Wallet Screen**:
```
Layout: Similar to other payment methods

Header:
  - Title: "Mobile Wallet Payment"
  - Amount: "PKR 1,250"

Wallet Type Selection:
  - Radio buttons OR large cards:
    - JazzCash
    - Easypaisa
    - SadaPay
    - NayaPay
    - Other
  - Each: Logo + name

Input Fields:
  - Mobile number: Phone input
    - Format: 03XX XXXXXXX
    - Validation: Valid Pakistan mobile
  
  - Transaction ID (after payment):
    - Text input
    - Customer provides after paying via their app
    - Required: Yes
    - Length: Variable by wallet

Instructions:
  - Step-by-step guide:
    1. "Open your [Wallet] app"
    2. "Send PKR 1,250 to: [Your Business Number]"
    3. "Enter the transaction ID below"
  
  - QR Code (if available):
    - Display QR for customer to scan
    - Alternative to manual transfer

Verification:
  - Manual: Cashier verifies transaction ID
  - API integration: Auto-verifies (if integration available)
  - Status: Pending, Verified, Failed

Footer:
  - Cancel: Returns to methods
  - Verify & Complete: Primary
    - Enabled when: Transaction ID entered
```

---

### State 6.7.5: Credit/On-Account Payment

**Credit Sale Screen**:
```
Layout: Simplified, shows customer credit info

Header:
  - Title: "Credit Sale"
  - Customer: Name and tier

Credit Information Card:
  - Background: Info color tint
  - Border: 2px solid info color
  - Content:
    - Credit limit: "PKR 10,000"
    - Used: "PKR 5,000"
    - Available: "PKR 5,000" (large, bold)
    - Current sale: "PKR 1,250"
    - After sale: "PKR 3,750 remaining" (calculated)

Visual Indicator:
  - Progress bar: Shows used vs limit
    - Green: < 70% used
    - Yellow: 70-90% used
    - Red: 90-100% used
  
  - Warning (if insufficient):
    - Red banner: "Insufficient credit"
    - Message: "This sale exceeds available credit by PKR X"
    - Options:
      - "Request limit increase"
      - "Use different payment method"
      - "Manager override"

Payment Terms:
  - Display: "Payment due in [N] days"
  - Due date: Calculated and shown
  - Terms: Net 30, Net 60, etc. (from customer tier)

Invoice Generation:
  - Checkbox: "Generate invoice" (default checked)
  - Invoice will be created automatically

Footer:
  - Cancel: Returns to methods
  - Complete Credit Sale: Primary
    - Enabled when: Credit available ≥ Sale amount
    - Or: Manager override provided
```

---

### State 6.7.6: Split Payment

**Split Payment Screen**:
```
Layout: Different from single methods

Header:
  - Title: "Split Payment"
  - Total: "PKR 1,250"
  - Remaining: "PKR 1,250" (updates as splits added)

Split Entry Section:
  - List: Shows added payment splits
  - Each split card:
    - Method icon + name
    - Amount: "PKR 500"
    - Edit/Remove icons

  - Add Split Button:
    - Prominent: "+ Add Payment Method"
    - Opens: Method selection (same grid as before)
    - After selection: Amount input for this split

Amount Input Modal (for each split):
  - Header: "[Method Name] Amount"
  - Input: Number field
    - Max: Remaining amount
    - Min: Any (can be partial)
  - Suggestion: "Full remaining (PKR X)" button
  - Footer: Cancel, Add

Split List Display:
  Card 1: Cash - PKR 500
  Card 2: Card - PKR 750
  ---
  Total Allocated: PKR 1,250 ✓
  Remaining: PKR 0

Validation:
  - Remaining = 0: Can proceed
  - Remaining > 0: Cannot proceed, shows "PKR X remaining"
  - Remaining < 0: Error, "Over-allocated by PKR X"

Process Flow:
  1. User adds splits one by one
  2. Each split: Select method → Enter amount → Add
  3. When total matched: "Complete Split Payment" enables
  4. Processing: Handles each split sequentially
     - Shows progress: "Processing payment 1 of 2..."
     - If any fails: Option to retry that split or cancel sale
```

---

## 6.8 Receipt Generation & Delivery

### State 6.8.1: Payment Success - Receipt Options

**Trigger**: Payment processing completes successfully

**Receipt Options Modal**:
```
Modal:
  - Width: 480px
  - Center screen
  - Cannot be dismissed (must select option)

Header:
  - Success icon: Large checkmark, 80px, green
  - Animation: Draws from center (800ms)
  - Title: "Payment Successful!", 24px Inter Bold
  - Amount: "PKR 1,250 received", 18px, green

Receipt Delivery Options:
  - Large button cards (vertical stack)
  - Each: 80px height, full width, 12px spacing

  Option 1: WhatsApp
    - Icon: WhatsApp logo, 32px, green
    - Title: "Send via WhatsApp", 18px
    - Description: "Instant delivery to customer"
    - Input: Phone number field (below card)
      - Pre-filled if customer has phone
      - Format: +92 XXX XXXXXXX
    - Status: "✓ Recommended"
  
  Option 2: Print
    - Icon: Printer, 32px, blue
    - Title: "Print Receipt"
    - Description: "Thermal or standard printer"
    - Status: Shows printer status
      - "✓ Printer ready" (green)
      - "⚠ Printer offline" (orange, disabled)
  
  Option 3: Email
    - Icon: Email, 32px, purple
    - Title: "Send via Email"
    - Description: "PDF receipt to email"
    - Input: Email field (below card)
      - Pre-filled if customer has email
  
  Option 4: SMS
    - Icon: Message, 32px, teal
    - Title: "Send via SMS"
    - Description: "Text message receipt"
    - Input: Phone number field
    - Note: "Charges may apply"
  
  Option 5: No Receipt
    - Icon: Circle with slash, 32px, gray
    - Title: "No Receipt"
    - Description: "Complete without receipt"
    - Confirmation: "Are you sure?"

Multiple Selection:
  - Checkboxes: Can select multiple options
  - Example: WhatsApp + Print
  - Process: Sends to all selected simultaneously

Footer:
  - "Complete Sale" button: Primary
    - Sends receipts and closes transaction
    - Text updates based on selection:
      - "Send & Complete" (if delivery method)
      - "Complete Sale" (if no receipt)
  
  - "View Receipt" link: Opens preview

Loading State:
  - When sending: "Sending receipt..."
  - Spinner on selected option cards
  - Disables other options
  - Shows checkmark when delivered

Success Feedback:
  - Green checkmark on delivered options
  - Toast: "Receipt sent successfully"
  - Auto-closes modal after 2s (or manual close)
```

**WhatsApp Receipt Flow**:
```
Process:
  1. User selects WhatsApp + enters/confirms phone
  2. System generates receipt PDF
  3. Uploads PDF to temporary storage (CDN)
  4. Constructs WhatsApp message:
     - "Thank you for shopping at [Business Name]!"
     - "Your receipt: [PDF URL]"
     - "Amount: PKR 1,250"
     - "Transaction: #TXN001"
  5. Opens WhatsApp:
     - Mobile: Deep link to WhatsApp app
     - Desktop: WhatsApp Web URL
  6. Pre-fills message with receipt details
  7. User: Taps send in WhatsApp
  8. Returns to POS
  9. Transaction marked complete

Mobile Deep Link:
  - URL: whatsapp://send?phone=[number]&text=[message]
  - If app installed: Opens WhatsApp directly
  - If not installed: Shows error, suggests SMS/Email

Desktop WhatsApp Web:
  - URL: https://wa.me/[number]?text=[message]
  - Opens in new tab
  - User: Scans QR if not logged in
```

---

### State 6.8.2: Receipt Preview

**Trigger**: User clicks "View Receipt" link

**Receipt Preview Modal**:
```
Modal:
  - Width: 600px
  - Height: 80vh
  - Scrollable content

Receipt Layout (Standard Format):
  ---
  [Business Logo]
  [Business Name]
  [Business Address]
  [Contact: Phone, Email]
  
  ---
  Receipt #: TXN001
  Date: Dec 06, 2024 10:45 AM
  Counter: Counter 1
  Cashier: [Name]
  
  ---
  Customer: [Name]
  Tier: [Tier Name]
  Phone: [Phone]
  
  ---
  ITEMS:
  
  1. Panadol 500mg Tab
     Batch: BATCH001
     Exp: Mar 2025
     Qty: 2 × PKR 50.00     PKR 100.00
     Discount: -10%         -PKR 10.00
  
  2. Augmentin 625mg
     Batch: BATCH002
     Exp: Jun 2025
     Qty: 1 × PKR 450.00    PKR 450.00
  
  ---
  Subtotal:                PKR 540.00
  Discount:                -PKR 10.00
  Tax (17%):               PKR 90.10
  
  TOTAL:                   PKR 620.10
  
  ---
  Payment Method: Cash
  Received: PKR 1,000.00
  Change: PKR 379.90
  
  ---
  [Barcode: Transaction ID]
  
  Thank you for your business!
  [Footer message if configured]
  ---

Footer Actions:
  - Download PDF: Icon button
  - Print: Icon button
  - Close: Button
```

---

### State 6.8.3: Transaction Complete - Return to Cart

**Trigger**: Receipt sent/printed or user completes without receipt

**Completion Animation**:
```
Sequence:
  1. Receipt modal: Scales down + fades out (300ms)
  2. Success overlay: Briefly flashes green (200ms)
  3. Payment panel: Slides right (exits) (400ms)
  4. Cart panel: Slides in from left (400ms)
  5. Cart: Empty state appears with new animation
  6. Stats update: Transaction counter increments (top bar)
  7. Toast: "Sale completed - PKR 1,250" (3s)

Stats Update Animation:
  - Today's sales count: "+1" badge appears briefly
  - Sales amount: Numbers roll up to new total
  - Animation: Counter effect (500ms)

Ready for Next Sale:
  - Cart: Empty
  - Customer: Reset to Walk-in
  - Search: Focused (ready for next scan/search)
  - All states: Cleared
```

---

## 6.9 Returns & Exchanges

### State 6.9.1: Return/Exchange - Access

**Access Points**:
1. Main navigation: "Returns" menu item
2. POS screen: "Process Return" button (toolbar)
3. Transaction history: "Return" action on transaction

**Returns Screen Launch**:
```
Full-screen interface (similar to POS):
  - Left panel: Return search
  - Right panel: Return cart

Header:
  - Title: "Returns & Exchanges"
  - Back: Returns to POS
```

---

### State 6.9.2: Original Transaction Lookup

**Return Search Panel (Left)**:
```
Search Methods (Tabs):
  
  Tab 1: Receipt Number
    - Input: Text field
    - Placeholder: "Enter receipt/transaction number"
    - Format: TXN001, RCP12345, etc.
    - Search: Real-time as typing
  
  Tab 2: Customer
    - Search: Customer name/phone
    - Shows: Recent transactions for selected customer
    - List: Last 30 days, 20 per page
  
  Tab 3: Date Range
    - Date pickers: From - To
    - Max range: 90 days
    - Shows: All transactions in range
    - Filter: By amount, items, payment method

Transaction Results:
  - List: Scrollable
  - Each transaction:
    - Receipt #: Bold, 16px
    - Date/Time: 13px gray
    - Amount: 16px, right-aligned
    - Items: "3 items", below amount
    - Payment: Icon + method name
    - Customer: If not walk-in
    - Status: "Completed" badge
    - Actions: "Return" button

  - Click transaction: Loads to return cart

Already Returned:
  - Transactions with returns: Shows badge
  - "Partial Return" (if some items returned)
  - "Full Return" (if all returned)
  - "View Return Details" link
```

---

### State 6.9.3: Select Items to Return

**Return Cart Panel (Right)**:
```
After transaction selected:

Header:
  - Title: "Return Items"
  - Original receipt: TXN001, date, amount
  - Time limit indicator:
    - "Return window: 5 days remaining" (green)
    - "Return window expired" (red, blocks return)

Original Items List:
  - Shows: All items from original transaction
  - Each item: Checkbox (left)

  Item Card:
    - Checkbox: Select for return
    - Product info: Name, batch, original price
    - Original qty: "Qty: 2"
    - Return qty selector: Shows if checkbox checked
      - Stepper: [ - ] [Qty] [ + ]
      - Max: Original quantity - already returned
    - Unit price: Original price paid
    - Refund: Calculated (qty × price)

Return Reason Dropdown:
  - Shows: When item selected
  - Options:
    - "Defective/Damaged"
    - "Wrong item received"
    - "Customer changed mind"
    - "Expired or near expiry"
    - "Quality issue"
    - "Price discrepancy"
    - "Other" (text input required)
  - Required: Yes, for each returned item

Item Condition:
  - Radio buttons (per item):
    - "Resellable" (add back to inventory)
    - "Damaged" (write off, don't restock)
    - "Expired" (quarantine)

Refund Summary:
  - Subtotal: Sum of returned items
  - Tax refund: Proportional tax
  - Total refund: Large, bold, primary color

Refund Method:
  - Radio buttons:
    - "Cash refund"
    - "Card refund" (if original payment was card)
    - "Store credit"
    - "Exchange" (credit applied to new purchase)
  - If card refund: Terminal integration needed

Footer:
  - Cancel: Returns to search
  - Process Return: Primary button
    - Enabled when: ≥1 item selected + all reasons filled
```

---

### State 6.9.4: Process Return

**Confirmation Modal**:
```
Modal:
  - Width: 480px
  - Center screen

Header:
  - Icon: Return/refresh, 48px, warning color
  - Title: "Confirm Return"

Content:
  - Original transaction: Receipt #, date, total
  - Items to return: Count and list
  - Refund amount: Large, bold
  - Refund method: Display selected method
  
  - Warning (if applicable):
    - "This action cannot be undone"
    - "Inventory will be updated"
    - "Original payment will be reversed"

Authorization:
  - Manager PIN: 4-digit input
  - Or: Manager approval (if configured)
  - Required for: Returns >threshold amount

Footer:
  - Cancel: Outlined
  - Confirm Return: Filled primary
```

**Processing Flow**:
```
After confirmation:
  1. Validate: All data correct
  2. Create: Return transaction record
  3. Update: Inventory (if resellable)
  4. Process: Refund (cash/card/credit)
  5. Generate: Return receipt
  6. Update: Customer account (if store credit)
  7. Link: Return to original transaction
  8. Success: Show completion screen
```

---

### State 6.9.5: Exchange Flow

**Exchange Process**:
```
If user selects "Exchange" refund method:

After return processed:
  1. Return panel: Closes
  2. POS panel: Opens with store credit applied
  3. Banner: "Store credit: PKR 620.10" (prominent)
  4. User: Adds exchange products to cart
  5. Checkout: Credit auto-applied
  6. If cart < credit: Remaining as store credit
  7. If cart > credit: Pay difference
  8. Complete: Both return and new sale recorded
```

---

## 6.10 Multi-Counter Operations

### State 6.10.1: Session Management

**Active Session Indicator**:
```
POS Top Bar:
  - Session info: Always visible
  - Content:
    - Counter name: "Counter 1"
    - Session start: "Started: 9:30 AM"
    - Time elapsed: "2h 15m" (updates every minute)
    - Transaction count: "15 sales today"
  - Style: Small text, right side, before user avatar
  - Click: Opens session details modal
```

**Session Details Modal**:
```
Modal:
  - Width: 500px
  - Center screen

Header:
  - Title: "Session Details"
  - Counter: Name + number

Content:
  - Session info:
    - Started: Date + time
    - Duration: Elapsed time
    - Cashier: Current user name
    - Starting cash: Amount entered at start
  
  - Transaction summary:
    - Total transactions: Count
    - Total sales: Amount
    - Total returns: Count + amount
    - Payment breakdown:
      - Cash: Count + amount
      - Card: Count + amount
      - Credit: Count + amount
      - Etc.
  
  - Expected cash:
    - Starting cash: +
    - Cash sales: +
    - Cash refunds: -
    - Expected total: =
    - Calculated and displayed
  
  - Last 10 transactions:
    - Scrollable list
    - Each: Time, amount, payment, items

Footer:
  - Close Session: Outlined warning button
  - Print Report: Icon button
  - Close: Button
```

---

### State 6.10.2: Close Session / End of Day

**Trigger**: User clicks "Close Session" in session details OR end of shift

**Close Session Flow**:
```
Modal Wizard (3 steps):

Step 1: Cash Count
  - Title: "Count Cash in Drawer"
  - Denomination breakdown:
    - PKR 5000 × [input] = [auto]
    - PKR 1000 × [input] = [auto]
    - PKR 500 × [input] = [auto]
    - PKR 100 × [input] = [auto]
    - PKR 50 × [input] = [auto]
    - PKR 20 × [input] = [auto]
    - PKR 10 × [input] = [auto]
    - Coins: [input]
    - Total counted: [sum], large display
  
  - Expected: PKR 12,500 (calculated from session)
  - Variance: Counted - Expected
    - Green: If 0
    - Yellow: If < PKR 100 difference
    - Red: If > PKR 100 difference
  
  - Continue: Enabled always (can have variance)

Step 2: Explain Variance (if variance exists)
  - Title: "Cash Variance"
  - Display:
    - Expected: PKR 12,500
    - Counted: PKR 12,450
    - Variance: -PKR 50 (short)
  
  - Reason input:
    - Text area: Required if variance > threshold
    - Placeholder: "Explain the difference..."
    - Max: 200 characters
  
  - Common reasons (quick select):
    - "Customer underpayment"
    - "Incorrect change given"
    - "Drawer malfunction"
    - "Missing receipt"
    - "Other"
  
  - Attachment: Option to attach photo/document
  
  - Continue: Enabled after reason provided

Step 3: Confirmation
  - Title: "Close Session?"
  - Summary:
    - Session duration: 8h 15m
    - Transactions: 45 sales, 2 returns
    - Total sales: PKR 15,670
    - Cash variance: PKR -50
  
  - Warning: "This action cannot be undone"
  
  - Actions:
    - Back: Returns to previous step
    - Cancel: Exits wizard
    - Close Session: Primary button
      - Manager PIN required if variance > threshold
      - Or automatic if within tolerance

Processing:
  1. Create: End-of-shift report
  2. Update: Session status to "Closed"
  3. Lock: Counter (requires new session to use)
  4. Generate: Detailed report PDF
  5. Email: Report to manager (if configured)
  6. Success: Show completion screen

Completion:
  - Success icon: Green checkmark
  - Message: "Session closed successfully"
  - Report: "Download Report" button
  - Action: "Return to Dashboard" or "Start New Session"
```

---

## 6.11 Offline Mode Handling

### State 6.11.1: Offline Detection

**Network Status Indicator**:
```
Top Bar:
  - Status icon: Right side, near time
  - States:
    - Online: Green dot (hidden after 5s)
    - Offline: Orange dot + "Offline" text (persistent)
    - Syncing: Blue dot + "Syncing..." (animated pulse)
  
  - Tooltip: On hover
    - Online: "Connected to server"
    - Offline: "Working offline - changes will sync when online"
    - Syncing: "Syncing [N] transactions..."

Banner:
  - Shows: When going offline
  - Position: Below top bar, full width
  - Background: Warning color tint
  - Icon: Wifi off, 20px
  - Message: "Working offline - sales will sync when connection restored"
  - Action: "View Queue" link (shows pending transactions)
  - Dismissible: X button (but reappears if still offline)
```

---

### State 6.11.2: Offline Operations

**What Works Offline**:
```
Fully Functional:
  - Product search (from local cache)
  - Barcode scanning
  - Add products to cart
  - Quantity adjustments
  - Apply discounts
  - Select customer (from cache)
  - Calculate totals
  - Cash payments (complete transactions)
  - Card payments (save for later processing)
  - Receipt generation (print only)

Limited:
  - Product images: May not load (shows placeholder)
  - Customer search: Limited to cached customers
  - Real-time inventory: Uses last synced data
  - Receipt WhatsApp/Email: Queued for later

Not Available:
  - New product creation
  - New customer creation
  - Credit limit verification (uses cached limits)
  - Manager approval requests (requires PIN)
  - Live reports
```

**Offline Transaction Flow**:
```
Complete sale offline:
  1. Products: Selected from cache
  2. Cart: Functions normally
  3. Customer: Selected from cache
  4. Payment: Process as normal
  5. Receipt: Print only (WhatsApp/Email queued)
  6. Transaction: Saved to local SQLite queue
  7. Status: Marked "Pending Sync"
  8. Cart: Clears for next sale
  9. UI: Shows success but with "Queued" indicator

Transaction Queue:
  - Stored: In local SQLite database
  - Each transaction: Complete data (items, payment, customer, etc.)
  - Sequence number: Ensures order preservation
  - Timestamp: Local device time
```

---

### State 6.11.3: Sync Process

**Automatic Sync**:
```
When connection restored:
  1. Detection: App detects internet available
  2. Banner: Changes to "Syncing..."
  3. Background: Sync engine starts
  4. Process:
     - Uploads: Transactions in queue (FIFO)
     - Batch size: 10 at a time
     - Retry: Failed uploads (3 attempts)
     - Downloads: Updated product data, prices, stock levels
  
  5. Progress:
     - Shows: "Syncing [X] of [N] transactions..."
     - Progress bar: In banner
  
  6. Conflicts:
     - Inventory: Server stock vs local stock
     - Resolution: Last-write-wins OR manual review
     - Negative stock: Flags for manual review
  
  7. Complete:
     - Banner: "Sync complete - [N] transactions uploaded"
     - Auto-dismiss: After 5 seconds
     - Success toast: "All sales synced"

Sync Queue Panel:
  - Access: Click "View Queue" in offline banner
  
  Modal:
    - Title: "Pending Sync"
    - List: All queued transactions
    - Each:
      - Transaction ID (local)
      - Time: When created
      - Amount: Total
      - Status: "Pending", "Uploading", "Failed", "Synced"
    
    - Actions:
      - Refresh: Manual sync trigger
      - Retry Failed: Retry failed uploads only
      - Clear Synced: Remove synced items from list
```

**Sync Conflict Resolution**:
```
If conflict detected:
  
  Example: Product sold offline but stock = 0 on server
  
  Modal:
    - Title: "Sync Conflict Detected"
    - Icon: Warning triangle, orange
    
    - Details:
      - Product: Name
      - Issue: "Sold 2 units but server shows 0 in stock"
      - Local transaction: TXN_LOCAL_001
    
    - Options:
      1. "Accept Sale" (creates negative stock, alerts manager)
      2. "Reject Sale" (voids transaction, refund customer)
      3. "Manual Review" (sends to manager for decision)
    
    - Default: Option 1 (accept sale, flag for review)
    - Footer: Confirm, Skip (leaves unresolved)

Negative Stock Handling:
  - Transaction: Accepted and synced
  - Inventory: Set to negative (e.g., -2)
  - Alert: Sent to manager
  - Flag: "Needs reconciliation" on product
  - Report: Added to "Stock Discrepancies" report
```

---

## Summary

**Part 4 Coverage Complete**:
- ✅ POS Launch & Counter Selection (3 states)
- ✅ POS Home Screen (3 states)
- ✅ Product Search & Selection (3 states)
- ✅ Cart Management (5 states)
- ✅ Customer Selection & Context (3 states)
- ✅ Discounts & Pricing (3 states)
- ✅ Payment Processing (6 states - all methods)
- ✅ Receipt Generation & Delivery (3 states)
- ✅ Returns & Exchanges (5 states)
- ✅ Multi-Counter Operations (2 states)
- ✅ Offline Mode Handling (3 states)

**Total States Documented**: 39 comprehensive states across all platforms and themes

**Key Accomplishments**:
- Complete POS transaction flow (start to finish)
- All payment methods with detailed processing
- Advanced cart management with animations
- Customer context and tier-based pricing
- Comprehensive return/exchange workflows
- Multi-counter session management
- Robust offline-first architecture with sync

**Technical Highlights**:
- Flutter animation code for all transitions
- Real-time calculations and validations
- Platform-specific adaptations (desktop/tablet/mobile)
- Both light and dark theme specifications
- Offline SQLite queue with sync engine
- Conflict resolution strategies
- Manager approval workflows

**Next Document (Part 5)**: Inventory Operations
- Stock adjustments and cycle counts
- Inter-location transfers (detailed workflows)
- Goods receiving (GRN process)
- Stock movement audit trails
- Batch management operations
- Expiry alert handling
- Inventory reports and analytics

---

**Document Complete**: Part 4 - Live POS Operations

**File Location**: `/mnt/user-data/outputs/bizPharma_States_Expansion_PART_4.md`
