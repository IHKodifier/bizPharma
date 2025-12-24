class AppCheckConfig {
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  static const String _devSiteKey = '6Le6Xi4sAAAAAHANwno2xugEDeaG5zLPtMcpcMtz';
  static const String _stagingSiteKey =
      '6LcqZjUsAAAAAKtTitPrBwz9hJS1DlXqVRa6Yiao';
  // TODO: Create Production reCAPTCHA Enterprise Key and add here
  static const String _prodSiteKey = 'TODO_PROD_KEY';

  static String get webRecaptchaSiteKey {
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
