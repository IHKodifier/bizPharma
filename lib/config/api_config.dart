class ApiConfig {
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  static String get baseUrl {
    // For android emulator use 10.0.2.2 instead of localhost
    if (environment == 'development') {
      return 'http://127.0.0.1:8000';
    }
    return 'https://api.bizpharma.app';
  }
}
