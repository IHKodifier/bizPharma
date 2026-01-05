part of 'biz_pharma.dart';

class CreateProductVariablesBuilder {
  String businessId;
  String genericName;
  Optional<String> _brandName = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _manufacturerId = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _nationalDrugCode = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _barcode = Optional.optional(nativeFromJson, nativeToJson);
  String internalSKU;
  DosageForm dosageForm;
  String strength;
  String unit;
  RouteOfAdministration routeOfAdministration;
  DrugSchedule drugSchedule;
  bool requiresPrescription;
  Optional<String> _therapeuticClassId = Optional.optional(nativeFromJson, nativeToJson);
  int packageSize;
  PackageUnit packageUnit;
  Optional<String> _primarySupplierId = Optional.optional(nativeFromJson, nativeToJson);
  int leadTimeDays;
  int reorderPoint;
  int reorderQuantity;
  int minimumStockLevel;
  Optional<String> _categoryId = Optional.optional(nativeFromJson, nativeToJson);
  String createdById;
  String updatedById;

  final FirebaseDataConnect _dataConnect;  CreateProductVariablesBuilder brandName(String? t) {
   _brandName.value = t;
   return this;
  }
  CreateProductVariablesBuilder manufacturerId(String? t) {
   _manufacturerId.value = t;
   return this;
  }
  CreateProductVariablesBuilder nationalDrugCode(String? t) {
   _nationalDrugCode.value = t;
   return this;
  }
  CreateProductVariablesBuilder barcode(String? t) {
   _barcode.value = t;
   return this;
  }
  CreateProductVariablesBuilder therapeuticClassId(String? t) {
   _therapeuticClassId.value = t;
   return this;
  }
  CreateProductVariablesBuilder primarySupplierId(String? t) {
   _primarySupplierId.value = t;
   return this;
  }
  CreateProductVariablesBuilder categoryId(String? t) {
   _categoryId.value = t;
   return this;
  }

