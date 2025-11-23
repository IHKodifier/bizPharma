part of 'ik_pharma.dart';

class ListProductsByBusinessVariablesBuilder {
  String businessId;

  final FirebaseDataConnect _dataConnect;
  ListProductsByBusinessVariablesBuilder(this._dataConnect, {required  this.businessId,});
  Deserializer<ListProductsByBusinessData> dataDeserializer = (dynamic json)  => ListProductsByBusinessData.fromJson(jsonDecode(json));
  Serializer<ListProductsByBusinessVariables> varsSerializer = (ListProductsByBusinessVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListProductsByBusinessData, ListProductsByBusinessVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListProductsByBusinessData, ListProductsByBusinessVariables> ref() {
    ListProductsByBusinessVariables vars= ListProductsByBusinessVariables(businessId: businessId,);
    return _dataConnect.query("ListProductsByBusiness", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListProductsByBusinessProducts {
  final String id;
  final String businessId;
  final String genericName;
  final String? brandName;
  final String? nationalDrugCode;
  final String? barcode;
  final String? upc;
  final String internalSKU;
  final EnumValue<DosageForm> dosageForm;
  final String strength;
  final String unit;
  final EnumValue<RouteOfAdministration> routeOfAdministration;
  final EnumValue<DrugSchedule> drugSchedule;
  final bool requiresPrescription;
  final EnumValue<ProductCategory> category;
  final EnumValue<ProductSubcategory>? subcategory;
  final bool isActive;
  final bool isDiscontinued;
  final Timestamp createdAt;
  ListProductsByBusinessProducts.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  businessId = nativeFromJson<String>(json['businessId']),
  genericName = nativeFromJson<String>(json['genericName']),
  brandName = json['brandName'] == null ? null : nativeFromJson<String>(json['brandName']),
  nationalDrugCode = json['nationalDrugCode'] == null ? null : nativeFromJson<String>(json['nationalDrugCode']),
  barcode = json['barcode'] == null ? null : nativeFromJson<String>(json['barcode']),
  upc = json['upc'] == null ? null : nativeFromJson<String>(json['upc']),
  internalSKU = nativeFromJson<String>(json['internalSKU']),
  dosageForm = dosageFormDeserializer(json['dosageForm']),
  strength = nativeFromJson<String>(json['strength']),
  unit = nativeFromJson<String>(json['unit']),
  routeOfAdministration = routeOfAdministrationDeserializer(json['routeOfAdministration']),
  drugSchedule = drugScheduleDeserializer(json['drugSchedule']),
  requiresPrescription = nativeFromJson<bool>(json['requiresPrescription']),
  category = productCategoryDeserializer(json['category']),
  subcategory = json['subcategory'] == null ? null : productSubcategoryDeserializer(json['subcategory']),
  isActive = nativeFromJson<bool>(json['isActive']),
  isDiscontinued = nativeFromJson<bool>(json['isDiscontinued']),
  createdAt = Timestamp.fromJson(json['createdAt']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListProductsByBusinessProducts otherTyped = other as ListProductsByBusinessProducts;
    return id == otherTyped.id && 
    businessId == otherTyped.businessId && 
    genericName == otherTyped.genericName && 
    brandName == otherTyped.brandName && 
    nationalDrugCode == otherTyped.nationalDrugCode && 
    barcode == otherTyped.barcode && 
    upc == otherTyped.upc && 
    internalSKU == otherTyped.internalSKU && 
    dosageForm == otherTyped.dosageForm && 
    strength == otherTyped.strength && 
    unit == otherTyped.unit && 
    routeOfAdministration == otherTyped.routeOfAdministration && 
    drugSchedule == otherTyped.drugSchedule && 
    requiresPrescription == otherTyped.requiresPrescription && 
    category == otherTyped.category && 
    subcategory == otherTyped.subcategory && 
    isActive == otherTyped.isActive && 
    isDiscontinued == otherTyped.isDiscontinued && 
    createdAt == otherTyped.createdAt;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, businessId.hashCode, genericName.hashCode, brandName.hashCode, nationalDrugCode.hashCode, barcode.hashCode, upc.hashCode, internalSKU.hashCode, dosageForm.hashCode, strength.hashCode, unit.hashCode, routeOfAdministration.hashCode, drugSchedule.hashCode, requiresPrescription.hashCode, category.hashCode, subcategory.hashCode, isActive.hashCode, isDiscontinued.hashCode, createdAt.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['businessId'] = nativeToJson<String>(businessId);
    json['genericName'] = nativeToJson<String>(genericName);
    if (brandName != null) {
      json['brandName'] = nativeToJson<String?>(brandName);
    }
    if (nationalDrugCode != null) {
      json['nationalDrugCode'] = nativeToJson<String?>(nationalDrugCode);
    }
    if (barcode != null) {
      json['barcode'] = nativeToJson<String?>(barcode);
    }
    if (upc != null) {
      json['upc'] = nativeToJson<String?>(upc);
    }
    json['internalSKU'] = nativeToJson<String>(internalSKU);
    json['dosageForm'] = 
    dosageFormSerializer(dosageForm)
    ;
    json['strength'] = nativeToJson<String>(strength);
    json['unit'] = nativeToJson<String>(unit);
    json['routeOfAdministration'] = 
    routeOfAdministrationSerializer(routeOfAdministration)
    ;
    json['drugSchedule'] = 
    drugScheduleSerializer(drugSchedule)
    ;
    json['requiresPrescription'] = nativeToJson<bool>(requiresPrescription);
    json['category'] = 
    productCategorySerializer(category)
    ;
    if (subcategory != null) {
      json['subcategory'] = 
    productSubcategorySerializer(subcategory!)
    ;
    }
    json['isActive'] = nativeToJson<bool>(isActive);
    json['isDiscontinued'] = nativeToJson<bool>(isDiscontinued);
    json['createdAt'] = createdAt.toJson();
    return json;
  }

  ListProductsByBusinessProducts({
    required this.id,
    required this.businessId,
    required this.genericName,
    this.brandName,
    this.nationalDrugCode,
    this.barcode,
    this.upc,
    required this.internalSKU,
    required this.dosageForm,
    required this.strength,
    required this.unit,
    required this.routeOfAdministration,
    required this.drugSchedule,
    required this.requiresPrescription,
    required this.category,
    this.subcategory,
    required this.isActive,
    required this.isDiscontinued,
    required this.createdAt,
  });
}

@immutable
class ListProductsByBusinessData {
  final List<ListProductsByBusinessProducts> products;
  ListProductsByBusinessData.fromJson(dynamic json):
  
  products = (json['products'] as List<dynamic>)
        .map((e) => ListProductsByBusinessProducts.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListProductsByBusinessData otherTyped = other as ListProductsByBusinessData;
    return products == otherTyped.products;
    
  }
  @override
  int get hashCode => products.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['products'] = products.map((e) => e.toJson()).toList();
    return json;
  }

  ListProductsByBusinessData({
    required this.products,
  });
}

@immutable
class ListProductsByBusinessVariables {
  final String businessId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListProductsByBusinessVariables.fromJson(Map<String, dynamic> json):
  
  businessId = nativeFromJson<String>(json['businessId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListProductsByBusinessVariables otherTyped = other as ListProductsByBusinessVariables;
    return businessId == otherTyped.businessId;
    
  }
  @override
  int get hashCode => businessId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['businessId'] = nativeToJson<String>(businessId);
    return json;
  }

  ListProductsByBusinessVariables({
    required this.businessId,
  });
}

