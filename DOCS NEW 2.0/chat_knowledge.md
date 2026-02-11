# Chat Knowledge Log - bizPharma

## Session Documentation

### 2026-02-05T08:25:00+05:00 - Session: Debugging Staging Auth (401 Unauthorized)

**Goal:** Resolve `401 Unauthorized` errors in Staging environment during anonymous user sign-up flow.

**Proceedings:**
1. Initially suspected backend deployment mismatch - deployed Data Connect to Staging
2. Investigated App Check enforcement - confirmed it was in "Monitoring" mode (unenforced)
3. Checked IAM permissions - added missing `Firebase Admin SDK Administrator Service Agent` role
4. Compared Production vs Dev code using GitHub CLI
5. Discovered Production uses `@auth(level: PUBLIC)` while Dev uses `@auth(level: USER)`
6. Researched Firebase Data Connect auth levels documentation
7. Identified root cause: `@auth(level: USER)` excludes anonymous users
8. Changed to `@auth(level: USER_ANON)` for onboarding operations

**What Worked:**
- ✅ Comparing Production (working) vs Dev (failing) code to identify differences
- ✅ Using GitHub CLI to view deployed schema in main branch
- ✅ Web search for Firebase Data Connect auth level documentation
- ✅ Systematic elimination of potential causes (App Check, IAM, Identity Platform)

**What Didn't:**
- ❌ Adding IAM roles didn't fix the issue (was not an IAM problem)
- ❌ Waiting for IAM propagation was unnecessary (wrong diagnosis)
- ❌ Attempting to change auth level to PUBLIC (defeats auth unification purpose)

**Gotchas:**
1. **Firebase Data Connect Auth Levels:**
   - `@auth(level: USER)` **excludes** anonymous Firebase Auth users
   - `@auth(level: USER_ANON)` **includes** anonymous Firebase Auth users
   - `@auth(level: PUBLIC)` allows unauthenticated access (no Firebase Auth required)

2. **Production ≠ Dev:** Production was using `@auth(level: PUBLIC)` which masked the issue during initial development

3. **GCP Quota Limits:** Cloud Billing API has rate limits (400 requests/minute) - wait 1-2 minutes between deployment attempts

4. **Anonymous Users ARE Authenticated:** Anonymous Firebase Auth users have valid tokens, but Data Connect treats them differently based on auth level

**Agent Directives:**
1. **Always check auth levels first** when debugging 401 errors with anonymous users
2. **Use `USER_ANON` for onboarding operations** that need to support anonymous trial flows
3. **Compare Production vs Dev** when Production works but Dev doesn't
4. **Read Firebase documentation** for subtle differences in auth behavior
5. **Don't assume IAM is always the issue** - check schema directives first

**Files Modified:**
- `dataconnect/connector/queries/core/get_user_by_auth_id.gql` → Changed to `USER_ANON`
- `dataconnect/connector/mutations/admin/onboarding.gql` → Changed to `USER_ANON`
- Created `DOCS NEW 2.0/project_memory.md` with critical gotchas
- Created `DOCS NEW 2.0/Knowledge Base/firebase_dataconnect_auth_levels_gotcha.md`

**Status:** ✅ **RESOLVED - Verified in Staging (2026-02-06)**

**Solution Summary:**
1. Changed `GetUserByAuthId`, `GetBusinessById`, and `CreateBusinessAndAdmin` to `@auth(level: USER_ANON)`
2. Replaced old REST API call with Data Connect mutation in onboarding code
3. Deployed to staging and verified successful anonymous sign-up flow

**Verification Results:**
- ✅ No 401 Unauthorized errors
- ✅ No CORS errors
- ✅ Successful redirect to dashboard
- ✅ Data created in database

---

### 2026-02-06T11:16:00+05:00 - Session: Auth Unification Verification & Deployment

**Goal:** Deploy auth unification fix to staging and verify anonymous sign-up flow works correctly.

**Proceedings:**
1. Discovered onboarding code was calling old REST API instead of Data Connect
2. Replaced API call with `CreateBusinessAndAdmin` Data Connect mutation
3. Fixed parameter names to match GQL schema
4. Added `insecureReason` to all `USER_ANON` operations
5. Deployed Data Connect schema to staging with `--force` flag
6. Built and deployed Flutter web app to staging
7. User tested anonymous sign-up flow successfully

**What Worked:**
- ✅ Using Data Connect mutation instead of REST API
- ✅ Adding `insecureReason` to satisfy Firebase security validation
- ✅ Deploying Data Connect first, then Hosting
- ✅ Hard refresh in incognito browser for testing

**What Didn't:**
- ❌ Initial deployment hit GCP quota limit (resolved by waiting)
- ❌ Browser automation tool had environment issues (used manual testing instead)

