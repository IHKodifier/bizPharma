import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/inventory_service.dart';

// Provider for the Inventory Service
final inventoryServiceProvider = Provider<InventoryService>((ref) {
  return InventoryService();
});

// Future Provider for Dashboard Stats
final inventoryStatsProvider = FutureProvider<Map<String, dynamic>>((
  ref,
) async {
  final service = ref.read(inventoryServiceProvider);
  return await service.getDashboardStats();
});

// Future Provider for Expiry Dashboard
final expiryDashboardProvider = FutureProvider<Map<String, dynamic>>((
  ref,
) async {
  final service = ref.read(inventoryServiceProvider);
  return await service.getExpiryDashboard();
});
