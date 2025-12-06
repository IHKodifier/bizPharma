# bizPharma - States Expansion Design Brief (Part 6)

## Document Information

**Version**: 1.0  
**Date**: December 2024  
**Document**: Part 6 of States Expansion Series  
**Scope**: Reporting & Analytics  
**Coverage**: Dashboards → Sales Reports → Inventory Reports → Financial Reports → Custom Builder  
**Platforms**: Mobile, Tablet, Desktop, Web  
**Themes**: Light & Dark (explicitly documented for each state)  
**Granularity**: Detailed with micro-interactions, animations, and platform variations

---

## What This Document Covers

This is **Part 6** focusing on:

1. ✅ Role-Based Dashboards & Widgets
2. ✅ Sales Analytics & Reports
3. ✅ Inventory Intelligence Reports
4. ✅ Financial Reporting & Statements
5. ✅ Supplier & Customer Analytics
6. ✅ Custom Report Builder
7. ✅ Data Visualization Library
8. ✅ Scheduled Reports & Automation

**Previous Documents**:  
- **Part 1**: Landing Page, Authentication Flows  
- **Part 2**: Business Onboarding & Configuration  
- **Part 3**: POS & Inventory Setup  
- **Part 4**: Live POS Operations
- **Part 5**: Inventory Operations

**Next Document (Part 7)**: Settings & Administration

---

## Design System References

Building upon:
- **Part 1-5**: All previous patterns
- **Style Guide**: `/mnt/project/4_a_Style_Guide__bizPharma.md`
- **Feature Stories**: `/mnt/project/3__Feature_Stories_bizPharma.md`
- **Architecture**: `/mnt/project/2__High_Level_Architecture_bizPharma.md`

---

# 8. ROLE-BASED DASHBOARDS & WIDGETS

## 8.1 Dashboard Overview & Customization

### State 8.1.1: Business Admin Dashboard - Desktop

**Access**: Home / Dashboard (after login)

**Layout Structure (Desktop 1280px+)**:
```
Top Navigation Bar:
  - Height: 64px
  - Background: Primary color
  - Content:
    - Logo: Left, 40px height
    - Business name: Next to logo, 18px white
    - Location selector: Dropdown (if multi-location)
    - Search: Global search, center-right
    - Notifications: Bell icon + badge
    - User menu: Avatar + name + dropdown

Secondary Bar:
  - Height: 48px
  - Background: Surface color
  - Content:
    - Dashboard title: "Business Overview", 20px
    - Date range selector: Dropdown
      - Today
      - Yesterday
      - Last 7 days
      - Last 30 days
      - This month
      - Last month
      - Custom range
    - Compare to: Dropdown (previous period, last year)
    - Refresh: Icon button (manual refresh)
    - Customize: Icon button (edit layout)
    - Export: Icon button (export dashboard)

Main Content Area (Grid Layout):
  - 12-column grid
  - 16px gutter between widgets
  - 24px padding from edges

Widget Grid (Default Business Admin Layout):
  
  Row 1 (KPI Summary - 4 widgets × 3 columns):
    
    Widget 1: Total Sales (Today/Period)
      - Size: 3 columns wide
      - Height: 140px
      - Content:
        - Icon: Shopping cart, 40px, primary color
        - Label: "Total Sales", 14px gray
        - Amount: "PKR 125,450", 32px bold primary
        - Trend: "+12.5%" with up arrow, green
        - Comparison: "vs yesterday/last period"
        - Mini chart: Sparkline (last 7 days)
      - Click action: Opens sales detail report
    
    Widget 2: Transactions Count
      - Size: 3 columns
      - Icon: Receipt
      - Label: "Transactions"
      - Count: "234", 32px bold
      - Trend: "+8.2%"
      - Average: "PKR 536 per transaction"
      - Mini chart: Bar chart (last 7 days)
    
    Widget 3: Gross Profit
      - Size: 3 columns
      - Icon: TrendingUp
      - Label: "Gross Profit"
      - Amount: "PKR 45,230", 32px bold success green
      - Margin: "36.1%"
      - Trend: "+5.8%"
      - Mini chart: Area chart
    
    Widget 4: Active Customers
      - Size: 3 columns
      - Icon: Users
      - Label: "Active Customers"
      - Count: "87", 32px bold
      - New: "+5 new today"
      - Trend: "+3.2%"
      - Mini list: Top 3 customers

  Row 2 (Critical Alerts - Full width):
    
    Widget 5: Alert Banner (Collapsible)
      - Size: 12 columns
      - Height: Auto (collapsed: 60px, expanded: varies)
      - Background: Warning/error tint based on severity
      
      Collapsed view:
        - Icon: Alert triangle
        - Text: "5 alerts requiring attention"
        - Categories: "2 inventory, 2 financial, 1 system"
        - Expand arrow: Right side
      
      Expanded view:
        - Alert cards in grid (3 per row)
        - Each alert:
          - Severity: Icon + badge (High/Medium/Low)
          - Title: 16px bold
          - Description: 14px, truncated
          - Action: Primary button
          - Dismiss: X icon
        
        Alert types shown:
          1. Low Stock Alerts
             - "15 products below minimum stock"
             - Action: "View & Reorder"
          
          2. Expiring Products
             - "8 products expiring in 30 days"
             - Action: "Apply Discounts"
          
          3. Pending Approvals
             - "3 transfer requests awaiting approval"
             - Action: "Review Approvals"
          
          4. Cash Flow Warning
             - "Accounts receivable: PKR 125K overdue"
             - Action: "View Aging"
          
          5. System Update
             - "New feature available: Automated reordering"
             - Action: "Learn More"

  Row 3 (Sales Performance - 8 cols + Quick Actions - 4 cols):
    
    Widget 6: Sales Chart (8 columns)
      - Height: 320px
      - Title: "Sales Trend", 18px
      - Subtitle: Period display
      - Chart type toggle: Line / Bar / Area
      - Timeframe: Today (hourly) / Week (daily) / Month (daily) / Year (monthly)
      
      Chart content:
        - X-axis: Time periods
        - Y-axis: Sales amount (PKR)
        - Line: Sales revenue
        - Optional overlay: Transactions count (secondary Y-axis)
        - Hover: Tooltip showing exact values
        - Zoom: Click-drag to zoom in
      
      Legend:
        - Revenue: Primary color
        - Transactions: Secondary color
        - Goal: Dashed line (if set)
      
      Footer stats:
        - Average: PKR X per period
        - Peak: Date + amount
        - Lowest: Date + amount
    
    Widget 7: Quick Actions (4 columns)
      - Height: 320px
      - Title: "Quick Actions", 18px
      - Grid: 2 columns × 4 rows
      
      Action buttons (each 140px × 70px):
        1. "New Sale" - Primary color
           - Icon: Plus + shopping cart
           - Opens: POS
        
        2. "Receive Goods" - Green
           - Icon: Box + arrow down
           - Opens: GRN entry
        
        3. "Stock Adjustment" - Orange
           - Icon: Edit + inventory
           - Opens: Adjustment form
        
        4. "View Reports" - Blue
           - Icon: Chart bar
           - Opens: Reports page
        
        5. "Transfer Stock" - Purple
           - Icon: Arrows horizontal
           - Opens: Transfer form
        
        6. "Add Product" - Teal
           - Icon: Plus + box
           - Opens: Product form
        
        7. "Customer Management" - Pink
           - Icon: Users
           - Opens: Customer list
        
        8. "Settings" - Gray
           - Icon: Gear
           - Opens: Settings

  Row 4 (Inventory Status - 6 cols + Top Products - 6 cols):
    
    Widget 8: Inventory Status (6 columns)
      - Height: 280px
      - Title: "Inventory Health", 18px
      
      Content:
        - Donut chart: Center
          - Segments:
            - Healthy: >Min stock (green)
            - Low: At min stock (yellow)
            - Critical: Below min (red)
            - Out of stock: Zero (dark red)
        
        - Center text: Total products count
        
        - Legend: Below chart
          - Each segment: Count + percentage
          - Clickable: Filters inventory list
        
        - Stats row:
          - Total value: PKR XXX,XXX
          - Turnover rate: X.Xx
          - Aging >90 days: Count
    
    Widget 9: Top Products (6 columns)
      - Height: 280px
      - Title: "Best Sellers", 18px
      - Subtitle: "Today / This week / This month"
      - Tab toggle: By Revenue / By Quantity / By Profit
      
      List (Top 5):
        - Each row:
          - Rank: #1-5
          - Product image: 48px
          - Product name: 14px, 2 lines max
          - Metric: Large number
            - Revenue: PKR XXX
            - Quantity: N units
            - Profit: PKR XXX
          - Bar: Visual representation
          - Trend: ↑↓ with percentage
      
      Footer: "View All Products" link

  Row 5 (Financial Summary - 4 cols × 3):
    
    Widget 10: Cash Flow (4 columns)
      - Height: 200px
      - Title: "Cash Flow", 16px
      
      Content:
        - Waterfall chart or simple flow diagram
        - Opening balance: Start
        - Inflows: Cash sales, AR collections
        - Outflows: Purchases, expenses
        - Closing balance: End
        - Color coded: Green (in), Red (out)
        - Net change: Large display
    
    Widget 11: Accounts Receivable (4 columns)
      - Height: 200px
      - Title: "Receivables", 16px
      
      Content:
        - Total outstanding: Large, primary
        - Aging buckets:
          - Current: 0-30 days, green
          - 31-60 days: yellow
          - 61-90 days: orange
          - 90+ days: red
        - Bar chart: Visual aging
        - Overdue amount: Highlighted
        - Action: "Send Reminders" button
    
    Widget 12: Accounts Payable (4 columns)
      - Height: 200px
      - Title: "Payables", 16px
      
      Content:
        - Total due: Large, warning color
        - Aging similar to AR
        - Due this week: Highlighted
        - Due this month: Display
        - Action: "Schedule Payments" button

  Row 6 (Recent Activity - Full width):
    
    Widget 13: Activity Feed (12 columns)
      - Height: 300px
      - Title: "Recent Activity", 18px
      - Filter tabs: All / Sales / Inventory / Users
      
      Activity list (scrollable):
        - Each item:
          - Avatar: User or system icon
          - Action: Bold text
          - Details: Regular text
          - Timestamp: Relative (2 hours ago)
          - Icon: Action type icon
        
        Examples:
          - "John Doe completed a sale of PKR 1,250"
          - "Low stock alert: Panadol 500mg"
          - "Jane Smith adjusted inventory: +50 units"
          - "Transfer approved: Main → Store #1"
          - "System: Daily backup completed"
      
      Load more: Button at bottom

Edit Mode (Customize Dashboard):
  - Triggered: Click "Customize" button
  - Overlay: Semi-transparent backdrop
  - Each widget: Shows edit controls
  
  Widget controls:
    - Drag handle: Top-left (6-dot icon)
    - Resize handles: Corners and edges
    - Settings: Gear icon (configure widget)
    - Remove: X icon (delete widget)
    - Opacity: 0.9 when dragging
  
  Sidebar: Available widgets
    - Categories: Sales, Inventory, Financial, Operations, Custom
    - Each widget: Card with preview
    - Drag to add: Drag onto grid
  
  Grid constraints:
    - Snaps to grid: 1-column increments
    - Min size: 3 columns × 2 rows
    - Max size: 12 columns × 6 rows
    - Collision detection: Can't overlap
  
  Save changes:
    - "Cancel" - Discard changes
    - "Reset to Default" - Restore default layout
    - "Save Layout" - Primary button
      - Saves to user preferences
      - Applies immediately
```