**Gotchas:**
1. **Firebase requires `insecureReason` for USER_ANON operations** - Without it, deployment fails with validation errors
2. **GQL parameter names must match exactly** - `userEmail` not `email`, `userFirstName` not `firstName`
3. **Wait for CDN propagation** - 1-2 minutes after deployment before testing
4. **Hard refresh required** - `Ctrl+Shift+R` to bypass browser cache

**Agent Directives:**
1. **Always use Data Connect mutations** instead of custom REST APIs for database operations
2. **Add `insecureReason` to USER_ANON operations** to pass Firebase validation
3. **Verify parameter names** against GQL schema before calling mutations
4. **Deploy Data Connect before Hosting** to ensure schema is ready
5. **Wait for CDN propagation** before testing deployed changes

**Files Modified:**
- `lib/pages/onboarding/onboarding_stepper.dart` → Replaced REST API with Data Connect mutation
- All three auth operations → Added `insecureReason` annotations

**Status:** ✅ Auth unification complete and verified in staging

---

### 2026-02-08T23:18:00+05:00 - Session: USER_ANON Trial User Implementation Success

**Goal:** Update 22 Data Connect operations to `USER_ANON` for anonymous trial user support and verify functionality in staging.

**Proceedings:**
1. Updated 22 operations from `@auth(level: USER)` to `@auth(level: USER_ANON)`
2. Added `insecureReason` annotations to all operations
3. Committed changes (hash: c62098c) and pushed to dev branch
4. User deployed Data Connect schema to staging manually
5. GitHub Actions build triggered for frontend deployment
6. User verified 5 critical operations working successfully in staging

**What Worked:**
- ✅ **Anonymous user sign-up and onboarding** - No 401 errors
- ✅ **Session persistence on page reload** - User stays logged in
- ✅ **Adding location** - CreateLocation mutation successful
- ✅ **Adding product category** - CreateCategory mutation successful
- ✅ **Adding products** - CreateProduct mutation successful
- ✅ Systematic category-by-category updates (locations, products, suppliers, customers, pricing, procurement, business)
- ✅ Standard `insecureReason` annotation for all operations
- ✅ Firebase INSECURE warnings expected and documented

**What Didn't:**
- ❌ No issues encountered during implementation or testing

**Gotchas:**
1. **Firebase INSECURE warnings are expected** - When using `USER_ANON`, Firebase Data Connect compiler shows warnings. These are intentional and documented with `insecureReason`.

2. **App Check was disabled for diagnosis** - Temporarily disabled to isolate auth issues. Analysis shows 15-20% probability of disruption when re-enabled (LOW RISK).

3. **Connectivity overlay needs toggle mechanism** - Diagnostic overlay on landing page should be controllable via feature flag, not hardcoded.

4. **Business-scoped access is critical** - All operations validate `businessId` to prevent cross-business data access. This is the actual security layer, not the auth level.

**Operations Updated (22 Total):**
- **Locations:** 5 operations (list, get, create, update, delete)
- **Products:** 8 operations (list, categories, inventory, create, batches, therapeutic classes)
- **Suppliers:** 2 operations (list, create)
- **Customers:** 2 operations (list, create)
- **Pricing:** 2 operations (list, create)
- **Procurement:** 2 operations (purchase orders, goods receipts)
- **Business:** 1 operation (get user business details)

**Agent Directives:**
1. **Use feature flags for debug overlays** - Create `lib/config/feature_flags.dart` with `bool.fromEnvironment()` for toggleable features
2. **App Check is independent of auth levels** - App Check validates the app instance, Firebase Auth validates the user, Data Connect validates authorization
3. **Test with App Check disabled first** - When debugging auth issues, disable App Check to isolate variables
4. **Document security rationale** - Always add `insecureReason` when using `USER_ANON` to explain why it's safe
5. **Business-scoped access is the real security** - Auth levels control who can call operations, but `businessId` validation prevents cross-business access

**Files Modified:**
- 22 GQL operation files → Changed to `USER_ANON` with `insecureReason`
- `lib/config/feature_flags.dart` → Created with `showConnectivityOverlay` flag
- `lib/pages/landing/landing_page.dart` → Wrapped overlay with `FeatureFlags.showConnectivityOverlay`
- `DOCS NEW 2.0/project_memory.md` → Updated with USER_ANON successes and App Check status
- `DOCS NEW 2.0/app_check_analysis.md` → Created comprehensive risk analysis

**Status:** ✅ **VERIFIED IN STAGING - Ready for App Check re-enablement testing**

**Next Steps:**
1. Re-enable App Check in staging (uncomment in main.dart)
2. Test all 5 verified operations with App Check enabled
3. Monitor for 403 errors or reCAPTCHA challenges
4. If successful, prepare for production deployment
5. Disable connectivity overlay before production (set `SHOW_CONNECTIVITY_OVERLAY=false`)

---
