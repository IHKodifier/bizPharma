import 'package:dio/dio.dart';
import 'api_client.dart';

class InventoryService {
  final ApiClient _client = ApiClient();

  // MOCK MODE: Set to true to use mock data instead of API
  static const bool _useMockData = true;

  // Get dashboard statistics
  Future<Map<String, dynamic>> getDashboardStats() async {
    if (_useMockData) {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 300));
      return {
        'low_stock_count': 12,
        'expiring_soon_count': 8,
        'total_products': 156,
        'total_value': 45000.00,
      };
    }

    try {
      final response = await _client.get('/api/v1/inventory/dashboard-stats');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Get expiry dashboard
  Future<Map<String, dynamic>> getExpiryDashboard({String? locationId}) async {
    if (_useMockData) {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 300));
      return {
        'critical_batches': 3,
        'warning_batches': 5,
        'attention_batches': 12,
        'total_value_at_risk': 8500.00,
        'batches': [
          {
            'batch_id': 'BATCH001',
            'product_name': 'Paracetamol 500mg',
            'quantity': 150,
            'expiry_date': '2025-01-15',
            'days_to_expiry': 38,
            'alert_level': 'warning',
          },
          {
            'batch_id': 'BATCH002',
            'product_name': 'Amoxicillin 250mg',
            'quantity': 80,
            'expiry_date': '2024-12-25',
            'days_to_expiry': 17,
            'alert_level': 'critical',
          },
          {
            'batch_id': 'BATCH003',
            'product_name': 'Ibuprofen 400mg',
            'quantity': 200,
            'expiry_date': '2025-03-10',
            'days_to_expiry': 92,
            'alert_level': 'attention',
          },
        ],
      };
    }

    try {
      final response = await _client.get(
        '/api/v1/inventory/expiry/dashboard',
        queryParameters: locationId != null
            ? {'location_id': locationId}
            : null,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // FEFO Batch Selection
  Future<Map<String, dynamic>> selectBatchesFefo({
    required String productId,
    required String locationId,
    required int quantity,
  }) async {
    if (_useMockData) {
      await Future.delayed(const Duration(milliseconds: 300));
      return {
        'selected_batches': [
          {
            'batch_id': 'BATCH001',
            'quantity': quantity,
            'expiry_date': '2025-01-15',
          },
        ],
        'total_quantity': quantity,
      };
    }

    try {
      final response = await _client.post(
        '/api/v1/inventory/batches/fefo-select',
        data: {
          'product_id': productId,
          'location_id': locationId,
          'quantity_needed': quantity,
        },
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Stock Adjustment
  Future<Map<String, dynamic>> adjustStock({
    required String productId,
    required String locationId,
    required String batchId,
    required int quantityChange,
    required String reason,
  }) async {
    if (_useMockData) {
      await Future.delayed(const Duration(milliseconds: 300));
      return {
        'success': true,
        'new_quantity': 100 + quantityChange,
        'adjustment_id': 'ADJ${DateTime.now().millisecondsSinceEpoch}',
      };
    }

    try {
      final response = await _client.post(
        '/api/v1/inventory/stock/adjust',
        data: {
          'product_id': productId,
          'location_id': locationId,
          'batch_id': batchId,
          'quantity_change': quantityChange,
          'reason': reason,
        },
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
