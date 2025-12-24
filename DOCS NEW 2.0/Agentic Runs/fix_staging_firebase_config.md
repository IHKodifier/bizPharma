# Fix: Multi-Environment Firebase Config

**Date**: 2025-12-23
**Related Issue**: [Staging Environment Configuration Mismatch](Knowledge%20Base/staging_auth_config_issue.md)

This document records the code changes made to resolve the issue where the Staging environment was incorrectly using the Development Firebase configuration.

## Files Changed

### 1. `lib/firebase_options.dart`

**Change**: Refactored `DefaultFirebaseOptions` to select the correct Firebase configuration based on the build environment.

```dart
class DefaultFirebaseOptions {
+  static const String environment = String.fromEnvironment('ENVIRONMENT', defaultValue: 'development');
+
   static FirebaseOptions get currentPlatform {
     if (kIsWeb) {
-      return web;
+      switch (environment) {
+        case 'production':
+          return webProd;
+        case 'staging':
+          return webStaging;
+        default:
+          return webDev;
+      }
     }
     switch (defaultTargetPlatform) {
       // ... (other platforms unchanged)
     }
   }
 
-  static const FirebaseOptions web = FirebaseOptions(
+  static const FirebaseOptions webDev = FirebaseOptions(
     apiKey: 'AIzaSyD1EIbEbBVBs5PqqgRkuZ185a78NfzWng0',
-    appId: '1:381385750800:web:YOUR_WEB_APP_ID',
+    appId: '1:381385750800:web:YOUR_WEB_APP_ID', // Development App ID (unchanged)
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

**Change**: Updated OAuth Consent Screen instructions to match the 2025 Google Cloud Console interface and added Firebase Console configuration requirements.

```markdown
+#### For Staging (Based on Current GCP Interface)
+
+**Starting Point**: You're likely on the "OAuth Overview" page (showing metrics).
+
+1. **Navigate to OAuth consent screen**:
+   - In the **left sidebar**, look for "OAuth consent screen" 
+   - Click on **"OAuth consent screen"** (it should be in the sidebar under "Google Auth Platform")
+   - OR directly navigate to: https://console.cloud.google.com/apis/credentials/consent?project=bizpharma-staging
+
+2. **Initial Setup** (First time only):
+   - You'll see a page asking you to configure the consent screen
+   - Under "User Type", select **"External"**
+   - Click the **"CREATE"** button
...
```
*(Full diff omitted for brevity, see valid file for complete instructions)*
