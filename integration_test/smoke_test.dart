import 'package:biz_pharma/config/api_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:biz_pharma/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Staging Smoke Test', () {
    testWidgets('Verify Environment is Staging', (WidgetTester tester) async {
      // 1. Launch the app
      app.main();
      await tester.pumpAndSettle();

      // 2. Check logic (Note: This runs inside the app context)
      // We are passing --dart-define=ENVIRONMENT=staging
      // So ApiConfig.baseUrl should match the staging URL.

      const expectedStagingUrl =
          'https://bizpharma-api-7rry5wij4a-el.a.run.app';

      // Print for debugging in console
      print('Current Base URL: ${ApiConfig.baseUrl}');

      // Assert
      // We check if it *contains* the run.app domain which is specific to staging
      expect(
        ApiConfig.baseUrl,
        contains('bizpharma-api'),
        reason: 'API URL should point to Staging (Cloud Run Service)',
      );

      expect(
        ApiConfig.baseUrl,
        isNot(contains('localhost')),
        reason: 'API URL should NOT be localhost',
      );
    });
  });
}
