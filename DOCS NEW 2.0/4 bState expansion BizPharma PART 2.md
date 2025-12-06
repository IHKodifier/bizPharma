# bizPharma - States Expansion Design Brief (Part 2)

## Document Information

**Version**: 1.0  
**Date**: December 2024  
**Document**: Part 2 of States Expansion Series  
**Scope**: Business Onboarding & Configuration  
**Coverage**: Post-Authentication → Business Setup Wizard → Location Hierarchy → Tax Configuration → Compliance Settings  
**Platforms**: Mobile, Tablet, Desktop, Web  
**Themes**: Light & Dark (explicitly documented for each state)  
**Granularity**: Detailed with micro-interactions, animations, and platform variations

---

## What This Document Covers

This is **Part 2** focusing on:

1. ✅ Business Onboarding Wizard (3-step process)
   - Step 1: Business Information Entry
   - Step 2: Currency & Tax Configuration
   - Step 3: Location Hierarchy Setup
2. ✅ Sample Data Options
3. ✅ Onboarding Completion & Dashboard Entry
4. ✅ Post-Setup Configuration (Edit Modes)

**Previous Document (Part 1)**: Landing Page, Authentication Flows  
**Next Document (Part 3)**: POS & Inventory Setup

---

## Design System References

Building upon:
- **Part 1**: Authentication & Landing Page States
- **Style Guide**: `/mnt/project/4_a_Style_Guide__bizPharma.md`
- **Feature Stories**: `/mnt/project/3__Feature_Stories_bizPharma.md`
- **Architecture**: `/mnt/project/2__High_Level_Architecture_bizPharma.md`

---

# 4. BUSINESS ONBOARDING & CONFIGURATION

## 4.1 Onboarding Wizard - Entry & Overview

### State 4.1.1: Onboarding Wizard Entry - Desktop

**Trigger**: User successfully completes trial signup or authenticated signup (email/phone verified)

**Transition from Authentication**:
```dart
// Crossfade transition from auth success to onboarding
Navigator.pushReplacement(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return FadeTransition(
        opacity: animation,
        child: OnboardingWizardScreen(),
      );
    },
    transitionDuration: Duration(milliseconds: 500),
  ),
);
```

**Visual Layout - Desktop (1280px+)**:
```
Screen Structure:
  - Full screen takeover (not modal)
  - Two-panel layout:
    - Left panel: Progress sidebar (320px width, fixed)
    - Right panel: Content area (flex 1, scrollable)
  - Background: Theme-specific surface color
  
Left Sidebar (Progress Panel):
  - Height: 100vh (full viewport height)
  - Sticky position
  - Padding: 40px
  - Background: Slightly darker/lighter than main surface (theme-dependent)
  - Border right: 1px solid outline color
  
Sidebar Content:
  1. Logo: Top (100px width)
  2. Progress Title: "Set up your business"
     - 24px Inter Semibold
     - Margin: 40px top from logo
  
  3. Step Indicators (vertical list):
     - 3 steps displayed vertically
     - Each step: 48px height
     - Spacing: 16px between steps
     
     Step Structure:
       - Number circle: 32px diameter, left
       - Step info: Right of circle
         - Title: 16px Inter Medium
         - Status: 14px Inter Regular, secondary color
     
     States per step:
       - Pending: Gray circle outline, gray text
       - Current: Primary color circle (filled), primary text, bold
       - Completed: Green circle with checkmark, green text
  
  4. Help Section (bottom):
     - Icon: Question mark circle, 20px
     - Text: "Need help? Contact support"
     - 14px Inter Regular, link styled
     - Position: Absolute bottom 40px

Right Content Area:
  - Padding: 64px 80px
  - Max-width: 800px
  - Background: Main surface color
  
Content Structure:
  1. Step Header:
     - Step label: "Step 1 of 3", 14px Inter Medium, secondary color
     - Step title: 32px Inter Semibold, primary text
     - Step description: 18px Inter Regular, secondary text
     - Margin bottom: 48px
  
  2. Form Content:
     - Dynamic based on current step
     - Form fields, inputs, selectors
     - Validation messages
  
  3. Navigation Buttons (bottom):
     - Layout: Flexbox, space-between
     - Left: "Back" button (outlined, or hidden on step 1)
     - Right: "Continue" button (filled, primary)
     - Both: 48px height, min 120px width
     - Spacing: 16px if both visible
```

**Light Theme Styling**:
```
Left Sidebar:
  - Background: #F8F9FA (off-white, slightly darker than main)
  - Border right: 1px solid #E8EAED
  
Logo:
  - Primary color: #0F4C4C (deep teal)

Progress Title:
  - Color: #0F4C4C

Step Indicators:
  Pending Step:
    - Circle: 2px border #D1D4D9, background transparent
    - Number: 14px Inter Medium, #9E9E9E (gray)
    - Title: 16px Inter Medium, #44474E
    - Status: 14px Inter Regular, #9E9E9E
  
  Current Step:
    - Circle: Filled #0F4C4C, no border
    - Number: 14px Inter Semibold, #FFFFFF (white)
    - Title: 16px Inter Semibold, #0F4C4C
    - Status: 14px Inter Medium, #0F4C4C
    - Left border: 4px solid #0F4C4C (emphasis)
  
  Completed Step:
    - Circle: Filled #28A745 (success green), no border
    - Icon: White checkmark (instead of number)
    - Title: 16px Inter Medium, #28A745
    - Status: 14px Inter Regular, #44474E

Help Section:
  - Icon: #0F4C4C
  - Text: 14px Inter Regular, #0F4C4C, underline on hover

Right Content Area:
  - Background: #FFFFFF
  
Step Header:
  - Label: #44474E
  - Title: #0F4C4C
  - Description: #44474E

Navigation Buttons:
  Back (Outlined):
    - Border: 1px solid #D1D4D9
    - Text: #0F4C4C, 14px Inter Medium
    - Background: Transparent
    - Height: 48px
  
  Continue (Filled):
    - Background: #0F4C4C
    - Text: #FFFFFF, 14px Inter Semibold
    - Height: 48px
    - Disabled state: Background #E8EAED, text #9E9E9E
```

**Dark Theme Styling**:
```
Left Sidebar:
  - Background: #1E1E1E (darker than main)
  - Border right: 1px solid #404040

Logo:
  - Primary color: #C5E64D (lime)

Progress Title:
  - Color: #C5E64D

Step Indicators:
  Pending Step:
    - Circle: 2px border #404040
    - Number: #666666
    - Title: #C7C7C7
    - Status: #666666
  
  Current Step:
    - Circle: Filled #C5E64D
    - Number: #2C3500 (dark on light bg)
    - Title: #C5E64D
    - Status: #C5E64D
    - Left border: 4px solid #C5E64D
  
  Completed Step:
    - Circle: Filled #4ADE80
    - Checkmark: #003912 (dark green)
    - Title: #4ADE80
    - Status: #C7C7C7

Help Section:
  - Icon: #C5E64D
  - Text: #C5E64D

Right Content Area:
  - Background: #2A2A2A

Step Header:
  - Label: #C7C7C7
  - Title: #C5E64D
  - Description: #C7C7C7

Navigation Buttons:
  Back:
    - Border: 1px solid #404040
    - Text: #C5E64D
  
  Continue:
    - Background: #C5E64D
    - Text: #2C3500
    - Disabled: Background #333333, text #666666
```

**Initial Animation on Load**:
```dart
class OnboardingWizardScreen extends StatefulWidget {
  @override
  _OnboardingWizardScreenState createState() => _OnboardingWizardScreenState();
}

class _OnboardingWizardScreenState extends State<OnboardingWizardScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  
  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    
    // Stagger animations
    _fadeController.forward();
    Future.delayed(Duration(milliseconds: 200), () {
      _slideController.forward();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left sidebar fade-in
          FadeTransition(
            opacity: _fadeController,
            child: AnimatedBuilder(
              animation: _slideController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(-50 * (1 - _slideController.value), 0),
                  child: child,
                );
              },
              child: _buildProgressSidebar(),
            ),
          ),
          
          // Right content slide-in from right
          Expanded(
            child: FadeTransition(
              opacity: _fadeController,
              child: AnimatedBuilder(
                animation: _slideController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(50 * (1 - _slideController.value), 0),
                    child: child,
                  );
                },
                child: _buildContentArea(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

### State 4.1.2: Onboarding Wizard Entry - Tablet

**Layout Adjustments (768px - 1279px)**:
```
Left Sidebar:
  - Width: 280px (reduced from 320px)
  - Padding: 32px (reduced from 40px)
  - Logo: 80px width (reduced from 100px)

Right Content Area:
  - Padding: 48px 64px (reduced from 64px 80px)
  - Max-width: 700px (reduced from 800px)

Step Header:
  - Step title: 28px (reduced from 32px)
  - Description: 16px (reduced from 18px)

Navigation Buttons:
  - Height: 48px (same)
  - Min width: 110px (slightly reduced)
```

**All other styling**: Same as desktop
**Animations**: Slightly faster (reduce durations by 100ms)

---

### State 4.1.3: Onboarding Wizard Entry - Mobile

**Layout Changes (<768px)**:
```
Structure: Single column, no sidebar

Header (replaces left sidebar):
  - Fixed at top
  - Height: 64px
  - Padding: 16px horizontal
  - Background: Surface color
  - Border bottom: 1px solid outline color
  - Z-index: 100
  
Header Content:
  - Logo: Left, 64px width
  - Progress indicator: Right side
    - Compact: "1 of 3", 14px Inter Medium
    - Circular progress: 32px diameter, shows % complete

Progress Dots (below header):
  - Horizontal row of 3 dots
  - Each: 8px diameter
  - Current: Primary color (filled)
  - Completed: Success color (filled)
  - Pending: Gray outline
  - Spacing: 12px between dots
  - Centered
  - Margin: 16px vertical

Content Area:
  - Padding: 24px horizontal, 32px vertical
  - Scrollable (full height minus header and nav)
  - No max-width constraint

Step Header:
  - Step label: 12px Inter Medium, secondary color
  - Title: 24px Inter Semibold (reduced from 32px)
  - Description: 15px Inter Regular (reduced from 18px)
  - Margin bottom: 32px (reduced from 48px)

Navigation Buttons:
  - Fixed at bottom (not in scroll area)
  - Background: Surface color
  - Border top: 1px solid outline color
  - Padding: 16px
  - Safe area padding bottom
  - Shadow: 0px -2px 8px rgba(0, 0, 0, 0.08) (upward)
  
Button Layout:
  - Stack vertically (not horizontal)
  - Continue: Full width, 52px height
  - Back: Full width, 48px height, 12px margin top
  - OR horizontal if space permits: 50/50 split with 12px gap
```

**Light Theme - Mobile**:
```
Header:
  - Background: #FFFFFF
  - Border bottom: 1px solid #E8EAED
  - Shadow: 0px 1px 2px rgba(0, 0, 0, 0.06)

Progress Indicator:
  - Current/Complete: #0F4C4C
  - Pending: #D1D4D9
  - Text: 14px Inter Medium, #44474E

Progress Dots:
  - Current: #0F4C4C (filled)
  - Complete: #28A745 (filled)
  - Pending: 2px border #D1D4D9, transparent fill

Navigation Bar (Bottom):
  - Background: #FFFFFF
  - Border top: 1px solid #E8EAED
  - Shadow: 0px -2px 8px rgba(0, 0, 0, 0.08)
```

**Dark Theme - Mobile**:
```
Header:
  - Background: #2A2A2A
  - Border bottom: 1px solid #404040

Progress Indicator:
  - Current/Complete: #C5E64D
  - Text: #C7C7C7

Progress Dots:
  - Current: #C5E64D
  - Complete: #4ADE80
  - Pending: 2px border #404040

Navigation Bar:
  - Background: #2A2A2A
  - Border top: 1px solid #404040
  - Shadow: 0px -2px 8px rgba(0, 0, 0, 0.3)
