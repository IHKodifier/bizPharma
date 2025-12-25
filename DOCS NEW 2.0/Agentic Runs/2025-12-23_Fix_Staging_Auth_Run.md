# Agentic Run: Fix Staging Auth Configuration & Infinite Loop Suspicion

**Date**: 2025-12-23
**Status**: Resolved
**Environment**: Staging
**User Request**: Fix "Start Free Trial" button unresponsiveness and missing Anonymous User creation.

---

## 1. Investigation & knowledge Base

### 10. `backend/config/settings.py` (Hotfix 3)
**Change**: Updated Data Connect API Endpoint.
**Reason**: The backend was using an incorrect base URL `https://dataconnect.googleapis.com`, which returned `404 Not Found` (HTML). The official endpoint is `https://firebasedataconnect.googleapis.com`.

```python
     @property
     def DATA_CONNECT_ENDPOINT(self) -> str:
-        return "https://dataconnect.googleapis.com"
+        return "https://firebasedataconnect.googleapis.com"
```
### Issue Description
The Staging environment (`https://bizpharma-staging.web.app`) was failing to function correctly.
- **Symptom 1**: The "Start Free Trial" button was unresponsive.
- **Symptom 2**: Anonymous user creation was failing, despite being enabled in the Staging Firebase Console.
- **Symptom 3**: The app behaved as if it was disconnected, leading to user suspicions of backend infinite loops or crashes.

### Investigation Steps
1.  **Backend Health Check**:
    *   **Action**: Checked Cloud Run logs and health endpoints for `bizpharma-api` in Staging.
    *   **Result**: Backend was healthy (`HTTP 200`), initialized correctly, and had no infinite loops.
2.  **Configuration Audit**:
    *   **Action**: Inspected `lib/firebase_options.dart`.
    *   **Result**: Found **hardcoded configuration** for the Development project (`bizpharma-4e73a`).
    *   **Root Cause**: Staging deployment was initializing with Development credentials, causing Auth mismatch.
3.  **Build Process Review**:
    *   **Action**: Checked `.github/workflows/deploy.yml`.
    *   **Result**: Workflow passed `ENVIRONMENT` variable, but Dart code ignored it.

### Resolution Strategy
To fix this, we needed to make the `firebase_options.dart` file **environment-aware**.
1.  **Obtain Configuration**: Retrieved correct Firebase Web Configs for Staging (`bizpharma-staging`) and Production (`bizpharma-prod`).
2.  **Refactor Code**: Modified `DefaultFirebaseOptions` to read `String.fromEnvironment` and switch between configs.
3.  **Deploy**: Committed to `dev` to trigger Staging CI/CD.

---

## 2. Run Log (Code Changes)

### 1. `lib/firebase_options.dart`
**Change**: Refactored `DefaultFirebaseOptions` to select configuration based on build environment.

```dart
class DefaultFirebaseOptions {
  static const String environment = String.fromEnvironment('ENVIRONMENT', defaultValue: 'development');

   static FirebaseOptions get currentPlatform {
     if (kIsWeb) {
       switch (environment) {
         case 'production':
           return webProd;
         case 'staging':
           return webStaging;
         default:
           return webDev;
       }
     }
     // ... (other platforms unchanged)
   }
 
-  static const FirebaseOptions web = FirebaseOptions(
+  static const FirebaseOptions webDev = FirebaseOptions(
     apiKey: 'AIzaSyD1EIbEbBVBs5PqqgRkuZ185a78NfzWng0',
-    appId: '1:381385750800:web:YOUR_WEB_APP_ID',
+    appId: '1:381385750800:web:YOUR_WEB_APP_ID', // Development
     messagingSenderId: '381385750800',
     projectId: 'bizpharma-4e73a',
     authDomain: 'bizpharma-4e73a.firebaseapp.com',
     storageBucket: 'bizpharma-4e73a.firebasestorage.app',
   );
+
+  static const FirebaseOptions webStaging = FirebaseOptions(
+    apiKey: 'AIzaSyArbFbooj4xmHeMhXwtrA3Ch5qTrsivgJM',
+    authDomain: 'bizpharma-staging.firebaseapp.com',
+    projectId: 'bizpharma-staging',
+    storageBucket: 'bizpharma-staging.firebasestorage.app',
+    messagingSenderId: '329922858118',
+    appId: '1:329922858118:web:80322052214a378573d507',
+  );
+
+  static const FirebaseOptions webProd = FirebaseOptions(
+    apiKey: 'AIzaSyARNecjdxHUCvcQOadO6hiAaIGExsrnSbs',
+    authDomain: 'bizpharma-prod.firebaseapp.com',
+    projectId: 'bizpharma-prod',
+    storageBucket: 'bizpharma-prod.firebasestorage.app',
+    messagingSenderId: '359227923382',
+    appId: '1:359227923382:web:6ff76b79629b6f2b3eff17',
+  );
```

### 2. `DOCS NEW 2.0/architecture_decisions.md`
**Change**: Updated OAuth Consent Screen instructions for 2025 Google Interface.

### 3. `lib/config/api_config.dart`
**Change**: Updated Staging API URL to use the direct Cloud Run endpoint instead of the unconfigured custom domain.

```dart
     if (environment == 'development') {
       return 'http://127.0.0.1:8000';
     } else if (environment == 'staging') {
-      return 'https://api-staging.bizpharma.app';
+      return 'https://bizpharma-api-7rry5wij4a-el.a.run.app';
     }
     return 'https://api.bizpharma.app';
```

---

## 3. Subsequent Fixes (10ms later)

### Issue: `ERR_NAME_NOT_RESOLVED`
After fixing the Auth config, the app failed to connect to the backend because it was trying to reach `https://api-staging.bizpharma.app`, which has not been configured (DNS) yet.


### 4. `backend/modules/shared/dataconnect_client.py`
**Change**: Updated `DataConnectClient` to use **ADC (Application Default Credentials)** and **v1beta** API.
**Reason**: The backend was failing with `404 Not Found` when acting as a Cloud Run service account because it was trying to load a non-existent local credential file, and potentially using the wrong API version (`v1`).

```python
     def _get_access_token(self) -> str:
-        # ... (Old code tried loading from file) ...
+        try:
+            import google.auth
+            import google.auth.transport.requests
+
+            # Use Application Default Credentials (works on Cloud Run)
+            scopes = ['https://www.googleapis.com/auth/cloud-platform']
+            creds, project = google.auth.default(scopes=scopes)
+            
+            # Refresh token
+            auth_req = google.auth.transport.requests.Request()
+            creds.refresh(auth_req)
+            return creds.token
+        # ...
```


### 5. `lib/config/app_check_config.dart` (New File) & `lib/main.dart`
**Change**: Created environment-aware App Check configuration to handle different reCAPTCHA keys for Dev, Staging, and Prod.
**Reason**: Staging was using the Development reCAPTCHA key, causing `AppCheck token failed` errors.

```dart
// lib/config/app_check_config.dart
  static const String _devSiteKey = '6Le6Xi4sAAAAAHANwno2xugEDeaG5zLPtMcpcMtz';
  static const String _stagingSiteKey = '6LcqZjUsAAAAAKtTitPrBwz9hJS1DlXqVRa6Yiao';
  // TODO: Create Production reCAPTCHA Enterprise Key and add here
  static const String _prodSiteKey = 'TODO_PROD_KEY';
```

```dart
// lib/main.dart
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaEnterpriseProvider(
-      '6Le6Xi4sAAAAAHANwno2xugEDeaG5zLPtMcpcMtz',
+      AppCheckConfig.webRecaptchaSiteKey,
    ),
    // ...
```
