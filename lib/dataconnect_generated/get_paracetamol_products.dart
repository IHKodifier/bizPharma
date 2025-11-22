part of 'ik_pharma.dart';

class GetParacetamolProductsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetParacetamolProductsVariablesBuilder(this._dataConnect, );
  Deserializer<GetParacetamolProductsData> dataDeserializer = (dynamic json)  => GetParacetamolProductsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetParacetamolProductsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetParacetamolProductsData, void> ref() {
    
    return _dataConnect.query("GetParacetamolProducts", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class GetParacetamolProductsProducts {
  final String id;
  final String genericName;
  final String? brandName;
  final String internalSKU;
  final GetParacetamolProductsProductsManufacturer manufacturer;
  final GetParacetamolProductsProductsBusiness business;
  final EnumValue<ProductCategory> category;
  final bool isActive;
  GetParacetamolProductsProducts.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  genericName = nativeFromJson<String>(json['genericName']),
  brandName = json['brandName'] == null ? null : nativeFromJson<String>(json['brandName']),
  internalSKU = nativeFromJson<String>(json['internalSKU']),
  manufacturer = GetParacetamolProductsProductsManufacturer.fromJson(json['manufacturer']),
  business = GetParacetamolProductsProductsBusiness.fromJson(json['business']),
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

    final GetParacetamolProductsProducts otherTyped = other as GetParacetamolProductsProducts;
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

  GetParacetamolProductsProducts({
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
class GetParacetamolProductsProductsManufacturer {
  final String name;
  GetParacetamolProductsProductsManufacturer.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetParacetamolProductsProductsManufacturer otherTyped = other as GetParacetamolProductsProductsManufacturer;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  GetParacetamolProductsProductsManufacturer({
    required this.name,
  });
}

@immutable
class GetParacetamolProductsProductsBusiness {
  final String name;
  GetParacetamolProductsProductsBusiness.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetParacetamolProductsProductsBusiness otherTyped = other as GetParacetamolProductsProductsBusiness;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  GetParacetamolProductsProductsBusiness({
    required this.name,
  });
}

@immutable
class GetParacetamolProductsData {
  final List<GetParacetamolProductsProducts> products;
  GetParacetamolProductsData.fromJson(dynamic json):
  
  products = (json['products'] as List<dynamic>)
        .map((e) => GetParacetamolProductsProducts.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetParacetamolProductsData otherTyped = other as GetParacetamolProductsData;
    return products == otherTyped.products;
    
  }
  @override
  int get hashCode => products.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['products'] = products.map((e) => e.toJson()).toList();
    return json;
  }

  GetParacetamolProductsData({
    required this.products,
  });
}

