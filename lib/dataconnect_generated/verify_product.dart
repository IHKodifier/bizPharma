part of 'ik_pharma.dart';

class VerifyProductVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  VerifyProductVariablesBuilder(this._dataConnect, );
  Deserializer<VerifyProductData> dataDeserializer = (dynamic json)  => VerifyProductData.fromJson(jsonDecode(json));
  
  Future<QueryResult<VerifyProductData, void>> execute() {
    return ref().execute();
  }

  QueryRef<VerifyProductData, void> ref() {
    
    return _dataConnect.query("VerifyProduct", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class VerifyProductProducts {
  final String id;
  final String genericName;
  final String? brandName;
  final String internalSKU;
  final VerifyProductProductsManufacturer manufacturer;
  final VerifyProductProductsBusiness business;
  final EnumValue<ProductCategory> category;
  final bool isActive;
  VerifyProductProducts.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  genericName = nativeFromJson<String>(json['genericName']),
  brandName = json['brandName'] == null ? null : nativeFromJson<String>(json['brandName']),
  internalSKU = nativeFromJson<String>(json['internalSKU']),
  manufacturer = VerifyProductProductsManufacturer.fromJson(json['manufacturer']),
  business = VerifyProductProductsBusiness.fromJson(json['business']),
  category = productCategoryDeserializer(json['category']),
  isActive = nativeFromJson<bool>(json['isActive']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final VerifyProductProducts otherTyped = other as VerifyProductProducts;
    return id == otherTyped.id && 
    genericName == otherTyped.genericName && 
    brandName == otherTyped.brandName && 
    internalSKU == otherTyped.internalSKU && 
    manufacturer == otherTyped.manufacturer && 
    business == otherTyped.business && 
    category == otherTyped.category && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, genericName.hashCode, brandName.hashCode, internalSKU.hashCode, manufacturer.hashCode, business.hashCode, category.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['genericName'] = nativeToJson<String>(genericName);
    if (brandName != null) {
      json['brandName'] = nativeToJson<String?>(brandName);
    }
    json['internalSKU'] = nativeToJson<String>(internalSKU);
    json['manufacturer'] = manufacturer.toJson();
    json['business'] = business.toJson();
    json['category'] = 
    productCategorySerializer(category)
    ;
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  VerifyProductProducts({
    required this.id,
    required this.genericName,
    this.brandName,
    required this.internalSKU,
    required this.manufacturer,
    required this.business,
    required this.category,
    required this.isActive,
  });
}

@immutable
class VerifyProductProductsManufacturer {
  final String name;
  VerifyProductProductsManufacturer.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final VerifyProductProductsManufacturer otherTyped = other as VerifyProductProductsManufacturer;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  VerifyProductProductsManufacturer({
    required this.name,
  });
}

@immutable
class VerifyProductProductsBusiness {
  final String name;
  VerifyProductProductsBusiness.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final VerifyProductProductsBusiness otherTyped = other as VerifyProductProductsBusiness;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  VerifyProductProductsBusiness({
    required this.name,
  });
}

@immutable
class VerifyProductData {
  final List<VerifyProductProducts> products;
  VerifyProductData.fromJson(dynamic json):
  
  products = (json['products'] as List<dynamic>)
        .map((e) => VerifyProductProducts.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final VerifyProductData otherTyped = other as VerifyProductData;
    return products == otherTyped.products;
    
  }
  @override
  int get hashCode => products.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['products'] = products.map((e) => e.toJson()).toList();
    return json;
  }

  VerifyProductData({
    required this.products,
  });
}

