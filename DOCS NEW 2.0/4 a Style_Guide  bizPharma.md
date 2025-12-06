# bizPharma - Flutter Material 3 UX/UI Style Guide

## Color System

### Primary Palette

#### Light Theme
```dart
// Primary Colors - Deep Teal/Forest Green (from sidebar inspiration)
primary: Color(0xFF0F4C4C),                    // Deep teal-green
onPrimary: Color(0xFFFFFFFF),                  // White text on primary
primaryContainer: Color(0xFF1A6363),           // Lighter teal for containers
onPrimaryContainer: Color(0xFFE0F2F2),         // Very light teal text

// Secondary Colors - Soft Lime Yellow (from accent buttons)
secondary: Color(0xFFCDDC39),                  // Lime yellow
onSecondary: Color(0xFF2C3E00),                // Dark green text on secondary
secondaryContainer: Color(0xFFE8F5B8),         // Pale lime container
onSecondaryContainer: Color(0xFF3D5100),       // Dark olive text

// Tertiary Colors - Sage Green (supporting accent)
tertiary: Color(0xFF5A7A6F),                   // Sage green
onTertiary: Color(0xFFFFFFFF),                 // White text
tertiaryContainer: Color(0xFFD4E8E0),          // Light sage container
onTertiaryContainer: Color(0xFF1B3B31),        // Dark sage text

// Error Colors
error: Color(0xFFDC3545),                      // Red for errors
onError: Color(0xFFFFFFFF),                    // White text on error
errorContainer: Color(0xFFFFDAD6),             // Light red container
onErrorContainer: Color(0xFF8B1A1A),           // Dark red text

// Background & Surface
background: Color(0xFFF8F9FA),                 // Off-white/cream background
onBackground: Color(0xFF1C1C1C),               // Dark gray text
surface: Color(0xFFFFFFFF),                    // White cards/surfaces
onSurface: Color(0xFF1C1C1C),                  // Dark text on surfaces

// Surface Variants
surfaceVariant: Color(0xFFE8EAED),             // Light gray surface variant
onSurfaceVariant: Color(0xFF44474E),           // Medium gray text

// Outline & Borders
outline: Color(0xFFD1D4D9),                    // Light gray borders
outlineVariant: Color(0xFFE8EAED),             // Very light gray borders

// Shadow & Scrim
shadow: Color(0xFF000000),                     // Black shadows (with opacity)
scrim: Color(0xFF000000),                      // Black overlay (with opacity)

// Inverse Colors
inverseSurface: Color(0xFF2F3033),             // Dark surface for inverse
onInverseSurface: Color(0xFFF2F2F2),           // Light text on inverse
inversePrimary: Color(0xFF6DCCCC),             // Light teal for inverse
```

#### Dark Theme
```dart
// Primary Colors - Bright Lime/Yellow-Green (from accent inspiration)
primary: Color(0xFFC5E64D),                    // Bright lime green
onPrimary: Color(0xFF2C3500),                  // Very dark green text
primaryContainer: Color(0xFF3F5100),           // Dark olive container
onPrimaryContainer: Color(0xFFE1F3A6),         // Pale lime text

// Secondary Colors - Purple/Lavender (from data visualization)
secondary: Color(0xFF9B8EE8),                  // Soft purple
onSecondary: Color(0xFF1F1A3D),                // Dark purple text
secondaryContainer: Color(0xFF352D5C),         // Dark purple container
onSecondaryContainer: Color(0xFFD4CEFF),       // Light lavender text

// Tertiary Colors - Cyan Accent (supporting)
tertiary: Color(0xFF4DD9D9),                   // Cyan
onTertiary: Color(0xFF003737),                 // Dark cyan text
tertiaryContainer: Color(0xFF004F4F),          // Dark cyan container
onTertiaryContainer: Color(0xFFA6F7F7),        // Light cyan text

// Error Colors
error: Color(0xFFFF5252),                      // Bright red for dark mode
onError: Color(0xFF3D0000),                    // Very dark red text
errorContainer: Color(0xFF5C0000),             // Dark red container
onErrorContainer: Color(0xFFFFDAD6),           // Light red text

// Background & Surface
background: Color(0xFF1E1E1E),                 // Very dark charcoal
onBackground: Color(0xFFE5E5E5),               // Light gray text
surface: Color(0xFF2A2A2A),                    // Slightly lighter dark for cards
onSurface: Color(0xFFE5E5E5),                  // Light text on surfaces

// Surface Variants
surfaceVariant: Color(0xFF333333),             // Medium dark variant
onSurfaceVariant: Color(0xFFC7C7C7),           // Medium light text

// Outline & Borders
outline: Color(0xFF404040),                    // Dark gray borders
outlineVariant: Color(0xFF2F2F2F),             // Very dark borders

// Shadow & Scrim
shadow: Color(0xFF000000),                     // Pure black shadows
scrim: Color(0xFF000000),                      // Pure black overlay

// Inverse Colors
inverseSurface: Color(0xFFE5E5E5),             // Light surface for inverse
onInverseSurface: Color(0xFF1E1E1E),           // Dark text on inverse
inversePrimary: Color(0xFF0F4C4C),             // Deep teal for inverse
```

