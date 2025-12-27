import 'package:flutter/foundation.dart';

class ApiConfig {
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  static String get baseUrl {
<<<<<<< HEAD
    // If we are in release mode but the environment says 'development' (default),
    // assume this is a production build.
    if (kReleaseMode && environment == 'development') {
      return 'https://api.bizpharma.app';
=======
    // Domain-based detection to ensure Production API is used on the live site
    if (kIsWeb) {
      final host = Uri.base.host;
      if (host == 'bizpharma.app' || host == 'www.bizpharma.app') {
        return 'https://api.bizpharma.app';
      }
>>>>>>> cc47e72f858c662b6df9d91863ba9938f3906e78
    }

    // For android emulator use 10.0.2.2 instead of localhost
    if (environment == 'development') {
      return 'http://127.0.0.1:8000';
    } else if (environment == 'staging') {
      return 'https://bizpharma-api-7rry5wij4a-el.a.run.app';
    }
    return 'https://api.bizpharma.app';
  }
}