```

**Mobile Slide-Up Animation**:
```dart
// Mobile enters from bottom
PageRouteBuilder(
  pageBuilder: (context, animation, secondaryAnimation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(0, 0.1),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      )),
      child: FadeTransition(
        opacity: animation,
        child: OnboardingWizardMobile(),
      ),
    );
  },
  transitionDuration: Duration(milliseconds: 400),
)
```

---

## 4.2 Step 1: Business Information Entry

### State 4.2.1: Step 1 Default State - Desktop

**Step Header**:
```
Label: "Step 1 of 3"
Title: "Tell us about your business"
Description: "Enter your basic business information to get started"
```

**Form Fields (vertical stack, 24px spacing)**:

**1. Business Name Field**:
```
Label: "Business name" (required indicator: red asterisk)
  - 14px Inter Medium, #1C1C1C (light) / #E5E5E5 (dark)
  
Input:
  - Outlined style per style guide
  - Height: 48px
  - Placeholder: "e.g., Green Valley Pharmacy"
  - Max length: 100 characters
  - Character counter: "0/100" in gray, bottom-right

Validation:
  - Required field
  - Minimum 3 characters
  - Real-time validation (red border + error message below)
  - Success state: Green border + checkmark icon right

Light Theme:
  - Border: 1px solid #D1D4D9 (default)
  - Focus: 2px solid #0F4C4C
  - Error: 2px solid #DC3545
  - Success: 2px solid #28A745
  - Background: #FFFFFF

Dark Theme:
  - Border: 1px solid #404040 (default)
  - Focus: 2px solid #C5E64D
  - Error: 2px solid #FF5252
  - Success: 2px solid #4ADE80
  - Background: #333333
```

**2. Contact Number Field**:
```
Label: "Contact number" (required)
  - 14px Inter Medium

Input:
  - Two-part field (similar to phone signup)
  - Country code selector: 80px width (dropdown)
  - Phone number: Flex 1
  - Combined height: 48px
  - Placeholder: "3XX XXXXXXX" (format hint based on country)

Country Selector:
  - Shows: Flag + code (e.g., "🇵🇰 +92")
  - Searchable dropdown (same as auth flow)
  - Default: Pakistan (+92) based on business context

Validation:
  - Required field
  - Format validation based on country code
  - Real-time check on blur

Styling: Same as business name field
```

**3. Primary Address Field**:
```
Label: "Primary business address" (optional indicator in gray)
  - 14px Inter Medium

Input:
  - Multi-line text area
  - Height: 96px (2-line display, scrollable if needed)
  - Placeholder: "Street address, city, postal code"
  - Max length: 250 characters
  - Character counter: "0/250"

Validation:
  - Optional (no red border if empty)
  - If filled, minimum 10 characters

Styling:
  - Border: 1px solid outline color (default)
  - Focus: 2px solid primary color
  - Border radius: 8px
  - Padding: 12px
  - Font: 14px Inter Regular
  - Line height: 1.5
```

**4. Business Type Selection**:
```
Label: "What type of business do you operate?" (required)
  - 14px Inter Medium

Input Type: Radio button group with card-style options
  - Layout: Horizontal row (desktop), stack (mobile)
  - 3 options:
    1. Retail Pharmacy
    2. Wholesale Pharmacy
    3. Mixed Operations (Retail + Wholesale)

Each Option Card:
  - Width: Auto (equal distribution)
  - Height: 72px
  - Padding: 16px
  - Border: 2px solid outline color (default)
  - Border radius: 8px
  - Cursor: pointer
  
  Content:
    - Radio circle: 20px, top-left or left-center
    - Icon: 32px, representing business type
    - Title: 16px Inter Medium
    - Description: 13px Inter Regular, secondary color

Light Theme:
  Unselected:
    - Background: #FFFFFF
    - Border: 1px solid #D1D4D9
    - Radio: Empty circle, border #D1D4D9
  
  Hover:
    - Background: #F8F9FA
    - Border: 2px solid #0F4C4C
  
  Selected:
    - Background: #E0F2F2 (light teal tint, 10% opacity)
    - Border: 2px solid #0F4C4C
    - Radio: Filled circle, #0F4C4C
  
  Disabled:
    - Opacity: 0.5
    - Cursor: not-allowed

Dark Theme:
  Unselected:
    - Background: #2A2A2A
    - Border: 1px solid #404040
    - Radio: Empty circle, border #404040
  
  Hover:
    - Background: #333333
    - Border: 2px solid #C5E64D
  
  Selected:
    - Background: #2C3500 (dark olive tint)
    - Border: 2px solid #C5E64D
    - Radio: Filled circle, #C5E64D
```

**Form Layout Animation**:
```dart
// Fields fade in with stagger
class StaggeredFormFields extends StatefulWidget {
  @override
  _StaggeredFormFieldsState createState() => _StaggeredFormFieldsState();
}

class _StaggeredFormFieldsState extends State<StaggeredFormFields>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _fieldAnimations;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    
    // Create staggered animations for each field
    _fieldAnimations = List.generate(4, (index) {
      final start = index * 0.15; // 150ms delay between fields
      final end = start + 0.4; // 400ms duration per field
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end.clamp(0.0, 1.0), curve: Curves.easeOut),
        ),
      );
    });
    
    _controller.forward();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < formFields.length; i++)
          AnimatedBuilder(
            animation: _fieldAnimations[i],
            builder: (context, child) {
              return Opacity(
                opacity: _fieldAnimations[i].value,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - _fieldAnimations[i].value)),
                  child: child,
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: formFields[i],
            ),
          ),
      ],
    );
  }
}
```

**Navigation Button States**:
```
Back Button:
  - State: Hidden (this is step 1)

Continue Button:
  - Default state: Disabled (gray)
  - Enabled when: Business name AND contact number are valid
  - Text: "Continue"
  - On click: Validate all fields, show errors if invalid, proceed to Step 2 if valid
```

---

### State 4.2.2: Field Focus States - All Fields

**Business Name Field Focus**:
```
Visual Changes:
  - Border: 2px solid #0F4C4C (light) / #C5E64D (dark)
  - Border width transition: 1px → 2px (200ms ease-out)
  - Label: Color changes to primary color
  - Cursor: Text cursor visible, blinking

Animation:
```dart
AnimatedContainer(
  duration: Duration(milliseconds: 200),
  curve: Curves.easeOut,
  decoration: BoxDecoration(
    border: Border.all(
      color: isFocused ? focusColor : borderColor,
      width: isFocused ? 2.0 : 1.0,
    ),
    borderRadius: BorderRadius.circular(8),
  ),
  child: TextField(
    decoration: InputDecoration(
      border: InputBorder.none, // Custom border via container
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  ),
)
```

**Label Float Animation** (Material-style):
```dart
// Label moves up and shrinks when focused or has content
AnimatedPositioned(
  duration: Duration(milliseconds: 200),
  curve: Curves.easeOut,
  top: (isFocused || hasText) ? -8 : 14,
  left: 12,
  child: Container(
    color: surfaceColor, // Background matches field background
    padding: EdgeInsets.symmetric(horizontal: 4),
    child: AnimatedDefaultTextStyle(
      duration: Duration(milliseconds: 200),
      style: TextStyle(
        fontSize: (isFocused || hasText) ? 12 : 14,
        fontWeight: FontWeight.w500,
        color: isFocused ? focusColor : labelColor,
      ),
      child: Text(labelText),
    ),
  ),
)
```

---

### State 4.2.3: Field Validation - Error States

**Business Name - Validation Errors**:

**Error 1: Empty Field** (on blur or form submit):
```
Visual:
  - Border: 2px solid #DC3545 (light) / #FF5252 (dark)
  - Error icon: Small red alert circle (16px), right side of field
  - Error message: Appears below field
    - Icon: Red alert (16px) left
    - Text: "Business name is required"
    - Style: 12px Inter Regular, #DC3545 (light) / #FFCDD2 (dark)
    - Spacing: 6px top margin from field

Animation:
```dart
// Error message slides down
AnimatedSize(
  duration: Duration(milliseconds: 200),
  curve: Curves.easeOut,
  child: hasError
      ? Container(
          padding: EdgeInsets.only(top: 6),
          child: Row(
            children: [
              Icon(Icons.error, size: 16, color: errorColor),
              SizedBox(width: 6),
              Text(
                errorMessage,
                style: TextStyle(fontSize: 12, color: errorColor),
              ),
            ],
          ),
        )
      : SizedBox.shrink(),
)

// Field shake animation on error
TweenAnimationBuilder<double>(
  key: ValueKey(showError), // Triggers on error change
  duration: Duration(milliseconds: 400),
  tween: Tween(begin: 0.0, end: 1.0),
  curve: Curves.elasticOut,
  builder: (context, value, child) {
    final offset = sin(value * pi * 3) * (1 - value) * 5;
    return Transform.translate(
      offset: Offset(offset, 0),
      child: child,
    );
  },
  child: inputField,
)
```

**Error 2: Too Short** (minimum 3 characters):
```
Trigger: On blur with 1-2 characters entered
Error message: "Business name must be at least 3 characters"
Visual: Same as Error 1
```

**Error 3: Invalid Characters** (if applicable):
```
Trigger: Contains special characters like <, >, {, }
Error message: "Business name contains invalid characters"
Visual: Same as Error 1
```

**Contact Number - Validation Errors**:

**Error: Invalid Format**:
```
Trigger: On blur with incorrect phone format for selected country
Error message: "Please enter a valid phone number"
Example: For Pakistan (+92), expects 10 digits starting with 3

Visual:
  - Border: 2px solid error color
  - Error icon: Right side of phone input (not country selector)
  - Error message: Below field
```

---

### State 4.2.4: Field Validation - Success States

**Business Name - Valid Entry**:
```
Visual:
  - Border: 2px solid #28A745 (light) / #4ADE80 (dark)
  - Success icon: Green checkmark circle (16px), right side of field
  - No message below field (success is indicated by icon + border color)
  - Transition: Border color changes from default to success (300ms ease-out)

Animation:
```dart
// Checkmark scale-in animation
AnimatedScale(
  duration: Duration(milliseconds: 300),
  scale: isValid ? 1.0 : 0.0,
  curve: Curves.elasticOut,
  child: Icon(
    Icons.check_circle,
    size: 16,
    color: successColor,
  ),
)

// Border color transition
AnimatedContainer(
  duration: Duration(milliseconds: 300),
  curve: Curves.easeOut,
  decoration: BoxDecoration(
    border: Border.all(
      color: isValid 
          ? successColor 
          : isFocused 
              ? focusColor 
              : borderColor,
      width: (isValid || isFocused) ? 2.0 : 1.0,
    ),
    borderRadius: BorderRadius.circular(8),
  ),
)
```

**Contact Number - Valid Entry**:
```
Visual: Same as business name success
  - Green border
  - Green checkmark icon right side
```

**Primary Address - Valid Entry** (optional field):
```
Visual:
  - If filled with 10+ characters: Green border + checkmark
  - If empty: Remains default style (no error, since optional)
```

---

### State 4.2.5: Business Type Selection - Interaction

**Card Hover State** (Desktop):
```
Light Theme:
  - Background: #F8F9FA (light gray fill)
  - Border: 2px solid #0F4C4C (thicker, primary color)
  - Transform: translateY(-2px) (slight lift)
  - Shadow: 0px 2px 8px rgba(0, 0, 0, 0.08)
  - Cursor: pointer
  - Transition: 200ms ease-out

Dark Theme:
  - Background: #333333
  - Border: 2px solid #C5E64D
  - Shadow: 0px 2px 8px rgba(197, 230, 77, 0.15)
```

