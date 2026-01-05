import 'package:biz_pharma/dataconnect_generated/biz_pharma.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final productServiceProvider = Provider((ref) => ProductService());

class ProductService {
  final BizPharmaConnector _connector;

  ProductService({BizPharmaConnector? connector})
    : _connector = connector ?? BizPharmaConnector.instance;

  Future<List<ListCategoriesByBusinessCategories>> listCategories(
    String businessId,
  ) async {
    // Force token refresh to ensure Data Connect gets a valid token
    await FirebaseAuth.instance.currentUser?.getIdToken(true);

    final result = await _connector
        .listCategoriesByBusiness(businessId: _fixUuid(businessId))
        .execute();
    return result.data.categories;
  }

  Future<void> createProduct({
    required String businessId,
    required String genericName,
    required String internalSKU,
    required String createdById,
    String? brandName,
    String? manufacturerId,
    String? nationalDrugCode,
    String? barcode,
    DosageForm? dosageForm,
    String? strength,
    String? unit,
    RouteOfAdministration? routeOfAdministration,
    DrugSchedule? drugSchedule,
    bool requiresPrescription = false,
    String? therapeuticClassId,
    int? packageSize,
    PackageUnit? packageUnit,
    String? primarySupplierId,
    int? leadTimeDays,
    int? reorderPoint,
    int? reorderQuantity,
    int? minimumStockLevel,
    String? categoryId,
  }) async {
    // Force token refresh
    await FirebaseAuth.instance.currentUser?.getIdToken(true);

    await _connector
        .createProduct(
          businessId: _fixUuid(businessId),
          genericName: genericName,
          internalSKU: internalSKU,
          createdById: createdById,
          updatedById: createdById,
          dosageForm: dosageForm ?? DosageForm.TABLET,
          strength: strength ?? "N/A",
          unit: unit ?? "N/A",
          routeOfAdministration:
              routeOfAdministration ?? RouteOfAdministration.ORAL,
          drugSchedule: drugSchedule ?? DrugSchedule.OVER_THE_COUNTER,
          requiresPrescription: requiresPrescription,
          packageSize: packageSize ?? 1,
          packageUnit: packageUnit ?? PackageUnit.BOX,
          leadTimeDays: leadTimeDays ?? 0,
          reorderPoint: reorderPoint ?? 0,
          reorderQuantity: reorderQuantity ?? 0,
          minimumStockLevel: minimumStockLevel ?? 0,
        )
        .brandName(brandName)
        // Now optional fields are chained
        .manufacturerId(manufacturerId)
        .nationalDrugCode(nationalDrugCode)
        .barcode(barcode)
        .therapeuticClassId(therapeuticClassId)
        .primarySupplierId(primarySupplierId)
        .categoryId(categoryId)
        .execute();
  }

  Future<void> createCategory({
    required String businessId,
    required String name,
    String? description,
    String? parentId,
  }) async {
    // Force token refresh
    await FirebaseAuth.instance.currentUser?.getIdToken(true);

    // Verify and normalize UUID format
    String formattedBusinessId = _fixUuid(businessId);

    try {
      final builder = _connector.createCategory(
        businessId: formattedBusinessId,
        name: name,
      );
      if (description != null) builder.description(description);
      if (parentId != null) builder.parentId(parentId);

      if (parentId != null) builder.parentId(parentId);

      await builder.execute();
    } catch (e) {
      // Re-throw to let UI handle it
      rethrow;
    }
  }
}

String _fixUuid(String id) {
  if (id.length == 32 && !id.contains('-')) {
    final fixed =
        '${id.substring(0, 8)}-${id.substring(8, 12)}-${id.substring(12, 16)}-${id.substring(16, 20)}-${id.substring(20)}';
    return fixed;
  }
  return id;
}
