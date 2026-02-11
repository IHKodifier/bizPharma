import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../dataconnect_generated/biz_pharma.dart';

/// Service for managing locations in the system.
/// Handles CRUD operations for business locations.
class LocationService {
  /// Get all locations for a business
  Future<List<ListLocationsByBusinessLocations>> getLocationsByBusiness(
    String businessId,
  ) async {
    try {
      print('🔍 DEBUG: Fetching locations for business: $businessId');

      // --- DIAGNOSTIC START ---
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final tokenResult = await user.getIdTokenResult(true);
          print('🛑 AUTH DIAGNOSTIC:');
          print('   - App Project ID: ${Firebase.app().options.projectId}');
          print('   - Token Issuer (iss): ${tokenResult.claims?['iss']}');
          print('   - Token Audience (aud): ${tokenResult.claims?['aud']}');
          print('   - User UID: ${user.uid}');
        } else {
          print('🛑 AUTH DIAGNOSTIC: User is NULL');
        }
      } catch (e) {
        print('🛑 AUTH DIAGNOSTIC ERROR: $e');
      }
      // --- DIAGNOSTIC END ---

      final result = await BizPharmaConnector.instance
          .listLocationsByBusiness(businessId: businessId)
          .execute();
      print('🔍 DEBUG: Fetched ${result.data.locations.length} locations');
      return result.data.locations;
    } catch (e) {
      log('Error fetching locations: $e');
      rethrow;
    }
  }

  /// Get a single location by ID
  Future<GetLocationByIdLocation?> getLocationById(String id) async {
    try {
      final result = await BizPharmaConnector.instance
          .getLocationById(id: id)
          .execute();
      return result.data.location;
    } catch (e) {
      log('Error fetching location: $e');
      rethrow;
    }
  }

  /// Create a new location
  /// Returns the generated location ID
  Future<String> createLocation({
    required String businessId,
    required String name,
    required LocationType type,
    String? phone,
    String? email,
    String? operatingHours,
    String? licenseNumber,
  }) async {
    try {
      // Force token refresh to ensure Data Connect gets a valid token
      await FirebaseAuth.instance.currentUser?.getIdToken(true);

      // DEBUG: Verify Auth State before mutation
      final user = FirebaseAuth.instance.currentUser;
      print('🔍 DEBUG: createLocation called.');
      print('🔍 DEBUG: Current Auth User: ${user?.uid ?? "NULL (Detached?)"}');
      if (user != null) {
        final tokenResult = await user.getIdTokenResult(true);
        print('🔍 DEBUG: Token Claims:');
        print('   - iss: ${tokenResult.claims?['iss']}');
        print('   - aud: ${tokenResult.claims?['aud']}');
        print('   - sub: ${tokenResult.claims?['sub']}');
        print('   - auth_time: ${tokenResult.claims?['auth_time']}');
      }

      // Auto-generate location code based on name
      final code = _generateLocationCode(name);

      // Use builder pattern for optional parameters
      final builder = BizPharmaConnector.instance.createLocation(
        businessId: businessId,
        name: name,
        code: code,
        type: type,
      );

      // Set optional parameters using builder methods
      if (phone != null) builder.phone(phone);
      if (email != null) builder.email(email);
      if (operatingHours != null) builder.operatingHours(operatingHours);
      if (licenseNumber != null) builder.licenseNumber(licenseNumber);

      await builder.execute();
      log('Location created: $name');
      return code;
    } catch (e) {
      log('Error creating location: $e');
      rethrow;
    }
  }

  /// Update an existing location
  Future<void> updateLocation({
    required String id,
    String? name,
    String? code,
    LocationType? type,
    String? phone,
    String? email,
    String? operatingHours,
    String? licenseNumber,
    bool? isActive,
  }) async {
    try {
      // Force token refresh
      await FirebaseAuth.instance.currentUser?.getIdToken(true);

      // Use builder pattern for optional parameters
      final builder = BizPharmaConnector.instance.updateLocation(id: id);

      // Set optional parameters using builder methods
      if (name != null) builder.name(name);
      if (code != null) builder.code(code);
      if (type != null) builder.type(type);
      if (phone != null) builder.phone(phone);
      if (email != null) builder.email(email);
      if (operatingHours != null) builder.operatingHours(operatingHours);
      if (licenseNumber != null) builder.licenseNumber(licenseNumber);
      if (isActive != null) builder.isActive(isActive);

      await builder.execute();
      log('Location updated: $id');
    } catch (e) {
      log('Error updating location: $e');
      rethrow;
    }
  }

  /// Deactivate a location (soft delete)
  Future<void> deactivateLocation(String id) async {
    try {
      await BizPharmaConnector.instance
          .updateLocation(id: id)
          .isActive(false)
          .execute();
      log('Location deactivated: $id');
    } catch (e) {
      log('Error deactivating location: $e');
      rethrow;
    }
  }

  /// Reactivate a previously deactivated location
  Future<void> reactivateLocation(String id) async {
    try {
      await BizPharmaConnector.instance
          .updateLocation(id: id)
          .isActive(true)
          .execute();
      log('Location reactivated: $id');
    } catch (e) {
      log('Error reactivating location: $e');
      rethrow;
    }
  }

  /// Generate a location code from the name
  /// Format: First 4 chars of name (uppercase) + 3 random digits
  String _generateLocationCode(String name) {
    final prefix = name
        .toUpperCase()
        .replaceAll(RegExp(r'[^A-Z]'), '')
        .padRight(4)
        .substring(0, 4);
    final suffix = (100 + DateTime.now().millisecondsSinceEpoch % 900)
        .toString()
        .substring(0, 3);
    return '$prefix-$suffix';
  }
}

/// Get display name for location type
String getLocationTypeDisplayName(LocationType type) {
  switch (type) {
    case LocationType.HEAD_OFFICE:
      return 'Head Office';
    case LocationType.REGIONAL_OFFICE:
      return 'Regional Office';
    case LocationType.REGIONAL_WAREHOUSE:
      return 'Regional Warehouse';
    case LocationType.RETAIL_STORE:
      return 'Retail Store';
    case LocationType.DISTRIBUTION_CENTER:
      return 'Distribution Center';
  }
}