**Light Theme Styling**:
```
Top Nav:
  - Background: #0F4C4C (primary)
  - Text: #FFFFFF
  - Icons: #FFFFFF

Secondary Bar:
  - Background: #FFFFFF
  - Border bottom: 1px solid #E8EAED
  - Text: #44474E

KPI Widgets:
  - Background: #FFFFFF
  - Border: 1px solid #E8EAED
  - Shadow: Elevation 1
  - Hover: Shadow elevation 2
  
  Icon: Primary color circle background
  Label: #44474E, 14px
  Value: #0F4C4C, 32px Bold
  Trend up: #4CAF50
  Trend down: #F44336
  
  Sparklines:
    - Line color: Primary
    - Fill: Primary with 20% opacity
    - Grid: #E8EAED

Alert Banner:
  - Collapsed: #FFF3CD background, #856404 text
  - High severity: #FFEBEE background, #C62828 text
  - Medium: #FFF3CD background, #F57C00 text
  - Low: #E3F2FD background, #1976D2 text

Charts:
  - Background: #FFFFFF
  - Grid lines: #E8EAED
  - Primary line: #0F4C4C
  - Secondary line: #1A6363
  - Area fill: #0F4C4C with 10% opacity
  - Bars: #0F4C4C
  - Hover: #1A6363
  - Tooltip: #2A2A2A background, white text

Quick Actions:
  - Each button: White background
  - Border: 2px solid category color
  - Icon: Category color
  - Text: #44474E
  - Hover: Category color background with 10% opacity

Activity Feed:
  - Items: Alternating #FFFFFF / #F8F9FA
  - Avatar: Primary color background
  - Timestamp: #9E9E9E
```

**Dark Theme Styling**:
```
Top Nav:
  - Background: #C5E64D (primary)
  - Text: #2C3500
  - Icons: #2C3500

Secondary Bar:
  - Background: #2A2A2A
  - Border: 1px solid #404040
  - Text: #C7C7C7

KPI Widgets:
  - Background: #2A2A2A
  - Border: 1px solid #404040
  - Shadow: Elevation 1
  
  Icon: Primary color circle
  Label: #C7C7C7
  Value: #C5E64D, 32px Bold
  Trend up: #66BB6A
  Trend down: #EF5350
  
  Sparklines:
    - Line: #C5E64D
    - Fill: #C5E64D with 20% opacity
    - Grid: #404040

Alert Banner:
  - High: #B71C1C background, #FFCDD2 text
  - Medium: #E65100 background, #FFE0B2 text
  - Low: #0D47A1 background, #BBDEFB text

Charts:
  - Background: #2A2A2A
  - Grid: #404040
  - Lines: #C5E64D, #B4A6F5
  - Bars: #C5E64D
  - Tooltip: #1E1E1E background, #E5E5E5 text

Quick Actions:
  - Background: #1E1E1E
  - Border: 2px solid #404040
  - Hover: Category color with 20% opacity

Activity Feed:
  - Items: Alternating #2A2A2A / #333333
  - Avatar: #C5E64D background
```

---

### State 8.1.2: Mobile Dashboard (Responsive)

**Mobile Layout (<768px)**:
```
Top Bar (Fixed):
  - Height: 56px
  - Background: Primary
  - Content:
    - Menu icon: Left (hamburger)
    - Business name: Center, truncated
    - Notifications: Bell icon, right
    - Date range: Hidden (in dropdown menu)

KPI Summary (Horizontal Scroll):
  - Swipeable cards
  - Each card: 280px width × 120px height
  - Padding: 16px between cards
  - Snap scrolling: Snaps to card edges
  - Indicators: Dots below showing position
  
  Card content (condensed):
    - Icon: 32px, top-left
    - Label: 13px, top-right
    - Value: 24px bold, center
    - Trend: 14px, below value
    - Mini chart: Removed (space constraint)

Alert Banner:
  - Full width
  - Collapsed by default
  - Tap to expand
  - Height: 48px collapsed, auto expanded

Main Widgets (Vertical Stack):
  - Full width cards
  - 16px margin horizontal
  - 12px margin vertical
  - Order (top to bottom):
    1. Sales Chart (simplified)
    2. Quick Actions (grid 2×4)
    3. Inventory Status (donut chart)
    4. Top Products (top 3 only)
    5. Activity Feed (last 5 items)

Bottom Navigation:
  - Height: 56px + safe area
  - Background: Surface
  - Fixed at bottom
  - 5 tabs:
    - Dashboard (home icon)
    - Sales (shopping cart)
    - Inventory (box)
    - Reports (chart)
    - More (dots)

Pull to Refresh:
  - Swipe down on dashboard
  - Loading indicator appears
  - Refreshes all widgets
  - Haptic feedback on refresh

Widget Customization (Mobile):
  - Long press widget → Options menu
  - Options:
    - Refresh widget
    - Configure
    - Remove
    - Move up
    - Move down
  - No drag-and-drop (simpler UX)
```

---

### State 8.1.3: Role-Specific Dashboard Variants

**Cashier/POS Operator Dashboard**:
```
Simplified focus: Sales operations

Widgets:
  1. Today's Sales (personal)
     - My sales: PKR XXX
     - My transactions: N
     - Average per sale: PKR XX
  
  2. Quick Start Sale
     - Large button: "Start New Sale"
     - Recent customers: Quick select
  
  3. My Shift Summary
     - Shift started: Time
     - Sales so far: Amount
     - Transactions: Count
     - Expected cash: Amount
  
  4. Current Counter Status
     - Counter name
     - Starting cash: Amount
     - Cash sales: Running total
     - Card sales: Running total
  
  5. Recent Transactions
     - Last 10 sales
     - Quick view/print receipt

No access to:
  - Financial summaries
  - Inventory deep dives
  - User management
  - Settings
```

**Warehouse Manager Dashboard**:
```
Focus: Inventory & receiving

Widgets:
  1. Stock Alerts (prominent)
     - Low stock: Count
     - Out of stock: Count
     - Expiring: Count
  
  2. Receiving Queue
     - Expected deliveries: Today/week
     - Pending GRNs: Count
     - Quick receive button
  
  3. Inventory Health
     - Total value: Amount
     - Turnover: Ratio
     - Aging items: Count
  
  4. Cycle Count Status
     - Scheduled: Upcoming
     - In progress: Live count
     - Completed: Recent
  
  5. Transfer Requests
     - Pending approvals: Count
     - In transit: Count
     - Quick approve/pack
  
  6. Top Movers
     - Fast moving: List
     - Slow moving: List
     - Dead stock: Count

Minimal:
  - Sales details (summary only)
  - Financial (no access)
```

**Procurement Manager Dashboard**:
```
Focus: Purchasing & suppliers

Widgets:
  1. Reorder Suggestions (AI)
     - Products to reorder: Count
     - Urgent: Count with red badge
     - Total value: Amount
  
  2. Purchase Orders
     - Pending: Count
     - Awaiting approval: Count
     - In transit: Count
     - Overdue: Count with alert
  
  3. Supplier Performance
     - Top suppliers: List
     - Issues: Count
     - On-time delivery: Percentage
  
  4. Pending Invoices
     - To be matched: Count
     - Discrepancies: Count
     - Due for payment: Amount
  
  5. Budget vs Spend
     - Budget: Amount
     - Spent: Amount + percentage
     - Remaining: Amount
     - Trend: Chart

  6. Stock Availability
     - Stock-out risk: Count
     - Min stock reached: Count
```