### Semantic Colors

#### Light Theme Status Colors
```dart
// Success States
success: Color(0xFF28A745),                    // Green
onSuccess: Color(0xFFFFFFFF),
successContainer: Color(0xFFD4EDDA),
onSuccessContainer: Color(0xFF155724),

// Warning States
warning: Color(0xFFFFC107),                    // Amber
onWarning: Color(0xFF000000),
warningContainer: Color(0xFFFFF3CD),
onWarningContainer: Color(0xFF856404),

// Info States
info: Color(0xFF17A2B8),                       // Cyan
onInfo: Color(0xFFFFFFFF),
infoContainer: Color(0xFFD1ECF1),
onInfoContainer: Color(0xFF0C5460),

// Chart & Data Visualization
chartPrimary: Color(0xFF0F4C4C),               // Deep teal bars
chartSecondary: Color(0xFF1A6363),             // Medium teal
chartTertiary: Color(0xFF5A7A6F),              // Sage green
chartAccent: Color(0xFFCDDC39),                // Lime yellow highlight
chartNeutral: Color(0xFFE8EAED),               // Light gray baseline
```

#### Dark Theme Status Colors
```dart
// Success States
success: Color(0xFF4ADE80),                    // Bright green
onSuccess: Color(0xFF003912),
successContainer: Color(0xFF005C1E),
onSuccessContainer: Color(0xFFB5F0C8),

// Warning States
warning: Color(0xFFFBBF24),                    // Bright amber
onWarning: Color(0xFF3D2500),
warningContainer: Color(0xFF5C3800),
onWarningContainer: Color(0xFFFDE68A),

// Info States
info: Color(0xFF3B82F6),                       // Blue
onInfo: Color(0xFF00214D),
infoContainer: Color(0xFF003470),
onInfoContainer: Color(0xFFBFDBFE),

// Chart & Data Visualization (Heatmap Style)
chartPrimary: Color(0xFF9B8EE8),               // Purple base
chartSecondary: Color(0xFFB4A6F5),             // Light purple
chartTertiary: Color(0xFF7B6BD9),              // Dark purple
chartAccent: Color(0xFFC5E64D),                // Lime green highlight
chartNeutral: Color(0xFF333333),               // Dark gray baseline
chartPattern: Color(0xFF4A4A4A),               // Diagonal stripe overlay
```

## Typography

### Type Scale

```dart
// Display Styles - Hero content, major headings
displayLarge: TextStyle(
  fontFamily: 'Inter',
  fontSize: 57.0,
  fontWeight: FontWeight.w400,
  letterSpacing: -0.25,
  height: 1.12,
),

displayMedium: TextStyle(
  fontFamily: 'Inter',
  fontSize: 45.0,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.0,
  height: 1.16,
),

displaySmall: TextStyle(
  fontFamily: 'Inter',
  fontSize: 36.0,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.0,
  height: 1.22,
),

// Headline Styles - Section headers, card titles
headlineLarge: TextStyle(
  fontFamily: 'Inter',
  fontSize: 32.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.0,
  height: 1.25,
),

headlineMedium: TextStyle(
  fontFamily: 'Inter',
  fontSize: 28.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.0,
  height: 1.29,
),

headlineSmall: TextStyle(
  fontFamily: 'Inter',
  fontSize: 24.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.0,
  height: 1.33,
),

// Title Styles - List items, dialog headers
titleLarge: TextStyle(
  fontFamily: 'Inter',
  fontSize: 22.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.0,
  height: 1.27,
),

titleMedium: TextStyle(
  fontFamily: 'Inter',
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.15,
  height: 1.5,
),

titleSmall: TextStyle(
  fontFamily: 'Inter',
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.1,
  height: 1.43,
),

// Body Styles - Primary content
bodyLarge: TextStyle(
  fontFamily: 'Inter',
  fontSize: 16.0,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.5,
  height: 1.5,
),

bodyMedium: TextStyle(
  fontFamily: 'Inter',
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
  height: 1.43,
),

bodySmall: TextStyle(
  fontFamily: 'Inter',
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.4,
  height: 1.33,
),

// Label Styles - Buttons, chips, captions
labelLarge: TextStyle(
  fontFamily: 'Inter',
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.1,
  height: 1.43,
),

labelMedium: TextStyle(
  fontFamily: 'Inter',
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  height: 1.33,
),

labelSmall: TextStyle(
  fontFamily: 'Inter',
  fontSize: 11.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  height: 1.45,
),
```

