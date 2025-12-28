import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/location_service.dart';
import '../dataconnect_generated/biz_pharma.dart';

/// Provider for the LocationService singleton
final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

/// Provider for the list of locations for a business
/// Pass the businessId as a family parameter
final locationsProvider = FutureProvider.autoDispose
    .family<List<ListLocationsByBusinessLocations>, String>((
      ref,
      businessId,
    ) async {
      final locationService = ref.watch(locationServiceProvider);
      return await locationService.getLocationsByBusiness(businessId);
    });

/// Provider for a single location by ID
final locationByIdProvider = FutureProvider.autoDispose
    .family<GetLocationByIdLocation?, String>((ref, locationId) async {
      final locationService = ref.watch(locationServiceProvider);
      return await locationService.getLocationById(locationId);
    });

/// Notifier for the currently selected location ID
/// This is used for location-scoped operations (inventory, POS, etc.)
class CurrentLocationNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setLocation(String? locationId) {
    state = locationId;
  }

  void clear() {
    state = null;
  }
}

final currentLocationIdProvider =
    NotifierProvider<CurrentLocationNotifier, String?>(
      CurrentLocationNotifier.new,
    );

/// Location type options for dropdown selection
final locationTypeOptions = [
  {'value': 'HEAD_OFFICE', 'label': 'Head Office'},
  {'value': 'REGIONAL_OFFICE', 'label': 'Regional Office'},
  {'value': 'REGIONAL_WAREHOUSE', 'label': 'Regional Warehouse'},
  {'value': 'RETAIL_STORE', 'label': 'Retail Store'},
  {'value': 'DISTRIBUTION_CENTER', 'label': 'Distribution Center'},
];