---

## 8.2 Sales Analytics & Reports

### State 8.2.1: Sales Dashboard - Comprehensive

**Access**: Reports → Sales Analytics

**Sales Analytics Page (Desktop)**:
```
Page Layout:
  
  Header:
    - Title: "Sales Analytics", 24px
    - Date range: Selector (Today → Custom)
    - Compare to: Toggle (vs previous period, vs last year)
    - Location filter: If multi-location
    - Export: Button (PDF/Excel)

  Filter Bar (Collapsible):
    - Product: Search/select
    - Category: Multi-select
    - Customer: Search/select
    - Customer tier: Multi-select
    - User/Cashier: Multi-select
    - Payment method: Checkboxes
    - Location: Multi-select
    - Apply Filters: Primary button

  Summary KPIs (Top Row):
    
    Card 1: Total Revenue
      - Amount: "PKR 1,245,670", 36px bold
      - Trend: "+15.3%" vs comparison, green arrow
      - Sub-metrics:
        - Cash: PKR XXX (%)
        - Card: PKR XXX (%)
        - Credit: PKR XXX (%)
      - Sparkline: 7-day trend
    
    Card 2: Transactions
      - Count: "3,456", 36px bold
      - Trend: "+8.2%"
      - Sub-metrics:
        - Average value: PKR XXX
        - Items per transaction: X.X
      - Bar chart: Daily distribution
    
    Card 3: Gross Profit
      - Amount: "PKR 448,250", 36px bold success
      - Margin: "36.0%"
      - Trend: "+12.1%"
      - Line chart: Margin trend
    
    Card 4: Customer Metrics
      - Active customers: "892", 36px bold
      - New customers: "+45"
      - Returning: "84.2%"
      - Donut: New vs returning

  Main Content (Tabbed Interface):
    
    Tab 1: Overview
      
      Section 1: Sales Trend Chart
        - Height: 400px
        - Chart type toggle: Line / Bar / Area / Combined
        - Metrics toggle: Revenue / Transactions / Items Sold
        - Granularity: Hour / Day / Week / Month
        
        Multi-line chart:
          - X-axis: Time periods
          - Y-axis: Amount (PKR) or Count
          - Lines:
            - Total sales: Primary color, solid
            - Target: Dashed line (if set)
            - Previous period: Gray, dotted (if comparison on)
          
          Interactive:
            - Hover: Tooltip with exact values
            - Click point: Drill down to transactions
            - Zoom: Click-drag region
            - Pan: Shift + drag
          
          Annotations:
            - Peak days: Flag icon
            - Promotions: Badge
            - Holidays: Different color
      
      Section 2: Sales by Hour (Heatmap)
        - Days of week (rows) × Hours of day (columns)
        - Color intensity: Sales volume
        - Hover: Exact amount
        - Purpose: Identify peak hours
        - Insights: "Busiest hour: 2-3 PM (PKR 45K avg)"
      
      Section 3: Payment Method Breakdown
        - Pie chart: Payment methods
        - Table:
          Method | Transactions | Amount | % of Total | Avg Value
          Cash | 1,234 | PKR 567K | 45% | PKR 459
          Card | 890 | PKR 445K | 36% | PKR 500
          Credit | 332 | PKR 233K | 19% | PKR 702
      
      Section 4: Top Performing Categories
        - Horizontal bar chart
        - Top 10 categories by revenue
        - Each bar: Shows amount + percentage
        - Clickable: Drills down to products

    Tab 2: Products
      
      Section 1: Product Performance Table
        - Sortable, filterable table
        - Virtual scrolling (handle 1000s of products)
        
        Columns:
          1. Product: Name + image thumbnail
          2. Category: Name
          3. Units Sold: Quantity
          4. Revenue: PKR amount
          5. COGS: Cost of goods sold
          6. Gross Profit: Revenue - COGS
          7. Margin %: Profit / Revenue
          8. Avg Price: Revenue / Units
          9. Discount Given: Amount + %
          10. Returns: Count + %
        
        Footer row:
          - Totals for numeric columns
        
        Actions:
          - Export: CSV/Excel
          - View details: Opens product detail page
      
      Section 2: Product Performance Matrix
        - Bubble chart: X=Sales volume, Y=Profit margin, Bubble size=Revenue
        - Quadrants:
          - High volume, high margin: Stars (green)
          - High volume, low margin: Cash cows (blue)
          - Low volume, high margin: Question marks (yellow)
          - Low volume, low margin: Dogs (red)
        - Purpose: Product portfolio analysis
      
      Section 3: ABC Analysis
        - Table: Products classified by value contribution
        - Class A: 70% of value (vital few)
        - Class B: 20% of value (important)
        - Class C: 10% of value (trivial many)
        - Chart: Pareto (cumulative %)

    Tab 3: Customers
      
      Section 1: Customer Segmentation
        - Pie chart: By customer tier
        - Walk-in: 45%
        - Bronze: 25%
        - Silver: 15%
        - Gold: 10%
        - Platinum: 5%
        
        Table per tier:
          Tier | Customers | Transactions | Revenue | Avg per Customer | Profit Margin
      
      Section 2: RFM Analysis
        - Recency, Frequency, Monetary segmentation
        - 3D visualization or table
        - Segments:
          - Champions: High RFM
          - Loyal customers: High F, M
          - At risk: Low R, high F, M
          - Lost: Low R, F, M
          - New customers: High R, low F, M
        
        Action recommendations per segment
      
      Section 3: Customer Lifetime Value
        - Top 20 customers by CLV
        - Table: Name, Total spent, Transactions, Avg order, Last purchase, CLV
        - Chart: CLV distribution
      
      Section 4: Customer Acquisition & Retention
        - New customers: Line chart over time
        - Retention rate: Percentage + trend
        - Churn rate: Percentage + at-risk count

    Tab 4: Trends & Insights
      
      Section 1: AI-Powered Insights (Text Cards)
        - Auto-generated insights from ML analysis
        
        Example insights:
          1. "Weekend sales are 35% higher than weekdays"
          2. "Pain relief category growing 18% month-over-month"
          3. "Platinum customers account for 28% of profit with only 5% of transactions"
          4. "Average transaction value increased 12% after introducing loyalty program"
          5. "Card payments peaked on Fridays, possibly due to payday"
        
        Each insight:
          - Icon: Light bulb
          - Title: Key finding
          - Details: Supporting data
          - Action: "View details" link
      
      Section 2: Seasonality Detection
        - Chart: Identified seasonal patterns
        - Monthly view: Heat map
        - Peak seasons: Highlighted
        - Forecast: Predicted next peak
      
      Section 3: Sales Velocity
        - Products gaining momentum: List
        - Products losing momentum: List
        - Chart: Velocity change over time
      
      Section 4: Comparison Analysis
        - Selected period vs Previous period
        - Side-by-side metrics
        - Change indicators: ↑↓ with %
        - Highlights: Winners and losers

    Tab 5: Reports Library
      
      Pre-built Report Cards:
        - Each card: Icon, title, description, "Generate" button
        
        Reports:
          1. Daily Sales Summary
             - Complete day's sales breakdown
             - By hour, product, payment method
          
          2. Monthly Sales Report
             - Month-end comprehensive report
             - With charts and tables
          
          3. Cashier Performance
             - Sales by cashier
             - Transactions, average value, discounts
          
          4. Sales vs Target
             - Compares actual to goals
             - By product, category, location
          
          5. Discount Analysis
             - All discounts given
             - By reason, user, impact
          
          6. Return Analysis
             - All returns
             - Reasons, products, value
          
          7. Peak Hour Analysis
             - Hourly sales distribution
             - Staffing recommendations
          
          8. Customer Purchase History
             - Individual customer report
             - All transactions, spending patterns
```

---

### State 8.2.2: Sales Report Generation

**Trigger**: User clicks "Generate" on any report

**Report Generation Flow**:
```
Modal: Configure Report
  Width: 600px
  
  Report preview: Shows report type
  
  Configuration options:
    
    Date Range*:
      - Presets: Today, Yesterday, Week, Month, Quarter, Year
      - Custom: Date pickers (from-to)
      - Required: Yes
    
    Filters:
      - Location: Multi-select (or All)
      - Product/Category: Search + select
      - Customer/Tier: Search + select
      - User/Cashier: Multi-select
      - Include inactive: Checkbox
    
    Level of Detail:
      - Summary: High-level aggregates only
      - Standard: Summary + key breakdowns
      - Detailed: Transaction-level data
      - Comprehensive: Everything + supporting docs
    
    Sections to Include (Checkboxes):
      - ☑ Summary KPIs
      - ☑ Charts and graphs
      - ☑ Data tables
      - ☐ Transaction details
      - ☐ Product images
      - ☐ Customer details
      - ☐ Notes and comments
    
    Output Format:
      - PDF: For printing/signing
      - Excel: For analysis (includes formulas)
      - CSV: Raw data export
      - Email: Send to addresses
    
    Options:
      - Include comparison: Checkbox (vs previous period)
      - Include goals: Checkbox (if set)
      - Include forecasts: Checkbox (AI predictions)
      - Color scheme: Dropdown (brand, monochrome, colorful)

  Footer:
    - Cancel: Link
    - Preview: Outlined button
      - Opens: Preview window
      - Shows: Report as it will be generated
    - Generate: Primary button
      - Processing: Progress bar
      - Time estimate: "~30 seconds"
      - Success: Download starts
      - Or: Email sent confirmation

Generated Report Structure (PDF):
  
  Page 1: Cover
    - Business logo
    - Report title: Large, bold
    - Period: Date range
    - Generated: Timestamp
    - Generated by: User name

  Page 2: Executive Summary
    - Key metrics: Large numbers
    - Highlights: Bullet points
    - Notable changes: vs previous period
    - Recommendations: AI-generated

  Page 3+: Detailed Sections
    - Each section: New page or continued
    - Charts: Full color, high resolution
    - Tables: Formatted with headers
    - Data: Aligned columns

  Last Page: Appendix
    - Methodology notes
    - Data sources
    - Filters applied
    - Glossary of terms

  Every Page Footer:
    - Business name
    - Page number: "Page X of Y"
    - Generated date
    - Confidential watermark (if set)

Report Actions (After Generation):
  - Download: Save to device
  - Email: Send to recipients
  - Print: Open print dialog
  - Schedule: Save configuration for recurring
  - Share: Generate secure link (24hr expiry)
  - Archive: Save to report library
```