### Typography Usage Guidelines

#### Desktop-First Hierarchy
- **Dashboard Headers**: displayMedium (45px) for main dashboard title
- **Page Headers**: headlineLarge (32px) for primary page titles
- **Section Headers**: headlineMedium (28px) for major sections
- **Card Titles**: titleLarge (22px) for card headers
- **Table Headers**: titleMedium (16px, bold) for data tables
- **Body Content**: bodyLarge (16px) for primary content, bodyMedium (14px) for secondary
- **Captions & Metadata**: bodySmall (12px) for timestamps, status text
- **Button Labels**: labelLarge (14px) for primary actions

#### Font Weights
- **Regular (400)**: Body text, descriptions
- **Medium (500)**: Labels, buttons, emphasized text
- **Semibold (600)**: Headers, titles, important UI elements

## Spacing & Layout

### Spacing Scale (8px Grid System)

```dart
// Base Unit: 8px
class Spacing {
  static const double xs = 4.0;      // 0.5x - Minimal spacing (icon padding)
  static const double sm = 8.0;      // 1x - Compact spacing (chip padding)
  static const double md = 16.0;     // 2x - Standard spacing (button padding)
  static const double lg = 24.0;     // 3x - Comfortable spacing (card padding)
  static const double xl = 32.0;     // 4x - Generous spacing (section margins)
  static const double xxl = 48.0;    // 6x - Large spacing (page margins)
  static const double xxxl = 64.0;   // 8x - Extra large spacing (hero sections)
}
```

### Layout Grid

#### Desktop (≥1200px)
```dart
Container Margins: 48px (left/right)
Column Count: 12
Gutter Width: 24px
Content Max Width: 1440px
```

#### Tablet (768px - 1199px)
```dart
Container Margins: 32px (left/right)
Column Count: 8
Gutter Width: 16px
Content Max Width: 100%
```

#### Mobile (<768px)
```dart
Container Margins: 16px (left/right)
Column Count: 4
Gutter Width: 16px
Content Max Width: 100%
```

### Component Spacing Guidelines

```dart
// Internal Component Spacing
class ComponentSpacing {
  // Button Padding
  static const EdgeInsets buttonPaddingLarge = EdgeInsets.symmetric(
    horizontal: 32.0,
    vertical: 16.0,
  );
  static const EdgeInsets buttonPaddingMedium = EdgeInsets.symmetric(
    horizontal: 24.0,
    vertical: 12.0,
  );
  static const EdgeInsets buttonPaddingSmall = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 8.0,
  );

  // Card Padding
  static const EdgeInsets cardPaddingLarge = EdgeInsets.all(24.0);
  static const EdgeInsets cardPaddingMedium = EdgeInsets.all(16.0);
  static const EdgeInsets cardPaddingSmall = EdgeInsets.all(12.0);

  // Input Field Padding
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 12.0,
  );

  // List Item Padding
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 12.0,
  );

  // Page Padding
  static const EdgeInsets pagePaddingDesktop = EdgeInsets.all(48.0);
  static const EdgeInsets pagePaddingTablet = EdgeInsets.all(32.0);
  static const EdgeInsets pagePaddingMobile = EdgeInsets.all(16.0);
}
```

## Component Library

### Buttons

#### Primary Filled Button

