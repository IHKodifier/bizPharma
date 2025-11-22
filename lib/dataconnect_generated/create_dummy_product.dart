part of 'ik_pharma.dart';

class CreateDummyProductVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  CreateDummyProductVariablesBuilder(this._dataConnect, );
  Deserializer<CreateDummyProductData> dataDeserializer = (dynamic json)  => CreateDummyProductData.fromJson(jsonDecode(json));
  
  Future<OperationResult<CreateDummyProductData, void>> execute() {
    return ref().execute();
  }

  MutationRef<CreateDummyProductData, void> ref() {
    
    return _dataConnect.mutation("createDummyProduct", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class CreateDummyProductBusinessInsert {
  final String id;
  CreateDummyProductBusinessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateDummyProductBusinessInsert otherTyped = other as CreateDummyProductBusinessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateDummyProductBusinessInsert({
    required this.id,
  });
}

@immutable
class CreateDummyProductUserInsert {
  final String id;
  CreateDummyProductUserInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateDummyProductUserInsert otherTyped = other as CreateDummyProductUserInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateDummyProductUserInsert({
    required this.id,
  });
}

@immutable
class CreateDummyProductManufacturerInsert {
  final String id;
  CreateDummyProductManufacturerInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateDummyProductManufacturerInsert otherTyped = other as CreateDummyProductManufacturerInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateDummyProductManufacturerInsert({
    required this.id,
  });
}

@immutable
class CreateDummyProductTherapeuticClassInsert {
  final String id;
  CreateDummyProductTherapeuticClassInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateDummyProductTherapeuticClassInsert otherTyped = other as CreateDummyProductTherapeuticClassInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateDummyProductTherapeuticClassInsert({
    required this.id,
  });
}

@immutable
class CreateDummyProductAddressInsert {
  final String id;
  CreateDummyProductAddressInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateDummyProductAddressInsert otherTyped = other as CreateDummyProductAddressInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateDummyProductAddressInsert({
    required this.id,
  });
}

@immutable
class CreateDummyProductDateRangeInsert {
  final String id;
  CreateDummyProductDateRangeInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateDummyProductDateRangeInsert otherTyped = other as CreateDummyProductDateRangeInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateDummyProductDateRangeInsert({
    required this.id,
  });
}

@immutable
class CreateDummyProductSupplierInsert {
  final String id;
  CreateDummyProductSupplierInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateDummyProductSupplierInsert otherTyped = other as CreateDummyProductSupplierInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateDummyProductSupplierInsert({
    required this.id,
  });
}

@immutable
class CreateDummyProductSupplierPerformanceScoreInsert {
  final String id;
  CreateDummyProductSupplierPerformanceScoreInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateDummyProductSupplierPerformanceScoreInsert otherTyped = other as CreateDummyProductSupplierPerformanceScoreInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateDummyProductSupplierPerformanceScoreInsert({
    required this.id,
  });
}

@immutable
class CreateDummyProductProductInsert {
  final String id;
  CreateDummyProductProductInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateDummyProductProductInsert otherTyped = other as CreateDummyProductProductInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateDummyProductProductInsert({
    required this.id,
  });
}

@immutable
class CreateDummyProductProductPricingInsert {
  final String id;
  CreateDummyProductProductPricingInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateDummyProductProductPricingInsert otherTyped = other as CreateDummyProductProductPricingInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateDummyProductProductPricingInsert({
    required this.id,
  });
}

@immutable
class CreateDummyProductExpiryWarningThresholdsInsert {
  final String id;
  CreateDummyProductExpiryWarningThresholdsInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateDummyProductExpiryWarningThresholdsInsert otherTyped = other as CreateDummyProductExpiryWarningThresholdsInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateDummyProductExpiryWarningThresholdsInsert({
    required this.id,
  });
}

@immutable
class CreateDummyProductData {
  final CreateDummyProductBusinessInsert business_insert;
  final CreateDummyProductUserInsert user_insert;
  final CreateDummyProductManufacturerInsert manufacturer_insert;
  final CreateDummyProductTherapeuticClassInsert therapeuticClass_insert;
  final CreateDummyProductAddressInsert address_insert;
  final CreateDummyProductDateRangeInsert dateRange_insert;
  final CreateDummyProductSupplierInsert supplier_insert;
  final CreateDummyProductSupplierPerformanceScoreInsert supplierPerformanceScore_insert;
  final CreateDummyProductProductInsert product_insert;
  final CreateDummyProductProductPricingInsert productPricing_insert;
  final CreateDummyProductExpiryWarningThresholdsInsert expiryWarningThresholds_insert;
  CreateDummyProductData.fromJson(dynamic json):
  
  business_insert = CreateDummyProductBusinessInsert.fromJson(json['business_insert']),
  user_insert = CreateDummyProductUserInsert.fromJson(json['user_insert']),
  manufacturer_insert = CreateDummyProductManufacturerInsert.fromJson(json['manufacturer_insert']),
  therapeuticClass_insert = CreateDummyProductTherapeuticClassInsert.fromJson(json['therapeuticClass_insert']),
  address_insert = CreateDummyProductAddressInsert.fromJson(json['address_insert']),
  dateRange_insert = CreateDummyProductDateRangeInsert.fromJson(json['dateRange_insert']),
  supplier_insert = CreateDummyProductSupplierInsert.fromJson(json['supplier_insert']),
  supplierPerformanceScore_insert = CreateDummyProductSupplierPerformanceScoreInsert.fromJson(json['supplierPerformanceScore_insert']),
  product_insert = CreateDummyProductProductInsert.fromJson(json['product_insert']),
  productPricing_insert = CreateDummyProductProductPricingInsert.fromJson(json['productPricing_insert']),
  expiryWarningThresholds_insert = CreateDummyProductExpiryWarningThresholdsInsert.fromJson(json['expiryWarningThresholds_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateDummyProductData otherTyped = other as CreateDummyProductData;
    return business_insert == otherTyped.business_insert && 
    user_insert == otherTyped.user_insert && 
    manufacturer_insert == otherTyped.manufacturer_insert && 
    therapeuticClass_insert == otherTyped.therapeuticClass_insert && 
    address_insert == otherTyped.address_insert && 
    dateRange_insert == otherTyped.dateRange_insert && 
    supplier_insert == otherTyped.supplier_insert && 
    supplierPerformanceScore_insert == otherTyped.supplierPerformanceScore_insert && 
    product_insert == otherTyped.product_insert && 
    productPricing_insert == otherTyped.productPricing_insert && 
    expiryWarningThresholds_insert == otherTyped.expiryWarningThresholds_insert;
    
  }
  @override
  int get hashCode => Object.hashAll([business_insert.hashCode, user_insert.hashCode, manufacturer_insert.hashCode, therapeuticClass_insert.hashCode, address_insert.hashCode, dateRange_insert.hashCode, supplier_insert.hashCode, supplierPerformanceScore_insert.hashCode, product_insert.hashCode, productPricing_insert.hashCode, expiryWarningThresholds_insert.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['business_insert'] = business_insert.toJson();
    json['user_insert'] = user_insert.toJson();
    json['manufacturer_insert'] = manufacturer_insert.toJson();
    json['therapeuticClass_insert'] = therapeuticClass_insert.toJson();
    json['address_insert'] = address_insert.toJson();
    json['dateRange_insert'] = dateRange_insert.toJson();
    json['supplier_insert'] = supplier_insert.toJson();
    json['supplierPerformanceScore_insert'] = supplierPerformanceScore_insert.toJson();
    json['product_insert'] = product_insert.toJson();
    json['productPricing_insert'] = productPricing_insert.toJson();
    json['expiryWarningThresholds_insert'] = expiryWarningThresholds_insert.toJson();
    return json;
  }

  CreateDummyProductData({
    required this.business_insert,
    required this.user_insert,
    required this.manufacturer_insert,
    required this.therapeuticClass_insert,
    required this.address_insert,
    required this.dateRange_insert,
    required this.supplier_insert,
    required this.supplierPerformanceScore_insert,
    required this.product_insert,
    required this.productPricing_insert,
    required this.expiryWarningThresholds_insert,
  });
}

