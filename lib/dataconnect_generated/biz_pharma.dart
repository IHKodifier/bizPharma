library biz_pharma;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

part 'create_product.dart';

part 'list_all_users.dart';

part 'create_therapeutic_class.dart';

part 'list_products_by_business.dart';

part 'list_all_businesses.dart';

part 'create_user.dart';

part 'create_customer.dart';

part 'create_location.dart';

part 'create_purchase_order.dart';

part 'list_all_suppliers.dart';

part 'create_supplier.dart';

part 'list_locations_by_business.dart';

part 'list_all_products.dart';

part 'create_business_and_admin.dart';

part 'create_business.dart';

part 'delete_all_users.dart';

part 'create_product_pricing.dart';

part 'get_business_by_id.dart';

part 'list_all_locations.dart';

part 'list_pricing_by_location.dart';

part 'list_inventory_by_location.dart';

part 'verify_product.dart';

part 'get_user_by_auth_id.dart';

part 'list_all_customers.dart';

part 'create_address.dart';

part 'create_manufacturer.dart';

part 'delete_all_businesses.dart';

part 'create_inventory_level.dart';

part 'create_product_batch.dart';

part 'get_location_by_id.dart';

part 'update_location.dart';

part 'create_goods_receipt.dart';



  enum BusinessTier {
    
      TRIAL,
    
      PAID,
    
      ENTERPRISE,
    
  }
  
  String businessTierSerializer(EnumValue<BusinessTier> e) {
    return e.stringValue;
  }
  EnumValue<BusinessTier> businessTierDeserializer(dynamic data) {
    switch (data) {
      
      case 'TRIAL':
        return const Known(BusinessTier.TRIAL);
      
      case 'PAID':
        return const Known(BusinessTier.PAID);
      
      case 'ENTERPRISE':
        return const Known(BusinessTier.ENTERPRISE);
      
      default:
        return Unknown(data);
    }
  }
  

  enum CustomerTier {
    
      WALK_IN,
    
      BRONZE,
    
      SILVER,
    
      GOLD,
    
      DIAMOND,
    
      PLATINUM,
    
  }
  
  String customerTierSerializer(EnumValue<CustomerTier> e) {
    return e.stringValue;
  }
  EnumValue<CustomerTier> customerTierDeserializer(dynamic data) {
    switch (data) {
      
      case 'WALK_IN':
        return const Known(CustomerTier.WALK_IN);
      
      case 'BRONZE':
        return const Known(CustomerTier.BRONZE);
      
      case 'SILVER':
        return const Known(CustomerTier.SILVER);
      
      case 'GOLD':
        return const Known(CustomerTier.GOLD);
      
      case 'DIAMOND':
        return const Known(CustomerTier.DIAMOND);
      
      case 'PLATINUM':
        return const Known(CustomerTier.PLATINUM);
      
      default:
        return Unknown(data);
    }
  }
  

  enum DosageForm {
    
      TABLET,
    
      CAPSULE,
    
      SYRUP,
    
      SUSPENSION,
    
      INJECTION,
    
      CREAM,
    
      OINTMENT,
    
      LOTION,
    
      GEL,
    
      DROPS,
    
      INHALER,
    
      PATCH,
    
      SUPPOSITORY,
    
      POWDER,
    
      SOLUTION,
    
      OTHER,
    
  }
  
  String dosageFormSerializer(EnumValue<DosageForm> e) {
    return e.stringValue;
  }
  EnumValue<DosageForm> dosageFormDeserializer(dynamic data) {
    switch (data) {
      
      case 'TABLET':
        return const Known(DosageForm.TABLET);
      
      case 'CAPSULE':
        return const Known(DosageForm.CAPSULE);
      
      case 'SYRUP':
        return const Known(DosageForm.SYRUP);
      
      case 'SUSPENSION':
        return const Known(DosageForm.SUSPENSION);
      
      case 'INJECTION':
        return const Known(DosageForm.INJECTION);
      
      case 'CREAM':
        return const Known(DosageForm.CREAM);
      
      case 'OINTMENT':
        return const Known(DosageForm.OINTMENT);
      
      case 'LOTION':
        return const Known(DosageForm.LOTION);
      
      case 'GEL':
        return const Known(DosageForm.GEL);
      
      case 'DROPS':
        return const Known(DosageForm.DROPS);
      
      case 'INHALER':
        return const Known(DosageForm.INHALER);
      
      case 'PATCH':
        return const Known(DosageForm.PATCH);
      
      case 'SUPPOSITORY':
        return const Known(DosageForm.SUPPOSITORY);
      
      case 'POWDER':
        return const Known(DosageForm.POWDER);
      
      case 'SOLUTION':
        return const Known(DosageForm.SOLUTION);
      
      case 'OTHER':
        return const Known(DosageForm.OTHER);
      
      default:
        return Unknown(data);
    }
  }
  

  enum DrugSchedule {
    
      PRESCRIPTION_ONLY,
    
      OVER_THE_COUNTER,
    
      BEHIND_THE_COUNTER,
    
      CONTROLLED_SUBSTANCE,
    
      INVESTIGATIONAL,
    
  }
  
  String drugScheduleSerializer(EnumValue<DrugSchedule> e) {
    return e.stringValue;
  }
  EnumValue<DrugSchedule> drugScheduleDeserializer(dynamic data) {
    switch (data) {
      
      case 'PRESCRIPTION_ONLY':
        return const Known(DrugSchedule.PRESCRIPTION_ONLY);
      
      case 'OVER_THE_COUNTER':
        return const Known(DrugSchedule.OVER_THE_COUNTER);
      
      case 'BEHIND_THE_COUNTER':
        return const Known(DrugSchedule.BEHIND_THE_COUNTER);
      
      case 'CONTROLLED_SUBSTANCE':
        return const Known(DrugSchedule.CONTROLLED_SUBSTANCE);
      
      case 'INVESTIGATIONAL':
        return const Known(DrugSchedule.INVESTIGATIONAL);
      
      default:
        return Unknown(data);
    }
  }
  

  enum GoodsReceiptStatus {
    
      PENDING,
    
      RECEIVED,
    
      INSPECTED,
    
      ACCEPTED,
    
      REJECTED,
    
  }
  
  String goodsReceiptStatusSerializer(EnumValue<GoodsReceiptStatus> e) {
    return e.stringValue;
  }
  EnumValue<GoodsReceiptStatus> goodsReceiptStatusDeserializer(dynamic data) {
    switch (data) {
      
      case 'PENDING':
        return const Known(GoodsReceiptStatus.PENDING);
      
      case 'RECEIVED':
        return const Known(GoodsReceiptStatus.RECEIVED);
      
      case 'INSPECTED':
        return const Known(GoodsReceiptStatus.INSPECTED);
      
      case 'ACCEPTED':
        return const Known(GoodsReceiptStatus.ACCEPTED);
      
      case 'REJECTED':
        return const Known(GoodsReceiptStatus.REJECTED);
      
      default:
        return Unknown(data);
    }
  }
  

  enum LocationType {
    
      HEAD_OFFICE,
    
      REGIONAL_OFFICE,
    
      REGIONAL_WAREHOUSE,
    
      RETAIL_STORE,
    
      DISTRIBUTION_CENTER,
    
  }
  
  String locationTypeSerializer(EnumValue<LocationType> e) {
    return e.stringValue;
  }
  EnumValue<LocationType> locationTypeDeserializer(dynamic data) {
    switch (data) {
      
      case 'HEAD_OFFICE':
        return const Known(LocationType.HEAD_OFFICE);
      
      case 'REGIONAL_OFFICE':
        return const Known(LocationType.REGIONAL_OFFICE);
      
      case 'REGIONAL_WAREHOUSE':
        return const Known(LocationType.REGIONAL_WAREHOUSE);
      
      case 'RETAIL_STORE':
        return const Known(LocationType.RETAIL_STORE);
      
      case 'DISTRIBUTION_CENTER':
        return const Known(LocationType.DISTRIBUTION_CENTER);
      
      default:
        return Unknown(data);
    }
  }
  

  enum PackageUnit {
    
      BOTTLE,
    
      BOX,
    
      BLISTER_PACK,
    
      VIAL,
    
      AMPULE,
    
      TUBE,
    
      JAR,
    
      POUCH,
    
      STRIP,
    
      OTHER,
    
  }
  
  String packageUnitSerializer(EnumValue<PackageUnit> e) {
    return e.stringValue;
  }
  EnumValue<PackageUnit> packageUnitDeserializer(dynamic data) {
    switch (data) {
      
      case 'BOTTLE':
        return const Known(PackageUnit.BOTTLE);
      
      case 'BOX':
        return const Known(PackageUnit.BOX);
      
      case 'BLISTER_PACK':
        return const Known(PackageUnit.BLISTER_PACK);
      
      case 'VIAL':
        return const Known(PackageUnit.VIAL);
      
      case 'AMPULE':
        return const Known(PackageUnit.AMPULE);
      
      case 'TUBE':
        return const Known(PackageUnit.TUBE);
      
      case 'JAR':
        return const Known(PackageUnit.JAR);
      
      case 'POUCH':
        return const Known(PackageUnit.POUCH);
      
      case 'STRIP':
        return const Known(PackageUnit.STRIP);
      
      case 'OTHER':
        return const Known(PackageUnit.OTHER);
      
      default:
        return Unknown(data);
    }
  }
  

  enum ProductCategory {
    
      PHARMACEUTICAL,
    
      OTC_MEDICINE,
    
      MEDICAL_DEVICE,
    
      SUPPLEMENT,
    
      PERSONAL_CARE,
    
      OTHER,
    
  }
  
  String productCategorySerializer(EnumValue<ProductCategory> e) {
    return e.stringValue;
  }
  EnumValue<ProductCategory> productCategoryDeserializer(dynamic data) {
    switch (data) {
      
      case 'PHARMACEUTICAL':
        return const Known(ProductCategory.PHARMACEUTICAL);
      
      case 'OTC_MEDICINE':
        return const Known(ProductCategory.OTC_MEDICINE);
      
      case 'MEDICAL_DEVICE':
        return const Known(ProductCategory.MEDICAL_DEVICE);
      
      case 'SUPPLEMENT':
        return const Known(ProductCategory.SUPPLEMENT);
      
      case 'PERSONAL_CARE':
        return const Known(ProductCategory.PERSONAL_CARE);
      
      case 'OTHER':
        return const Known(ProductCategory.OTHER);
      
      default:
        return Unknown(data);
    }
  }
  

  enum ProductSubcategory {
    
      ANALGESICS,
    
      ANTIBIOTICS,
    
      CARDIOVASCULAR,
    
      DIABETES,
    
      DERMATOLOGY,
    
      GASTROINTESTINAL,
    
      NEUROLOGY,
    
      ONCOLOGY,
    
      OPHTHALMOLOGY,
    
      PEDIATRICS,
    
      PSYCHIATRY,
    
      RESPIRATORY,
    
      UROLOGY,
    
      VITAMINS,
    
      MINERALS,
    
      HERBALS,
    
      COSMETICS,
    
      SKIN_CARE,
    
      HAIR_CARE,
    
      ORAL_CARE,
    
      OTHER,
    
  }
  
  String productSubcategorySerializer(EnumValue<ProductSubcategory> e) {
    return e.stringValue;
  }
  EnumValue<ProductSubcategory> productSubcategoryDeserializer(dynamic data) {
    switch (data) {
      
      case 'ANALGESICS':
        return const Known(ProductSubcategory.ANALGESICS);
      
      case 'ANTIBIOTICS':
        return const Known(ProductSubcategory.ANTIBIOTICS);
      
      case 'CARDIOVASCULAR':
        return const Known(ProductSubcategory.CARDIOVASCULAR);
      
      case 'DIABETES':
        return const Known(ProductSubcategory.DIABETES);
      
      case 'DERMATOLOGY':
        return const Known(ProductSubcategory.DERMATOLOGY);
      
      case 'GASTROINTESTINAL':
        return const Known(ProductSubcategory.GASTROINTESTINAL);
      
      case 'NEUROLOGY':
        return const Known(ProductSubcategory.NEUROLOGY);
      
      case 'ONCOLOGY':
        return const Known(ProductSubcategory.ONCOLOGY);
      
      case 'OPHTHALMOLOGY':
        return const Known(ProductSubcategory.OPHTHALMOLOGY);
      
      case 'PEDIATRICS':
        return const Known(ProductSubcategory.PEDIATRICS);
      
      case 'PSYCHIATRY':
        return const Known(ProductSubcategory.PSYCHIATRY);
      
      case 'RESPIRATORY':
        return const Known(ProductSubcategory.RESPIRATORY);
      
      case 'UROLOGY':
        return const Known(ProductSubcategory.UROLOGY);
      
      case 'VITAMINS':
        return const Known(ProductSubcategory.VITAMINS);
      
      case 'MINERALS':
        return const Known(ProductSubcategory.MINERALS);
      
      case 'HERBALS':
        return const Known(ProductSubcategory.HERBALS);
      
      case 'COSMETICS':
        return const Known(ProductSubcategory.COSMETICS);
      
      case 'SKIN_CARE':
        return const Known(ProductSubcategory.SKIN_CARE);
      
      case 'HAIR_CARE':
        return const Known(ProductSubcategory.HAIR_CARE);
      
      case 'ORAL_CARE':
        return const Known(ProductSubcategory.ORAL_CARE);
      
      case 'OTHER':
        return const Known(ProductSubcategory.OTHER);
      
      default:
        return Unknown(data);
    }
  }
  

  enum PurchaseOrderStatus {
    
      DRAFT,
    
      PENDING_APPROVAL,
    
      APPROVED,
    
      ORDERED,
    
      PARTIALLY_RECEIVED,
    
      RECEIVED,
    
      CANCELLED,
    
  }
  
  String purchaseOrderStatusSerializer(EnumValue<PurchaseOrderStatus> e) {
    return e.stringValue;
  }
  EnumValue<PurchaseOrderStatus> purchaseOrderStatusDeserializer(dynamic data) {
    switch (data) {
      
      case 'DRAFT':
        return const Known(PurchaseOrderStatus.DRAFT);
      
      case 'PENDING_APPROVAL':
        return const Known(PurchaseOrderStatus.PENDING_APPROVAL);
      
      case 'APPROVED':
        return const Known(PurchaseOrderStatus.APPROVED);
      
      case 'ORDERED':
        return const Known(PurchaseOrderStatus.ORDERED);
      
      case 'PARTIALLY_RECEIVED':
        return const Known(PurchaseOrderStatus.PARTIALLY_RECEIVED);
      
      case 'RECEIVED':
        return const Known(PurchaseOrderStatus.RECEIVED);
      
      case 'CANCELLED':
        return const Known(PurchaseOrderStatus.CANCELLED);
      
      default:
        return Unknown(data);
    }
  }
  

  enum RouteOfAdministration {
    
      ORAL,
    
      TOPICAL,
    
      INTRAVENOUS,
    
      INTRAMUSCULAR,
    
      SUBCUTANEOUS,
    
      INHALATION,
    
      RECTAL,
    
      VAGINAL,
    
      OPHTHALMIC,
    
      OTIC,
    
      NASAL,
    
      TRANSDERMAL,
    
      OTHER,
    
  }
  
  String routeOfAdministrationSerializer(EnumValue<RouteOfAdministration> e) {
    return e.stringValue;
  }
  EnumValue<RouteOfAdministration> routeOfAdministrationDeserializer(dynamic data) {
    switch (data) {
      
      case 'ORAL':
        return const Known(RouteOfAdministration.ORAL);
      
      case 'TOPICAL':
        return const Known(RouteOfAdministration.TOPICAL);
      
      case 'INTRAVENOUS':
        return const Known(RouteOfAdministration.INTRAVENOUS);
      
      case 'INTRAMUSCULAR':
        return const Known(RouteOfAdministration.INTRAMUSCULAR);
      
      case 'SUBCUTANEOUS':
        return const Known(RouteOfAdministration.SUBCUTANEOUS);
      
      case 'INHALATION':
        return const Known(RouteOfAdministration.INHALATION);
      
      case 'RECTAL':
        return const Known(RouteOfAdministration.RECTAL);
      
      case 'VAGINAL':
        return const Known(RouteOfAdministration.VAGINAL);
      
      case 'OPHTHALMIC':
        return const Known(RouteOfAdministration.OPHTHALMIC);
      
      case 'OTIC':
        return const Known(RouteOfAdministration.OTIC);
      
      case 'NASAL':
        return const Known(RouteOfAdministration.NASAL);
      
      case 'TRANSDERMAL':
        return const Known(RouteOfAdministration.TRANSDERMAL);
      
      case 'OTHER':
        return const Known(RouteOfAdministration.OTHER);
      
      default:
        return Unknown(data);
    }
  }
  

  enum SupplierTier {
    
      PREFERRED,
    
      STANDARD,
    
      BACKUP,
    
      TRIAL,
    
  }
  
  String supplierTierSerializer(EnumValue<SupplierTier> e) {
    return e.stringValue;
  }
  EnumValue<SupplierTier> supplierTierDeserializer(dynamic data) {
    switch (data) {
      
      case 'PREFERRED':
        return const Known(SupplierTier.PREFERRED);
      
      case 'STANDARD':
        return const Known(SupplierTier.STANDARD);
      
      case 'BACKUP':
        return const Known(SupplierTier.BACKUP);
      
      case 'TRIAL':
        return const Known(SupplierTier.TRIAL);
      
      default:
        return Unknown(data);
    }
  }
  

  enum SupplierType {
    
      MANUFACTURER,
    
      DISTRIBUTOR,
    
      WHOLESALER,
    
      IMPORTER,
    
  }
  
  String supplierTypeSerializer(EnumValue<SupplierType> e) {
    return e.stringValue;
  }
  EnumValue<SupplierType> supplierTypeDeserializer(dynamic data) {
    switch (data) {
      
      case 'MANUFACTURER':
        return const Known(SupplierType.MANUFACTURER);
      
      case 'DISTRIBUTOR':
        return const Known(SupplierType.DISTRIBUTOR);
      
      case 'WHOLESALER':
        return const Known(SupplierType.WHOLESALER);
      
      case 'IMPORTER':
        return const Known(SupplierType.IMPORTER);
      
      default:
        return Unknown(data);
    }
  }
  

  enum UserRole {
    
      BUSINESS_ADMIN,
    
      WAREHOUSE_MANAGER,
    
      PROCUREMENT_MANAGER,
    
      SALES_MANAGER,
    
      STORE_MANAGER,
    
      CASHIER_POS_OPERATOR,
    
      DISTRICT_AREA_MANAGER,
    
      BILLING_SPECIALIST_ACCOUNTANT,
    
      CLINICAL_SERVICES_COORDINATOR,
    
      DATA_ANALYST,
    
      OPERATIONS_MANAGER,
    
      FRONT_END_SUPERVISOR,
    
      RECEIVING_STOCK_CLERK,
    
      DELIVERY_LOGISTICS_COORDINATOR,
    
  }
  
  String userRoleSerializer(EnumValue<UserRole> e) {
    return e.stringValue;
  }
  EnumValue<UserRole> userRoleDeserializer(dynamic data) {
    switch (data) {
      
      case 'BUSINESS_ADMIN':
        return const Known(UserRole.BUSINESS_ADMIN);
      
      case 'WAREHOUSE_MANAGER':
        return const Known(UserRole.WAREHOUSE_MANAGER);
      
      case 'PROCUREMENT_MANAGER':
        return const Known(UserRole.PROCUREMENT_MANAGER);
      
      case 'SALES_MANAGER':
        return const Known(UserRole.SALES_MANAGER);
      
      case 'STORE_MANAGER':
        return const Known(UserRole.STORE_MANAGER);
      
      case 'CASHIER_POS_OPERATOR':
        return const Known(UserRole.CASHIER_POS_OPERATOR);
      
      case 'DISTRICT_AREA_MANAGER':
        return const Known(UserRole.DISTRICT_AREA_MANAGER);
      
      case 'BILLING_SPECIALIST_ACCOUNTANT':
        return const Known(UserRole.BILLING_SPECIALIST_ACCOUNTANT);
      
      case 'CLINICAL_SERVICES_COORDINATOR':
        return const Known(UserRole.CLINICAL_SERVICES_COORDINATOR);
      
      case 'DATA_ANALYST':
        return const Known(UserRole.DATA_ANALYST);
      
      case 'OPERATIONS_MANAGER':
        return const Known(UserRole.OPERATIONS_MANAGER);
      
      case 'FRONT_END_SUPERVISOR':
        return const Known(UserRole.FRONT_END_SUPERVISOR);
      
      case 'RECEIVING_STOCK_CLERK':
        return const Known(UserRole.RECEIVING_STOCK_CLERK);
      
      case 'DELIVERY_LOGISTICS_COORDINATOR':
        return const Known(UserRole.DELIVERY_LOGISTICS_COORDINATOR);
      
      default:
        return Unknown(data);
    }
  }
  