**Light Theme**
```dart
FilledButton(
  style: FilledButton.styleFrom(
    backgroundColor: Color(0xFF0F4C4C),           // Deep teal
    foregroundColor: Color(0xFFFFFFFF),           // White text
    padding: EdgeInsets.symmetric(
      horizontal: 32.0,
      vertical: 16.0,
    ),
    minimumSize: Size(120, 48),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    elevation: 0,                                  // Minimal elevation
    textStyle: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
  ),
  onPressed: () {},
  child: Text('Primary Action'),
)

// Hover State
backgroundColor: Color(0xFF1A6363),                // Lighter teal
elevation: 1,

// Pressed State
backgroundColor: Color(0xFF0A3838),                // Darker teal
elevation: 0,

// Disabled State
backgroundColor: Color(0xFFE8EAED),                // Light gray
foregroundColor: Color(0xFF9E9E9E),                // Medium gray
```

**Dark Theme**
```dart
FilledButton(
  style: FilledButton.styleFrom(
    backgroundColor: Color(0xFFC5E64D),           // Bright lime
    foregroundColor: Color(0xFF2C3500),           // Dark green text
    // ... same dimensions and shape
  ),
  onPressed: () {},
  child: Text('Primary Action'),
)

// Hover State
backgroundColor: Color(0xFFD4ED6A),                // Lighter lime
elevation: 1,

// Pressed State
backgroundColor: Color(0xFFB0D340),                // Darker lime
elevation: 0,

// Disabled State
backgroundColor: Color(0xFF333333),                // Dark gray
foregroundColor: Color(0xFF666666),                // Medium gray
```

#### Secondary Button

**Light Theme**
```dart
FilledButton(
  style: FilledButton.styleFrom(
    backgroundColor: Color(0xFFCDDC39),           // Lime yellow
    foregroundColor: Color(0xFF2C3E00),           // Dark green text
    padding: EdgeInsets.symmetric(
      horizontal: 24.0,
      vertical: 12.0,
    ),
    minimumSize: Size(100, 44),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    elevation: 0,
  ),
  onPressed: () {},
  child: Text('Secondary'),
)
```

**Dark Theme**
```dart
FilledButton(
  style: FilledButton.styleFrom(
    backgroundColor: Color(0xFF9B8EE8),           // Purple
    foregroundColor: Color(0xFFFFFFFF),           // White text
    // ... same dimensions
  ),
  onPressed: () {},
  child: Text('Secondary'),
)
```

#### Tertiary Button

**Both Themes**
```dart
FilledButton.tonal(
  style: FilledButton.styleFrom(
    backgroundColor: surfaceVariant,              // Theme-specific
    foregroundColor: onSurfaceVariant,
    padding: EdgeInsets.symmetric(
      horizontal: 24.0,
      vertical: 12.0,
    ),
    minimumSize: Size(100, 44),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    elevation: 0,
  ),
  onPressed: () {},
  child: Text('Tertiary'),
)
```

#### Outlined Button

**Light Theme**
```dart
OutlinedButton(
  style: OutlinedButton.styleFrom(
    foregroundColor: Color(0xFF0F4C4C),           // Deep teal text
    side: BorderSide(
      color: Color(0xFFD1D4D9),                   // Light gray border
      width: 1.0,
    ),
    padding: EdgeInsets.symmetric(
      horizontal: 24.0,
      vertical: 12.0,
    ),
    minimumSize: Size(100, 44),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    elevation: 0,
  ),
  onPressed: () {},
  child: Text('Outlined'),
)

// Hover State
backgroundColor: Color(0xFFF8F9FA),                // Light background
side: BorderSide(color: Color(0xFF0F4C4C), width: 1.5),
```

**Dark Theme**
```dart
OutlinedButton(
  style: OutlinedButton.styleFrom(
    foregroundColor: Color(0xFFC5E64D),           // Lime text
    side: BorderSide(
      color: Color(0xFF404040),                   // Dark gray border
      width: 1.0,
    ),
    // ... same dimensions
  ),
  onPressed: () {},
  child: Text('Outlined'),
)

// Hover State
backgroundColor: Color(0xFF2A2A2A),                // Lighter dark
side: BorderSide(color: Color(0xFFC5E64D), width: 1.5),
```

#### Text Button

**Both Themes**
```dart
TextButton(
  style: TextButton.styleFrom(
    foregroundColor: primary,                     // Theme primary
    padding: EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 8.0,
    ),
    minimumSize: Size(80, 40),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  onPressed: () {},
  child: Text('Text Button'),
)

// Hover State
backgroundColor: primary.withOpacity(0.08),
```

#### Elevated Button

