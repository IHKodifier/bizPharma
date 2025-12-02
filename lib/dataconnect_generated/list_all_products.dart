part of 'biz_pharma.dart';

class ListAllProductsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListAllProductsVariablesBuilder(this._dataConnect, );
  Deserializer<ListAllProductsData> dataDeserializer = (dynamic json)  => ListAllProductsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListAllProductsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListAllProductsData, void> ref() {
    
    return _dataConnect.query("listAllProducts", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListAllProductsProducts {
  final String id;
  final String genericName;
  final String internalSKU;
  final ListAllProductsProductsManufacturer manufacturer;
  final ListAllProductsProductsBusiness business;
  ListAllProductsProducts.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  genericName = nativeFromJson<String>(json['genericName']),
  internalSKU = nativeFromJson<String>(json['internalSKU']),
  manufacturer = ListAllProductsProductsManufacturer.fromJson(json['manufacturer']),
  business = ListAllProductsProductsBusiness.fromJson(json['business']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAllProductsProducts otherTyped = other as ListAllProductsProducts;
    return id == otherTyped.id && 
    genericName == otherTyped.genericName && 
    internalSKU == otherTyped.internalSKU && 
    manufacturer == otherTyped.manufacturer && 
    business == otherTyped.business;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, genericName.hashCode, internalSKU.hashCode, manufacturer.hashCode, business.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['genericName'] = nativeToJson<String>(genericName);
    json['internalSKU'] = nativeToJson<String>(internalSKU);
    json['manufacturer'] = manufacturer.toJson();
    json['business'] = business.toJson();
    return json;
  }

  ListAllProductsProducts({
    required this.id,
    required this.genericName,
    required this.internalSKU,
    required this.manufacturer,
    required this.business,
  });
}

@immutable
class ListAllProductsProductsManufacturer {
  final String name;
  ListAllProductsProductsManufacturer.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAllProductsProductsManufacturer otherTyped = other as ListAllProductsProductsManufacturer;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  ListAllProductsProductsManufacturer({
    required this.name,
  });
}

@immutable
class ListAllProductsProductsBusiness {
  final String name;
  ListAllProductsProductsBusiness.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAllProductsProductsBusiness otherTyped = other as ListAllProductsProductsBusiness;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  ListAllProductsProductsBusiness({
    required this.name,
  });
}

@immutable
class ListAllProductsData {
  final List<ListAllProductsProducts> products;
  ListAllProductsData.fromJson(dynamic json):
  
  products = (json['products'] as List<dynamic>)
        .map((e) => ListAllProductsProducts.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAllProductsData otherTyped = other as ListAllProductsData;
    return products == otherTyped.products;
    
  }
  @override
  int get hashCode => products.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['products'] = products.map((e) => e.toJson()).toList();
    return json;
  }

  ListAllProductsData({
    required this.products,
  });
}

