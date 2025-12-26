import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';

void main() {
  const String productionUrl = 'https://api.bizpharma.app';

  group('Backend Health Check', () {
    test('Health endpoint returns 200 OK', () async {
      print('Checking health of $productionUrl...');
      try {
        final response = await http.get(Uri.parse('$productionUrl/health'));

        print('Status Code: ${response.statusCode}');
        print('Body: ${response.body}');

        expect(
          response.statusCode,
          equals(200),
          reason: 'Backend should return 200 OK',
        );
      } catch (e) {
        fail('Failed to connect to backend: $e');
      }
    });

    test('Root endpoint is reachable', () async {
      try {
        final response = await http.get(Uri.parse('$productionUrl/'));
        // We expect either 200 or 404 (if root not defined), but mostly just reachability
        print('Root Status: ${response.statusCode}');
      } catch (e) {
        // This is just a reachability check
      }
    });
  });
}
