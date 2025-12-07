import 'package:dio/dio.dart';
import 'api_client.dart';

class SetupService {
  final ApiClient _client = ApiClient();

  // Business Setup
  Future<Map<String, dynamic>> getBusinessProfile() async {
    try {
      final response = await _client.get('/api/v1/setup/business');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateBusinessProfile(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _client.put('/api/v1/setup/business', data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Location Setup
  Future<Map<String, dynamic>> createLocation(Map<String, dynamic> data) async {
    try {
      final response = await _client.post(
        '/api/v1/setup/locations',
        data: data,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> getLocations() async {
    try {
      final response = await _client.get('/api/v1/setup/locations');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Supplier Setup
  Future<Map<String, dynamic>> createSupplier(Map<String, dynamic> data) async {
    try {
      final response = await _client.post(
        '/api/v1/setup/suppliers',
        data: data,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Product Setup
  Future<Map<String, dynamic>> createProduct(Map<String, dynamic> data) async {
    try {
      final response = await _client.post('/api/v1/setup/products', data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
