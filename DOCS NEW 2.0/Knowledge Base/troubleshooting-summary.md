# BizPharma Staging - Troubleshooting Session Summary

## 🔴 CURRENT STATUS: MID-RESOLUTION - ISSUE #2 IN PROGRESS

**WHERE WE ARE NOW**: 
- ✅ Issue #1 (ReCAPTCHA) has been completely resolved
- 🔄 Issue #2 (Firebase Data Connect 401) is PARTIALLY resolved - still occurring during onboarding save
- ❌ Issue #3 (CORS) has NOT been addressed yet

**NEXT IMMEDIATE STEPS**: 
1. **Fix CORS on backend API** (Priority: HIGH) - This is blocking the onboarding flow
2. **Investigate remaining Data Connect 401 errors** - These occur when user tries to save onboarding information
3. User needs to provide: Backend framework type and confirm they have access to modify the API code

---

## Project Context
- **Project**: bizpharma-staging
- **App URL**: https://bizpharma-staging.web.app
- **Backend API**: https://bizpharma-api-7rry5wij4a-el.a.run.app
- **Framework**: Flutter Web with Firebase

## Initial Error Log (Start of Troubleshooting Session)

**Context**: User reported errors when trying to use the app. This console log was the starting point of our troubleshooting session.

```
Installing/Activating first service worker.
flutter_bootstrap.js:3 Activated new service worker.
flutter_bootstrap.js:1 Injecting <script> tag. Using callback.
main.dart.js:30403 TrustedTypes available. Creating policy: gis-dart
main.dart.js:55241 TrustedTypes available. Creating policy: flutterfire-firebase_core
 Initializing Firebase firebase_core
main.dart.js:55241 TrustedTypes available. Creating policy: flutterfire-firebase_app_check
 Initializing Firebase firebase_app_check
main.dart.js:55241 TrustedTypes available. Creating policy: flutterfire-firebase_auth
 Initializing Firebase firebase_auth
(index):1 Uncaught (in promise) Timeout
main.dart.js:6500  Uncaught Error
component.ts:29  [2026-01-13T02:35:47.048Z]  @firebase/auth: Auth (12.3.0): Error while retrieving App Check token: FirebaseError: AppCheck: ReCAPTCHA error. (appCheck/recaptcha-error).
defaultLogHandler @ component.ts:29
main.dart.js:6500  Uncaught Error
component.ts:29  [2026-01-13T02:35:48.108Z]  @firebase/auth: Auth (12.3.0): Error while retrieving App Check token: FirebaseError: AppCheck: ReCAPTCHA error. (appCheck/recaptcha-error).
defaultLogHandler @ component.ts:29
main.dart.js:6500  Uncaught Error
firebasedataconnect.googleapis.com/v1/projects/bizpharma-staging/locations/asia-south1/services/bizpharma-service/connectors/biz-pharma:executeQuery:1   Failed to load resource: the server responded with a status of 401 ()
main.dart.js:6500  Uncaught Error
firebasedataconnect.googleapis.com/v1/projects/bizpharma-staging/locations/asia-south1/services/bizpharma-service/connectors/biz-pharma:executeQuery:1   Failed to load resource: the server responded with a status of 401 ()
main.dart.js:6500  Uncaught Error
(index):1  Access to XMLHttpRequest at 'https://bizpharma-api-7rry5wij4a-el.a.run.app/api/v1/setup/initialize' from origin 'https://bizpharma-staging.web.app' has been blocked by CORS policy: No 'Access-Control-Allow-Origin' header is present on the requested resource.
bizpharma-api-7rry5wij4a-el.a.run.app/api/v1/setup/initialize:1   Failed to load resource: net::ERR_FAILED
```

---

## Issues Identified

### Issue #1: ReCAPTCHA/App Check Configuration ✅ RESOLVED
- **Problem**: ReCAPTCHA Enterprise key was missing the Firebase hosting domain
- **Root Cause**: Domain `bizpharma-staging.firebaseapp.com` was not in the allowed domains list
- **Solution Applied**:
  1. Navigated to Google Cloud Console → reCAPTCHA Enterprise
  2. Found key: `6LcqZjUsAAAAAKtTitPrBwz9hJSIDlXqVRa6Yiao`
  3. Added missing domain: `bizpharma-staging.firebaseapp.com`
  4. Final domain list now includes:
     - `bizpharma-staging.web.app`
     - `bizpharma-staging.firebaseapp.com`
     - `localhost`
- **Status**: ✅ FIXED - ReCAPTCHA errors no longer appear in console

