import 'package:biz_pharma/config/api_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';

void main() {
  group('Staging Configuration Test', () {
    test('ApiConfig uses Staging URL', () {
      print('Environment: ${ApiConfig.environment}');
      print('Base URL: ${ApiConfig.baseUrl}');

      expect(
        ApiConfig.baseUrl,
        contains('bizpharma-api'),
        reason: 'Should point to Cloud Run service in Staging',
      );
    });

    test('Staging Backend is Reachable', () async {
      // Only run this if we are seemingly in staging
      if (ApiConfig.baseUrl.contains('bizpharma-api')) {
        final dio = Dio();
        try {
          // We hit the /docs endpoint or root which usually returns 200 or 404 (but reachable)
          // Cloud Run usually requires Auth for root in some setups, but we allowed unauthenticated.
          // Hitting /docs or /openapi.json is safer for a 200.
          final response = await dio.get('${ApiConfig.baseUrl}/docs');

          print('Staging Response Status: ${response.statusCode}');
          expect(response.statusCode, 200);
        } catch (e) {
          fail('Could not reach Staging Backend: $e');
        }
      } else {
        print('Skipping network test as URL is not staging');
      }
    });
  });
}