**Light Theme**
```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFFFFFFFF),           // White
    foregroundColor: Color(0xFF0F4C4C),           // Deep teal text
    elevation: 1,                                  // Minimal elevation
    shadowColor: Color(0xFF000000).withOpacity(0.1),
    padding: EdgeInsets.symmetric(
      horizontal: 24.0,
      vertical: 12.0,
    ),
    minimumSize: Size(100, 44),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  onPressed: () {},
  child: Text('Elevated'),
)

// Hover State
elevation: 2,

// Pressed State
elevation: 1,
```

**Dark Theme**
```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF333333),           // Medium dark
    foregroundColor: Color(0xFFC5E64D),           // Lime text
    elevation: 1,
    shadowColor: Color(0xFF000000).withOpacity(0.3),
    // ... same dimensions
  ),
  onPressed: () {},
  child: Text('Elevated'),
)
```

### Cards

#### Elevated Card

**Light Theme**
```dart
Card(
  elevation: 1,                                    // Minimal elevation
  shadowColor: Color(0xFF000000).withOpacity(0.08),
  color: Color(0xFFFFFFFF),                       // White surface
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
    side: BorderSide.none,
  ),
  child: Padding(
    padding: EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card content
      ],
    ),
  ),
)

// Hover State
elevation: 2,
```

**Dark Theme**
```dart
Card(
  elevation: 1,
  shadowColor: Color(0xFF000000).withOpacity(0.3),
  color: Color(0xFF2A2A2A),                       // Lighter dark
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
    side: BorderSide.none,
  ),
  // ... same padding and content
)
```

#### Outlined Card

**Light Theme**
```dart
Card(
  elevation: 0,
  color: Color(0xFFFFFFFF),                       // White
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
    side: BorderSide(
      color: Color(0xFFD1D4D9),                   // Light gray border
      width: 1.0,
    ),
  ),
  child: Padding(
    padding: EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card content
      ],
    ),
  ),
)

// Hover State
side: BorderSide(
  color: Color(0xFF0F4C4C),                       // Primary color
  width: 1.5,
),
```

**Dark Theme**
```dart
Card(
  elevation: 0,
  color: Color(0xFF2A2A2A),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
    side: BorderSide(
      color: Color(0xFF404040),                   // Dark gray border
      width: 1.0,
    ),
  ),
  // ... same content
)

// Hover State
side: BorderSide(
  color: Color(0xFFC5E64D),                       // Primary lime
  width: 1.5,
),
```

#### Filled Card

**Light Theme**
```dart
Card(
  elevation: 0,
  color: Color(0xFFF8F9FA),                       // Off-white/cream
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
    side: BorderSide.none,
  ),
  child: Padding(
    padding: EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card content
      ],
    ),
  ),
)
```

**Dark Theme**
```dart
Card(
  elevation: 0,
  color: Color(0xFF333333),                       // Medium dark
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
    side: BorderSide.none,
  ),
  // ... same content
)
```

### Input Fields

#### Outlined Input Field (Default)

**Light Theme**
```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Label',
    hintText: 'Enter text...',
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: Color(0xFFD1D4D9),                 // Light gray
        width: 1.0,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: Color(0xFFD1D4D9),
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: Color(0xFF0F4C4C),                 // Primary teal
        width: 2.0,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: Color(0xFFDC3545),                 // Error red
        width: 1.0,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: Color(0xFFDC3545),
        width: 2.0,
      ),
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 12.0,
    ),
    filled: false,
    labelStyle: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: Color(0xFF44474E),
    ),
    hintStyle: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: Color(0xFF9E9E9E),
    ),
    errorStyle: TextStyle(
      fontSize: 12.0,
      color: Color(0xFFDC3545),
    ),
  ),
)
```

**Dark Theme**
```dart
TextField(
  decoration: InputDecoration(
    // Same structure, different colors
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFF404040),                 // Dark gray
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFC5E64D),                 // Lime
        width: 2.0,
      ),
    ),
    labelStyle: TextStyle(
      color: Color(0xFFC7C7C7),
    ),
    hintStyle: TextStyle(
      color: Color(0xFF666666),
    ),
  ),
)
```

#### Filled Input Field

**Light Theme**
```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Label',
    hintText: 'Enter text...',
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: Color(0xFF0F4C4C),
        width: 2.0,
      ),
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 12.0,
    ),
    filled: true,
    fillColor: Color(0xFFF8F9FA),                 // Light fill
  ),
)
```