String enumSerializer(Enum e) {
  return e.name;
}



/// A sealed class representing either a known enum value or an unknown string value.
@immutable
sealed class EnumValue<T extends Enum> {
  const EnumValue();

  

  /// The string representation of the value.
  String get stringValue;
  @override
  String toString() {
    return "EnumValue($stringValue)";
  }
}

/// Represents a known, valid enum value.
class Known<T extends Enum> extends EnumValue<T> {
  /// The actual enum value.
  final T value;

  const Known(this.value);

  @override
  String get stringValue => value.name;

  @override
  String toString() {
    return "Known($stringValue)";
  }
}
/// Represents an unknown or unrecognized enum value.
class Unknown extends EnumValue<Never> {
  /// The raw string value that couldn't be mapped to a known enum.
  @override
  final String stringValue;

  const Unknown(this.stringValue);
  @override
  String toString() {
    return "Unknown($stringValue)";
  }
}

class BizPharmaConnector {
  
  
  CreateProductVariablesBuilder createProduct ({required String businessId, required String genericName, required String manufacturerId, required String internalSKU, required DosageForm dosageForm, required String strength, required String unit, required RouteOfAdministration routeOfAdministration, required DrugSchedule drugSchedule, required bool requiresPrescription, required String therapeuticClassId, required int packageSize, required PackageUnit packageUnit, required String primarySupplierId, required int leadTimeDays, required int reorderPoint, required int reorderQuantity, required int minimumStockLevel, required ProductCategory category, required String createdById, required String updatedById, }) {
    return CreateProductVariablesBuilder(dataConnect, businessId: businessId,genericName: genericName,manufacturerId: manufacturerId,internalSKU: internalSKU,dosageForm: dosageForm,strength: strength,unit: unit,routeOfAdministration: routeOfAdministration,drugSchedule: drugSchedule,requiresPrescription: requiresPrescription,therapeuticClassId: therapeuticClassId,packageSize: packageSize,packageUnit: packageUnit,primarySupplierId: primarySupplierId,leadTimeDays: leadTimeDays,reorderPoint: reorderPoint,reorderQuantity: reorderQuantity,minimumStockLevel: minimumStockLevel,category: category,createdById: createdById,updatedById: updatedById,);
  }
  
  
  ListAllUsersVariablesBuilder listAllUsers () {
    return ListAllUsersVariablesBuilder(dataConnect, );
  }
  
  
  CreateTherapeuticClassVariablesBuilder createTherapeuticClass ({required String code, required String name, }) {
    return CreateTherapeuticClassVariablesBuilder(dataConnect, code: code,name: name,);
  }
  
  
  ListProductsByBusinessVariablesBuilder listProductsByBusiness ({required String businessId, }) {
    return ListProductsByBusinessVariablesBuilder(dataConnect, businessId: businessId,);
  }
  
  
  ListAllBusinessesVariablesBuilder listAllBusinesses () {
    return ListAllBusinessesVariablesBuilder(dataConnect, );
  }
  
  
  CreateUserVariablesBuilder createUser ({required String id, required String businessId, required String email, required String firstName, required String lastName, required String mobile, required UserRole role, }) {
    return CreateUserVariablesBuilder(dataConnect, id: id,businessId: businessId,email: email,firstName: firstName,lastName: lastName,mobile: mobile,role: role,);
  }
  
  
  CreateCustomerVariablesBuilder createCustomer ({required String businessId, required String firstName, required String lastName, required String createdById, }) {
    return CreateCustomerVariablesBuilder(dataConnect, businessId: businessId,firstName: firstName,lastName: lastName,createdById: createdById,);
  }
  
  
  CreateLocationVariablesBuilder createLocation ({required String businessId, required String name, required String code, required LocationType type, }) {
    return CreateLocationVariablesBuilder(dataConnect, businessId: businessId,name: name,code: code,type: type,);
  }
  
  
  CreatePurchaseOrderVariablesBuilder createPurchaseOrder ({required String businessId, required String supplierId, required String orderNumber, required double totalAmount, required double subtotal, required double taxAmount, required PurchaseOrderStatus status, required String createdById, }) {
    return CreatePurchaseOrderVariablesBuilder(dataConnect, businessId: businessId,supplierId: supplierId,orderNumber: orderNumber,totalAmount: totalAmount,subtotal: subtotal,taxAmount: taxAmount,status: status,createdById: createdById,);
  }
  
  
  ListAllSuppliersVariablesBuilder listAllSuppliers () {
    return ListAllSuppliersVariablesBuilder(dataConnect, );
  }
  
  
  CreateSupplierVariablesBuilder createSupplier ({required String businessId, required String name, required SupplierType type, required String paymentTerms, required SupplierTier tier, }) {
    return CreateSupplierVariablesBuilder(dataConnect, businessId: businessId,name: name,type: type,paymentTerms: paymentTerms,tier: tier,);
  }
  
  
  ListLocationsByBusinessVariablesBuilder listLocationsByBusiness ({required String businessId, }) {
    return ListLocationsByBusinessVariablesBuilder(dataConnect, businessId: businessId,);
  }
  
  
  ListAllProductsVariablesBuilder listAllProducts () {
    return ListAllProductsVariablesBuilder(dataConnect, );
  }
  
  
  CreateBusinessAndAdminVariablesBuilder createBusinessAndAdmin ({required String businessId, required String businessName, required String userEmail, required String userFirstName, required String userLastName, required String userMobile, required String authUid, required DateTime today, required String defaultLocationId, }) {
    return CreateBusinessAndAdminVariablesBuilder(dataConnect, businessId: businessId,businessName: businessName,userEmail: userEmail,userFirstName: userFirstName,userLastName: userLastName,userMobile: userMobile,authUid: authUid,today: today,defaultLocationId: defaultLocationId,);
  }
  
  
  CreateBusinessVariablesBuilder createBusiness ({required String name, required BusinessTier tier, required DateTime subscriptionStartDate, }) {
    return CreateBusinessVariablesBuilder(dataConnect, name: name,tier: tier,subscriptionStartDate: subscriptionStartDate,);
  }
  
  
  DeleteAllUsersVariablesBuilder deleteAllUsers () {
    return DeleteAllUsersVariablesBuilder(dataConnect, );
  }
  
  
  CreateProductPricingVariablesBuilder createProductPricing ({required String productId, required String businessId, required double wholesaleCost, required double retailPrice, required double walkInPrice, required double grossMarginPercent, required double markupPercent, required double taxRate, required DateTime effectiveDate, required String updatedById, }) {
    return CreateProductPricingVariablesBuilder(dataConnect, productId: productId,businessId: businessId,wholesaleCost: wholesaleCost,retailPrice: retailPrice,walkInPrice: walkInPrice,grossMarginPercent: grossMarginPercent,markupPercent: markupPercent,taxRate: taxRate,effectiveDate: effectiveDate,updatedById: updatedById,);
  }
  
  
  GetBusinessByIdVariablesBuilder getBusinessById ({required String id, }) {
    return GetBusinessByIdVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListAllLocationsVariablesBuilder listAllLocations () {
    return ListAllLocationsVariablesBuilder(dataConnect, );
  }
  
  
  ListPricingByLocationVariablesBuilder listPricingByLocation ({required String businessId, }) {
    return ListPricingByLocationVariablesBuilder(dataConnect, businessId: businessId,);
  }
  
  
  ListInventoryByLocationVariablesBuilder listInventoryByLocation ({required String locationId, }) {
    return ListInventoryByLocationVariablesBuilder(dataConnect, locationId: locationId,);
  }
  
  
  VerifyProductVariablesBuilder verifyProduct () {
    return VerifyProductVariablesBuilder(dataConnect, );
  }
  
  
  GetUserByAuthIdVariablesBuilder getUserByAuthId ({required String id, }) {
    return GetUserByAuthIdVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListAllCustomersVariablesBuilder listAllCustomers () {
    return ListAllCustomersVariablesBuilder(dataConnect, );
  }
  
  
  CreateAddressVariablesBuilder createAddress ({required String line1, required String city, required String state, required String postalCode, required String country, }) {
    return CreateAddressVariablesBuilder(dataConnect, line1: line1,city: city,state: state,postalCode: postalCode,country: country,);
  }
  
  
  CreateManufacturerVariablesBuilder createManufacturer ({required String name, required String country, }) {
    return CreateManufacturerVariablesBuilder(dataConnect, name: name,country: country,);
  }
  
  
  DeleteAllBusinessesVariablesBuilder deleteAllBusinesses () {
    return DeleteAllBusinessesVariablesBuilder(dataConnect, );
  }
  
  
  CreateInventoryLevelVariablesBuilder createInventoryLevel ({required String productId, required String locationId, required String businessId, required int quantityOnHand, required int quantityAvailable, required double averageCost, required double totalValue, }) {
    return CreateInventoryLevelVariablesBuilder(dataConnect, productId: productId,locationId: locationId,businessId: businessId,quantityOnHand: quantityOnHand,quantityAvailable: quantityAvailable,averageCost: averageCost,totalValue: totalValue,);
  }
  
  
  CreateProductBatchVariablesBuilder createProductBatch ({required String productId, required String businessId, required String batchNumber, required String lotNumber, required DateTime manufacturingDate, required DateTime expiryDate, required String supplierId, required String goodsReceiptId, required DateTime receivedDate, required double unitCost, required double totalCost, required int totalQuantity, required int quantityRemaining, required String locationId, required String createdById, required String updatedById, }) {
    return CreateProductBatchVariablesBuilder(dataConnect, productId: productId,businessId: businessId,batchNumber: batchNumber,lotNumber: lotNumber,manufacturingDate: manufacturingDate,expiryDate: expiryDate,supplierId: supplierId,goodsReceiptId: goodsReceiptId,receivedDate: receivedDate,unitCost: unitCost,totalCost: totalCost,totalQuantity: totalQuantity,quantityRemaining: quantityRemaining,locationId: locationId,createdById: createdById,updatedById: updatedById,);
  }
  
  
  GetLocationByIdVariablesBuilder getLocationById ({required String id, }) {
    return GetLocationByIdVariablesBuilder(dataConnect, id: id,);
  }
  
  
  UpdateLocationVariablesBuilder updateLocation ({required String id, }) {
    return UpdateLocationVariablesBuilder(dataConnect, id: id,);
  }
  
  
  CreateGoodsReceiptVariablesBuilder createGoodsReceipt ({required String purchaseOrderId, required String businessId, required String receiptNumber, required GoodsReceiptStatus status, required String inspectedById, }) {
    return CreateGoodsReceiptVariablesBuilder(dataConnect, purchaseOrderId: purchaseOrderId,businessId: businessId,receiptNumber: receiptNumber,status: status,inspectedById: inspectedById,);
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'asia-south1',
    'biz-pharma',
    'bizpharma-service',
  );

  BizPharmaConnector({required this.dataConnect});
  static BizPharmaConnector get instance {
    return BizPharmaConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}