---

## 8.3 Inventory Intelligence Reports

### State 8.3.1: Inventory Dashboard & Analytics

**Access**: Reports → Inventory Analytics

**Inventory Analytics Page**:
```
Page Structure:
  
  Header:
    - Title: "Inventory Intelligence"
    - As of: Date/time (live)
    - Location filter: Multi-select
    - Refresh: Button (updates live)

  Summary KPIs:
    
    Card 1: Total Inventory Value
      - Amount: "PKR 2,450,000", 36px bold
      - Change: "+5.2% from last month"
      - Breakdown:
        - By location: Pie chart
        - By category: Bar chart mini
    
    Card 2: Inventory Turnover
      - Ratio: "4.2x annually", 36px bold
      - Benchmark: "Industry avg: 3.8x"
      - Trend: Line chart (last 12 months)
      - Status: Green (healthy)
    
    Card 3: Days Inventory Outstanding
      - Days: "87", 36px bold
      - Target: "60 days"
      - Status: Yellow (above target)
      - Insight: "Reduce slow-movers"
    
    Card 4: Stock Health Score
      - Score: "78/100", 36px bold
      - Factors:
        - Turnover: 85/100
        - Aging: 70/100
        - Availability: 92/100
        - Accuracy: 85/100
      - Overall: Yellow (good, not excellent)

  Main Content (Tabs):
    
    Tab 1: Stock Levels
      
      Section 1: Stock Status Distribution
        - Stacked bar chart by location
        - Segments:
          - Healthy (green): >Min stock
          - Low (yellow): At min stock
          - Critical (red): Below min
          - Out of stock (dark red): Zero
        
        Table:
          Location | Total Products | Healthy | Low | Critical | Out of Stock | Value
      
      Section 2: ABC Classification
        - Pareto chart: Value contribution
        - Class A: 20% of items = 70% of value
        - Class B: 30% of items = 20% of value
        - Class C: 50% of items = 10% of value
        
        Action recommendations:
          - Class A: Tight control, frequent counts
          - Class B: Moderate control
          - Class C: Simple control, bulk orders
      
      Section 3: Products Requiring Attention
        - Cards:
          1. Out of Stock: Count with red badge
          2. Below Min: Count with yellow badge
          3. Expiring Soon: Count with orange badge
          4. Slow-Moving: Count with gray badge
          5. Dead Stock: Count with dark gray badge
        - Each clickable: Filters product list

    Tab 2: Turnover Analysis
      
      Section 1: Turnover by Category
        - Bar chart: Categories ranked by turnover
        - Each bar: Shows ratio + target line
        - Color: Green (above target), red (below)
        
        Table:
          Category | Turnover Ratio | Target | Status | Days to Sell | Avg Cost
      
      Section 2: Fast Movers
        - Top 20 products by turnover
        - Table:
          Product | Units Sold | Avg Stock | Turnover | Days Stock | Value
        - Chart: Visualizes velocity
      
      Section 3: Slow Movers
        - Bottom 20 products
        - Table: Same structure as fast movers
        - Actions:
          - Mark for discount
          - Request supplier return
          - Discontinue
      
      Section 4: Turnover Trend
        - Line chart: Monthly turnover ratio
        - Shows: Last 12 months
        - Annotations: Major events (inventory write-off, new products)

    Tab 3: Aging Analysis
      
      Section 1: Aging Distribution
        - Histogram: Products by age
        - Buckets:
          - 0-30 days: Fresh
          - 31-90 days: Current
          - 91-180 days: Aging
          - 181-365 days: Old
          - 365+ days: Very old / Dead
        
        Each bucket: Count + value + %
      
      Section 2: Value at Risk
        - Total value of aging inventory: Large, warning color
        - By age bucket: Breakdown
        - Trend: Is it increasing or decreasing?
        - Recommendations: Actions to take
      
      Section 3: Dead Stock Details
        - Definition: No sales in 365+ days
        - Total count: N products
        - Total value: PKR XXX,XXX (capital tied up)
        
        Table:
          Product | Last Sale | Age | Qty | Cost | Value | Action
        
        Actions:
          - Write off
          - Deep discount
          - Donate
          - Return to supplier
      
      Section 4: Aging by Category
        - Heat map: Categories × Age buckets
        - Identifies: Problem categories

    Tab 4: Valuation & COGS
      
      Section 1: Inventory Valuation Summary
        - Total value: By valuation method (FIFO/LIFO/WAC)
        - Opening: Value at start of period
        - Additions: Purchases, transfers in
        - Deductions: Sales COGS, write-offs
        - Closing: Current value
        - Variance: Physical vs book
      
      Section 2: COGS Analysis
        - Total COGS: Period total
        - COGS %: Percentage of sales
        - Gross margin: Sales - COGS
        - Margin %: Gross margin / Sales
        
        Trend: Line chart over time
      
      Section 3: Value by Location
        - Pie chart: Value distribution
        - Table:
          Location | Products | Value | % Total | Avg Cost | Space Utilization
      
      Section 4: Valuation Reconciliation
        - Book value: PKR XXX,XXX
        - Physical value: PKR XXX,XXX (from cycle counts)
        - Variance: ±PKR XXX
        - Variance %: ±X.X%
        - Reasons: Shrinkage, errors, theft, damage
        - Action items: Investigation, correction

    Tab 5: Forecasting & Recommendations
      
      Section 1: Demand Forecast
        - AI-generated forecasts
        - Products: Forecasted sales (next 30/60/90 days)
        - Confidence intervals: Low, expected, high
        - Chart: Historical + forecast line
        - Accuracy: Past forecast vs actual
      
      Section 2: Reorder Recommendations
        - AI-powered suggestions
        - Table:
          Product | Current Stock | Forecasted Demand | Reorder Point | Recommended Qty | Urgency
        
        Urgency levels:
          - Critical (red): Will stock out in <7 days
          - High (orange): <14 days
          - Medium (yellow): <30 days
          - Low (green): Sufficient stock
        
        Actions:
          - Convert to requisition: One-click
          - Adjust quantity: Edit
          - Dismiss: If incorrect
      
      Section 3: Optimization Insights
        - AI-generated cards
        
        Examples:
          1. "Reduce XYZ inventory by 30% - slow turnover costing PKR 45K/month in carrying cost"
          2. "Increase ABC stock by 20% - frequent stockouts losing PKR 12K/month in sales"
          3. "Consolidate DEF inventory to Main Warehouse - spread across 3 locations inefficiently"
      
      Section 4: Seasonal Patterns
        - Detected: Automatic pattern recognition
        - Chart: Monthly sales with seasonal overlay
        - Annotations: Peak seasons
        - Preparation: Recommendations for upcoming season
```

---

### State 8.3.2: Inventory Report Generator

**Pre-Built Inventory Reports**:
```
Report Library:
  
  1. Stock Status Report
     - Current stock levels all products
     - By location, category
     - Status: Healthy/Low/Critical/Out
     - Generated: On-demand or scheduled
  
  2. Stock Movement Report
     - All inventory transactions
     - Period: Date range
     - Details: Product, qty, type, user, location
     - Includes: Sales, purchases, adjustments, transfers
  
  3. Turnover Analysis Report
     - Turnover ratios by product/category
     - Fast movers and slow movers
     - Recommendations
     - Charts: Visual performance
  
  4. Aging Report
     - Products by age buckets
     - Value at risk
     - Dead stock list
     - Action recommendations
  
  5. Valuation Report
     - Complete inventory valuation
     - By location, category
     - Reconciliation vs physical
     - COGS analysis
  
  6. Reorder Report
     - Products below min stock
     - AI recommendations
     - Suggested order quantities
     - Supplier information
  
  7. Variance Report
     - Cycle count variances
     - Adjustments made
     - Reasons and patterns
     - Investigation needed
  
  8. Batch Tracking Report (Pharmacy)
     - All batches
     - Expiry dates
     - Stock levels
     - Transactions per batch
  
  9. Expiry Management Report
     - Products expiring soon
     - By date ranges
     - Value at risk
     - Actions taken (discounts, returns)
  
  10. Shrinkage Report
      - Lost inventory
      - Theft, damage, expiry
      - Value impact
      - Trends and patterns

Each report: Same generation flow as sales reports
```

---

## 8.4 Financial Reporting

### State 8.4.1: Financial Dashboard

**Access**: Reports → Financial