### Issue #2: Firebase Data Connect 401 Errors 🔄 IN PROGRESS
- **Problem**: Data Connect API calls returning 401 Unauthorized
- **Initial Status**: Errors appeared during app initialization
- **After Fix #1**: Initial 401 errors during page load were resolved
- **Current Status**: ⚠️ **401 ERRORS REAPPEAR WHEN USER TRIES TO SAVE ONBOARDING INFORMATION** ← WE ARE HERE NOW
- **Trigger**: Specifically happens when attempting to save onboarding data
- **Architecture Note**: 
  - Firebase Data Connect is an abstraction layer over Cloud SQL (PostgreSQL)
  - **Dev Environment**: Data hits Data Connect emulator only
  - **Staging Environment**: Data should persist to Cloud SQL PostgreSQL database
  - The 401 errors may indicate Data Connect cannot connect to the Cloud SQL instance
- **App Check Status for Data Connect**:
  - Mode: Monitoring (not enforcing)
  - Verified requests: 77% (51/66)
  - Unverified requests: 23%
    - 9% outdated client requests (6/66)
    - 14% unknown origin requests (9/66)
- **Analysis**: The 401 errors are likely authentication-related. Possible causes:
  1. Missing Firebase Auth tokens from the client
  2. **Data Connect service account lacks permissions to access Cloud SQL**
  3. **Cloud SQL instance not properly connected to Data Connect service**
  4. Database connection string or credentials misconfigured
- **What We Know**:
  - User attempted to run `firebase.auth().currentUser` in console but got "firebase is not defined" (expected for Flutter web)
  - Need to determine if user is properly authenticated before saving onboarding data
  - Need to verify Cloud SQL connection is properly configured in Data Connect

### Issue #3: CORS Policy Blocking API Calls ❌ NOT RESOLVED
- **Problem**: Custom backend API rejecting requests due to CORS
- **Error**: 
  ```
  Access to XMLHttpRequest at 'https://bizpharma-api-7rry5wij4a-el.a.run.app/api/v1/setup/initialize' 
  from origin 'https://bizpharma-staging.web.app' has been blocked by CORS policy: 
  No 'Access-Control-Allow-Origin' header is present on the requested resource.
  ```
- **Root Cause**: Backend API not configured to accept requests from `bizpharma-staging.web.app`
- **Required Solution**: Add CORS headers to the backend API:
  ```
  Access-Control-Allow-Origin: https://bizpharma-staging.web.app
  Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS
  Access-Control-Allow-Headers: Content-Type, Authorization
  ```

---

## Current Console Log (After Partial Fixes - During Onboarding Save Attempt)

