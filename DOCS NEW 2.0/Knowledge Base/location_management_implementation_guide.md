# Location Management Implementation Guide

> **Purpose**: This document provides a comprehensive guide for implementing CRUD features in bizPharma using Firebase Data Connect and Flutter with Riverpod. It uses the Location Management feature as a reference implementation.

---

## Table of Contents

1. [Overview](#overview)
2. [Architecture Patterns](#architecture-patterns)
3. [GraphQL Schema & Mutations](#graphql-schema--mutations)
4. [Flutter Implementation](#flutter-implementation)
5. [Riverpod 3.x Patterns](#riverpod-3x-patterns)
6. [Data Connect SDK Usage](#data-connect-sdk-usage)
7. [Common Pitfalls](#common-pitfalls)
8. [Troubleshooting & Gotchas](#troubleshooting--gotchas)
9. [File Structure Reference](#file-structure-reference)

---

## Overview

The Location Management feature demonstrates the standard pattern for implementing CRUD functionality:

- **Schema**: GraphQL types and enums in `dataconnect/schema/`
- **Connector**: Mutations and queries in `dataconnect/connector/`
- **Service Layer**: Dart service class wrapping Data Connect calls
- **Provider Layer**: Riverpod providers for state management
- **UI Layer**: Pages and widgets in the features directory

---

## Architecture Patterns

### Layer Diagram

```
┌─────────────────────────────────────────┐
│              UI Layer                   │
│   (pages, widgets, form modals)         │
├─────────────────────────────────────────┤
│           Provider Layer                │
│   (Riverpod NotifierProvider,           │
│    FutureProvider, etc.)                │
├─────────────────────────────────────────┤
│           Service Layer                 │
│   (location_service.dart)               │
├─────────────────────────────────────────┤
│      Generated SDK Layer                │
│   (dataconnect_generated/biz_pharma.dart)│
├─────────────────────────────────────────┤
│      Firebase Data Connect              │
│   (GraphQL queries/mutations)           │
└─────────────────────────────────────────┘
```

---

## GraphQL Schema & Mutations

### Adding a New Enum Value

**File**: `dataconnect/schema/enums/enums.gql`

```graphql
enum LocationType {
  HEAD_OFFICE
  REGIONAL_OFFICE      # Added new value
  REGIONAL_WAREHOUSE
  RETAIL_STORE
  DISTRIBUTION_CENTER
}
```

> **Important**: Adding enum values is a **breaking change** for Data Connect. Use `--force` flag when deploying.

### Creating a Query

**File**: `dataconnect/connector/queries/locations/get_location_by_id.gql`

```graphql
query GetLocationById($id: UUID!) @auth(level: USER) {
  location(id: $id) {
    id
    businessId
    name
    code
    type
    phone
    email
    operatingHours
    licenseNumber
    isActive
    address {
      line1
      line2
      city
      state
      postalCode
      country
    }
  }
}
```

### Creating a Mutation

**File**: `dataconnect/connector/mutations/locations/update_location.gql`

```graphql
mutation UpdateLocation(
  $id: UUID!
  $name: String
  $code: String
  $type: LocationType
  $phone: String
  $email: String
  $operatingHours: String
  $licenseNumber: String
  $isActive: Boolean
) @auth(level: USER) {
  location_update(
    id: $id
    data: {
      name: $name
      code: $code
      type: $type
      phone: $phone
      email: $email
      operatingHours: $operatingHours
      licenseNumber: $licenseNumber
      isActive: $isActive
    }
  ) {
    id
  }
}
```

### Deploying Schema Changes

```bash
# Check which project is active
firebase use

# Deploy to development project explicitly
firebase deploy --only dataconnect --project bizpharma-4e73a --force

# Regenerate Flutter SDK
firebase dataconnect:sdk:generate
```

> **Note**: The `--force` flag is required for breaking changes (enum additions, field changes).

---

## Flutter Implementation

### Service Layer Pattern

**File**: `lib/services/location_service.dart`

The service layer wraps Data Connect calls and provides a clean API.

```dart
import 'dart:developer';
import '../dataconnect_generated/biz_pharma.dart';

class LocationService {
  /// Get all locations for a business
  Future<List<ListLocationsByBusinessLocations>> getLocationsByBusiness(
      String businessId) async {
    try {
      final result = await BizPharmaConnector.instance
          .listLocationsByBusiness(businessId: businessId)
          .execute();
      return result.data.locations;
    } catch (e) {
      log('Error fetching locations: $e');
      rethrow;
    }
  }

  /// Create a new location using BUILDER PATTERN
  Future<String> createLocation({
    required String businessId,
    required String name,
    required LocationType type,
    String? phone,
    String? email,
  }) async {
    try {
      // Use builder pattern for optional parameters
      final builder = BizPharmaConnector.instance.createLocation(
        businessId: businessId,
        name: name,
        code: _generateLocationCode(name),
        type: type,
      );

      // Set optional parameters using builder methods
      if (phone != null) builder.phone(phone);
      if (email != null) builder.email(email);

      await builder.execute();
      return code;
    } catch (e) {
      log('Error creating location: $e');
      rethrow;
    }
  }
}
```

> **Critical**: Data Connect SDK uses a **builder pattern** for optional parameters. Do NOT pass them as named parameters directly!

---

## Riverpod 3.x Patterns

### ⚠️ Deprecated Patterns (DO NOT USE)

```dart
// ❌ DEPRECATED - StateProvider
final myProvider = StateProvider<String?>((ref) => null);

// ❌ DEPRECATED - StateNotifierProvider
final myProvider = StateNotifierProvider<MyNotifier, MyState>((ref) => MyNotifier());

// ❌ DEPRECATED - extends StateNotifier
class MyNotifier extends StateNotifier<MyState> { }
```

### ✅ Modern Patterns (USE THESE)

```dart
// ✅ Notifier with NotifierProvider
class CurrentLocationNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setLocation(String? locationId) {
    state = locationId;
  }
}

final currentLocationIdProvider =
    NotifierProvider<CurrentLocationNotifier, String?>(
        CurrentLocationNotifier.new);
```

### Provider Types Reference

| Type | Use Case | Example |
|------|----------|---------|
| `Provider<T>` | Simple services, singletons | `Provider<LocationService>` |
| `FutureProvider<T>` | Async data fetching | `FutureProvider<List<Location>>` |
| `FutureProvider.family<T, Arg>` | Async with parameter | `FutureProvider.family<Location, String>` |
| `FutureProvider.autoDispose` | Auto-cleanup when unused | For lists that should refresh |
| `StreamProvider<T>` | Reactive streams | `StreamProvider<User?>` for auth |
| `NotifierProvider<N, T>` | Mutable state | User-editable state |
| `AsyncNotifierProvider` | Async mutable state | CRUD operations with loading states |

### Provider File Structure

**File**: `lib/providers/location_provider.dart`

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/location_service.dart';
import '../dataconnect_generated/biz_pharma.dart';

// Service singleton
final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

// List provider with family parameter
final locationsProvider = FutureProvider.autoDispose
    .family<List<ListLocationsByBusinessLocations>, String>((
  ref,
  businessId,
) async {
  final locationService = ref.watch(locationServiceProvider);
  return await locationService.getLocationsByBusiness(businessId);
});

// Notifier for mutable state
class CurrentLocationNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setLocation(String? id) => state = id;
}

final currentLocationIdProvider =
    NotifierProvider<CurrentLocationNotifier, String?>(
        CurrentLocationNotifier.new);
```

---

## Data Connect SDK Usage

### EnumValue Handling

Data Connect wraps enums in `EnumValue<T>`. Use `.stringValue` to get the string representation:

```dart
// ❌ WRONG - EnumValue doesn't have .name
location.type.name

// ❌ WRONG - .value property doesn't exist on EnumValue
location.type.value

// ✅ CORRECT - Use stringValue
location.type.stringValue  // Returns "RETAIL_STORE"

// ✅ CORRECT - Convert string back to enum for mutations
LocationType.values.byName(_selectedType)
```

### Type Conversions

```dart
// String to LocationType (for mutations)
LocationType type = LocationType.values.byName("RETAIL_STORE");

// EnumValue<LocationType> to String (for display)
String displayType = location.type.stringValue;
```

---

## Common Pitfalls

### 1. Builder Pattern for Optional Parameters

```dart
// ❌ WRONG - Named parameters don't work for optional fields
await BizPharmaConnector.instance.createLocation(
  businessId: id,
  name: name,
  code: code,
  type: type,
  phone: phone,  // ERROR: undefined_named_parameter
);

// ✅ CORRECT - Use builder pattern
final builder = BizPharmaConnector.instance.createLocation(
  businessId: id,
  name: name,
  code: code,
  type: type,
  phone: phone, // This line is not needed in the builder, use the method below
);
if (phone != null) builder.phone(phone);
await builder.execute();
```

### 2. Import Paths in Nested Features

```dart
// Feature path: lib/features/settings/locations/presentation/pages/

// ❌ WRONG - Relative path from feature root
import '../../../../providers/location_provider.dart';

// ✅ CORRECT - Count directories from file location
import '../../../../../providers/location_provider.dart';
```

### 3. Cloud SQL Connection Timeout

If deployment fails with "Connection terminated due to connection timeout":

1. The connector may have still deployed successfully
2. Retry the command - instance warms up after first attempt
3. Check deployment status in Firebase Console

### 4. EnumValue in UI Components

```dart
// Widget receiving EnumValue
Widget _buildTypeBadge(BuildContext context, EnumValue<LocationType> type) {
  return Text(type.stringValue);  // Use stringValue
}
```

---

## Troubleshooting & Gotchas

### 1. AuthWrapper State Staleness after Onboarding

**Issue**: After completing Onboarding (creating business), the app gets stuck on "Loading" because `AuthWrapper` providers (`currentUserProvider`, `businessByIdProvider`) are caching the *old* state (user has no business).

**Fix**: Explicitly invalidate the user provider upon successful onboarding.
```dart
// lib/pages/onboarding/onboarding_stepper.dart
// Inside _submit() after success:

// 1. Force ID Token refresh to get new claims
await user.getIdToken(true);

// 2. Invalidate provider to force re-fetch
ref.invalidate(currentUserProvider);

// 3. Navigate
Navigator.of(context).pushReplacement(...);
```

### 2. 401 Unauthorized "App Check" Issues in Emulator

**Issue**: `GetBusinessById` fails with `401 Unauthorized` even for logged-in users, often accompanied by `App Check: HTTP 400` errors in the console. This happens if the App Check debug token is invalid or if the emulator enforcement is too strict.

**Root Cause**: Incorrect App ID in `lib/firebase_options.dart`.

**Fix**:
1. Run `flutterfire configure --project=YOUR_PROJECT_ID --yes` to regenerate the correct App ID.
2. (Optional) Hot Restart is usually not enough; full app restart is recommended.

**Workaround (Dev Only)**: Relax the query's auth level to `PUBLIC` in the `.gql` file temporarily if App Check is still blocking, but this is **NOT** recommended for production.

```graphql
# dataconnect/connector/queries/core/get_business_by_id.gql
query GetBusinessById($id: UUID!) @auth(level: PUBLIC) { ... }
```

### 3. Data Connect Emulator Panic (Crash) on Schema Load

**Issue**: The Data Connect emulator crashes with `panic: invalid memory address` or `Internal Server Error` (500).

**Cause**: Malformed GraphQL files, specifically incorrectly defined `deleteMany` mutations (e.g. asking for `{ count }` selection set when the schema doesn't support it, or using `where: {}` vs `all: true` incorrectly).

**Fix**:
1. **Delete** the problematic `.gql` files.
2. **Restart** the emulator (`npx firebase emulators:start`) - the crash puts it in an unrecoverable state.
3. Use simple, verified syntax:
   ```graphql
   mutation DeleteAll {
     user_deleteMany(all: true)
     business_deleteMany(all: true)
   }
   ```

### 4. Security Hardening for Production

**Important**: During development, we often relax auth levels to `@auth(level: PUBLIC)` to avoid emulator friction.

**Before Deployment**: You **MUST** revert these to `@auth(level: USER)` or stricter.
Check the following files for `TODO: SECURITY` comments:
- `create_location.gql`
- `update_location.gql`
- `delete_location.gql`
- `list_locations_by_business.gql`
- `get_business_by_id.gql`
- `list_all_businesses.gql`

---

## File Structure Reference

### Complete Feature Structure

```
lib/
├── services/
│   └── location_service.dart        # CRUD operations
├── providers/
│   └── location_provider.dart       # Riverpod providers
├── features/
│   └── settings/
│       └── locations/
│           └── presentation/
│               ├── pages/
│               │   └── locations_page.dart
│               └── widgets/
│                   └── location_form_modal.dart
└── dataconnect_generated/
    └── biz_pharma.dart              # Generated SDK

dataconnect/
├── schema/
│   ├── enums/
│   │   └── enums.gql                # Enum definitions
│   └── locations/
│       └── location.gql             # Location type
└── connector/
    ├── mutations/
    │   └── locations/
    │       ├── create_location.gql
    │       └── update_location.gql
    └── queries/
        └── locations/
        │   ├── list_locations_by_business.gql
        │   └── get_location_by_id.gql
```

### Navigation Integration

**Sidebar**: `lib/features/dashboard/presentation/widgets/sidebar_navigation.dart`

```dart
_buildExpandableModule(
  context,
  Icons.settings,
  'Settings',
  'settings',
  [
    _ModuleItem('Locations', Icons.location_on, route: 'locations'),
    // other items...
  ],
),
```

**Dashboard Routing**: `lib/features/dashboard/presentation/pages/dashboard_page.dart`

```dart
Widget _buildMainContent() {
  switch (_currentRoute) {
    case 'locations':
      return const Expanded(child: LocationsPage());
    // other cases...
  }
}
```

---

## Checklist for New CRUD Features

- [ ] Define/update GraphQL types in `dataconnect/schema/`
- [ ] Create queries in `dataconnect/connector/queries/`
- [ ] Create mutations in `dataconnect/connector/mutations/`
- [ ] Deploy schema: `firebase deploy --only dataconnect --force`
- [ ] Regenerate SDK: `firebase dataconnect:sdk:generate`
- [ ] Create service class in `lib/services/`
- [ ] Create providers in `lib/providers/`
- [ ] Create page and widgets in `lib/features/`
- [ ] Update navigation/routing
- [ ] Run `flutter analyze` to verify

---

*Last updated: December 28, 2025*
*Feature: Location Management Implementation*
