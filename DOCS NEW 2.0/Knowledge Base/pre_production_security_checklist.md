# Pre-Production Security Checklist & Audit

**Target:** Production Readiness
**Scope:** Data Connect Security & Access Control
**Status:** 🔴 PENDING (High Risk if deployed as-is)

## Executive Summary
During the "Product Catalog Phase 2" development, we utilized `@auth(level: PUBLIC)` to facilitate local testing with the Firebase Emulator. This allows any client (authenticated or not) to read/write data. **This must be reverted before any deployment to a public environment (Staging or Production).**

## 1. Critical Actions: Revert `@auth` Levels

The following files are currently set to `PUBLIC`. They must be changed to `USER` (or `ADMIN` if applicable roles exist) to ensure only authenticated users can access them.

### A. Core Business Mutations (High Risk)
These allow data modification. Leaving them public allows anyone to corrupt your database.

- [ ] [dataconnect/connector/mutations/products/create_product.gql](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/dataconnect/connector/mutations/products/create_product.gql)
    - **Action**: Change to `@auth(level: USER)`
- [ ] [dataconnect/connector/mutations/products/create_category.gql](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/dataconnect/connector/mutations/products/create_category.gql)
    - **Action**: Change to `@auth(level: USER)`
- [ ] [dataconnect/connector/mutations/locations/create_location.gql](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/dataconnect/connector/mutations/locations/create_location.gql)
    - **Action**: Change to `@auth(level: USER)`
- [ ] [dataconnect/connector/mutations/core/create_user.gql](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/dataconnect/connector/mutations/core/create_user.gql)
    - **Action**: Change to `@auth(level: USER)`

### B. Core Business Queries (Data Leak Risk)
These allow data retrieval. Leaving them public exposes business data.

- [ ] [dataconnect/connector/queries/products/list_products_by_business.gql](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/dataconnect/connector/queries/products/list_products_by_business.gql)
    - **Action**: Change to `@auth(level: USER)`
- [ ] [dataconnect/connector/queries/products/list_categories_by_business.gql](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/dataconnect/connector/queries/products/list_categories_by_business.gql)
    - **Action**: Change to `@auth(level: USER)`
- [ ] [dataconnect/connector/queries/locations/list_locations_by_business.gql](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/dataconnect/connector/queries/locations/list_locations_by_business.gql)
    - **Action**: Change to `@auth(level: USER)`
- [ ] [dataconnect/connector/queries/core/get_business_by_id.gql](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/dataconnect/connector/queries/core/get_business_by_id.gql)
    - **Action**: Change to `@auth(level: USER)`
- [ ] [dataconnect/connector/queries/core/get_user_business_details.gql](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/dataconnect/connector/queries/core/get_user_business_details.gql)
    - **Action**: Change to `@auth(level: USER)`

### C. Onboarding & Special Access
These flows are sensitive because they often involve anonymous users converting to authenticated users.

- [ ] [dataconnect/connector/mutations/admin/onboarding.gql](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/dataconnect/connector/mutations/admin/onboarding.gql)
    - **Context**: Used during initial setup.
    - **Action**: Verify if `USER` level works for Anonymous users (Firebase Auth "Anonymous" counts as `USER`). If so, switch to `@auth(level: USER)`.
- [ ] [dataconnect/connector/queries/core/get_user_by_auth_id.gql](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/dataconnect/connector/queries/core/get_user_by_auth_id.gql)
    - **Context**: Often used to check if a user exists.
    - **Action**: Change to `@auth(level: USER)`.

## 2. Admin & Debug Utilities (Dangerous)

These files exist solely for testing and should NEVER be exposed in production.

### Action: DELETE or RESTRICT to Admin-Only (if roles supported)
- [ ] [dataconnect/connector/mutations/core/delete_all_businesses.gql](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/dataconnect/connector/mutations/core/delete_all_businesses.gql)
- [ ] [dataconnect/connector/mutations/core/delete_all_users.gql](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/dataconnect/connector/mutations/core/delete_all_users.gql)
- [ ] [dataconnect/connector/mutations/locations/delete_all_locations.gql](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/dataconnect/connector/mutations/locations/delete_all_locations.gql)
- [ ] [dataconnect/connector/queries/core/list_all_businesses.gql](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/dataconnect/connector/queries/core/list_all_businesses.gql)
- [ ] [dataconnect/connector/queries/core/list_all_users.gql](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/dataconnect/connector/queries/core/list_all_users.gql)
- [ ] [dataconnect/connector/queries/products/list_all_products.gql](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/dataconnect/connector/queries/products/list_all_products.gql)
- [ ] [dataconnect/connector/queries/admin/verify_product.gql](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/dataconnect/connector/queries/admin/verify_product.gql)

**Recommendation**: delete these files entirely from the production build, or move them to a generic `admin/` folder that is excluded from the production connector configuration if possible.

## 3. Additional Security Verifications

- [ ] **Data Validation**: Ensure strict types (like the UUID fix we implemented) are enforced in the Application Layer (Dart) as well, since Data Connect might rely on Postgres to catch them (which results in ugly errors).
- [ ] **App Check**: Ensure Firebase App Check is enabled and enforced for the Data Connect service in the Firebase Console to prevent abuse from non-app sources.
- [ ] **IAM Policies**: Verify that the Service Account used by the Backend (if applicable) has the minimal required permissions (Least Privilege).