**Financial Dashboard**:
```
Page Layout:
  
  Header:
    - Title: "Financial Overview"
    - Period: Fiscal year, quarter, month selector
    - As of: Date display

  Summary KPIs:
    
    Card 1: Total Revenue
      - Amount: "PKR 5,450,000", 36px bold
      - Change: "+12.5% YoY"
      - Breakdown: Cash vs credit
    
    Card 2: Gross Profit
      - Amount: "PKR 1,962,000", 36px bold success
      - Margin: "36.0%"
      - Change: "+8.2%"
    
    Card 3: Operating Expenses
      - Amount: "PKR 845,000", 36px bold warning
      - % of Revenue: "15.5%"
      - Change: "+3.1%"
    
    Card 4: Net Profit
      - Amount: "PKR 1,117,000", 36px bold success
      - Margin: "20.5%"
      - Change: "+15.8%"

  Main Content (Tabs):
    
    Tab 1: Profit & Loss
      
      P&L Statement (Table):
        Line Item | Current Period | Previous Period | Change | % Change
        
        Revenue:
          Sales Revenue | PKR 5,450,000 | PKR 4,844,000 | +606K | +12.5%
          Returns/Discounts | (PKR 150,000) | (PKR 120,000) | +30K | +25%
          Net Revenue | PKR 5,300,000 | PKR 4,724,000 | +576K | +12.2%
        
        Cost of Goods Sold:
          Opening Inventory | PKR 2,200,000 | PKR 1,950,000
          Purchases | PKR 3,100,000 | PKR 2,850,000
          Closing Inventory | (PKR 2,450,000) | (PKR 2,200,000)
          COGS | PKR 2,850,000 | PKR 2,600,000 | +250K | +9.6%
        
        Gross Profit | PKR 2,450,000 | PKR 2,124,000 | +326K | +15.4%
        Gross Margin % | 46.2% | 45.0% | +1.2pp
        
        Operating Expenses:
          Salaries | PKR 450,000 | PKR 420,000
          Rent | PKR 150,000 | PKR 150,000
          Utilities | PKR 45,000 | PKR 42,000
          Marketing | PKR 80,000 | PKR 65,000
          Other | PKR 120,000 | PKR 105,000
          Total Expenses | PKR 845,000 | PKR 782,000 | +63K | +8.1%
        
        Operating Profit | PKR 1,605,000 | PKR 1,342,000 | +263K | +19.6%
        Operating Margin % | 30.3% | 28.4% | +1.9pp
        
        Other Income/Expense:
          Interest Expense | (PKR 25,000) | (PKR 30,000)
          Other Income | PKR 5,000 | PKR 3,000
        
        Net Profit Before Tax | PKR 1,585,000 | PKR 1,315,000 | +270K | +20.5%
        Tax | (PKR 468,000) | (PKR 395,000)
        
        Net Profit After Tax | PKR 1,117,000 | PKR 920,000 | +197K | +21.4%
        Net Margin % | 21.1% | 19.5% | +1.6pp
      
      Chart: Visual P&L
        - Waterfall chart showing flow
        - Start: Revenue
        - Subtract: COGS (red bar)
        - Result: Gross profit (green level)
        - Subtract: Expenses (red bars)
        - Result: Operating profit
        - End: Net profit (large green bar)
      
      Export: Excel with formulas

    Tab 2: Balance Sheet
      
      Balance Sheet Statement:
        As of: [Date]
        
        Assets:
          Current Assets:
            Cash | PKR 450,000
            Accounts Receivable | PKR 320,000
            Inventory | PKR 2,450,000
            Other Current | PKR 80,000
            Total Current | PKR 3,300,000
          
          Fixed Assets:
            Equipment | PKR 500,000
            Furniture | PKR 150,000
            Less: Depreciation | (PKR 120,000)
            Net Fixed Assets | PKR 530,000
          
          Total Assets | PKR 3,830,000
        
        Liabilities:
          Current Liabilities:
            Accounts Payable | PKR 280,000
            Short-term Loans | PKR 150,000
            Other Current | PKR 45,000
            Total Current | PKR 475,000
          
          Long-term Liabilities:
            Long-term Loans | PKR 300,000
            Total Long-term | PKR 300,000
          
          Total Liabilities | PKR 775,000
        
        Equity:
          Owner's Capital | PKR 2,000,000
          Retained Earnings | PKR 1,055,000
          Total Equity | PKR 3,055,000
        
        Total Liabilities + Equity | PKR 3,830,000
        
        Validation: Assets = Liabilities + Equity ✓
      
      Financial Ratios:
        - Current Ratio: 6.95:1 (Current Assets / Current Liabilities)
        - Quick Ratio: 1.79:1 ((Current Assets - Inventory) / Current Liabilities)
        - Debt-to-Equity: 0.25:1 (Total Liabilities / Total Equity)
        - ROE: 36.6% (Net Profit / Total Equity)
        - ROA: 29.2% (Net Profit / Total Assets)
      
      Chart: Asset composition pie
      Chart: Liabilities + Equity composition

    Tab 3: Cash Flow
      
      Cash Flow Statement:
        Period: [Date Range]
        
        Operating Activities:
          Net Profit | PKR 1,117,000
          Adjustments:
            Depreciation | +PKR 25,000
            Increase in AR | (PKR 45,000)
            Increase in Inventory | (PKR 250,000)
            Increase in AP | +PKR 35,000
          Net Cash from Operations | PKR 882,000
        
        Investing Activities:
          Purchase of Equipment | (PKR 120,000)
          Net Cash from Investing | (PKR 120,000)
        
        Financing Activities:
          Loan Repayment | (PKR 50,000)
          Owner's Drawings | (PKR 200,000)
          Net Cash from Financing | (PKR 250,000)
        
        Net Increase in Cash | PKR 512,000
        Opening Cash Balance | PKR 338,000
        Closing Cash Balance | PKR 850,000 (but only 450K in account - reconcile!)
      
      Chart: Waterfall showing cash flow
      
      Forecast: Next 30/60/90 days
        - Projected inflows (sales, AR collection)
        - Projected outflows (purchases, expenses)
        - Projected closing balance
        - Warning: If negative projected

    Tab 4: AR/AP Aging
      
      Accounts Receivable Aging:
        Total Outstanding: PKR 320,000
        
        Table:
          Customer | Total | Current | 1-30 | 31-60 | 61-90 | 90+ | Status
          
          Aging Summary:
            Current (0-30) | PKR 180,000 | 56% | Green
            31-60 days | PKR 75,000 | 23% | Yellow
            61-90 days | PKR 40,000 | 13% | Orange
            90+ days | PKR 25,000 | 8% | Red
        
        Chart: Stacked bar or pie showing aging
        
        Actions:
          - Send payment reminders: Bulk button
          - Generate statements: Per customer
          - Flag for collection: High-risk accounts
      
      Accounts Payable Aging:
        Total Due: PKR 280,000
        
        Similar structure to AR
        
        Aging Summary:
          Current | PKR 200,000 | 71%
          1-30 overdue | PKR 50,000 | 18%
          31-60 overdue | PKR 20,000 | 7%
          60+ overdue | PKR 10,000 | 4%
        
        Actions:
          - Schedule payments
          - Request payment extension
          - Prioritize critical suppliers

    Tab 5: Budget vs Actual
      
      If budgets set:
        
        Table:
          Line Item | Budget | Actual | Variance | Variance %
          
          Revenue | PKR 5,000,000 | PKR 5,300,000 | +300K | +6%
          COGS | PKR 2,900,000 | PKR 2,850,000 | -50K | -1.7%
          Gross Profit | PKR 2,100,000 | PKR 2,450,000 | +350K | +16.7%
          Expenses | PKR 800,000 | PKR 845,000 | +45K | +5.6%
          Net Profit | PKR 1,300,000 | PKR 1,605,000 | +305K | +23.5%
        
        Chart: Budget vs actual bars side-by-side
        
        Variance analysis:
          - Favorable: Green
          - Unfavorable: Red
          - Commentary: Auto-generated insights
        
        YTD tracking: Progress towards annual budget

    Tab 6: Tax Reports
      
      Tax Summary:
        Period: Tax period (monthly/quarterly)
        
        GST/Sales Tax:
          Output Tax (on sales) | PKR 689,000
          Input Tax (on purchases) | PKR 403,000
          Net Tax Payable | PKR 286,000
        
        Withholding Tax:
          Tax Withheld | PKR 25,000
          Tax Paid | PKR 25,000
        
        Table: Transaction-level tax details
          Date | Transaction | Type | Taxable Amount | Tax Rate | Tax Amount
        
        Export: Formatted for tax filing
        
        Compliance:
          - Filing deadline: Display
          - Status: Filed / Pending
          - Payment status: Paid / Unpaid
```

---

[Document continues with Custom Report Builder, Data Visualization, Scheduled Reports sections...]

Let me continue creating the remaining sections for Part 6...

---

## 8.5 Supplier & Customer Analytics

### State 8.5.1: Supplier Performance Dashboard

**Access**: Reports → Supplier Analytics