**Card Selection Animation**:
```dart
class BusinessTypeCard extends StatefulWidget {
  final BusinessType type;
  final bool isSelected;
  final Function(BusinessType) onSelect;
  
  @override
  _BusinessTypeCardState createState() => _BusinessTypeCardState();
}

class _BusinessTypeCardState extends State<BusinessTypeCard> {
  bool _isHovered = false;
  
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => widget.onSelect(widget.type),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _isHovered ? -2 : 0, 0),
          decoration: BoxDecoration(
            color: widget.isSelected 
                ? selectedBackgroundColor 
                : _isHovered 
                    ? hoverBackgroundColor 
                    : defaultBackgroundColor,
            border: Border.all(
              color: widget.isSelected || _isHovered 
                  ? primaryColor 
                  : borderColor,
              width: widget.isSelected || _isHovered ? 2.0 : 1.0,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: _isHovered ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                offset: Offset(0, 2),
                blurRadius: 8,
              ),
            ] : [],
          ),
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              // Radio button
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.isSelected ? primaryColor : borderColor,
                    width: 2,
                  ),
                  color: widget.isSelected ? primaryColor : Colors.transparent,
                ),
                child: widget.isSelected
                    ? Center(
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: onPrimaryColor, // White/dark based on theme
                          ),
                        ),
                      )
                    : null,
              ),
              SizedBox(width: 12),
              
              // Icon
              Icon(
                widget.type.icon,
                size: 32,
                color: widget.isSelected ? primaryColor : iconColor,
              ),
              SizedBox(width: 12),
              
              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.type.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: widget.isSelected ? primaryColor : titleColor,
                      ),
                    ),
                    Text(
                      widget.type.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: descriptionColor,
                      ),
                    ),
                  ],
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

**Mobile Selection** (no hover):
```
Tap Interaction:
  - Ripple effect: Material InkWell splash
  - Brief scale: 0.98 on tap down
  - Haptic feedback: Light impact
  - Selection: Radio button animates to filled
```

---

### State 4.2.6: Continue Button Enable/Disable

**Disabled State** (default on load):
```
Condition: Business name empty OR contact number invalid

Light Theme:
  - Background: #E8EAED (light gray)
  - Text: #9E9E9E (medium gray)
  - Cursor: not-allowed
  - Opacity: 0.6
  - No hover effect
  - Height: 48px

Dark Theme:
  - Background: #333333
  - Text: #666666
  - Opacity: 0.6
```

**Enabled State** (when form valid):
```
Condition: Business name valid (3+ chars) AND contact number valid AND business type selected

Light Theme:
  - Background: #0F4C4C (primary teal)
  - Text: #FFFFFF, 14px Inter Semibold
  - Cursor: pointer
  - Opacity: 1.0
  - Hover: Background #1A6363 (lighter), translateY(-2px)
  - Active/Press: Background #0A3838 (darker), scale(0.98)

Dark Theme:
  - Background: #C5E64D (lime)
  - Text: #2C3500
  - Hover: Background #D4ED6A
  - Active: Background #9FC230

Animation:
```dart
AnimatedContainer(
  duration: Duration(milliseconds: 200),
  curve: Curves.easeOut,
  decoration: BoxDecoration(
    color: isEnabled ? enabledColor : disabledColor,
    borderRadius: BorderRadius.circular(8),
  ),
  child: AnimatedOpacity(
    duration: Duration(milliseconds: 200),
    opacity: isEnabled ? 1.0 : 0.6,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? _handleContinue : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 48,
          padding: EdgeInsets.symmetric(horizontal: 32),
          alignment: Alignment.center,
          child: Text(
            'Continue',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    ),
  ),
)
```

---

### State 4.2.7: Continue Button Click - Transition to Step 2

**Trigger**: User clicks Continue button with all fields valid

**Sequence**:
1. Button enters loading state (200ms)
2. Form validation completes (300ms)
3. Data saves to backend/local (500ms)
4. Step 1 content slides out left (400ms)
5. Step 2 content slides in from right (400ms)
6. Progress sidebar updates (300ms)

**Loading State**:
```
Button:
  - Disabled (can't re-click)
  - Spinner: 20px circular progress, left of text
  - Text: "Saving..." or "Continue"
  - Background: Maintains color but slightly dimmed

Light Theme:
  - Background: #0F4C4C (maintains, but opacity 0.9)
  - Spinner: #FFFFFF
  - Text: #FFFFFF, 14px Inter Medium

Dark Theme:
  - Background: #C5E64D (opacity 0.9)
  - Spinner: #2C3500
  - Text: #2C3500
```

**Progress Sidebar Update**:
```
Step 1:
  - Circle: Changes from filled primary to filled success green
  - Number: Changes to checkmark icon
  - Title: Color changes to success green
  - Status: Changes to "Completed"
  - Animation: Checkmark draws from center (300ms)

Step 2:
  - Circle: Changes from gray outline to filled primary
  - Number: Becomes bold white on primary background
  - Title: Changes to primary color, bold
  - Status: Changes to "In progress"
  - Left border: 4px solid primary (emphasis indicator)
  - Animation: All changes with 300ms ease-out

Transition Animation:
```dart
// Step 1 to Step 2 transition
class StepTransition extends StatefulWidget {
  @override
  _StepTransitionState createState() => _StepTransitionState();
}

class _StepTransitionState extends State<StepTransition>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _progressController;
  
  int currentStep = 1;
  
  void _transitionToNextStep() async {
    setState(() => isLoading = true);
    
    // Save data
    await _saveStepData();
    
    // Animate out current content
    await _slideController.reverse();
    
    // Update step
    setState(() {
      currentStep = 2;
      isLoading = false;
    });
    
    // Animate in new content
    _slideController.forward(from: 0.0);
    
    // Update progress
    _progressController.forward();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _slideController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            -MediaQuery.of(context).size.width * (1 - _slideController.value),
            0,
          ),
          child: Opacity(
            opacity: _slideController.value,
            child: child,
          ),
        );
      },
      child: _buildStepContent(currentStep),
    );
  }
}

// Progress indicator checkmark animation
class CheckmarkAnimation extends StatelessWidget {
  final Animation<double> animation;
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return CustomPaint(
          painter: CheckmarkPainter(
            progress: animation.value,
            color: successColor,
            strokeWidth: 2.5,
          ),
          size: Size(16, 16),
        );
      },
    );
  }
}

class CheckmarkPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;
  
  CheckmarkPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    
    final path = Path();
    
    // Checkmark path (short line down-left, long line up-right)
    final p1 = Offset(size.width * 0.2, size.height * 0.5);
    final p2 = Offset(size.width * 0.4, size.height * 0.7);
    final p3 = Offset(size.width * 0.8, size.height * 0.3);
    
    if (progress <= 0.5) {
      // Draw first segment
      final currentProgress = progress * 2;
      path.moveTo(p1.dx, p1.dy);
      path.lineTo(
        p1.dx + (p2.dx - p1.dx) * currentProgress,
        p1.dy + (p2.dy - p1.dy) * currentProgress,
      );
    } else {
      // Draw full first segment + second segment
      final currentProgress = (progress - 0.5) * 2;
      path.moveTo(p1.dx, p1.dy);
      path.lineTo(p2.dx, p2.dy);
      path.lineTo(
        p2.dx + (p3.dx - p2.dx) * currentProgress,
        p2.dy + (p3.dy - p2.dy) * currentProgress,
      );
    }
    
    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(CheckmarkPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
```

---

### State 4.2.8: Step 1 - Tablet & Mobile Variations

**Tablet Adjustments**:
```
Form Fields:
  - Width: 100% (maintains full width)
  - Spacing: 20px between fields (from 24px)
  - Font sizes: Same as desktop

Business Type Cards:
  - Layout: Remains horizontal if space permits
  - OR switches to 2-column grid with 3rd card full-width below
  - Card height: 64px (reduced from 72px)
  - Icon: 28px (reduced from 32px)

Navigation:
  - Button sizes: Same (48px height)
```

**Mobile Adjustments**:
```
Form Fields:
  - Width: 100%
  - Padding: 16px horizontal (container)
  - Spacing: 20px between fields

Business Name:
  - Height: 52px (from 48px - larger touch target)
  - Padding: 14px (from 12px)

Contact Number:
  - Country selector: Full width, 52px height
  - Phone input: Full width, 52px height, 12px top spacing
  - Stack vertically (not side-by-side)

Primary Address:
  - Height: 120px (from 96px - more writing space)
  - Font: 15px (from 14px - better mobile readability)

Business Type Cards:
  - Layout: Vertical stack (full width each)
  - Height: 80px per card
  - Spacing: 12px between cards
  - Radio: Left side
  - Content: Horizontal layout (icon + text right)

Continue Button:
  - Fixed at bottom (not scrolling with content)
  - Full width minus 32px margins
  - Height: 52px
  - Safe area padding bottom
  - Shadow: 0px -2px 8px rgba(0, 0, 0, 0.08) upward

Back Button:
  - Hidden (Step 1)
```

---

## 4.3 Step 2: Currency & Tax Configuration

### State 4.3.1: Step 2 Default State - Desktop

**Step Header**:
```
Label: "Step 2 of 3"
Title: "Set up your currency and taxes"
Description: "Configure your business currency and tax settings"
```

**Form Structure**:

**1. Currency Selection**:
```
Label: "Business currency" (required)
  - 14px Inter Medium
  - Helper text below: "This cannot be changed later"
    - 12px Inter Regular, warning color (#FFC107 light / #FBF24 dark)
    - Icon: Small alert triangle (14px) left

Input Type: Searchable dropdown
  - Height: 48px
  - Shows: Currency name, code, symbol (e.g., "Pakistani Rupee (PKR) â‚¨")
  - Default: PKR (based on business location/user location)
  - Search: Type to filter currencies

Dropdown List:
  - Max height: 320px (scrollable)
  - Search input: Sticky at top, 40px height
  - List items: 44px height each
  - Each item shows:
    - Country flag emoji: 24px (if available)
    - Currency name: 14px Inter Regular
    - Currency code: 14px Inter Medium, secondary color
    - Currency symbol: 14px Inter Medium, right-aligned

Light Theme:
  - Field background: #FFFFFF
  - Border: 1px solid #D1D4D9 (default), 2px solid #0F4C4C (focus)
  - Dropdown: Background #FFFFFF, border 1px #D1D4D9, shadow 0px 4px 16px rgba(0,0,0,0.12)
  - Selected item: Background #E0F2F2, checkmark right
  - Hover item: Background #F8F9FA

Dark Theme:
  - Field background: #333333
  - Border: 1px solid #404040 (default), 2px solid #C5E64D (focus)
  - Dropdown: Background #2A2A2A, border 1px #404040, shadow 0px 4px 16px rgba(0,0,0,0.5)
  - Selected: Background #2C3500, checkmark #C5E64D
  - Hover: Background #333333

Warning Message Styling:
  - Background: #FFF3CD (light) / #5C3800 (dark)
  - Border: 1px solid #FFC107 (light) / #FBF24 (dark)
  - Icon: #856404 (light) / #FBF24 (dark)
  - Text: 12px Inter Regular, #856404 (light) / #FDE68A (dark)
  - Padding: 8px 12px
  - Border radius: 6px
  - Margin top: 8px
```

**2. Tax Regime Configuration**:
```
Label: "Tax regime" (required)
  - 14px Inter Medium

Input Type: Card-based radio selection
  - 2 main options:
    1. Pakistan (GST/Sales Tax)
    2. Other Country (Custom)

Card Layout: Horizontal (desktop), vertical (mobile)
  - Each card: Auto width (equal distribution), 120px height
  - Padding: 20px
  - Border: 2px (same as business type cards)

Option 1: Pakistan Card
  Content:
    - Flag: 🇵🇰, 32px
    - Title: "Pakistan", 18px Inter Medium
    - Subtitle: "GST & Sales Tax", 14px Inter Regular, secondary
    - Radio button: 20px, top-right corner

Option 2: Other Country Card
  Content:
    - Icon: Globe icon, 32px
    - Title: "Other Country", 18px Inter Medium
    - Subtitle: "Custom tax rules", 14px Inter Regular
    - Radio button: 20px, top-right

Selection States: Same as business type cards (hover, selected, default)
```

**3. Tax Rate Configuration** (conditional):

**If Pakistan Selected**:
```
Auto-populated fields (read-only/editable):

GST Rate:
  - Label: "GST rate (%)"
  - Input: Number field
  - Default value: 17% (pre-filled)
  - Editable: Yes
  - Suffix: "%" symbol inside field, right-aligned
  - Validation: 0-100 range
  - Helper: "Standard Pakistan GST rate"

Sales Tax Rate:
  - Label: "Sales tax rate (%)"
  - Default: 16% (pre-filled)
  - Editable: Yes
  - Suffix: "%"
  - Helper: "Provincial sales tax rate"

Apply To:
  - Label: "Apply taxes to"
  - Checkbox group (multiple selection):
    □ Products
    □ Services
  - Default: Both checked
  - Layout: Horizontal
```

**If Other Country Selected**:
```
Custom Tax Configuration:

Tax Name:
  - Label: "Tax name"
  - Input: Text field
  - Placeholder: "e.g., VAT, GST, Sales Tax"
  - Max length: 50 characters

Tax Rate:
  - Label: "Tax rate (%)"
  - Input: Number field
  - Placeholder: "e.g., 20"
  - Suffix: "%"
  - Validation: 0-100 range

Apply To:
  - Same as Pakistan option

Add Another Tax Button:
  - Text: "+ Add another tax", 14px Inter Medium, primary color
  - Icon: Plus circle, 18px
  - Style: Text button
  - Action: Adds new tax configuration fields below
  - Max: 5 tax types
```

**4. Fiscal Year Configuration**:
```
Label: "When does your fiscal year start?" (required)
  - 14px Inter Medium

Input Type: Month selector dropdown
  - Height: 48px
  - Shows: Month name (e.g., "January", "July")
  - Default: January
  - Dropdown: 12 months listed

Display below selection:
  - Info text: "Current fiscal year: July 2024 - June 2025"
  - 13px Inter Regular, secondary color
  - Icon: Info circle (16px) left
  - Background: Light info color tint
  - Padding: 12px
  - Border radius: 8px
  - Margin top: 12px
```

**Animation - Step 2 Entrance**:
```dart
// Step 2 slides in from right
class Step2Entrance extends StatefulWidget {
  @override
  _Step2EntranceState createState() => _Step2EntranceState();
}

class _Step2EntranceState extends State<Step2Entrance>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    _controller.forward();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            MediaQuery.of(context).size.width * 0.3 * (1 - _controller.value),
            0,
          ),
          child: Opacity(
            opacity: _controller.value,
            child: child,
          ),
        );
      },
      child: step2Content,
    );
  }
}
```

---

### State 4.3.2: Currency Dropdown Interaction

**Dropdown Open State**:
```
Trigger: Click/tap on currency field

