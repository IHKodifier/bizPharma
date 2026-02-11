import 'package:flutter/foundation.dart';

/// Feature flags for controlling optional/debug features across environments
class FeatureFlags {
  /// Controls visibility of the connectivity diagnostic overlay on the landing page
  ///
  /// This overlay shows:
  /// - Current environment (dev/staging/production)
  /// - API URL and Firebase project ID
  /// - App Check status warning
  /// - Connectivity probe button
  ///
  /// Usage:
  /// - Development: true (always show for debugging)
  /// - Staging: Set via --dart-define=SHOW_CONNECTIVITY_OVERLAY=true
  /// - Production: false (MUST be disabled)
  ///
  /// To enable in staging build:
  /// ```bash
  /// flutter build web --dart-define=SHOW_CONNECTIVITY_OVERLAY=true
  /// ```
  static const bool showConnectivityOverlay = bool.fromEnvironment(
    'SHOW_CONNECTIVITY_OVERLAY',
    defaultValue: kDebugMode, // Auto-enable in debug mode, disabled in release
  );

  /// Controls whether App Check debug mode is enabled
  ///
  /// When true, uses the debug token set in main.dart
  /// When false, uses production reCAPTCHA Enterprise validation
  static const bool appCheckDebugMode = bool.fromEnvironment(
    'APP_CHECK_DEBUG',
    defaultValue: kDebugMode,
  );
}