**Supplier Analytics Page**:
```
Page Layout:
  
  Header:
    - Title: "Supplier Performance"
    - Period: Date range selector
    - Export: Button

  Summary KPIs:
    
    Card 1: Total Suppliers
      - Count: "45", 36px bold
      - Active: 42
      - Inactive: 3
      - New this period: +2
    
    Card 2: Total Purchases
      - Amount: "PKR 3,100,000", 36px bold
      - Change: "+8.5%"
      - Average: PKR XXX per supplier
    
    Card 3: On-Time Delivery
      - Percentage: "87.5%", 36px bold
      - Target: 90%
      - Status: Yellow (below target)
    
    Card 4: Quality Score
      - Score: "92/100", 36px bold
      - Factors:
        - Defect rate: 1.2%
        - Return rate: 0.8%
      - Status: Green (excellent)

  Main Content (Tabs):
    
    Tab 1: Supplier Scorecard
      
      Table: All suppliers ranked
        Columns:
          1. Rank: #1-N
          2. Supplier: Name + logo
          3. Overall Score: /100
          4. Quality: /100
            - Sub: Defect %, Return %
          5. Delivery: /100
            - Sub: On-time %, Lead time
          6. Pricing: /100
            - Sub: Competitiveness, Stability
          7. Total Purchases: PKR amount
          8. Orders: Count
          9. Grade: S/A/B/C/D
          10. Trend: ↑↓→
        
        Sorting: By any column
        Filtering:
          - Grade: Multi-select
          - Category: Product category
          - Min purchases: Amount threshold
        
        Color coding:
          - Grade S: Dark green
          - Grade A: Green
          - Grade B: Yellow
          - Grade C: Orange
          - Grade D: Red
        
        Actions per row:
          - View details: Opens supplier detail page
          - Contact: Email/phone quick action
          - Create PO: Quick purchase order
      
      Chart: Supplier distribution by grade (pie)

    Tab 2: Quality Analysis
      
      Section 1: Defect Rates
        - Table:
          Supplier | Orders | Items Received | Defects | Defect Rate | Trend
        
        - Chart: Bar chart of defect rates
        - Benchmark: Industry average line
      
      Section 2: Return Analysis
        - Table:
          Supplier | Purchases | Returns | Return Rate | Value | Reasons
        
        - Pareto: Top 10 suppliers by return value
        - Reasons breakdown: Pie chart
      
      Section 3: Quality Incidents
        - Timeline: Major quality issues
        - Each incident:
          - Date
          - Supplier
          - Product affected
          - Issue description
          - Resolution
          - Impact (PKR)

    Tab 3: Delivery Performance
      
      Section 1: On-Time Delivery
        - Table:
          Supplier | Total Deliveries | On Time | Late | Avg Delay | On-Time %
        
        - Chart: On-time % by supplier (horizontal bar)
        - Target line: 90%
      
      Section 2: Lead Time Analysis
        - Table:
          Supplier | Avg Lead Time | Min | Max | Std Dev | Reliability
        
        - Chart: Lead time distribution (box plot)
        - Consistency score: Low std dev = high score
      
      Section 3: Partial Deliveries
        - Table:
          Supplier | Orders | Partial Deliveries | Partial %
        
        - Impact: Additional handling cost
        - Recommendations: Prefer suppliers with low partial rate

    Tab 4: Pricing Analysis
      
      Section 1: Price Comparison
        - For each product sourced from multiple suppliers:
          Product | Supplier A Price | Supplier B Price | Best Price | Your Current
        
        - Savings potential: If switched to best price
        - Chart: Price competitiveness score by supplier
      
      Section 2: Price Trends
        - Line chart: Price changes over time
        - By supplier or by product
        - Annotations: Major price changes
        - Inflation adjustment: Optional
      
      Section 3: Discount Analysis
        - Table:
          Supplier | Standard Price | Discounts Given | Avg Discount % | Conditions
        
        - Recommendations: Negotiate better terms

    Tab 5: Relationship Management
      
      Section 1: Purchase Volume
        - Table:
          Supplier | Total Spend | % of Total | Orders | Avg Order Value | Payment Terms
        
        - Chart: Spend concentration (Pareto)
        - Risk: Over-reliance on single supplier
      
      Section 2: Payment Performance
        - Table:
          Supplier | Total Invoices | Paid On Time | Late | Avg Days to Pay
        
        - Our performance as customer
        - Relationship health indicator
      
      Section 3: Communication Log
        - Timeline: All interactions
        - Each entry:
          - Date, Type (email, call, meeting)
          - Subject, Participants
          - Notes, Outcomes
        
        - Quick actions: Log new interaction
```

---

### State 8.5.2: Customer Analytics Dashboard

**Access**: Reports → Customer Analytics

**Customer Analytics Page**:
```
Structure similar to supplier analytics but focused on customers

Summary KPIs:
  1. Total Customers: Count + growth
  2. Active Customers: Last 30/90 days
  3. Customer Lifetime Value: Average
  4. Retention Rate: Percentage

Tabs:
  
  Tab 1: Customer Segmentation
    - RFM Analysis (Recency, Frequency, Monetary)
    - Tier distribution (Walk-in, Bronze, Silver, Gold, Platinum)
    - Behavior segments: Champions, Loyal, At-risk, Lost
    - Value per segment
  
  Tab 2: Purchase Patterns
    - Average order value by segment
    - Purchase frequency
    - Preferred products by segment
    - Shopping hours/days patterns
  
  Tab 3: Retention & Churn
    - Retention rate trend
    - Churn rate
    - At-risk customers: List
    - Win-back campaigns success
  
  Tab 4: Profitability
    - Customer lifetime value (CLV)
    - Customer acquisition cost (CAC)
    - CLV:CAC ratio
    - Most profitable customers: Top 20
    - Margin by customer tier
  
  Tab 5: Credit Management
    - Credit customers: Count
    - Total outstanding: Amount
    - Aging analysis
    - Payment behavior scores
    - Risky accounts: Flagged

Each section: Similar detail level as supplier analytics
```

---

## 8.6 Custom Report Builder

### State 8.6.1: Report Builder Interface

**Access**: Reports → Custom Reports → Build New

**Report Builder Page (Desktop)**:
```
Page Layout:
  
  Left Sidebar (280px): Component Library
    
    Sections (Collapsible accordions):
      
      1. Data Sources
         - Sales Transactions
         - Inventory Items
         - Customers
         - Suppliers
         - Products
         - Batches (if pharmacy)
         - Users/Staff
         - Locations
         - Financial Accounts
      
      2. Fields
         - Shows fields based on selected data source
         - Drag to add to report
         - Examples for Sales:
           - Transaction ID
           - Date
           - Customer
           - Product
           - Quantity
           - Amount
           - Payment Method
           - Location
           - User
      
      3. Aggregations
         - Sum
         - Average
         - Count
         - Min/Max
         - Distinct Count
         - Percentage
      
      4. Visualizations
         - Table
         - Bar Chart
         - Line Chart
         - Pie Chart
         - Donut Chart
         - Area Chart
         - Scatter Plot
         - Heatmap
         - Gauge
         - KPI Card
      
      5. Filters
         - Date Range
         - Category
         - Location
         - User
         - Status
         - Custom Conditions

  Main Canvas (Center): Report Design Area
    
    Header:
      - Report title: Editable inline
      - Description: Editable
      - Author: Auto (current user)
    
    Canvas:
      - Drag-and-drop area
      - Grid layout: Helps alignment
      - Snap to grid: Optional
      
      Components added:
        - Each component: Resizable, movable
        - Handles: Corner and edge
        - Delete: X icon on hover
        - Configure: Gear icon
        - Duplicate: Copy icon
      
      Empty state:
        - Illustration: Empty canvas
        - Text: "Drag components here to build your report"
        - Quick start: "Or use a template"

  Right Panel (320px): Component Configuration
    
    Appears when: Component selected
    
    Configuration options (vary by component):
      
      For Table:
        - Columns: Multi-select fields
        - Order: Drag to reorder columns
        - Grouping: Group by field
        - Aggregation: Per column
        - Sorting: Field + direction
        - Filtering: Add conditions
        - Formatting:
          - Number format (currency, decimal places)
          - Date format
          - Text alignment
        - Pagination: Rows per page
        - Export: Enable/disable
      
      For Charts:
        - Chart type: Dropdown
        - X-axis: Field selection
        - Y-axis: Metric + aggregation
        - Series: Optional grouping
        - Colors: Color picker per series
        - Legend: Position (top, bottom, left, right, none)
        - Axes:
          - Show/hide
          - Label
          - Scale (linear, log)
        - Tooltip: Customize format
        - Annotations: Add reference lines
      
      For KPI Card:
        - Metric: Field + aggregation
        - Label: Text
        - Comparison: vs previous period
        - Trend: Show up/down arrow
        - Color: Success/warning/error
        - Icon: Selection
      
      For Filters:
        - Filter type: Dropdown, date range, checkbox, etc.
        - Field: Which field to filter
        - Default value: Set default
        - Required: Make mandatory
        - Multiple: Allow multi-select
        - Position: Where to show (top, sidebar)

  Top Toolbar:
    - Save: Button (saves report definition)
    - Preview: Button (opens preview with live data)
    - Run Report: Primary button (generates with current filters)
    - Undo/Redo: Icons
    - Templates: Dropdown (load template)
    - Share: Button (share with users)

  Building Flow:
    
    Step 1: Select Data Source
      - Click on data source in sidebar
      - Sets main table for report
      - Loads available fields
    
    Step 2: Add Fields
      - Drag fields to canvas
      - Or: Drag visualization then select fields
      - Multiple fields: Creates table automatically
      - Single field: Prompts for visualization type
    
    Step 3: Add Visualizations
      - Drag chart type to canvas
      - Configure axes and metrics
      - Preview updates live
    
    Step 4: Configure Filters
      - Drag filter components
      - Link to data fields
      - Set initial values
    
    Step 5: Arrange Layout
      - Drag components to position
      - Resize as needed
      - Group related components
    
    Step 6: Style & Format
      - Colors, fonts, spacing
      - Headers, footers
      - Page breaks (for PDF)
    
    Step 7: Preview & Test
      - Click Preview
      - Verify data accuracy
      - Test filters
      - Check layout on different screens
    
    Step 8: Save & Run
      - Save report definition
      - Run to generate output
      - Schedule if recurring

Template Library:
  - Pre-built templates for common reports
  - Examples:
    1. Daily Sales Summary
    2. Product Performance
    3. Customer Analysis
    4. Inventory Status
    5. Financial Statement
  
  - Click template: Loads into builder
  - Customize as needed
  - Save as new report

Advanced Features:
  
  1. Calculated Fields
     - Create custom formulas
     - Example: Profit = Revenue - COGS
     - Use in reports like regular fields
  
  2. Joins/Relationships
     - Join multiple data sources
     - Example: Sales × Products × Customers
     - Visual relationship diagram
  
  3. Parameters
     - User inputs when running report
     - Example: "Enter target revenue"
     - Used in calculations or filters
  
  4. Conditional Formatting
     - Rules: If value meets condition, apply style
     - Example: Negative profit → red text
     - Multiple rules per field
  
  5. Drill-Down
     - Click chart segment → detailed table
     - Or: Click row → related records
     - Breadcrumb: Navigate back
  
  6. Export Options
     - PDF: For printing/signing
     - Excel: With formulas
     - CSV: Raw data
     - Image: PNG/JPG of visualizations
```