Visual Changes:
  - Field border: 2px solid primary color (focus state)
  - Dropdown panel: Appears below field
  - Backdrop: Semi-transparent (mobile only)

Dropdown Panel:
  - Position: Below field (or above if near bottom)
  - Width: Same as field width
  - Max height: 320px
  - Z-index: 1000
  - Animation: Slide down + fade (200ms ease-out)

Search Input (inside dropdown):
  - Position: Sticky top
  - Height: 40px
  - Placeholder: "Search currencies..."
  - Background: Slightly different shade (for distinction)
  - Border bottom: 1px solid divider color
  - Auto-focus: Yes
  - Clear button: X icon appears when text entered

Currency List:
  - Scrollable container
  - Virtual scrolling for performance (if many items)
  - Each item: 44px height
  - Hover: Background color change
  - Selected: Background tint + checkmark
  - Keyboard navigable: Arrow keys, Enter to select
```

**Search Behavior**:
```
Real-time Filtering:
  - Matches: Currency name, code, country name
  - Case-insensitive
  - Highlights matched text (optional)
  - Shows "No results found" if no matches
  
Example:
  User types "pak" → Shows:
    🇵🇰 Pakistani Rupee (PKR)
  
  User types "usd" → Shows:
    🇺🇸 United States Dollar (USD)
```

**Selection Animation**:
```dart
class CurrencyDropdown extends StatefulWidget {
  @override
  _CurrencyDropdownState createState() => _CurrencyDropdownState();
}

class _CurrencyDropdownState extends State<CurrencyDropdown>
    with SingleTickerProviderStateMixin {
  late AnimationController _dropdownController;
  bool isOpen = false;
  Currency? selectedCurrency;
  
  void _toggleDropdown() {
    setState(() => isOpen = !isOpen);
    if (isOpen) {
      _dropdownController.forward();
    } else {
      _dropdownController.reverse();
    }
  }
  
  void _selectCurrency(Currency currency) {
    setState(() {
      selectedCurrency = currency;
      isOpen = false;
    });
    _dropdownController.reverse();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Field
        GestureDetector(
          onTap: _toggleDropdown,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: isOpen ? focusColor : borderColor,
                width: isOpen ? 2.0 : 1.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedCurrency?.displayName ?? 'Select currency',
                  style: TextStyle(
                    fontSize: 14,
                    color: selectedCurrency != null ? textColor : hintColor,
                  ),
                ),
                AnimatedRotation(
                  duration: Duration(milliseconds: 200),
                  turns: isOpen ? 0.5 : 0.0, // 180° rotation
                  child: Icon(Icons.keyboard_arrow_down, size: 20),
                ),
              ],
            ),
          ),
        ),
        
        // Dropdown panel
        if (isOpen)
          AnimatedBuilder(
            animation: _dropdownController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, -10 * (1 - _dropdownController.value)),
                child: Opacity(
                  opacity: _dropdownController.value,
                  child: child,
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: surfaceColor,
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    offset: Offset(0, 4),
                    blurRadius: 16,
                  ),
                ],
              ),
              constraints: BoxConstraints(maxHeight: 320),
              child: Column(
                children: [
                  // Search input
                  _buildSearchInput(),
                  // Currency list
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredCurrencies.length,
                      itemBuilder: (context, index) {
                        return _buildCurrencyItem(filteredCurrencies[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
```

---

### State 4.3.3: Tax Regime Card Selection

**Pakistan Card Selected**:
```
Visual Changes:
  - Card background: #E0F2F2 (light teal tint) / #2C3500 (dark olive)
  - Border: 2px solid #0F4C4C (light) / #C5E64D (dark)
  - Radio button: Filled circle, primary color
  - Additional fields appear below (GST/Sales Tax rates)

Animation:
  - Card selection: Same as business type (200ms ease-out)
  - Tax fields: Slide down + fade in (300ms, 100ms delay after selection)
```

**Tax Rate Fields Appearance** (when Pakistan selected):
```dart
// Conditional rendering with animation
AnimatedSize(
  duration: Duration(milliseconds: 300),
  curve: Curves.easeOut,
  child: isPakistanSelected
      ? Padding(
          padding: EdgeInsets.only(top: 24),
          child: Column(
            children: [
              // Fade in animation for fields
              TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 300),
                tween: Tween(begin: 0.0, end: 1.0),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: Column(
                  children: [
                    gstRateField,
                    SizedBox(height: 20),
                    salesTaxRateField,
                    SizedBox(height: 20),
                    applyToCheckboxes,
                  ],
                ),
              ),
            ],
          ),
        )
      : SizedBox.shrink(),
)
```

**Other Country Selected**:
```
Visual Changes:
  - Same card selection styling
  - Different fields appear:
    - Tax name input
    - Tax rate input
    - Apply to checkboxes
    - Add another tax button

Animation: Same slide + fade pattern
```

---

### State 4.3.4: Tax Rate Input Validation

**GST Rate Field**:
```
Input Type: Number field with percentage suffix
  - Min: 0
  - Max: 100
  - Step: 0.01 (allows decimals like 17.5%)
  - Suffix: "%" symbol inside field, right side, non-editable

Validation Rules:
  1. Must be between 0-100
  2. Cannot be negative
  3. Can be decimal (up to 2 places)

Error States:
  - Empty: "GST rate is required"
  - Out of range: "Rate must be between 0% and 100%"
  - Invalid format: "Please enter a valid number"

Success State:
  - Green border + checkmark when 0-100 entered

Light Theme:
  - Default: Border #D1D4D9
  - Focus: Border #0F4C4C
  - Error: Border #DC3545, red error message
  - Success: Border #28A745, green checkmark

Dark Theme:
  - Default: Border #404040
  - Focus: Border #C5E64D
  - Error: Border #FF5252
  - Success: Border #4ADE80
```

**Percentage Suffix Styling**:
```dart
TextField(
  keyboardType: TextInputType.numberWithOptions(decimal: true),
  inputFormatters: [
    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
  ],
  decoration: InputDecoration(
    suffixIcon: Padding(
      padding: EdgeInsets.only(right: 16),
      child: Center(
        widthFactor: 0.0,
        child: Text(
          '%',
          style: TextStyle(
            fontSize: 14,
            color: secondaryTextColor,
          ),
        ),
      ),
    ),
    suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
  ),
)
```

---

### State 4.3.5: Add Another Tax - Dynamic Fields

**Trigger**: User clicks "+ Add another tax" button

**Visual Changes**:
```
New Tax Configuration Block:
  - Appears below first tax block
  - Same fields: Name, Rate, Apply To
  - Additional: Remove button (X icon, top-right)
  - Border: 1px solid outline color
  - Border radius: 8px
  - Padding: 20px
  - Margin top: 16px
  - Background: Slightly tinted surface color

Remove Button:
  - Icon: X circle, 20px
  - Color: Error color (red)
  - Position: Absolute top-right, 8px from edges
  - Touch target: 40x40px
  - Hover: Background rgba(error, 0.1)

Add Button State:
  - Disabled when 5 tax blocks exist (max limit)
  - Text changes: "Maximum 5 taxes reached"
  - Color: Gray (disabled state)
```

**Animation - Add Tax Block**:
```dart
class DynamicTaxFields extends StatefulWidget {
  @override
  _DynamicTaxFieldsState createState() => _DynamicTaxFieldsState();
}

class _DynamicTaxFieldsState extends State<DynamicTaxFields> {
  List<TaxConfig> taxConfigs = [TaxConfig()]; // Start with 1
  
  void _addTaxConfig() {
    if (taxConfigs.length < 5) {
      setState(() {
        taxConfigs.add(TaxConfig());
      });
    }
  }
  
  void _removeTaxConfig(int index) {
    setState(() {
      taxConfigs.removeAt(index);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Animated list of tax configs
        AnimatedList(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          initialItemCount: taxConfigs.length,
          itemBuilder: (context, index, animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 0.3),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: FadeTransition(
                opacity: animation,
                child: _buildTaxConfigBlock(
                  taxConfigs[index],
                  index,
                  canRemove: taxConfigs.length > 1,
                ),
              ),
            );
          },
        ),
        
        // Add button
        if (taxConfigs.length < 5)
          TextButton.icon(
            onPressed: _addTaxConfig,
            icon: Icon(Icons.add_circle_outline, size: 18),
            label: Text('Add another tax'),
            style: TextButton.styleFrom(
              foregroundColor: primaryColor,
            ),
          ),
      ],
    );
  }
  
  Widget _buildTaxConfigBlock(TaxConfig config, int index, {required bool canRemove}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
        color: surfaceVariant,
      ),
      child: Stack(
        children: [
          Column(
            children: [
              taxNameField,
              SizedBox(height: 16),
              taxRateField,
              SizedBox(height: 16),
              applyToCheckboxes,
            ],
          ),
          if (canRemove)
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.cancel, color: errorColor),
                iconSize: 20,
                onPressed: () => _removeTaxConfig(index),
              ),
            ),
        ],
      ),
    );
  }
}
```

**Remove Animation**:
```
When X clicked:
  1. Block scales down to 0.9 (100ms)
  2. Opacity fades to 0 (200ms)
  3. Height collapses (200ms)
  4. Blocks below shift up smoothly
```

---

### State 4.3.6: Fiscal Year Selection

**Month Selector Dropdown**:
```
Visual: Similar to currency dropdown
  - Height: 48px
  - Shows: Month name (e.g., "January")
  - Icon: Calendar icon left, dropdown arrow right

Dropdown List:
  - 12 months in chronological order
  - Each item: 44px height
  - Current month: Highlighted (optional)
  - Selected month: Checkmark right

