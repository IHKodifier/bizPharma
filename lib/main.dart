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

  if (kDebugMode) {
    // --- Set a persistent App Check debug token ---
    // Using the one you provided to avoid refreshes.
    js.context['FIREBASE_APPCHECK_DEBUG_TOKEN'] =
        'af5e46d4-e084-4cc4-9b16-10312aa29084';
    // ------------------------------------
  }

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode) {
    // Connect to local emulators
    await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);
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

  runApp(const ProviderScope(child: MyApp()));
}