**Light Theme Styling**:
```
Sidebar:
  - Background: #F8F9FA
  - Border: 1px solid #E8EAED
  - Component cards: White with hover shadow

Canvas:
  - Background: White with subtle grid (#F0F0F0)
  - Components: White cards with shadows
  - Selected: Blue outline (2px)

Right Panel:
  - Background: White
  - Border: 1px solid #E8EAED
  - Input fields: Standard form styling
```

**Dark Theme Styling**:
```
Sidebar:
  - Background: #1E1E1E
  - Border: 1px solid #404040
  - Component cards: #2A2A2A

Canvas:
  - Background: #2A2A2A with grid (#333333)
  - Components: #1E1E1E cards
  - Selected: #C5E64D outline

Right Panel:
  - Background: #2A2A2A
  - Inputs: #1E1E1E
```

---

### State 8.6.2: Report Preview & Execution

**Trigger**: User clicks "Preview" or "Run Report"

**Preview Modal**:
```
Modal:
  - Full screen or 90% screen
  - Close: X button or Esc key
  
  Header:
    - Report title: Display
    - Date range: Shows applied filters
    - Refresh: Button (re-runs with latest data)
    - Export: Dropdown (PDF, Excel, CSV)
  
  Content:
    - Renders report exactly as designed
    - Live data: Fetches from database
    - Interactive:
      - Charts: Hover tooltips
      - Tables: Sortable columns
      - Filters: Apply on-the-fly
    
    - Loading states:
      - Initial: Skeleton screens
      - Large datasets: Progress bar
      - Error: Error message with retry
  
  Footer:
    - Record count: "Showing X records"
    - Generated: Timestamp
    - Close: Button
    - Edit Report: Button (returns to builder)
    - Run & Save: Button (generates final output)

Run Report (Final Execution):
  - Processing:
    - Shows: Progress modal
    - Steps:
      1. Executing queries...
      2. Fetching data...
      3. Generating visualizations...
      4. Formatting output...
      5. Preparing download...
    
    - Time estimate: Based on data volume
  
  - Output:
    - Format: As selected (PDF/Excel/CSV)
    - Download: Starts automatically
    - Or: Email if specified
    - Archive: Saved to report library
  
  - Success:
    - Modal: "Report generated successfully"
    - Actions:
      - Download: Link
      - View: Opens in new tab
      - Email: Send to recipients
      - Schedule: Set up recurring
      - Close: Returns to dashboard
```

---

## 8.7 Data Visualization Library

### State 8.7.1: Chart Configuration Options

**Available Chart Types & Configurations**:

**1. Bar Chart**:
```
Configuration:
  - Orientation: Vertical / Horizontal
  - Bars: Single / Grouped / Stacked
  - X-axis: Category field
  - Y-axis: Numeric metric
  - Series: Optional grouping
  - Colors: Per series or gradient
  - Data labels: Show/hide values on bars
  - Grid lines: Major/minor
  - Animation: On load, on hover
  
Use cases:
  - Sales by category
  - Comparing locations
  - Product performance
```

**2. Line Chart**:
```
Configuration:
  - Lines: Single / Multiple series
  - X-axis: Usually time/date
  - Y-axis: Metric
  - Line style: Solid, dashed, dotted
  - Markers: Points on data
  - Area fill: Optional beneath line
  - Smooth: Curved vs straight
  - Annotations: Mark events
  
Use cases:
  - Sales trends over time
  - Inventory levels
  - KPI tracking
```

**3. Pie/Donut Chart**:
```
Configuration:
  - Type: Pie / Donut
  - Slices: Auto from data
  - Labels: Inside / Outside / None
  - Percentages: Show/hide
  - Legend: Position
  - Colors: Custom per slice
  - Explosion: Pull out slice
  - Hole size: For donut
  
Use cases:
  - Market share
  - Category distribution
  - Payment method breakdown
```

**4. Area Chart**:
```
Configuration:
  - Fill: Solid / Gradient / Pattern
  - Stacking: None / Normal / Percentage
  - Multiple series: Overlapping or stacked
  - Similar to line chart otherwise
  
Use cases:
  - Cumulative sales
  - Stock levels over time
  - Cash flow
```

**5. Scatter Plot**:
```
Configuration:
  - X-axis: Numeric field
  - Y-axis: Numeric field
  - Bubble size: Optional third metric
  - Color: Optional category
  - Trend line: Linear regression
  - Quadrants: Reference lines
  
Use cases:
  - Price vs volume analysis
  - Product performance matrix
  - Customer segmentation (RFM)
```

**6. Heatmap**:
```
Configuration:
  - Rows: Category/dimension
  - Columns: Category/dimension
  - Values: Metric
  - Color scale: Low to high
  - Annotations: Show values in cells
  
Use cases:
  - Sales by day and hour
  - Aging analysis
  - Cross-category performance
```

**7. Gauge**:
```
Configuration:
  - Min: Starting value
  - Max: Ending value
  - Value: Current metric
  - Ranges: Color zones (red, yellow, green)
  - Needle: Style
  - Labels: Show ranges
  
Use cases:
  - Target progress
  - Performance score
  - Capacity utilization
```

**8. KPI Card**:
```
Configuration:
  - Metric: Large number
  - Label: Description
  - Icon: Visual indicator
  - Trend: Arrow + percentage
  - Comparison: vs target or previous
  - Color: Status-based
  - Sparkline: Mini chart
  
Use cases:
  - Dashboard KPIs
  - Quick metrics
  - At-a-glance status
```

**Chart Interactivity**:
```
Hover:
  - Tooltips: Show exact values
  - Highlight: Emphasize hovered element
  - Cross-highlight: Related elements in other charts

Click:
  - Drill-down: Navigate to details
  - Filter: Apply filter to other components
  - Legend toggle: Show/hide series

Zoom:
  - Mouse wheel: Zoom in/out
  - Click-drag: Zoom to selection
  - Reset: Double-click

Pan:
  - Drag: Move viewable area (when zoomed)
  - Scroll: Horizontal scroll for wide charts
```

**Responsive Behavior**:
```
Desktop (1280px+):
  - Full chart with all features
  - Legend on right or bottom
  - Tooltips on hover

Tablet (768-1279px):
  - Simplified legend
  - Touch-friendly targets
  - Swipe for multiple series

Mobile (<768px):
  - Simplified charts
  - Fewer data points shown
  - Tap tooltips
  - Horizontal scroll if needed
  - Legend collapsed by default
```

---

## 8.8 Scheduled Reports & Automation

### State 8.8.1: Report Scheduling Interface

**Access**: Reports → Scheduled Reports → + Schedule New