Info Display (below selector):
  - Updates in real-time as month changes
  - Shows: "Current fiscal year: [Selected Month] [Year] - [End Month] [Year+1]"
  - Example: "Current fiscal year: July 2024 - June 2025"
  
Light Theme:
  Info box:
    - Background: #E8F5B8 (pale lime, info color)
    - Border: 1px solid #CDDC39
    - Icon: Info circle, #5A7A6F
    - Text: 13px Inter Regular, #3D5100
    - Padding: 12px
    - Border radius: 8px

Dark Theme:
  Info box:
    - Background: #2C3500
    - Border: 1px solid #9FC230
    - Icon: #C5E64D
    - Text: #E1F3A6
```

---

### State 4.3.7: Navigation Buttons - Step 2

**Back Button** (now visible):
```
Visual:
  - Outlined style
  - Text: "Back", 14px Inter Medium
  - Icon: Left arrow (optional), 18px
  - Height: 48px
  - Min width: 120px

Light Theme:
  - Border: 1px solid #D1D4D9
  - Text: #0F4C4C
  - Hover: Background #F8F9FA, border #0F4C4C

Dark Theme:
  - Border: 1px solid #404040
  - Text: #C5E64D
  - Hover: Background #333333, border #C5E64D

Action: Returns to Step 1 (slides right, fade out/in)
```

**Continue Button**:
```
State: Enabled when currency selected AND tax regime selected AND fiscal year selected

Visual: Same as Step 1 continue button
  - Filled primary color
  - Text: "Continue"
  - Height: 48px

Action: Proceeds to Step 3 (slides left)
```

**Animation - Back Click**:
```dart
void _goBackToStep1() async {
  setState(() => isLoading = true);
  
  // Slide out current content to right
  await _slideController.reverse();
  
  // Update step
  setState(() {
    currentStep = 1;
    isLoading = false;
  });
  
  // Slide in Step 1 from left
  _slideController.forward(from: 0.0);
  
  // Update progress sidebar
  _updateProgressIndicator();
}

// Animation: Step 2 slides right (reverse of forward animation)
Transform.translate(
  offset: Offset(
    MediaQuery.of(context).size.width * 0.3 * _backController.value,
    0,
  ),
  child: Opacity(
    opacity: 1.0 - _backController.value,
    child: step2Content,
  ),
)
```

---

### State 4.3.8: Step 2 - Mobile & Tablet Variations

**Mobile Layout (<768px)**:
```
Currency Selection:
  - Full width field
  - Height: 52px (larger touch target)
  - Helper text: Stacks below field (not inline)

Tax Regime Cards:
  - Layout: Vertical stack
  - Each card: Full width, 88px height
  - Spacing: 12px between cards
  - Radio button: Top-right corner
  - Content: Icon + text centered

Tax Rate Fields (Pakistan):
  - GST Rate: Full width, 52px height
  - Sales Tax: Full width, 52px height
  - Spacing: 16px between fields
  - Percentage suffix: Larger (16px) for visibility

Apply To Checkboxes:
  - Layout: Vertical (not horizontal)
  - Each checkbox: 52px height (full width)
  - Label: 15px font size

Fiscal Year:
  - Dropdown: Full width, 52px height
  - Info box: Full width, wraps text if needed

Navigation:
  - Back & Continue: Stack vertically (full width each)
  - Continue: 52px height, bottom fixed
  - Back: 48px height, 12px above Continue
```

**Tablet Adjustments (768px - 1279px)**:
```
Currency:
  - Height: 48px (same as desktop)

Tax Cards:
  - Can remain horizontal if space permits (2 cards side-by-side)
  - Or vertical stack on smaller tablets

Tax Fields:
  - Two-column layout: GST left, Sales Tax right (50/50 split)
  - Gap: 16px between columns

All other elements: Scale proportionally
```

---

## 4.4 Step 3: Location Hierarchy Setup

### State 4.4.1: Step 3 Default State - Desktop

**Step Header**:
```
Label: "Step 3 of 3"
Title: "Set up your locations"
Description: "Define your business locations and hierarchy"
```

**Content Structure**:
```
Two-column layout (desktop):
  - Left: Location tree diagram (400px width)
  - Right: Location details form (flex 1)
  - Gap: 32px

Mobile/Tablet: Single column, tree collapses
```

**Left Column - Location Tree**:
```
Tree Container:
  - Background: Slight tint of surface color
  - Border: 1px solid outline color
  - Border radius: 12px
  - Padding: 24px
  - Min height: 400px

Tree Structure:
  Root Node (Head Office):
    - Always present, cannot be deleted
    - Icon: Building icon, 24px, primary color
    - Name: "Head Office" (default, editable)
    - Type badge: "Head Office", 12px, pill shape
    - Edit icon: Pencil, 16px, right side
    - Add child button: "+ Add location" below

  Child Nodes (Regional/Store):
    - Indented: 24px from parent
    - Connecting line: 2px dashed, outline color
    - Icon: Based on type (warehouse/store)
    - Name: Editable
    - Type badge: "Regional" or "Store"
    - Actions: Edit, Delete, Add child (if Regional)

Visual Tree Lines:
  - Vertical line: From parent to children
  - Horizontal line: To each child node
  - Color: Outline color (light gray)
  - Style: Dashed (2px dash, 4px gap)

Light Theme:
  Container background: #F8F9FA
  Border: 1px solid #E8EAED
  Tree lines: #D1D4D9
  Active node: Background #E0F2F2, border #0F4C4C

Dark Theme:
  Container background: #1E1E1E
  Border: 1px solid #404040
  Tree lines: #404040
  Active node: Background #2C3500, border #C5E64D
```

**Right Column - Location Details Form**:
```
Initial State (no location selected):
  - Empty state illustration: Location pin icon, 80px
  - Text: "Select a location to view details"
  - Subtext: "Or add a new location to get started"
  - 14px Inter Regular, secondary color

When Location Selected:
  - Form appears with location details
  - Animated slide-in from right (300ms)

Form Fields:
  1. Location Name (required)
  2. Location Type (dropdown)
  3. Manager (searchable dropdown, optional)
  4. Address (multi-line, optional)
  5. Contact Number (optional)
  6. Parent Location (auto-filled, read-only)

Type Dropdown Options:
  - Head Office (disabled if editing root)
  - Regional Warehouse
  - Retail Store

Save Button:
  - Text: "Save Location"
  - Style: Filled primary
  - Height: 48px
  - Width: 150px
  - Position: Bottom right of form

Cancel Button:
  - Text: "Cancel"
  - Style: Outlined
  - Height: 48px
  - Position: Left of Save button
```

**Tree Node Component**:
```dart
class LocationTreeNode extends StatefulWidget {
  final Location location;
  final int depth;
  final bool isSelected;
  final Function(Location) onSelect;
  final Function(Location) onEdit;
  final Function(Location) onDelete;
  final Function(Location) onAddChild;
  
  @override
  _LocationTreeNodeState createState() => _LocationTreeNodeState();
}

class _LocationTreeNodeState extends State<LocationTreeNode> {
  bool _isExpanded = true;
  bool _isHovered = false;
  
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Node row
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeOut,
            margin: EdgeInsets.only(
              left: widget.depth * 24.0,
              bottom: 8,
            ),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? selectedNodeColor
                  : _isHovered
                      ? hoverNodeColor
                      : Colors.transparent,
              border: Border.all(
                color: widget.isSelected ? primaryColor : Colors.transparent,
                width: widget.isSelected ? 2.0 : 0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // Expand/collapse button (if has children)
                if (widget.location.children.isNotEmpty)
                  GestureDetector(
                    onTap: () => setState(() => _isExpanded = !_isExpanded),
                    child: AnimatedRotation(
                      duration: Duration(milliseconds: 200),
                      turns: _isExpanded ? 0.25 : 0.0, // 90° rotation
                      child: Icon(
                        Icons.chevron_right,
                        size: 20,
                        color: iconColor,
                      ),
                    ),
                  ),
                if (widget.location.children.isEmpty)
                  SizedBox(width: 20),
                
                SizedBox(width: 8),
                
                // Location icon
                Icon(
                  widget.location.type.icon,
                  size: 24,
                  color: widget.isSelected ? primaryColor : iconColor,
                ),
                
                SizedBox(width: 12),
                
                // Location name
                Expanded(
                  child: Text(
                    widget.location.name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: widget.isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: widget.isSelected ? primaryColor : textColor,
                    ),
                  ),
                ),
                
