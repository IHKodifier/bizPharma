import 'package:flutter/foundation.dart';

class AppCheckConfig {
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  static const String _devSiteKey = '6Le6Xi4sAAAAAHANwno2xugEDeaG5zLPtMcpcMtz';
  static const String _stagingSiteKey =
      '6LcqZjUsAAAAAKtTitPrBwz9hJS1DlXqVRa6Yiao';
  // TODO: Create Production reCAPTCHA Enterprise Key and add here
  static const String _prodSiteKey = '6LdmAzgsAAAAALi4XGcnxBgs_TJmDOJfnURMsLJH';

  static String get webRecaptchaSiteKey {
    // Domain-based detection to ensure Production Key is used on the live site
    if (kIsWeb) {
      final host = Uri.base.host;
      if (host == 'bizpharma.app' || host == 'www.bizpharma.app') {
        return _prodSiteKey;
      }
    }

    switch (environment) {
      case 'production':
        return _prodSiteKey;
      case 'staging':
        return _stagingSiteKey;
      case 'development':
      default:
        return _devSiteKey;
    }
  }
}