**Schedule Report Configuration**:
```
Modal: Schedule Report
  Width: 700px
  
  Step 1: Select Report
    - Report library: List of all saved reports
    - Or: Report builder (create new)
    - Or: Template (use pre-built)
    
    Selected report preview:
      - Name
      - Description
      - Last run: Date/time
      - Average run time: Seconds
  
  Step 2: Schedule Configuration
    
    Frequency:
      Radio buttons:
        1. Daily
           - Time: Time picker (e.g., 8:00 AM)
           - Days: All days / Weekdays only / Weekends only
        
        2. Weekly
           - Day(s): Multi-select checkboxes (Mon-Sun)
           - Time: Time picker
        
        3. Monthly
           - Day of month: 1-31 or Last day
           - Or: First/Second/Third/Fourth/Last [Day] of month
           - Time: Time picker
        
        4. Quarterly
           - Month: Select which month in quarter
           - Day: Day of month
           - Time: Time picker
        
        5. Annually
           - Month: Dropdown
           - Day: Day of month
           - Time: Time picker
    
    Timezone:
      - Dropdown: Select timezone
      - Default: Business timezone
    
    Date Range (for report):
      Radio buttons:
        1. Previous period
           - Yesterday (for daily)
           - Last week (for weekly)
           - Last month (for monthly)
           - Automatic: Adjusts to frequency
        
        2. Rolling window
           - Last 7 days
           - Last 30 days
           - Last 90 days
           - Last 12 months
        
        3. Fixed period
           - MTD (Month to date)
           - QTD (Quarter to date)
           - YTD (Year to date)
        
        4. Custom
           - Start: Relative (e.g., -30 days)
           - End: Relative (e.g., today)
  
  Step 3: Delivery Options
    
    Output Format:
      Checkboxes (can select multiple):
        - ☑ PDF
        - ☑ Excel
        - ☐ CSV
        - ☐ JSON
    
    Delivery Method:
      Checkboxes:
        - ☑ Email
          - Recipients: Email addresses (multi-input)
          - Subject: Customizable template
          - Body: Message template
          - Attachments: Reports as files
        
        - ☐ Save to Cloud Storage
          - Folder: Dropdown path
          - Filename: Template with variables
          - Retention: Days to keep
        
        - ☐ Push Notification
          - To: User roles
          - Message: Template
          - Include: Link to view report
        
        - ☐ Webhook
          - URL: HTTP endpoint
          - Method: POST/PUT
          - Headers: Custom headers
          - Payload: Report data as JSON
    
    Conditions (Optional):
      - Only send if: Dropdown condition
        - Data exists (no empty reports)
        - Metric exceeds threshold
        - Variance detected
        - Custom condition
      
      - Threshold: Value
      - Action if condition not met:
        - Skip sending
        - Send anyway with note
        - Send summary only
  
  Step 4: Review & Activate
    
    Summary Display:
      - Report: Name
      - Frequency: Human-readable (e.g., "Every Monday at 8:00 AM")
      - Next run: Calculated date/time
      - Recipients: Count + list
      - Formats: PDF, Excel
    
    Advanced Options (Expandable):
      - Retry on failure: Checkbox + max attempts
      - Alert on failure: Email address
      - Archive reports: Retention period
      - Priority: Normal / High
    
    Test Run:
      - Button: "Send Test Now"
      - Generates report immediately
      - Sends to current user only
      - Validates configuration

  Footer:
    - Cancel: Link
    - Save as Draft: Outlined (inactive until activated)
    - Activate Schedule: Primary
      - Creates scheduled job
      - Confirmation: "Schedule activated"
      - Shows: Next run time
```

---

### State 8.8.2: Scheduled Reports Management

**Access**: Reports → Scheduled Reports

**Scheduled Reports Dashboard**:
```
Page Layout:
  
  Header:
    - Title: "Scheduled Reports"
    - Active schedules: Badge count
    - + Schedule New: Primary button

  Filter/Sort Bar:
    - Status: All / Active / Paused / Failed
    - Frequency: All / Daily / Weekly / Monthly
    - Report type: Dropdown
    - Search: By name

  Schedule List:
    
    Each Schedule Card:
      - Height: 140px
      - Border: 1px solid outline
      - Border radius: 12px
      
      Content:
        - Report name: 18px bold
        - Report type: Badge (Sales, Inventory, Financial)
        - Frequency: Icon + text (e.g., "📅 Every Monday 8 AM")
        - Next run: "Next: Dec 11, 2024 8:00 AM"
        - Last run: "Last: Dec 4, 2024 8:02 AM"
        - Status: Badge
          - Active: Green "Running"
          - Paused: Yellow "Paused"
          - Failed: Red "Error"
        - Recipients: Avatar group (max 3 shown, +N more)
        - Formats: Icons (PDF, Excel, CSV)
      
      Actions (Right side):
        - Toggle: Switch (Active/Paused)
        - Run Now: Button (execute immediately)
        - Edit: Icon button
        - History: Icon button (view past runs)
        - Delete: Icon button (with confirmation)
      
      Status Indicators:
        - Active: Green left border (4px)
        - Paused: Gray left border
        - Failed: Red left border

  Run History Panel (Slide-in):
    - Triggered: Click "History" on any schedule
    - Width: 500px
    - Slides from right
    
    Header:
      - Schedule name
      - Close: X button
    
    Content:
      - Table: Past 30 runs
        Columns:
          - Run date/time
          - Status: Success / Failed / Partial
          - Duration: Seconds
          - Recipients: Count
          - Size: File size
          - Actions: View / Download / Resend
      
      - Chart: Success rate over time (sparkline)
      
      - Stats:
        - Total runs: Count
        - Success rate: Percentage
        - Average duration: Seconds
        - Average size: MB
      
      - Failed runs (if any):
        - Error details
        - Retry button
        - Troubleshooting: Link to help

  Bulk Actions:
    - Select multiple: Checkboxes
    - Toolbar: "X schedules selected"
    - Actions:
      - Pause all: Bulk pause
      - Resume all: Bulk resume
      - Delete all: With confirmation
      - Run now: Bulk execute

Report Archive:
  - Access: Tab or separate section
  - Shows: All generated reports
  - List view: 
    - Report name
    - Generated: Date/time
    - Format: PDF/Excel/CSV
    - Size: File size
    - Actions: Download, Email, Delete
  - Filters: By date, type, schedule
  - Retention: Auto-delete after X days
  - Storage: Cloud storage details
```

---

### State 8.8.3: Report Delivery & Notifications

**Email Delivery**:
```
Email Template:
  
  Subject: [Business Name] - [Report Name] - [Date]
  Example: "bizPharma - Daily Sales Report - Dec 6, 2024"
  
  Body:
    - Header: Business logo + name
    - Greeting: "Hello [Recipient Name],"
    
    - Introduction:
      "Your scheduled report '[Report Name]' has been generated."
      "Period: [Date Range]"
    
    - Quick Summary (if configured):
      - Key metrics: 3-5 KPIs
      - Visual: Small chart image (if available)
      - Insights: AI-generated highlights
    
    - Attachments:
      - Report files: PDF, Excel (as selected)
      - File sizes: Shown
    
    - Actions:
      - View Online: Link (opens in browser)
      - Manage Subscription: Link (update preferences)
      - Unsubscribe: Link (stop receiving)
    
    - Footer:
      - Generated: Timestamp
      - Questions: Support email
      - Powered by: bizPharma

  Attachments:
    - Reports: As selected formats
    - Size limit: 25 MB (if exceeded, link to download)
    - Compression: Auto-compress if near limit
```

**Push Notification**:
```
Notification (In-App):
  - Icon: Report icon
  - Title: "Report ready: [Report Name]"
  - Message: "Your scheduled report has been generated"
  - Timestamp: Relative (2 minutes ago)
  - Action: Tap to view
  - Badge: Red dot if unread

Mobile Push:
  - Similar to in-app
  - Opens: App to report page
  - Silent: If configured (no sound/vibration)
```

**Webhook Delivery**:
```
HTTP POST to configured URL:

Headers:
  Content-Type: application/json
  X-BizPharma-Signature: [HMAC signature]
  X-BizPharma-Schedule-ID: [Schedule ID]

Payload:
{
  "schedule_id": "SCH001",
  "report_name": "Daily Sales Report",
  "report_type": "sales",
  "generated_at": "2024-12-06T08:00:00Z",
  "period": {
    "start": "2024-12-05T00:00:00Z",
    "end": "2024-12-05T23:59:59Z"
  },
  "summary": {
    "total_sales": 125450.00,
    "transactions": 234,
    "customers": 87
  },
  "files": [
    {
      "format": "pdf",
      "url": "https://reports.bizpharma.com/files/abc123.pdf",
      "size": 245678,
      "expires_at": "2024-12-07T08:00:00Z"
    },
    {
      "format": "excel",
      "url": "https://reports.bizpharma.com/files/abc123.xlsx",
      "size": 189034,
      "expires_at": "2024-12-07T08:00:00Z"
    }
  ],
  "status": "success"
}

Response Expected:
  200 OK: Webhook received
  4xx/5xx: Will retry up to 3 times
```

---

## Summary - Part 6 Complete

**Part 6 Coverage**:
✅ 8.1 Role-Based Dashboards (3 states)
✅ 8.2 Sales Analytics (2 states)
✅ 8.3 Inventory Intelligence (2 states)
✅ 8.4 Financial Reporting (1 state)
✅ 8.5 Supplier & Customer Analytics (2 states)
✅ 8.6 Custom Report Builder (2 states)
✅ 8.7 Data Visualization Library (1 state)
✅ 8.8 Scheduled Reports (3 states)

**Total States in Part 6**: 16 comprehensive states

**Key Features Documented**:
- Fully customizable dashboards with drag-and-drop
- Role-specific dashboard variants (Admin, Cashier, Warehouse Manager, Procurement Manager)
- Comprehensive sales analytics with AI insights
- Advanced inventory intelligence and forecasting
- Complete financial reporting (P&L, Balance Sheet, Cash Flow)
- Supplier and customer performance scorecards
- Custom report builder with 8+ chart types
- Interactive visualizations with drill-down
- Scheduled report automation with multiple delivery methods
- Email, push, webhook, cloud storage integrations
- Report archive and version management

**Design Patterns Established**:
- Widget-based dashboard architecture
- Consistent KPI card layout
- Tabbed interface for complex reports
- Filter-once-apply-everywhere pattern
- Responsive chart rendering
- Export flexibility (PDF, Excel, CSV, JSON)
- Template-based report generation
- Scheduled execution with retry logic
- Comprehensive error handling and logging

---

**End of Part 6 Document**

**Series Progress**:
- Part 1: Landing & Authentication (23 states) ✅
- Part 2: Business Onboarding (36 states) ✅
- Part 3: POS & Inventory Setup (28 states) ✅
- Part 4: Live POS Operations (39 states) ✅
- Part 5: Inventory Operations (28 states) ✅
- Part 6: Reporting & Analytics (16 states) ✅
- **Total: 170 comprehensive states documented**

Next: Part 7 - Settings & Administration