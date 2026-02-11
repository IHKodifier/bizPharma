# Navigation Architecture Guide

> **Purpose**: This document explains how navigation works in the bizPharma Flutter application, from authentication routing to in-app content switching.

---

## Table of Contents

1. [Navigation Flow Overview](#navigation-flow-overview)
2. [Route Decision Tree](#route-decision-tree)
3. [Key Components](#key-components)
4. [Dashboard Internal Routing](#dashboard-internal-routing)
5. [Adding New Routes](#adding-new-routes)
6. [Code Examples](#code-examples)

---

## Navigation Flow Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              main.dart                                       │
│                         MaterialApp(home: AuthWrapper)                       │
└───────────────────────────────────┬─────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                           AuthWrapper                                        │
│                    (lib/widgets/auth_wrapper.dart)                          │
│                                                                              │
│   Watches: authStateProvider (Firebase Auth stream)                         │
│                                                                              │
│   ┌──────────────────────────────────────────────────────────────────────┐  │
│   │                                                                      │  │
│   │  if (firebaseUser == null)  ──────────▶  LandingPage                │  │
│   │                                          (public marketing page)     │  │
│   │                                                                      │  │
│   │  if (firebaseUser != null)  ──────────▶  Check Data Connect...      │  │
│   │                                                                      │  │
│   │      if (dcUser == null || no business) ──▶  OnboardingStepper      │  │
│   │                                              (create business/user)  │  │
│   │                                                                      │  │
│   │      if (dcUser exists + business) ───────▶  AppHomePage            │  │
│   │                                              (authenticated shell)   │  │
│   │                                                                      │  │
│   └──────────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                          DashboardPage                                       │
│       (lib/features/dashboard/presentation/pages/dashboard_page.dart)       │
│                                                                              │
│   Layout: Row([Sidebar, MainContent])                                       │
│                                                                              │
│   State: _currentRoute = 'dashboard' | 'inventory' | 'locations' | ...      │
│                                                                              │
│   ┌────────────────────────────────────────────────────────────────────┐    │
│   │                     SidebarNavigation                              │    │
│   │   onItemSelected(route) ──────▶ setState(_currentRoute = route)   │    │
│   └────────────────────────────────────────────────────────────────────┘    │
│                                                                              │
│   ┌────────────────────────────────────────────────────────────────────┐    │
│   │                     _buildMainContent()                            │    │
│   │   switch (_currentRoute) → renders appropriate page widget        │    │
│   └────────────────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Route Decision Tree

```
User opens app
    │
    ▼
AuthWrapper checks Firebase Auth
    │
    ├── No Firebase user ──────────────▶ LandingPage
    │                                    (marketing/login page)
    │
    └── Firebase user exists
            │
            ▼
        Fetch Data Connect user profile
            │
            ├── No DC user OR no businessId ──▶ OnboardingStepper
            │                                   (new user registration)
            │
            └── DC user + businessId exists
                    │
                    ▼
                Fetch Business details
                    │
                    ├── Business found ──────▶ AppHomePage → DashboardPage
                    │
                    └── Business not found ──▶ Error screen
```

---

## Key Components

| Component | File Path | Responsibility |
|-----------|-----------|----------------|
| **AuthWrapper** | `lib/widgets/auth_wrapper.dart` | Root routing based on auth state |
| **AppHomePage** | `lib/app_home_page.dart` | Simple auth check wrapper |
| **DashboardPage** | `lib/features/dashboard/presentation/pages/dashboard_page.dart` | Main app shell with sidebar |
| **SidebarNavigation** | `lib/features/dashboard/presentation/widgets/sidebar_navigation.dart` | Navigation menu items |
| **LandingPage** | `lib/pages/landing/landing_page.dart` | Public marketing page |
| **OnboardingStepper** | `lib/pages/onboarding/onboarding_stepper.dart` | New user registration |

---

## Dashboard Internal Routing

The DashboardPage uses a **single-page app pattern** with setState-based routing:

### State Variables

```dart
class _DashboardPageState extends ConsumerState<DashboardPage> {
  bool _isSidebarCollapsed = false;
  String _currentRoute = 'dashboard';  // Current active route
}
```

### Route Handler

```dart
void _onItemSelected(String route) {
  setState(() {
    _currentRoute = route;
  });
}
```

### Content Switch

```dart
Widget _buildMainContent() {
  switch (_currentRoute) {
    case 'inventory':
      return const Expanded(
        child: SingleChildScrollView(child: InventoryPage()),
      );
    case 'locations':
      return const Expanded(child: LocationsPage());
    case 'dashboard':
    default:
      return const DashboardContent();
  }
}
```

### Available Routes

| Route String | Page Widget | Sidebar Location |
|--------------|-------------|------------------|
| `'dashboard'` | `DashboardContent` | Dashboard (top-level) |
| `'inventory'` | `InventoryPage` | Inventory → Stock Levels |
| `'locations'` | `LocationsPage` | Settings → Locations |

---

## Adding New Routes

### Step 1: Create the Page Widget

```dart
// lib/features/my_feature/presentation/pages/my_feature_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyFeaturePage extends ConsumerWidget {
  const MyFeaturePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: Text('My Feature Page'));
  }
}
```

### Step 2: Import in DashboardPage

```dart
// lib/features/dashboard/presentation/pages/dashboard_page.dart

import '../../../my_feature/presentation/pages/my_feature_page.dart';
```

### Step 3: Add Case in _buildMainContent()

```dart
Widget _buildMainContent() {
  switch (_currentRoute) {
    case 'inventory':
      return const Expanded(child: SingleChildScrollView(child: InventoryPage()));
    case 'locations':
      return const Expanded(child: LocationsPage());
    case 'my-feature':  // ADD THIS
      return const Expanded(child: MyFeaturePage());
    case 'dashboard':
    default:
      return const DashboardContent();
  }
}
```

### Step 4: Add Sidebar Menu Item

```dart
// lib/features/dashboard/presentation/widgets/sidebar_navigation.dart

// Option A: Top-level nav item
_buildNavItem(
  context, 
  Icons.star, 
  'My Feature',
  isSelected: _currentRoute == 'my-feature',
  onTap: () {
    setState(() => _currentRoute = 'my-feature');
    widget.onItemSelected('my-feature');
  },
),

// Option B: Under expandable module
_buildExpandableModule(
  context,
  Icons.settings,
  'Settings',
  'settings',
  [
    _ModuleItem('Locations', Icons.location_on, route: 'locations'),
    _ModuleItem('My Feature', Icons.star, route: 'my-feature'),  // ADD THIS
  ],
),
```

---

## Code Examples

### SidebarNavigation Structure

```dart
class SidebarNavigation extends ConsumerStatefulWidget {
  final bool isCollapsed;
  final VoidCallback onToggleCollapse;
  final Function(String route) onItemSelected;  // Callback to parent

  // ...
}

class _SidebarNavigationState extends ConsumerState<SidebarNavigation> {
  String? _expandedModule;  // Currently expanded accordion
  String _currentRoute = 'dashboard';  // For highlighting

  // Top-level nav item
  _buildNavItem(
    context,
    Icons.dashboard,
    'Dashboard',
    isSelected: _currentRoute == 'dashboard',
    onTap: () {
      setState(() => _currentRoute = 'dashboard');
      widget.onItemSelected('dashboard');  // Notify parent
    },
  ),

  // Expandable module with sub-items
  _buildExpandableModule(
    context,
    Icons.settings,
    'Settings',
    'settings',
    [
      _ModuleItem('Locations', Icons.location_on, route: 'locations'),
      _ModuleItem('Business Profile', Icons.business),  // No route = not clickable
    ],
  ),
}
```

### _ModuleItem Class

```dart
class _ModuleItem {
  final String title;
  final IconData icon;
  final String? route;  // If null, item is display-only

  _ModuleItem(this.title, this.icon, {this.route});
}
```

---

## Design Pattern Summary

| Aspect | Pattern Used |
|--------|--------------|
| **Auth Routing** | Reactive (Riverpod providers + `.when()`) |
| **Main Content Routing** | StatefulWidget with switch statement |
| **Sidebar State** | Local StatefulWidget state |
| **URL/Deep Linking** | Not implemented (SPA style) |
| **Navigation Method** | Callback-based (`onItemSelected`) |

---

## Potential Improvements

1. **go_router integration** - For proper URL-based routing and deep linking
2. **Route constants** - Define routes in a central file instead of strings
3. **Breadcrumbs** - Show current location path for nested items
4. **Mobile drawer** - Sidebar converts to drawer on small screens

---

*Last updated: December 28, 2025*