**Context**: This log was captured when the user attempted to save onboarding information. Notice:
- ✅ NO MORE ReCAPTCHA errors (Issue #1 is fixed)
- ❌ Data Connect 401 errors are back
- ❌ CORS error blocking the backend API call

```
Installing/Activating first service worker.
Activated new service worker.
Injecting <script> tag. Using callback.
TrustedTypes available. Creating policy: gis-dart
TrustedTypes available. Creating policy: flutterfire-firebase_core
Initializing Firebase firebase_core
TrustedTypes available. Creating policy: flutterfire-firebase_app_check
Initializing Firebase firebase_app_check
TrustedTypes available. Creating policy: flutterfire-firebase_auth
Initializing Firebase firebase_auth

firebasedataconnect.googleapis.com/v1/projects/bizpharma-staging/locations/asia-south1/services/bizpharma-service/connectors/biz-pharma:executeQuery:1
Failed to load resource: the server responded with a status of 401 ()

firebasedataconnect.googleapis.com/v1/projects/bizpharma-staging/locations/asia-south1/services/bizpharma-service/connectors/biz-pharma:executeQuery:1
Failed to load resource: the server responded with a status of 401 ()

Access to XMLHttpRequest at 'https://bizpharma-api-7rry5wij4a-el.a.run.app/api/v1/setup/initialize' 
from origin 'https://bizpharma-staging.web.app' has been blocked by CORS policy: 
No 'Access-Control-Allow-Origin' header is present on the requested resource.

bizpharma-api-7rry5wij4a-el.a.run.app/api/v1/setup/initialize:1
Failed to load resource: net::ERR_FAILED

[Violation] 'requestAnimationFrame' handler took 51ms
```

**Key Observation**: User confirmed that on initial page load (before attempting to save), there were NO 401 errors and NO ReCAPTCHA errors. The errors only appear when attempting the save operation.

---

## Firebase Configuration Details

### App Check Configuration
- **Provider**: reCAPTCHA Enterprise
- **Site Key**: `6LcqZjUsAAAAAKtTitPrBwz9hJSIDlXqVRa6Yiao`
- **Token TTL**: 1 hour
- **App Risk Level**: Medium (0.5)
- **Status**: Registered ✅

### Firebase Data Connect Configuration
- **Service Name**: `bizpharma-service`
- **Location**: `asia-south1`
- **Connector**: `biz-pharma`
- **App Check Enforcement**: Monitoring mode (not blocking)
- **Architecture**:
  - Data Connect acts as an abstraction layer over Cloud SQL (PostgreSQL)
  - **Dev Environment**: Uses Data Connect emulator (local only, no persistence to Cloud SQL)
  - **Staging Environment**: Should persist data to Cloud SQL PostgreSQL instance
  - **Production Environment**: Presumably also uses Cloud SQL
- **Critical Configuration Points**:
  - Cloud SQL instance must be properly linked to Data Connect service
  - Service account must have IAM permissions to access Cloud SQL
  - Database schema migrations must be applied to Cloud SQL
  - Connection credentials must be correctly configured

---

## Next Steps to Complete Resolution

### 1. Fix CORS on Backend API (Priority: HIGH) ← START HERE
**Required Information - NEED TO ASK USER:**
- ❓ Do you have access to the backend code?
- ❓ What framework is the backend built with? (Node.js/Express, Python/Flask, Go, Java/Spring, etc.)
- ❓ Who can modify this API if you don't have access?

**Implementation Steps (once we know the framework):**
1. Identify backend framework
2. Add CORS middleware/headers for the framework
3. Allow origin: `https://bizpharma-staging.web.app`
4. Allow credentials: true (if using authentication cookies)
5. Allow headers: `Content-Type`, `Authorization`
6. Redeploy backend API to Cloud Run
7. Test API calls from frontend

**Example CORS Configuration by Framework:**

**Node.js/Express:**
```javascript
const cors = require('cors');
app.use(cors({
  origin: 'https://bizpharma-staging.web.app',
  credentials: true
}));
```

**Python/Flask:**
```python
from flask_cors import CORS
CORS(app, origins=['https://bizpharma-staging.web.app'], supports_credentials=True)
```

**Go:**
```go
w.Header().Set("Access-Control-Allow-Origin", "https://bizpharma-staging.web.app")
w.Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE")
w.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")
```

### 2. Investigate Data Connect 401 Errors During Onboarding (Priority: MEDIUM)
**Possible Causes:**
- User not authenticated at the time of saving onboarding info
- Firebase Auth token not being included in Data Connect queries
- Data Connect security rules rejecting the authenticated user
- Token expiration or refresh issues
- **Cloud SQL Connection Issues:**
  - Data Connect service may not have proper Cloud SQL instance configured
  - Service account lacks IAM permissions to access Cloud SQL
  - Cloud SQL instance is not running or not accessible from Data Connect
  - Connection credentials (database name, user, password) misconfigured
  - Cloud SQL Auth Proxy not properly configured

**Investigation Steps:**

**A. Verify Cloud SQL Configuration (START HERE FOR STAGING):**
1. ❓ Go to Firebase Console → Data Connect → `bizpharma-service` → Settings
2. ❓ Check **Data source** configuration:
   - Is Cloud SQL instance properly linked?
   - What's the instance connection name? (format: `project:region:instance-name`)
   - Is the database name correct?
3. ❓ Go to Google Cloud Console → SQL
4. ❓ Verify Cloud SQL instance:
   - Is the instance running?
   - What's the instance name and connection string?
   - Which database exists? (should match Data Connect config)
5. ❓ Check IAM permissions:
   - Does the Data Connect service account have `Cloud SQL Client` role?
   - Service account format: `firebase-dataconnect@bizpharma-staging.iam.gserviceaccount.com`

**B. Check Authentication Flow:**
1. ❓ **CRITICAL QUESTION**: Is the user authenticated (logged in) when they try to save onboarding info?
2. ❓ Describe the authentication flow:
   - When does signup/login happen?
   - Is onboarding before or after authentication?
   - Does the user have a valid Firebase Auth session?
3. Check Flutter code: Verify Firebase Auth token is being sent with Data Connect queries
4. Review Data Connect security rules in Firebase Console
5. Add logging to see if auth state exists before making queries
6. Consider if this is a timing issue (auth not complete before query)

**C. Check Data Connect Configuration:**
1. ❓ In Firebase Console → Data Connect → `bizpharma-service`:
   - Click on **Connector**: `biz-pharma`
   - Check the queries/mutations being used
   - Verify schema matches Cloud SQL database schema
2. ❓ Check if Data Connect has been deployed to staging:
   - Run: `firebase dataconnect:sql:migrate` (if using Firebase CLI)
   - Verify migrations have been applied to Cloud SQL

**Testing Approach:**
- Try logging in first, then navigating to onboarding
- Check browser Application/Storage tab → IndexedDB → firebase-auth to see if auth token exists
- Add console logs in Flutter code before Data Connect queries to verify auth state
- **Test Data Connect queries directly** using Firebase Console's query explorer to isolate whether it's a client auth issue or a Cloud SQL connection issue

### 3. Monitor App Check Metrics (Priority: LOW)
- Currently 23% unverified requests
- Consider enforcing App Check after stabilizing authentication
- Monitor metrics after other fixes are applied

---

## Questions to Answer Before Proceeding

**⚠️ THESE QUESTIONS WERE ASKED BUT NOT YET ANSWERED - START BY ASKING USER:**

### About Backend API (Priority: HIGH - Blocks Issue #3)
1. ❓ **Do you have access to modify the backend API code** at `bizpharma-api-7rry5wij4a-el.a.run.app`?
2. ❓ **What framework/language is the backend API built with?** (Node.js, Python, Go, Java, etc.)
3. ❓ If you don't have access, who manages this API and can make changes?

### About Authentication Flow (Priority: MEDIUM - Helps Issue #2)
4. ❓ **Is the user authenticated (logged in) when trying to save onboarding info?**
5. ❓ **Describe the complete user flow**:
   - Does user signup/login first?
   - Then fill out onboarding form?
   - Then click save?
   - OR is onboarding part of the signup process?
6. ❓ **What triggers the Data Connect queries** that are returning 401?
7. ❓ At what point in the flow does the user get a Firebase Auth token?

### About Data Connect & Cloud SQL (Priority: HIGH - May be root cause of Issue #2)
8. ❓ **Go to Firebase Console → Data Connect → `bizpharma-service` → Settings**
   - What Cloud SQL instance is configured? (connection name)
   - What database name is specified?
   - Is the instance connection name valid? (format: `bizpharma-staging:asia-south1:instance-name`)
9. ❓ **Go to Google Cloud Console → SQL**
   - Is there a Cloud SQL PostgreSQL instance running?
   - What's the instance name?
   - What's the instance status? (Running, Stopped, etc.)
   - Which databases exist in the instance?
10. ❓ **Check IAM permissions:**
    - Go to Google Cloud Console → IAM & Admin → IAM
    - Look for service account: `firebase-dataconnect@bizpharma-staging.iam.gserviceaccount.com`
    - Does it have the `Cloud SQL Client` role?
11. ❓ **Has Data Connect been deployed to staging with migrations?**
    - Have you run `firebase dataconnect:sql:migrate` to create tables in Cloud SQL?
    - Can you verify tables exist in the PostgreSQL database?

---

## Testing Checklist

After implementing fixes, verify:
- [ ] No ReCAPTCHA errors in console (✅ Already verified)
- [ ] No 401 errors on page load
- [ ] No 401 errors when saving onboarding data
- [ ] No CORS errors when calling backend API
- [ ] User can successfully complete onboarding flow
- [ ] Data is properly saved to Firebase Data Connect
- [ ] Backend API calls succeed

---

## Key Files/Locations Referenced

### Firebase Console
- Project: `bizpharma-staging`
- App Check → Web App: `bizpharma-staging-web-app`
- Data Connect → Service: `bizpharma-service`

### Google Cloud Console
- reCAPTCHA Enterprise → Key: `bizPharma-staging-web`
- Key ID: `6LcqZjUsAAAAAKtTitPrBwz9hJSIDlXqVRa6Yiao`

### Code References
- Flutter initialization: `main.dart`
- Firebase initialization includes:
  - `firebase_core`
  - `firebase_app_check`
  - `firebase_auth`
  - `firebase_data_connect`

---

## Summary Status

| Issue | Status | Priority |
|-------|--------|----------|
| ReCAPTCHA/App Check Configuration | ✅ Fixed | - |
| Firebase Data Connect 401 Errors | ⚠️ Partially Fixed | Medium |
| CORS Policy Blocking | ❌ Not Fixed | High |

**Primary Blocker**: CORS configuration on backend API must be fixed to allow cross-origin requests from the frontend.