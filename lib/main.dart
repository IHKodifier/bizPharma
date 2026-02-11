import 'dart:js' as js;
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'config/app_check_config.dart';
import 'dataconnect_generated/biz_pharma.dart';
import 'my_app.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Use the same domain-based detection pattern as firebase_options.dart
  // This ensures consistency and avoids environment detection issues
  bool isLocalDev = false;
  if (kIsWeb) {
    final host = Uri.base.host;
    // Only localhost and 127.0.0.1 are considered local development
    // All other domains (bizpharma.app, bizpharma-staging.web.app) use remote services
    isLocalDev = (host == 'localhost' || host.startsWith('127.0.0.1'));
    print('🔍 DEBUG: Uri.base.host = $host (isLocalDev: $isLocalDev)');
  }

  if (isLocalDev) {
    // Set App Check debug token for local development only
    js.context['FIREBASE_APPCHECK_DEBUG_TOKEN'] =
        'af5e46d4-e084-4cc4-9b16-10312aa29084';
  }

  // Determine options (uses same domain-based detection internally)
  final options = DefaultFirebaseOptions.currentPlatform;
  print('🔍 DEBUG: Selected Firebase Options Project ID: ${options.projectId}');

  await Firebase.initializeApp(options: options);

  // Only connect to emulators when running on localhost
  if (isLocalDev) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    BizPharmaConnector.instance.dataConnect.useDataConnectEmulator(
      '127.0.0.1',
      9399,
    );
    print('🔧 Connected to local Firebase Emulators');
  }

  // Activate App Check
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaEnterpriseProvider(
      AppCheckConfig.webRecaptchaSiteKey,
    ),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );
  print('✅ App Check activated');

  runApp(const ProviderScope(child: MyApp()));
}