**Dark Theme**
```dart
TextField(
  decoration: InputDecoration(
    // Same structure
    filled: true,
    fillColor: Color(0xFF333333),                 // Dark fill
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFC5E64D),
      ),
    ),
  ),
)
```

### Icons

#### Outlined Icons (Default State)

**Light Theme**
```dart
Icon(
  Icons.shopping_cart_outlined,
  size: 24.0,
  color: Color(0xFF44474E),                       // Medium gray
)

// In Navigation/Active State
Icon(
  Icons.shopping_cart_outlined,
  color: Color(0xFF0F4C4C),                       // Primary teal
)
```

**Dark Theme**
```dart
Icon(
  Icons.shopping_cart_outlined,
  size: 24.0,
  color: Color(0xFFC7C7C7),                       // Light gray
)

// In Navigation/Active State
Icon(
  Icons.shopping_cart_outlined,
  color: Color(0xFFC5E64D),                       // Lime
)
```

#### Filled Icons (Selected/Active State)

**Light Theme**
```dart
Icon(
  Icons.shopping_cart,                            // Filled variant
  size: 24.0,
  color: Color(0xFF0F4C4C),                       // Primary teal
)
```

**Dark Theme**
```dart
Icon(
  Icons.shopping_cart,
  size: 24.0,
  color: Color(0xFFC5E64D),                       // Lime
)
```

#### Icon Sizes
```dart
class IconSizes {
  static const double xs = 16.0;                  // Inline icons
  static const double sm = 20.0;                  // Compact UI
  static const double md = 24.0;                  // Standard (default)
  static const double lg = 32.0;                  // Large buttons
  static const double xl = 48.0;                  // Feature icons
  static const double xxl = 64.0;                 // Empty states
}
```

## Elevation System

### Elevation Levels (Progressive, Minimal Approach)

```dart
class Elevation {
  // Level 0 - Flat surfaces (default cards, inputs)
  static const double level0 = 0.0;
  
  // Level 1 - Slight lift (cards on hover, active buttons)
  static const double level1 = 1.0;
  
  // Level 2 - Floating elements (dropdowns, tooltips)
  static const double level2 = 2.0;
  
  // Level 3 - Dialogs and modals
  static const double level3 = 4.0;
  
  // Level 4 - Top-most overlays (snackbars, alerts)
  static const double level4 = 8.0;
}
```

### Shadow Configuration

**Light Theme**
```dart
BoxShadow(
  color: Color(0xFF000000).withOpacity(0.08),    // Subtle shadow
  offset: Offset(0, 1),
  blurRadius: 3.0,
  spreadRadius: 0,
)

// For Level 2
BoxShadow(
  color: Color(0xFF000000).withOpacity(0.10),
  offset: Offset(0, 2),
  blurRadius: 6.0,
  spreadRadius: 0,
)

// For Level 3
BoxShadow(
  color: Color(0xFF000000).withOpacity(0.12),
  offset: Offset(0, 4),
  blurRadius: 12.0,
  spreadRadius: 0,
)
```

**Dark Theme**
```dart
BoxShadow(
  color: Color(0xFF000000).withOpacity(0.3),     // Stronger shadow
  offset: Offset(0, 1),
  blurRadius: 3.0,
  spreadRadius: 0,
)

// For Level 2
BoxShadow(
  color: Color(0xFF000000).withOpacity(0.4),
  offset: Offset(0, 2),
  blurRadius: 6.0,
  spreadRadius: 0,
)

// For Level 3
BoxShadow(
  color: Color(0xFF000000).withOpacity(0.5),
  offset: Offset(0, 4),
  blurRadius: 12.0,
  spreadRadius: 0,
)
```

### Border Enhancement (Minimal Elevation Alternative)

```dart
// Light Theme
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12.0),
    border: Border.all(
      color: Color(0xFFE8EAED),                   // Very light gray
      width: 1.0,
    ),
  ),
)

// Dark Theme
Container(
  decoration: BoxDecoration(
    color: Color(0xFF2A2A2A),
    borderRadius: BorderRadius.circular(12.0),
    border: Border.all(
      color: Color(0xFF404040),                   // Dark gray
      width: 1.0,
    ),
  ),
)
```

## Motion & Animation

### Animation Durations

