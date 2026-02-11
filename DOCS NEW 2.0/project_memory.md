# Project Memory - bizPharma

## Critical Gotchas and Lessons Learned

### Firebase Data Connect Auth Levels (2026-02-05)

**Issue:** `401 Unauthorized` errors when using `@auth(level: USER)` with anonymous Firebase Auth users.

**Root Cause:** Firebase Data Connect has three distinct auth levels with different behaviors:

| Auth Level | Authenticated Users | Anonymous Users | Unauthenticated Users |
|------------|-------------------|-----------------|---------------------|
| `USER` | ✅ Allowed | ❌ **DENIED** | ❌ Denied |
| `USER_ANON` | ✅ Allowed | ✅ **Allowed** | ❌ Denied |
| `PUBLIC` | ✅ Allowed | ✅ Allowed | ✅ Allowed |

**Key Insight:** `@auth(level: USER)` **explicitly excludes** anonymous Firebase Auth users, even though they have valid Firebase Auth tokens.

**Solution:** For queries/mutations that need to support anonymous trial flows (e.g., onboarding), use `@auth(level: USER_ANON)`.

**When to Use Each Level:**
- **`USER_ANON`** → Onboarding queries/mutations (checking if user exists, creating business/user records)
- **`USER`** → Business operations after onboarding, operations requiring permanent credentials
- **`PUBLIC`** → Avoid in production; only for truly public data (health checks, uptime queries)

**Auth Unification Strategy:**
1. Onboarding operations → `USER_ANON`
2. All other operations → `USER`
3. Public health checks → `PUBLIC` (minimal use)

**Files Affected:**
- `dataconnect/connector/queries/core/get_user_by_auth_id.gql`
- `dataconnect/connector/mutations/admin/onboarding.gql`

**References:**
- [Firebase Data Connect Auth Documentation](https://firebase.google.com/docs/data-connect/authorization)
- Detailed documentation: `DOCS NEW 2.0/Knowledge Base/firebase_dataconnect_auth_levels_gotcha.md`

---

### USER_ANON Trial User Implementation (2026-02-08)

**Success:** Updated 22 Data Connect operations to `USER_ANON` for anonymous trial user support.

**What Worked:**
1. ✅ Anonymous user sign-up and onboarding successful
2. ✅ Logged-in user persisted on page reload (session restoration)
3. ✅ Adding location successful
4. ✅ Adding product category successful
5. ✅ Adding products successful

**Key Actions That Enabled Success:**
- Changed auth level from `USER` to `USER_ANON` for 22 operations
- Added `insecureReason` annotations to document security rationale
- Deployed Data Connect schema to staging
- Pushed frontend code to trigger GitHub Actions build

**Operations Updated (22 Total):**
- **Locations:** 5 operations (list, get, create, update, delete)
- **Products:** 8 operations (list, categories, inventory, create, batches, therapeutic classes)
- **Suppliers:** 2 operations (list, create)
- **Customers:** 2 operations (list, create)
- **Pricing:** 2 operations (list, create)
- **Procurement:** 2 operations (purchase orders, goods receipts)
- **Business:** 1 operation (get user business details)

**Security Measures:**
- Business-scoped access enforced via `businessId` validation
- Trial limits: 500 products, 50 suppliers, 500 transactions/day, 4-week duration
- Multi-user features remain restricted to paid users

**Commit:** c62098c

---

### Connectivity Diagnostic Overlay (2026-02-08)

**Location:** `lib/pages/landing/landing_page.dart` (lines 89-159)

**Purpose:** Visual debugging tool to verify Data Connect connectivity in staging.

**Features:**
- Shows environment, API URL, Firebase project ID
- "Run Connectivity Probe" button to test Data Connect
- Status indicator (OK/FAIL)
- Warning banner: "APP CHECK DISABLED"

**Current Status:** Controlled by feature flag in `lib/config/feature_flags.dart`

**Toggle Mechanism:** ✅ Implemented with `FeatureFlags.showConnectivityOverlay`

**Default Behavior:**
- **Local Debug:** Automatically enabled (`kDebugMode = true`)
- **Release Builds:** Automatically disabled (`kDebugMode = false`)
- **Production:** Always disabled (release build)
- **Staging:** Disabled by default (release build)

**How to Enable in Staging:**

Option 1: Update GitHub Actions workflow (`.github/workflows/deploy.yml`):
```yaml
- name: Build Web App
  run: |
    if [[ "${{ env.BUILD_ENV }}" == "staging" ]]; then
      flutter build web --release \
        --dart-define=ENVIRONMENT=${{ env.BUILD_ENV }} \
        --dart-define=SHOW_CONNECTIVITY_OVERLAY=true
    else
      flutter build web --release \
        --dart-define=ENVIRONMENT=${{ env.BUILD_ENV }}
    fi
```

Option 2: Manual staging deployment with flag:
```bash
flutter build web --release \
  --dart-define=ENVIRONMENT=staging \
  --dart-define=SHOW_CONNECTIVITY_OVERLAY=true
firebase deploy --only hosting --project bizpharma-staging
```

**Production Requirement:** Overlay is automatically disabled in release builds. No action needed.

---

### App Check Status (2026-02-08)

**Current Status:** **DISABLED** in staging for diagnosis

**Location:** `lib/main.dart` (lines 48-54)

**Reason for Disabling:** Temporary measure to isolate auth issues during USER_ANON implementation.

**Configuration:**
- Staging reCAPTCHA Site Key: `6LcqZjUsAAAAAKtTitPrBwz9hJS1DlXqVRa6Yiao`
- Production reCAPTCHA Site Key: `6LdmAzgsAAAAALi4XGcnxBgs_TJmDOJfnURMsLJH`
- Debug token set for local development: `af5e46d4-e084-4cc4-9b16-10312aa29084`

**Re-enablement Risk Assessment:** See App Check Analysis section below.

---

## Architecture Decisions

### Anonymous User Trial Flow
- Users can sign up anonymously to start a free trial
- Anonymous users can create business and user records
- Full access requires linking to permanent credentials (Google Sign-In)
- After linking, anonymous UID is preserved, maintaining all trial data

---

## Common Pitfalls

1. **Don't assume Production = Dev** - Production may use different auth levels (e.g., PUBLIC) that mask issues
2. **Always test with anonymous users** when implementing auth unification
3. **IAM roles are not always the issue** - Check auth level directives first
4. **GCP quota limits** - Cloud Billing API has rate limits; wait 1-2 minutes between deployment attempts
5. **App Check can interfere with Data Connect** - Test with App Check disabled first, then re-enable after confirming auth works

---

## Environment-Specific Notes

### Staging (`bizpharma-staging`)
- Project Number: 563584335869
- Region: asia-south1
- Data Connect Service: bizpharma-service
- Connector: biz-pharma
- **App Check:** Currently DISABLED for diagnosis
- **Connectivity Overlay:** ENABLED

### Development (`bizpharma-4e73a`)
- Project Number: 381385750800
- Region: asia-south1
- Used for local development and hotfix branches
- **App Check:** Debug mode enabled

### Production (`bizpharma-prod`)
- Region: asia-south1
- Used for main branch deployments
- **App Check:** Must be ENABLED (production reCAPTCHA)
- **Connectivity Overlay:** Must be DISABLED