                // Type badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.location.type.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.location.type.label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: widget.location.type.color,
                    ),
                  ),
                ),
                
                SizedBox(width: 8),
                
                // Actions (visible on hover or selected)
                if (_isHovered || widget.isSelected)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, size: 16),
                        onPressed: () => widget.onEdit(widget.location),
                        color: primaryColor,
                        constraints: BoxConstraints(),
                        padding: EdgeInsets.all(4),
                      ),
                      if (!widget.location.isRoot)
                        IconButton(
                          icon: Icon(Icons.delete, size: 16),
                          onPressed: () => widget.onDelete(widget.location),
                          color: errorColor,
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.all(4),
                        ),
                    ],
                  ),
              ],
            ),
          ),
          
          // Children (if expanded)
          if (_isExpanded && widget.location.children.isNotEmpty)
            AnimatedSize(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
              child: Column(
                children: widget.location.children.map((child) {
                  return LocationTreeNode(
                    location: child,
                    depth: widget.depth + 1,
                    isSelected: false, // Implement selection logic
                    onSelect: widget.onSelect,
                    onEdit: widget.onEdit,
                    onDelete: widget.onDelete,
                    onAddChild: widget.onAddChild,
                  );
                }).toList(),
              ),
            ),
          
          // Add child button (for Regional nodes)
          if (widget.location.canHaveChildren && _isExpanded)
            Padding(
              padding: EdgeInsets.only(
                left: (widget.depth + 1) * 24.0,
                top: 4,
              ),
              child: TextButton.icon(
                onPressed: () => widget.onAddChild(widget.location),
                icon: Icon(Icons.add_circle_outline, size: 16),
                label: Text('Add location'),
                style: TextButton.styleFrom(
                  foregroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
```

---

### State 4.4.2: Add New Location - Dialog/Form

**Trigger**: User clicks "+ Add location" button on any node

**Desktop - Slide-in Panel** (right side):
```
Panel Dimensions:
  - Width: 480px
  - Height: 100vh (full height)
  - Position: Fixed right, slides in from right edge
  - Z-index: 1100
  - Backdrop: Semi-transparent overlay (rgba(0, 0, 0, 0.5))

Panel Animation:
```dart
AnimatedPositioned(
  duration: Duration(milliseconds: 300),
  curve: Curves.easeOut,
  right: isOpen ? 0 : -480,
  top: 0,
  bottom: 0,
  width: 480,
  child: Container(
    decoration: BoxDecoration(
      color: surfaceColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(-4, 0),
          blurRadius: 16,
        ),
      ],
    ),
    child: addLocationForm,
  ),
)

// Backdrop
GestureDetector(
  onTap: _closePanel,
  child: AnimatedOpacity(
    duration: Duration(milliseconds: 300),
    opacity: isOpen ? 1.0 : 0.0,
    child: Container(
      color: Colors.black.withOpacity(0.5),
    ),
  ),
)
```

**Panel Content**:
```
Header:
  - Height: 64px
  - Padding: 20px horizontal
  - Border bottom: 1px solid outline color
  - Background: Surface color
  
  Content:
    - Title: "Add New Location", 20px Inter Semibold
    - Close button: X icon, 24px, top-right
    - Parent info: "Under: [Parent Name]", 13px, secondary color

Form Section:
  - Padding: 24px
  - Scrollable if content overflows
  
  Fields (same as edit form):
    1. Location Name (required)
       - Placeholder: "e.g., Downtown Store"
       - Max length: 100 chars
    
    2. Location Type (required)
       - Dropdown: Regional Warehouse, Retail Store
       - Default: Retail Store
       - If parent is Head Office: Can select Regional
       - If parent is Regional: Only Retail Store
    
    3. Manager (optional)
       - Searchable dropdown
       - Shows existing users with Manager role
       - Or "Assign Later" option
    
    4. Address (optional)
       - Multi-line: 96px height
       - Placeholder: "Street address, city, postal code"
    
    5. Contact Number (optional)
       - Country code + number (same as Step 1)

Footer (fixed at bottom):
  - Height: 80px
  - Border top: 1px solid outline color
  - Padding: 16px 24px
  - Background: Surface color
  - Safe area padding
  
  Buttons:
    - Cancel: Outlined, 48px height, 120px width
    - Add Location: Filled primary, 48px height, 150px width
    - Layout: Space-between (left/right)
```

**Light Theme**:
```
Panel:
  - Background: #FFFFFF
  - Shadow: -4px 0 16px rgba(0, 0, 0, 0.2)

Header:
  - Background: #FFFFFF
  - Border: 1px solid #E8EAED
  - Title: #0F4C4C
  - Parent info: #44474E

Footer:
  - Background: #FFFFFF
  - Border: 1px solid #E8EAED
```

**Dark Theme**:
```
Panel:
  - Background: #2A2A2A
  - Shadow: -4px 0 16px rgba(0, 0, 0, 0.5)

Header:
  - Background: #2A2A2A
  - Border: 1px solid #404040
  - Title: #C5E64D
  - Parent info: #C7C7C7

Footer:
  - Background: #2A2A2A
  - Border: 1px solid #404040
```

**Mobile - Full Screen Modal**:
```
Layout:
  - Takes full screen
  - Header: 56px height, fixed top
  - Form: Scrollable content
  - Footer: 72px height, fixed bottom

Header:
  - Back arrow: Left (instead of X)
  - Title: Centered
  - Smaller padding: 16px

Form:
  - Padding: 16px
  - Fields: 52px height (larger touch targets)

Footer:
  - Buttons: Stack vertically
  - Add Location: Full width, 52px
  - Cancel: Full width, 48px, 12px top margin
```

---

### State 4.4.3: Location Form Validation

**Required Field Validation**:

**Location Name**:
```
Rules:
  - Required
  - Min 3 characters
  - Max 100 characters
  - No special characters: <, >, {, }

Validation Triggers:
  - On blur (lose focus)
  - On form submit

Error Messages:
  - Empty: "Location name is required"
  - Too short: "Name must be at least 3 characters"
  - Invalid chars: "Name contains invalid characters"

Visual:
  - Border: 2px solid error color
  - Error icon: Right side
  - Error text: Below field, slides down (200ms)
  - Field shake: On error (400ms elastic)

Success:
  - Border: 2px solid success color
  - Checkmark: Right side, scales in (300ms)
```

**Location Type**:
```
Rules:
  - Required
  - Must be valid based on parent type

Parent Hierarchy Rules:
  - Head Office → Can have Regional OR Store
  - Regional → Can only have Store
  - Store → Cannot have children

If Invalid Selection:
  - Error: "Stores cannot be added under other stores"
  - Dropdown: Disabled invalid options (grayed out)
```

**Manager Selection** (optional):
```
If selected:
  - Validates user exists
  - Checks user has Manager role
  - Warning if already managing another location:
    - "This user manages [Other Location]. Assign anyway?"
    - Yellow warning banner
    - Checkbox: "I understand, assign anyway"
```

**Duplicate Name Check**:
```
Validation:
  - On blur: Checks if name exists at same level
  - If duplicate found:
    - Warning (not error): "A location with this name already exists"
    - Yellow banner with info icon
    - Can proceed but shows warning

Location Uniqueness:
  - Names must be unique within same parent
  - "Store A" under Head Office vs "Store A" under Regional → OK
  - Two "Store A" under same Regional → Warning
```

---

### State 4.4.4: Add Location Success - Tree Update

**Trigger**: User clicks "Add Location" with valid form

**Sequence**:
1. Button enters loading state (spinner + "Adding...")
2. Form submission (300ms simulated delay)
3. Success confirmation
4. Panel closes with slide-out animation (300ms)
5. Tree updates with new node
6. New node highlights briefly (2 seconds)
7. Tree scrolls to show new node if needed

**Button Loading State**:
```dart
FilledButton(
  onPressed: isLoading ? null : _handleSubmit,
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
            Text('Adding...'),
          ],
        )
      : Text('Add Location'),
)
```

**Tree Update Animation**:
```dart
class TreeUpdateAnimation extends StatefulWidget {
  final Location newLocation;
  
  @override
  _TreeUpdateAnimationState createState() => _TreeUpdateAnimationState();
}

class _TreeUpdateAnimationState extends State<TreeUpdateAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;
  
  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    
    // Scale animation: pulse effect
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: Curves.elasticOut),
        ),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.05),
        weight: 10,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.05, end: 1.0),
        weight: 10,
      ),
      TweenSequenceItem(
        tween: ConstantTween(1.0),
        weight: 40,
      ),
    ]).animate(_controller);
    
    // Color animation: highlight fade
    _colorAnimation = ColorTween(
      begin: successColor.withOpacity(0.3),
      end: Colors.transparent,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.5, 1.0, curve: Curves.easeOut),
    ));
    
    _controller.forward();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              color: _colorAnimation.value,
              borderRadius: BorderRadius.circular(8),
            ),
            child: child,
          ),
        );
      },
      child: LocationTreeNode(
        location: widget.newLocation,
        // ... other props
      ),
    );
  }
}
```

**Auto-Scroll to New Node**:
```dart
// After adding node, scroll tree to make it visible
WidgetsBinding.instance.addPostFrameCallback((_) {
  if (_newNodeKey.currentContext != null) {
    Scrollable.ensureVisible(
      _newNodeKey.currentContext!,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      alignment: 0.5, // Center in viewport
    );
  }
});
```

---

### State 4.4.5: Edit Location

**Trigger**: User clicks edit icon on tree node

**Visual Changes**:
```
Same slide-in panel as Add Location, but:
  - Title: "Edit Location"
  - Fields pre-populated with existing data
  - Parent Location: Read-only, shows current parent
  - Delete button: Appears in footer (red, outlined)

Footer Buttons Layout:
  - Delete: Left side, outlined red, 48px height
  - Cancel: Center-left, outlined, 48px height
  - Save Changes: Right side, filled primary, 48px height
```

**Pre-fill Animation**:
```dart
// Fields fade in with pre-filled data
TweenAnimationBuilder<double>(
  duration: Duration(milliseconds: 300),
  tween: Tween(begin: 0.0, end: 1.0),
  curve: Curves.easeOut,
  builder: (context, value, child) {
    return Opacity(
      opacity: value,
      child: child,
    );
  },
  child: formWithPrefilledData,
)
```

**Save Changes Button**:
```
State: Disabled until any field changes
  - Tracks original values vs current values
  - Enables when difference detected

On Save:
  1. Validates changed fields
  2. Button shows loading state
  3. Updates backend/local data
  4. Panel closes
  5. Tree node updates in place
  6. Brief highlight flash (success color)
```

**Delete Button** (appears only in Edit mode):
```
Visual:
  - Text: "Delete Location", 14px Inter Medium
  - Icon: Trash can, 18px, left of text
  - Style: Outlined
  - Border: 1px solid error color (#DC3545 light / #FF5252 dark)
  - Text color: Error color
  - Height: 48px
  - Min width: 140px

Hover:
  - Background: Error color with 0.08 opacity
  - Border: 2px solid error color

Click Action:
  - Opens confirmation dialog (see State 4.4.6)
```

---

### State 4.4.6: Delete Location Confirmation

**Trigger**: User clicks "Delete Location" button

**Confirmation Dialog**:
```
Desktop - Modal Dialog:
  - Width: 480px
  - Max-width: 90vw
  - Center screen position
  - Backdrop: Semi-transparent (rgba(0, 0, 0, 0.6))
  - Animation: Scale + fade in (300ms)

Dialog Structure:
  Header:
    - Icon: Warning triangle, 48px, error color
    - Title: "Delete [Location Name]?", 20px Inter Semibold
    - Close button: X, top-right corner

  Content:
    - Warning message: "This action cannot be undone."
    - If location has children:
      - Additional warning: "This location has [N] child locations. They will also be deleted."
      - List of children: Max 3 shown, "and [N] more..." if >3
    - If location has inventory:
      - Blocking message: "Cannot delete location with active inventory ([N] items). Transfer inventory first."
      - Delete button: Disabled

  Footer:
    - Cancel button: Outlined, 48px height
    - Delete button: Filled error color, 48px height
    - Layout: Space-between

Light Theme:
  Dialog:
    - Background: #FFFFFF
    - Border radius: 16px
    - Shadow: 0px 8px 32px rgba(0, 0, 0, 0.12)
  
  Warning icon: #DC3545
  
  Footer:
    - Cancel: Border #D1D4D9, text #44474E
    - Delete: Background #DC3545, text #FFFFFF

Dark Theme:
  Dialog:
    - Background: #2A2A2A
    - Shadow: 0px 8px 32px rgba(0, 0, 0, 0.5)
  
  Warning icon: #FF5252
  
  Footer:
    - Cancel: Border #404040, text #C7C7C7
    - Delete: Background #FF5252, text #FFFFFF
```

**Dialog Animation**:
```dart
// Scale + fade entrance
AnimatedScale(
  scale: isVisible ? 1.0 : 0.8,
  duration: Duration(milliseconds: 300),
  curve: Curves.easeOut,
  child: FadeTransition(
    opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
    ),
    child: Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: dialogContent,
    ),
  ),
)
```

**Delete Confirmation Flow**:
```
User clicks "Delete":
  1. Dialog appears (scale + fade, 300ms)
  2. User clicks "Delete" in dialog
  3. Dialog button shows loading (spinner)
  4. Deletion processes (500ms)
  5. Dialog closes (fade out, 200ms)
  6. Edit panel closes (slide right, 300ms)
  7. Tree node fades out (300ms)
  8. Other nodes shift up smoothly (300ms)
  9. Success toast: "Location deleted", 3s duration

If Deletion Blocked:
  - Delete button in dialog: Disabled state
  - Message explains why (inventory exists)
  - Only "Cancel" button enabled
  - Close dialog returns to edit form
```

**Mobile Dialog**:
```
Layout: Bottom sheet instead of centered modal
  - Slides up from bottom
  - Height: Auto (content-based)
  - Border radius: Top corners 16px
  - Handle bar: Top center, 32px wide, 4px tall, gray
```

---

### State 4.4.7: Navigation - Step 3 Complete

**Continue Button State**:
```
Enabled When:
  - At least 1 location exists (Head Office counts)
  - OR user chooses "Skip for now"

Visual:
  - Same styling as previous steps
  - Text: "Complete Setup"
  - Icon: Checkmark (optional), right of text

Desktop:
  - Position: Bottom right of main content area
  - Height: 48px
  - Min width: 160px

Mobile:
  - Fixed at bottom
  - Full width minus 32px margins
  - Height: 52px
```

**Alternative: Skip Option**:
```
Below Continue button:
  - Text link: "Skip location setup for now"
  - 14px Inter Regular, primary color
  - Underline on hover
  - Margin: 12px top

Click Action:
  - Confirmation dialog (if no locations added yet):
    - "Are you sure? You can add locations later in settings."
    - Cancel / Skip buttons
  - If confirmed: Proceeds to sample data options
```

---

### State 4.4.8: Step 3 - Mobile & Tablet Variations

**Mobile Layout (<768px)**:
```
Tree View:
  - Full width
  - Collapsible sections (accordion style)
  - Each node: 60px height
  - Touch targets: 52px minimum
  - Swipe actions:
    - Swipe left: Reveals Edit/Delete buttons
    - Swipe right: Collapse/expand children

Add Location:
  - Floating Action Button (FAB): Bottom-right
  - Icon: Plus, 24px
  - Size: 56px diameter
  - Elevated: 6dp
  - Color: Primary
  - Opens full-screen form (not panel)

Location Details:
  - Tap node: Opens full-screen details (not right panel)
  - Slides in from right (300ms)
  - Back button: Top-left
  - Save button: Top-right ("Done" text)

Tree Navigation:
  - Breadcrumbs: Top of tree
  - Shows: "All locations > [selected]"
  - Tap breadcrumb: Navigates up
```

**Tablet Adjustments (768px - 1279px)**:
```
Tree View:
  - Width: 350px (reduced from 400px)
  - Node indentation: 20px (reduced from 24px)

Details Panel:
  - Flex: Takes remaining space
  - OR full width if tree collapsed

Add Location:
  - Can use side panel (if width > 900px)
  - OR full-screen modal (if width < 900px)
```

---

## 4.5 Sample Data Options

### State 4.5.1: Sample Data Prompt - Desktop

**Trigger**: User clicks "Complete Setup" on Step 3

**Transition**:
```
Step 3 fades out (400ms)
Sample data screen crossfades in (400ms)
Progress sidebar: All 3 steps show checkmarks
```

**Screen Layout - Desktop**:
```
Full-screen modal overlay:
  - Center-aligned content
  - Max-width: 600px
  - Background: Surface color
  - Border radius: 16px
  - Padding: 48px
  - Shadow: 0px 8px 32px rgba(0, 0, 0, 0.12)

Content Structure:
  Icon:
    - Database/box icon with sparkles
    - Size: 80px
    - Color: Primary color
    - Animated: Gentle float (up/down 8px, 2s loop)

  Title:
    - "Add sample data?"
    - 28px Inter Semibold
    - Color: Primary text
    - Margin: 24px top

  Description:
    - "We can add sample products and transactions to help you learn the system"
    - 16px Inter Regular
    - Color: Secondary text
    - Max-width: 480px
    - Line height: 1.5
    - Margin: 16px top

  What's Included:
    - List of items with checkmarks
    - Each item: 15px Inter Regular
    - Icon: Green checkmark, 18px, left
    - Spacing: 12px between items
    - Margin: 32px top

    Items:
      ✓ 50 sample products (pharmacy items)
      ✓ 10 sample customers (various tiers)
      ✓ 5 sample transactions (sales history)
      ✓ 3 sample suppliers

  Note Box:
    - Background: Info color tint (light blue/purple)
    - Border: 1px solid info color
    - Border radius: 8px
    - Padding: 16px
    - Icon: Info circle, 20px, left
    - Text: "You can delete sample data anytime from settings"
    - 13px Inter Regular
    - Margin: 24px top

  Action Buttons:
    - Layout: Horizontal row, center-aligned
    - Spacing: 16px between buttons
    - Margin: 40px top

    No Button:
      - Text: "No, start fresh"
      - Style: Outlined
      - Height: 48px
      - Min width: 150px

    Yes Button:
      - Text: "Yes, add sample data"
      - Style: Filled primary
      - Height: 48px
      - Min width: 180px
```

**Light Theme**:
```
Modal:
  - Background: #FFFFFF
  - Shadow: 0px 8px 32px rgba(0, 0, 0, 0.12)

Icon: #0F4C4C
Title: #0F4C4C
Description: #44474E

Checkmarks: #28A745

Note Box:
  - Background: #D1ECF1
  - Border: 1px solid #17A2B8
  - Icon: #17A2B8
  - Text: #0C5460

Buttons:
  No:
    - Border: 1px solid #D1D4D9
    - Text: #44474E
  Yes:
    - Background: #0F4C4C
    - Text: #FFFFFF
```

**Dark Theme**:
```
Modal:
  - Background: #2A2A2A
  - Shadow: 0px 8px 32px rgba(0, 0, 0, 0.5)

Icon: #C5E64D
Title: #C5E64D
Description: #C7C7C7

Checkmarks: #4ADE80

Note Box:
  - Background: #003470
  - Border: 1px solid #3B82F6
  - Icon: #3B82F6
  - Text: #BFDBFE

Buttons:
  No:
    - Border: 1px solid #404040
    - Text: #C7C7C7
  Yes:
    - Background: #C5E64D
    - Text: #2C3500
```

**Icon Float Animation**:
```dart
class FloatingIconAnimation extends StatefulWidget {
  @override
  _FloatingIconAnimationState createState() => _FloatingIconAnimationState();
}

class _FloatingIconAnimationState extends State<FloatingIconAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _animation = Tween<double>(begin: -8.0, end: 8.0).animate(
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
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: Icon(
        Icons.inventory_2_outlined,
        size: 80,
        color: primaryColor,
      ),
    );
  }
}
```

---

### State 4.5.2: Sample Data Processing - Loading

**Trigger**: User clicks "Yes, add sample data"

**Loading Screen**:
```
Replaces button area with loading indicator:

Progress Section:
  - Spinner: 48px diameter, primary color
  - Text: "Adding sample data..."
  - 16px Inter Medium, primary color
  - Layout: Column, center-aligned

Progress Steps (below spinner):
  - Vertical list showing current operation
  - Each step fades in as it starts
  - Checkmark appears when complete

Steps (sequential, 500ms each):
  1. ⏳ Creating sample products... → ✓ 50 products added
  2. ⏳ Adding sample customers... → ✓ 10 customers added
  3. ⏳ Generating transactions... → ✓ 5 transactions created
  4. ⏳ Setting up suppliers... → ✓ 3 suppliers configured

Total time: ~2.5 seconds
```

**Step Animation**:
```dart
class SampleDataProgress extends StatefulWidget {
  @override
  _SampleDataProgressState createState() => _SampleDataProgressState();
}

class _SampleDataProgressState extends State<SampleDataProgress> {
  int currentStep = 0;
  List<String> steps = [
    'Creating sample products',
    'Adding sample customers',
    'Generating transactions',
    'Setting up suppliers',
  ];
  
  @override
  void initState() {
    super.initState();
    _processSteps();
  }
  
  Future<void> _processSteps() async {
    for (int i = 0; i < steps.length; i++) {
      setState(() => currentStep = i);
      await Future.delayed(Duration(milliseconds: 500));
    }
    // All complete, transition to dashboard
    _navigateToDashboard();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Main spinner
        SizedBox(
          width: 48,
          height: 48,
          child: CircularProgressIndicator(
            strokeWidth: 4,
            valueColor: AlwaysStoppedAnimation(primaryColor),
          ),
        ),
        
        SizedBox(height: 24),
        
        Text(
          'Adding sample data...',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: primaryColor,
          ),
        ),
        
        SizedBox(height: 32),
        
        // Progress steps
        Column(
          children: List.generate(steps.length, (index) {
            final isComplete = index < currentStep;
            final isCurrent = index == currentStep;
            
            return AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: index <= currentStep ? 1.0 : 0.3,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon: Loading spinner, checkmark, or pending
                    if (isCurrent)
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(primaryColor),
                        ),
                      )
                    else if (isComplete)
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: successColor,
                      )
                    else
                      Icon(
                        Icons.circle_outlined,
                        size: 16,
                        color: Colors.grey,
                      ),
                    
                    SizedBox(width: 12),
                    
                    // Step text
                    Text(
                      isComplete
                          ? _getCompleteText(index)
                          : steps[index],
                      style: TextStyle(
                        fontSize: 14,
                        color: isComplete
                            ? successColor
                            : isCurrent
                                ? primaryColor
                                : secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
  
  String _getCompleteText(int index) {
    switch (index) {
      case 0: return '50 products added';
      case 1: return '10 customers added';
      case 2: return '5 transactions created';
      case 3: return '3 suppliers configured';
      default: return 'Complete';
    }
  }
}
```

---

### State 4.5.3: No Sample Data - Immediate Transition

**Trigger**: User clicks "No, start fresh"

**Transition**:
```
Modal scales down + fades out (300ms)
Immediately transitions to completion screen
No data processing delay
```

---

### State 4.5.4: Sample Data Options - Mobile

**Mobile Layout (<768px)**:
```
Full-screen takeover (not modal):
  - Padding: 24px horizontal
  - Scrollable if content exceeds viewport

Icon:
  - Size: 64px (reduced from 80px)

Title:
  - Size: 24px (reduced from 28px)

Description:
  - Size: 15px (reduced from 16px)

What's Included List:
  - Font: 14px (reduced from 15px)
  - Checkmarks: 16px (reduced from 18px)

Buttons:
  - Stack vertically (not horizontal)
  - Yes button: Top, 52px height, full width
  - No button: Below, 48px height, full width
  - Spacing: 12px between
  - Position: Fixed at bottom (with safe area)

Note Box:
  - Full width
  - Font: 12px (reduced from 13px)
```

---

## 4.6 Onboarding Complete & Dashboard Entry

### State 4.6.1: Success Screen

**Trigger**: After sample data processing completes (or "No" selected)

**Success Screen Layout**:
```
Full-screen centered content:
  - Max-width: 500px
  - Center-aligned

Success Animation:
  - Large checkmark circle: 120px
  - Animated: Draws from center outward (800ms)
  - Color: Success green
  - After draw: Brief scale pulse (1.0 → 1.1 → 1.0, 400ms)

Title:
  - "You're all set!"
  - 32px Inter Semibold
  - Color: Primary
  - Margin: 32px top
  - Fade in: 300ms delay after checkmark

Message:
  - "Your business is ready. Let's start managing your pharmacy!"
  - 18px Inter Regular
  - Color: Secondary text
  - Max-width: 420px
  - Line height: 1.6
  - Margin: 16px top
  - Fade in: 500ms delay

Summary Box (optional):
  - Background: Success color tint (light green)
  - Border: 1px solid success color
  - Border radius: 12px
  - Padding: 20px
  - Margin: 32px top
  - Fade in: 700ms delay

  Content:
    - Title: "What we set up:", 14px Inter Semibold
    - List:
      ✓ Business information
      ✓ Currency & tax settings
      ✓ [N] locations
      ✓ [if applicable] Sample data (50 products, 10 customers)
    - Each item: 14px Inter Regular, 8px spacing

CTA Button:
  - Text: "Go to Dashboard"
  - Icon: Arrow right, 20px, right of text
  - Style: Filled primary
  - Height: 56px (larger for emphasis)
  - Min width: 200px
  - Margin: 48px top
  - Fade in: 900ms delay
  - Subtle pulse animation: Scale 1.0 → 1.02 → 1.0, repeats every 2s

Light Theme:
  Checkmark: #28A745
  Title: #0F4C4C
  Message: #44474E
  
  Summary Box:
    - Background: #D4EDDA
    - Border: 1px solid #28A745
    - Text: #155724
    - Checkmarks: #28A745
  
  Button:
    - Background: #0F4C4C
    - Text: #FFFFFF

Dark Theme:
  Checkmark: #4ADE80
  Title: #C5E64D
  Message: #C7C7C7
  
  Summary Box:
    - Background: #005C1E
    - Border: 1px solid #4ADE80
    - Text: #B5F0C8
    - Checkmarks: #4ADE80
  
  Button:
    - Background: #C5E64D
    - Text: #2C3500
```

**Checkmark Draw Animation**:
```dart
class CheckmarkDraw extends StatefulWidget {
  @override
  _CheckmarkDrawState createState() => _CheckmarkDrawState();
}

class _CheckmarkDrawState extends State<CheckmarkDraw>
    with SingleTickerProviderStateMixin {
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: CheckmarkPainter(
            progress: _controller.value,
            color: successColor,
          ),
          size: Size(120, 120),
        );
      },
    );
  }
}

class CheckmarkPainter extends CustomPainter {
  final double progress;
  final Color color;
  
  CheckmarkPainter({required this.progress, required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    
    // Draw circle
    final circlePaint = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      circlePaint,
    );
    
    // Draw checkmark path
    final checkPath = Path();
    final center = Offset(size.width / 2, size.height / 2);
    
    // Checkmark coordinates (relative to center)
    final p1 = Offset(center.dx - 20, center.dy);
    final p2 = Offset(center.dx - 5, center.dy + 15);
    final p3 = Offset(center.dx + 20, center.dy - 15);
    
    if (progress <= 0.4) {
      // Draw first segment
      final segmentProgress = progress / 0.4;
      checkPath.moveTo(p1.dx, p1.dy);
      checkPath.lineTo(
        p1.dx + (p2.dx - p1.dx) * segmentProgress,
        p1.dy + (p2.dy - p1.dy) * segmentProgress,
      );
    } else {
      // Draw full first segment + second segment
      final segmentProgress = (progress - 0.4) / 0.6;
      checkPath.moveTo(p1.dx, p1.dy);
      checkPath.lineTo(p2.dx, p2.dy);
      checkPath.lineTo(
        p2.dx + (p3.dx - p2.dx) * segmentProgress,
        p2.dy + (p3.dy - p2.dy) * segmentProgress,
      );
    }
    
    canvas.drawPath(checkPath, paint);
  }
  
  @override
  bool shouldRepaint(CheckmarkPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
```

---

### State 4.6.2: Dashboard Entry Transition

**Trigger**: User clicks "Go to Dashboard"

**Transition Sequence**:
```
1. Button press animation (scale 0.98, 100ms)
2. Success screen fades out (400ms)
3. Brief white/dark flash (100ms) - transition effect
4. Dashboard fades in with stagger animation (600ms)
5. Welcome tooltip tour starts (optional)
```

**Dashboard Entrance Animation**:
```dart
class DashboardEntrance extends StatefulWidget {
  @override
  _DashboardEntranceState createState() => _DashboardEntranceState();
}

class _DashboardEntranceState extends State<DashboardEntrance>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _staggerController;
  
  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    
    _staggerController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    
    // Start animations
    _fadeController.forward();
    Future.delayed(Duration(milliseconds: 200), () {
      _staggerController.forward();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeController,
      child: AnimatedBuilder(
        animation: _staggerController,
        builder: (context, child) {
          return Column(
            children: [
              // Dashboard header
              _buildAnimatedElement(
                widget: dashboardHeader,
                delay: 0.0,
                controller: _staggerController,
              ),
              
              // Stats cards row
              _buildAnimatedElement(
                widget: statsCardsRow,
                delay: 0.2,
                controller: _staggerController,
              ),
              
              // Main content area
              _buildAnimatedElement(
                widget: mainContentArea,
                delay: 0.4,
                controller: _staggerController,
              ),
            ],
          );
        },
      ),
    );
  }
  
  Widget _buildAnimatedElement({
    required Widget widget,
    required double delay,
    required AnimationController controller,
  }) {
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          delay,
          (delay + 0.3).clamp(0.0, 1.0),
          curve: Curves.easeOut,
        ),
      ),
    );
    
    return FadeTransition(
      opacity: animation,
      child: Transform.translate(
        offset: Offset(0, 30 * (1 - animation.value)),
        child: widget,
      ),
    );
  }
}
```

---

### State 4.6.3: Welcome Tooltip Tour (Optional)

**Trigger**: Dashboard loads for first-time user

**Tooltip System**:
```
Overlay tooltips highlighting key features:
  - Sequential: One at a time
  - Dismissible: Click "Next" or "Skip tour"
  - Persistent: Can be restarted from help menu

Tour Steps (5 total):
  1. "This is your dashboard - see sales, alerts, and key metrics"
     - Targets: Dashboard header
     - Position: Below element
  
  2. "Access POS here to start making sales"
     - Targets: POS navigation item
     - Position: Right of element
  
  3. "Manage your inventory and products"
     - Targets: Inventory navigation item
     - Position: Right of element
  
  4. "View reports and analytics"
     - Targets: Reports navigation item
     - Position: Right of element
  
  5. "Settings for business configuration"
     - Targets: Settings icon
     - Position: Below element

Tooltip Visual:
  - Background: Primary color
  - Text: White (light theme) / Dark (dark theme)
  - Font: 14px Inter Medium
  - Max width: 280px
  - Padding: 16px 20px
  - Border radius: 12px
  - Shadow: 0px 4px 12px rgba(0, 0, 0, 0.15)
  - Arrow: Points to target element

Controls:
  - "Skip tour" link: Top-right corner, small, underline
  - "Next" button: Bottom-right, outlined white/dark
  - Progress: "1 of 5" text, bottom-left
  - Last step: Button text changes to "Got it!"

Backdrop:
  - Semi-transparent: rgba(0, 0, 0, 0.4)
  - Spotlight: Clear circle around target element (no overlay)
```

**Tooltip Animation**:
```dart
// Tooltip fades in with slight scale
AnimatedOpacity(
  opacity: isVisible ? 1.0 : 0.0,
  duration: Duration(milliseconds: 300),
  curve: Curves.easeOut,
  child: AnimatedScale(
    scale: isVisible ? 1.0 : 0.9,
    duration: Duration(milliseconds: 300),
    curve: Curves.easeOut,
    child: TooltipCard(
      message: currentStep.message,
      onNext: _handleNext,
      onSkip: _handleSkip,
      progress: '$currentStepIndex of $totalSteps',
    ),
  ),
)

// Spotlight animation
CustomPaint(
  painter: SpotlightPainter(
    targetRect: targetRect,
    backdropColor: Colors.black.withOpacity(0.4),
  ),
)

class SpotlightPainter extends CustomPainter {
  final Rect targetRect;
  final Color backdropColor;
  
  SpotlightPainter({required this.targetRect, required this.backdropColor});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = backdropColor;
    
    // Draw backdrop with hole
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    
    // Cut out target area (with padding)
    final spotlightRect = targetRect.inflate(8);
    path.addRRect(
      RRect.fromRectAndRadius(spotlightRect, Radius.circular(8)),
    );
    
    path.fillType = PathFillType.evenOdd;
    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(SpotlightPainter oldDelegate) {
    return oldDelegate.targetRect != targetRect;
  }
}
```

---

## 4.7 Post-Setup Configuration (Edit Modes)

### State 4.7.1: Business Settings - View Mode

**Access**: Settings → Business Profile

**Desktop Layout**:
```
Page structure:
  - Page header: "Business Profile", 28px Inter Semibold
  - Edit button: Top-right, outlined primary
  - Content: Cards with read-only data

Content Cards (3 main sections):

Card 1: Business Information
  - Title: "Business Information", 18px Inter Semibold
  - Fields (label: value pairs):
    - Business Name: [value]
    - Contact Number: [value]
    - Primary Address: [value]
    - Business Type: [badge]
  - Layout: 2-column grid on desktop

Card 2: Currency & Tax
  - Title: "Currency & Tax Settings"
  - Warning banner at top: "Some settings cannot be changed"
    - Yellow background, warning icon
  - Fields:
    - Currency: [value] (locked icon if transactions exist)
    - Tax Regime: [value]
    - GST Rate: [value]%
    - Sales Tax Rate: [value]%
    - Fiscal Year Start: [value]

Card 3: Locations
  - Title: "Business Locations"
  - Mini tree view (collapsed, read-only)
  - "Manage Locations" button: Opens location manager
  - Shows count: "[N] locations configured"

Card Styling (Light Theme):
  - Background: #FFFFFF
  - Border: 1px solid #E8EAED
  - Border radius: 12px
  - Padding: 24px
  - Spacing: 24px between cards
  - Shadow: 0px 1px 3px rgba(0, 0, 0, 0.06)

Card Styling (Dark Theme):
  - Background: #2A2A2A
  - Border: 1px solid #404040
  - Shadow: None

Edit Button:
  - Text: "Edit Profile", 14px Inter Medium
  - Icon: Pencil, 18px, left
  - Style: Outlined primary
  - Height: 40px
  - Hover: Background primary with 0.08 opacity
```

---

### State 4.7.2: Business Settings - Edit Mode

**Trigger**: User clicks "Edit Profile"

**Visual Changes**:
```
Mode Switch:
  - Edit button changes to: "Cancel" (outlined) + "Save Changes" (filled)
  - All editable fields become active (borders visible)
  - Non-editable fields remain grayed out with lock icon
  - Transition: 300ms fade between modes

Editable Fields:
  - Background: Slight tint (editable color)
  - Border: 1px solid outline color
  - On focus: 2px solid primary color
  - Validation: Real-time on blur

Currency Field (Special Case):
  - If transactions exist:
    - Field: Grayed out, lock icon right
    - Tooltip: "Cannot change currency with existing transactions"
    - Hover: Shows tooltip
  - If no transactions:
    - Field: Editable with warning message
    - Warning: "This affects all pricing. Are you sure?"
```

**Save Changes Flow**:
```
Click "Save Changes":
  1. Validate all changed fields
  2. If errors: Show inline error messages, prevent save
  3. If valid: Show confirmation dialog (if critical changes like currency)
  4. Button shows loading state
  5. Save completes
  6. Success toast: "Profile updated"
  7. Return to view mode (fade transition)
```

**Confirmation Dialog (Critical Changes)**:
```
Triggers:
  - Currency change
  - Tax rate changes (if transactions exist)

Dialog:
  - Width: 480px
  - Icon: Warning triangle, 40px
  - Title: "Confirm changes"
  - Message: "[Specific warning about impact]"
  - Checkbox: "I understand this affects existing data"
  - Buttons:
    - Cancel: Outlined
    - Confirm: Filled error color (red)
  - Disabled until checkbox checked
```

---

### State 4.7.3: Location Manager (Post-Setup)

**Access**: Settings → Business Profile → Manage Locations

**Full-Screen Location Manager**:
```
Same interface as Step 3, but:
  - Full application chrome (header, nav, etc.)
  - Breadcrumb: Settings > Business Profile > Locations
  - Back button: Top-left, returns to settings
  - No onboarding context

Additional Features (not in onboarding):
  - Search locations: Text input, filters tree
  - Filter by type: Dropdown (All, Head Office, Regional, Store)
  - Export tree: Button, exports to CSV/PDF
  - Bulk actions: Select multiple, delete/deactivate

Inactive Locations:
  - Soft delete: Not deleted from database
  - Visual: Grayed out in tree, "(Inactive)" label
  - Can be reactivated via edit form
  - Toggle: "Show inactive locations" checkbox
```

---

### State 4.7.4: Location Edit - Advanced Options

**Additional Fields (Post-Setup)**:
```
Form includes (beyond onboarding):
  - Is Active: Toggle switch
  - Location Code: Auto-generated, editable
  - Operating Hours: Time range inputs
  - Assigned Users: Multi-select, shows all users
  - Stock Transfer Rules:
    - Auto-approve transfers: Toggle
    - Approval threshold: Number input (PKR amount)
  - Notifications:
    - Low stock alerts: Toggle
    - Alert threshold: Number (% of min stock)
```

---

### State 4.7.5: Mobile Settings Navigation

**Mobile Layout**:
```
Settings Screen:
  - List of setting categories (cards)
  - Each card: 64px height, tap opens new screen

Business Profile Card:
  - Icon: Building, 24px, left
  - Title: "Business Profile", 16px Inter Medium
  - Subtitle: "Name, currency, locations", 13px, gray
  - Arrow: Right chevron, 20px, right
  - Tap: Opens Business Profile screen

Business Profile Screen (Mobile):
  - Back button: Top-left
  - Title: "Business Profile", centered
  - Edit: Text button, top-right ("Edit")
  - Content: Scrollable cards (full width)
  - Each section: Accordion (collapsible)

Edit Mode (Mobile):
  - Header: "Edit Profile" title
  - Cancel: Top-left
  - Save: Top-right
  - Fields: Full width, 52px height
  - Footer: Sticky save button at bottom
```

---

## Summary

**Part 2 Coverage Complete**:
- ✅ Business Onboarding Wizard (Desktop/Tablet/Mobile)
- ✅ Step 1: Business Information Entry (8 states)
- ✅ Step 2: Currency & Tax Configuration (8 states)
- ✅ Step 3: Location Hierarchy Setup (8 states)
- ✅ Sample Data Options (4 states)
- ✅ Onboarding Complete & Dashboard Entry (3 states)
- ✅ Post-Setup Configuration (5 states)

**Total States Documented**: 36 states across all platforms and themes

**Next Document (Part 3)**: POS & Inventory Setup
- POS first-time setup
- Inventory product addition
- Category management
- Batch & expiry setup
- Stock level configuration
- Customer tier setup

---

**Document Complete**: Part 2 - Business Onboarding & Configuration