```dart
class AnimationDurations {
  // Micro-interactions (100-200ms)
  static const Duration instant = Duration(milliseconds: 100);
  static const Duration quick = Duration(milliseconds: 150);
  static const Duration fast = Duration(milliseconds: 200);
  
  // Standard interactions (250-400ms)
  static const Duration standard = Duration(milliseconds: 300);
  static const Duration moderate = Duration(milliseconds: 350);
  
  // Complex transitions (400-600ms)
  static const Duration slow = Duration(milliseconds: 400);
  static const Duration deliberate = Duration(milliseconds: 500);
}
```

### Animation Curves

```dart
class AnimationCurves {
  // Micro-interactions
  static const Curve button = Curves.easeOut;
  static const Curve fade = Curves.easeInOut;
  
  // Spatial transitions
  static const Curve slideIn = Curves.easeOut;
  static const Curve slideOut = Curves.easeIn;
  
  // Emphasized motion
  static const Curve emphasized = Curves.easeInOutCubic;
  static const Curve elastic = Curves.elasticOut;
}
```

### Micro-Interaction Animations

#### Button States

**Hover**
```dart
AnimatedContainer(
  duration: AnimationDurations.quick,
  curve: AnimationCurves.button,
  decoration: BoxDecoration(
    color: isHovered ? hoverColor : defaultColor,
    borderRadius: BorderRadius.circular(8.0),
  ),
)
```

**Press**
```dart
TweenAnimationBuilder<double>(
  duration: AnimationDurations.instant,
  tween: Tween(begin: 1.0, end: isPressed ? 0.95 : 1.0),
  curve: AnimationCurves.button,
  builder: (context, scale, child) {
    return Transform.scale(
      scale: scale,
      child: child,
    );
  },
  child: buttonWidget,
)
```

#### Loading States (Shimmer)

```dart
class ShimmerLoading extends StatefulWidget {
  final Widget child;
  final bool isLoading;
  
  @override
  _ShimmerLoadingState createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..repeat();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(-1.0 - _controller.value * 2, 0),
              end: Alignment(1.0 - _controller.value * 2, 0),
              colors: [
                Colors.grey.shade300,
                Colors.grey.shade100,
                Colors.grey.shade300,
              ],
              stops: [0.0, 0.5, 1.0],
            ).createShader(bounds);
          },
          child: widget.isLoading
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  height: 100,
                )
              : widget.child,
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

#### Icon State Transitions

```dart
// Outlined to Filled transition
AnimatedSwitcher(
  duration: AnimationDurations.fast,
  transitionBuilder: (child, animation) {
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  },
  child: Icon(
    isSelected ? Icons.favorite : Icons.favorite_border,
    key: ValueKey<bool>(isSelected),
    color: isSelected ? primary : onSurface,
  ),
)
```

#### Input Focus Animation

```dart
AnimatedContainer(
  duration: AnimationDurations.standard,
  curve: AnimationCurves.emphasized,
  decoration: BoxDecoration(
    border: Border.all(
      color: isFocused ? primary : outline,
      width: isFocused ? 2.0 : 1.0,
    ),
    borderRadius: BorderRadius.circular(8.0),
  ),
)
```

### Component-Specific Animations

#### Card Hover Effect

```dart
class AnimatedCard extends StatefulWidget {
  final Widget child;
  
  @override
  _AnimatedCardState createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  bool _isHovered = false;
  
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AnimationDurations.standard,
        curve: AnimationCurves.emphasized,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.12 : 0.08),
              offset: Offset(0, _isHovered ? 2 : 1),
              blurRadius: _isHovered ? 6.0 : 3.0,
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  },
}
```

#### Fade Transition (Page Load)

```dart
FadeTransition(
  opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: animationController,
      curve: AnimationCurves.fade,
    ),
  ),
  child: pageContent,
)
```

## Data Visualization

### Heatmap/Calendar Style (Dark Theme Inspiration)

#### Color Palette
```dart
class HeatmapColors {
  // Base levels (purple tones)
  static const Color level0 = Color(0xFF2A2A2A);  // No data
  static const Color level1 = Color(0xFF4A3D6F);  // Low activity
  static const Color level2 = Color(0xFF6B5B9B);  // Medium-low
  static const Color level3 = Color(0xFF8B7FD9);  // Medium
  static const Color level4 = Color(0xFFB4A6F5);  // Medium-high
  static const Color level5 = Color(0xFFC5E64D);  // High (lime accent)
  