  CreateProductVariablesBuilder(this._dataConnect, {required  this.businessId,required  this.genericName,required  this.internalSKU,required  this.dosageForm,required  this.strength,required  this.unit,required  this.routeOfAdministration,required  this.drugSchedule,required  this.requiresPrescription,required  this.packageSize,required  this.packageUnit,required  this.leadTimeDays,required  this.reorderPoint,required  this.reorderQuantity,required  this.minimumStockLevel,required  this.createdById,required  this.updatedById,});
  Deserializer<CreateProductData> dataDeserializer = (dynamic json)  => CreateProductData.fromJson(jsonDecode(json));
  Serializer<CreateProductVariables> varsSerializer = (CreateProductVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateProductData, CreateProductVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateProductData, CreateProductVariables> ref() {
    CreateProductVariables vars= CreateProductVariables(businessId: businessId,genericName: genericName,brandName: _brandName,manufacturerId: _manufacturerId,nationalDrugCode: _nationalDrugCode,barcode: _barcode,internalSKU: internalSKU,dosageForm: dosageForm,strength: strength,unit: unit,routeOfAdministration: routeOfAdministration,drugSchedule: drugSchedule,requiresPrescription: requiresPrescription,therapeuticClassId: _therapeuticClassId,packageSize: packageSize,packageUnit: packageUnit,primarySupplierId: _primarySupplierId,leadTimeDays: leadTimeDays,reorderPoint: reorderPoint,reorderQuantity: reorderQuantity,minimumStockLevel: minimumStockLevel,categoryId: _categoryId,createdById: createdById,updatedById: updatedById,);
    return _dataConnect.mutation("CreateProduct", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateProductProductInsert {
  final String id;
  CreateProductProductInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateProductProductInsert otherTyped = other as CreateProductProductInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateProductProductInsert({
    required this.id,
  });
}

@immutable
class CreateProductData {
  final CreateProductProductInsert product_insert;
  CreateProductData.fromJson(dynamic json):
  
  product_insert = CreateProductProductInsert.fromJson(json['product_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateProductData otherTyped = other as CreateProductData;
    return product_insert == otherTyped.product_insert;
    
  }
  @override
  int get hashCode => product_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['product_insert'] = product_insert.toJson();
    return json;
  }

  CreateProductData({
    required this.product_insert,
  });
}

@immutable
class CreateProductVariables {
  final String businessId;
  final String genericName;
  late final Optional<String>brandName;
  late final Optional<String>manufacturerId;
  late final Optional<String>nationalDrugCode;
  late final Optional<String>barcode;
  final String internalSKU;
  final DosageForm dosageForm;
  final String strength;
  final String unit;
  final RouteOfAdministration routeOfAdministration;
  final DrugSchedule drugSchedule;
  final bool requiresPrescription;
  late final Optional<String>therapeuticClassId;
  final int packageSize;
  final PackageUnit packageUnit;
  late final Optional<String>primarySupplierId;
  final int leadTimeDays;
  final int reorderPoint;
  final int reorderQuantity;
  final int minimumStockLevel;
  late final Optional<String>categoryId;
  final String createdById;
  final String updatedById;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateProductVariables.fromJson(Map<String, dynamic> json):
  
  businessId = nativeFromJson<String>(json['businessId']),
  genericName = nativeFromJson<String>(json['genericName']),
  internalSKU = nativeFromJson<String>(json['internalSKU']),
  dosageForm = DosageForm.values.byName(json['dosageForm']),
  strength = nativeFromJson<String>(json['strength']),
  unit = nativeFromJson<String>(json['unit']),
  routeOfAdministration = RouteOfAdministration.values.byName(json['routeOfAdministration']),
  drugSchedule = DrugSchedule.values.byName(json['drugSchedule']),
  requiresPrescription = nativeFromJson<bool>(json['requiresPrescription']),
  packageSize = nativeFromJson<int>(json['packageSize']),
  packageUnit = PackageUnit.values.byName(json['packageUnit']),
  leadTimeDays = nativeFromJson<int>(json['leadTimeDays']),
  reorderPoint = nativeFromJson<int>(json['reorderPoint']),
  reorderQuantity = nativeFromJson<int>(json['reorderQuantity']),
  minimumStockLevel = nativeFromJson<int>(json['minimumStockLevel']),
  createdById = nativeFromJson<String>(json['createdById']),
  updatedById = nativeFromJson<String>(json['updatedById']) {
  
  
  
  
    brandName = Optional.optional(nativeFromJson, nativeToJson);
    brandName.value = json['brandName'] == null ? null : nativeFromJson<String>(json['brandName']);
  
  
    manufacturerId = Optional.optional(nativeFromJson, nativeToJson);
    manufacturerId.value = json['manufacturerId'] == null ? null : nativeFromJson<String>(json['manufacturerId']);
  
  
    nationalDrugCode = Optional.optional(nativeFromJson, nativeToJson);
    nationalDrugCode.value = json['nationalDrugCode'] == null ? null : nativeFromJson<String>(json['nationalDrugCode']);
  
  
    barcode = Optional.optional(nativeFromJson, nativeToJson);
    barcode.value = json['barcode'] == null ? null : nativeFromJson<String>(json['barcode']);
  
  
  
  
  
  
  
  
  
    therapeuticClassId = Optional.optional(nativeFromJson, nativeToJson);
    therapeuticClassId.value = json['therapeuticClassId'] == null ? null : nativeFromJson<String>(json['therapeuticClassId']);
  
  
  
  
    primarySupplierId = Optional.optional(nativeFromJson, nativeToJson);
    primarySupplierId.value = json['primarySupplierId'] == null ? null : nativeFromJson<String>(json['primarySupplierId']);
  
  
  
  
  
  
    categoryId = Optional.optional(nativeFromJson, nativeToJson);
    categoryId.value = json['categoryId'] == null ? null : nativeFromJson<String>(json['categoryId']);
  
  
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateProductVariables otherTyped = other as CreateProductVariables;
    return businessId == otherTyped.businessId && 
    genericName == otherTyped.genericName && 
    brandName == otherTyped.brandName && 
    manufacturerId == otherTyped.manufacturerId && 
    nationalDrugCode == otherTyped.nationalDrugCode && 
    barcode == otherTyped.barcode && 
    internalSKU == otherTyped.internalSKU && 
    dosageForm == otherTyped.dosageForm && 
    strength == otherTyped.strength && 
    unit == otherTyped.unit && 
    routeOfAdministration == otherTyped.routeOfAdministration && 
    drugSchedule == otherTyped.drugSchedule && 
    requiresPrescription == otherTyped.requiresPrescription && 
    therapeuticClassId == otherTyped.therapeuticClassId && 
    packageSize == otherTyped.packageSize && 
    packageUnit == otherTyped.packageUnit && 
    primarySupplierId == otherTyped.primarySupplierId && 
    leadTimeDays == otherTyped.leadTimeDays && 
    reorderPoint == otherTyped.reorderPoint && 
    reorderQuantity == otherTyped.reorderQuantity && 
    minimumStockLevel == otherTyped.minimumStockLevel && 
    categoryId == otherTyped.categoryId && 
    createdById == otherTyped.createdById && 
    updatedById == otherTyped.updatedById;
    
  }
  @override
  int get hashCode => Object.hashAll([businessId.hashCode, genericName.hashCode, brandName.hashCode, manufacturerId.hashCode, nationalDrugCode.hashCode, barcode.hashCode, internalSKU.hashCode, dosageForm.hashCode, strength.hashCode, unit.hashCode, routeOfAdministration.hashCode, drugSchedule.hashCode, requiresPrescription.hashCode, therapeuticClassId.hashCode, packageSize.hashCode, packageUnit.hashCode, primarySupplierId.hashCode, leadTimeDays.hashCode, reorderPoint.hashCode, reorderQuantity.hashCode, minimumStockLevel.hashCode, categoryId.hashCode, createdById.hashCode, updatedById.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['businessId'] = nativeToJson<String>(businessId);
    json['genericName'] = nativeToJson<String>(genericName);
    if(brandName.state == OptionalState.set) {
      json['brandName'] = brandName.toJson();
    }
    if(manufacturerId.state == OptionalState.set) {
      json['manufacturerId'] = manufacturerId.toJson();
    }
    if(nationalDrugCode.state == OptionalState.set) {
      json['nationalDrugCode'] = nationalDrugCode.toJson();
    }
    if(barcode.state == OptionalState.set) {
      json['barcode'] = barcode.toJson();
    }
    json['internalSKU'] = nativeToJson<String>(internalSKU);
    json['dosageForm'] = 
    dosageForm.name
    ;
    json['strength'] = nativeToJson<String>(strength);
    json['unit'] = nativeToJson<String>(unit);
    json['routeOfAdministration'] = 
    routeOfAdministration.name
    ;
    json['drugSchedule'] = 
    drugSchedule.name
    ;
    json['requiresPrescription'] = nativeToJson<bool>(requiresPrescription);
    if(therapeuticClassId.state == OptionalState.set) {
      json['therapeuticClassId'] = therapeuticClassId.toJson();
    }
    json['packageSize'] = nativeToJson<int>(packageSize);
    json['packageUnit'] = 
    packageUnit.name
    ;
    if(primarySupplierId.state == OptionalState.set) {
      json['primarySupplierId'] = primarySupplierId.toJson();
    }
    json['leadTimeDays'] = nativeToJson<int>(leadTimeDays);
    json['reorderPoint'] = nativeToJson<int>(reorderPoint);
    json['reorderQuantity'] = nativeToJson<int>(reorderQuantity);
    json['minimumStockLevel'] = nativeToJson<int>(minimumStockLevel);
    if(categoryId.state == OptionalState.set) {
      json['categoryId'] = categoryId.toJson();
    }
    json['createdById'] = nativeToJson<String>(createdById);
    json['updatedById'] = nativeToJson<String>(updatedById);
    return json;
  }

  CreateProductVariables({
    required this.businessId,
    required this.genericName,
    required this.brandName,
    required this.manufacturerId,
    required this.nationalDrugCode,
    required this.barcode,
    required this.internalSKU,
    required this.dosageForm,
    required this.strength,
    required this.unit,
    required this.routeOfAdministration,
    required this.drugSchedule,
    required this.requiresPrescription,
    required this.therapeuticClassId,
    required this.packageSize,
    required this.packageUnit,
    required this.primarySupplierId,
    required this.leadTimeDays,
    required this.reorderPoint,
    required this.reorderQuantity,
    required this.minimumStockLevel,
    required this.categoryId,
    required this.createdById,
    required this.updatedById,
  });
}