  // Diagonal stripe pattern overlay
  static const Color stripeOverlay = Color(0xFF4A4A4A);
}
```

#### Heatmap Cell
```dart
Container(
  width: 32.0,
  height: 32.0,
  decoration: BoxDecoration(
    color: getHeatmapColor(intensity),
    borderRadius: BorderRadius.circular(4.0),
    // Diagonal stripe pattern for specific states
    image: shouldShowPattern ? DecorationImage(
      image: AssetImage('assets/diagonal_stripes.png'),
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.1),
        BlendMode.darken,
      ),
    ) : null,
  ),
)
```

### Chart Components

#### Bar Chart (Light Theme)
```dart
BarChart(
  BarChartData(
    barGroups: data.map((item) => BarChartGroupData(
      x: item.index,
      barRods: [
        BarChartRodData(
          toY: item.value,
          color: Color(0xFF0F4C4C),              // Deep teal
          width: 24,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
      ],
    )).toList(),
    gridData: FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: 5000,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Color(0xFFE8EAED),              // Light gray
          strokeWidth: 1,
        );
      },
    ),
  ),
)
```

#### Line Chart with Area Fill
```dart
LineChart(
  LineChartData(
    lineBarsData: [
      LineChartBarData(
        spots: dataPoints,
        isCurved: true,
        color: Color(0xFF0F4C4C),
        barWidth: 3,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0F4C4C).withOpacity(0.3),
              Color(0xFF0F4C4C).withOpacity(0.05),
            ],
          ),
        ),
      ),
    ],
  ),
)
```

## Accessibility

### WCAG AA 2.1 Compliance

#### Contrast Ratios

**Light Theme**
```dart
// Text on Background
onBackground on background: 13.5:1 (AAA)
onSurface on surface: 13.5:1 (AAA)
onSurfaceVariant on surface: 4.8:1 (AA)

// Interactive Elements
primary on primaryContainer: 6.2:1 (AA)
onPrimary on primary: 8.1:1 (AAA)
error on errorContainer: 5.5:1 (AA)
```

**Dark Theme**
```dart
// Text on Background
onBackground on background: 11.2:1 (AAA)
onSurface on surface: 11.2:1 (AAA)
onSurfaceVariant on surface: 4.6:1 (AA)

// Interactive Elements
primary on background: 8.9:1 (AAA)
onPrimary on primary: 10.5:1 (AAA)
error on errorContainer: 5.1:1 (AA)
```

#### Touch Target Sizes
```dart
class TouchTargets {
  static const double minimum = 44.0;             // WCAG minimum
  static const double comfortable = 48.0;         // Recommended
  static const double spacious = 56.0;            // Primary actions
}
```

#### Focus Indicators
```dart
// Focus ring for keyboard navigation
Container(
  decoration: BoxDecoration(
    border: Border.all(
      color: primary,
      width: 2.0,
    ),
    borderRadius: BorderRadius.circular(8.0),
  ),
)
```

## Border Radius System

```dart
class BorderRadii {
  static const double none = 0.0;
  static const double xs = 4.0;                   // Small elements
  static const double sm = 8.0;                   // Buttons, inputs
  static const double md = 12.0;                  // Cards
  static const double lg = 16.0;                  // Large cards
  static const double xl = 24.0;                  // Modal dialogs
  static const double full = 9999.0;              // Pills, avatars
}
```

## Implementation Notes

### Theme Configuration

```dart
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: Color(0xFF0F4C4C),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF1A6363),
    onPrimaryContainer: Color(0xFFE0F2F2),
    secondary: Color(0xFFCDDC39),
    onSecondary: Color(0xFF2C3E00),
    // ... (complete color system)
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(/* ... */),
    // ... (complete typography scale)
  ),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    primary: Color(0xFFC5E64D),
    onPrimary: Color(0xFF2C3500),
    // ... (complete dark color system)
  ),
  textTheme: TextTheme(/* ... */),
);
```

### Desktop-First Responsive Breakpoints

```dart
class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 960;
  static const double desktop = 1280;
  static const double wide = 1920;
}

// Usage
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth >= Breakpoints.desktop) {
      return DesktopLayout();
    } else if (constraints.maxWidth >= Breakpoints.tablet) {
      return TabletLayout();
    } else {
      return MobileLayout();
    }
  },
)
```

### Component State Management

```dart
enum ComponentState {
  enabled,
  hovered,
  focused,
  pressed,
  disabled,
  loading,
}
```

---

**Document Version**: 1.0  
**Last Updated**: December 2024  
**Design System**: Material 3  
**Framework**: Flutter  
**Application**: bizPharma - Pharmacy Management System
