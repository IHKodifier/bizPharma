part of 'biz_pharma.dart';

class ListPricingByLocationVariablesBuilder {
  String businessId;

  final FirebaseDataConnect _dataConnect;
  ListPricingByLocationVariablesBuilder(this._dataConnect, {required  this.businessId,});
  Deserializer<ListPricingByLocationData> dataDeserializer = (dynamic json)  => ListPricingByLocationData.fromJson(jsonDecode(json));
  Serializer<ListPricingByLocationVariables> varsSerializer = (ListPricingByLocationVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListPricingByLocationData, ListPricingByLocationVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListPricingByLocationData, ListPricingByLocationVariables> ref() {
    ListPricingByLocationVariables vars= ListPricingByLocationVariables(businessId: businessId,);
    return _dataConnect.query("ListPricingByLocation", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListPricingByLocationProductPricings {
  final String id;
  final String productId;
  final String businessId;
  final double wholesaleCost;
  final double retailPrice;
  final double walkInPrice;
  final double? bronzePrice;
  final double? silverPrice;
  final double? goldPrice;
  final double? diamondPrice;
  final double? platinumPrice;
  final double grossMarginPercent;
  final double markupPercent;
  final double taxRate;
  final DateTime effectiveDate;
  final Timestamp updatedAt;
  ListPricingByLocationProductPricings.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  productId = nativeFromJson<String>(json['productId']),
  businessId = nativeFromJson<String>(json['businessId']),
  wholesaleCost = nativeFromJson<double>(json['wholesaleCost']),
  retailPrice = nativeFromJson<double>(json['retailPrice']),
  walkInPrice = nativeFromJson<double>(json['walkInPrice']),
  bronzePrice = json['bronzePrice'] == null ? null : nativeFromJson<double>(json['bronzePrice']),
  silverPrice = json['silverPrice'] == null ? null : nativeFromJson<double>(json['silverPrice']),
  goldPrice = json['goldPrice'] == null ? null : nativeFromJson<double>(json['goldPrice']),
  diamondPrice = json['diamondPrice'] == null ? null : nativeFromJson<double>(json['diamondPrice']),
  platinumPrice = json['platinumPrice'] == null ? null : nativeFromJson<double>(json['platinumPrice']),
  grossMarginPercent = nativeFromJson<double>(json['grossMarginPercent']),
  markupPercent = nativeFromJson<double>(json['markupPercent']),
  taxRate = nativeFromJson<double>(json['taxRate']),
  effectiveDate = nativeFromJson<DateTime>(json['effectiveDate']),
  updatedAt = Timestamp.fromJson(json['updatedAt']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListPricingByLocationProductPricings otherTyped = other as ListPricingByLocationProductPricings;
    return id == otherTyped.id && 
    productId == otherTyped.productId && 
    businessId == otherTyped.businessId && 
    wholesaleCost == otherTyped.wholesaleCost && 
    retailPrice == otherTyped.retailPrice && 
    walkInPrice == otherTyped.walkInPrice && 
    bronzePrice == otherTyped.bronzePrice && 
    silverPrice == otherTyped.silverPrice && 
    goldPrice == otherTyped.goldPrice && 
    diamondPrice == otherTyped.diamondPrice && 
    platinumPrice == otherTyped.platinumPrice && 
    grossMarginPercent == otherTyped.grossMarginPercent && 
    markupPercent == otherTyped.markupPercent && 
    taxRate == otherTyped.taxRate && 
    effectiveDate == otherTyped.effectiveDate && 
    updatedAt == otherTyped.updatedAt;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, productId.hashCode, businessId.hashCode, wholesaleCost.hashCode, retailPrice.hashCode, walkInPrice.hashCode, bronzePrice.hashCode, silverPrice.hashCode, goldPrice.hashCode, diamondPrice.hashCode, platinumPrice.hashCode, grossMarginPercent.hashCode, markupPercent.hashCode, taxRate.hashCode, effectiveDate.hashCode, updatedAt.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['productId'] = nativeToJson<String>(productId);
    json['businessId'] = nativeToJson<String>(businessId);
    json['wholesaleCost'] = nativeToJson<double>(wholesaleCost);
    json['retailPrice'] = nativeToJson<double>(retailPrice);
    json['walkInPrice'] = nativeToJson<double>(walkInPrice);
    if (bronzePrice != null) {
      json['bronzePrice'] = nativeToJson<double?>(bronzePrice);
    }
    if (silverPrice != null) {
      json['silverPrice'] = nativeToJson<double?>(silverPrice);
    }
    if (goldPrice != null) {
      json['goldPrice'] = nativeToJson<double?>(goldPrice);
    }
    if (diamondPrice != null) {
      json['diamondPrice'] = nativeToJson<double?>(diamondPrice);
    }
    if (platinumPrice != null) {
      json['platinumPrice'] = nativeToJson<double?>(platinumPrice);
    }
    json['grossMarginPercent'] = nativeToJson<double>(grossMarginPercent);
    json['markupPercent'] = nativeToJson<double>(markupPercent);
    json['taxRate'] = nativeToJson<double>(taxRate);
    json['effectiveDate'] = nativeToJson<DateTime>(effectiveDate);
    json['updatedAt'] = updatedAt.toJson();
    return json;
  }

  ListPricingByLocationProductPricings({
    required this.id,
    required this.productId,
    required this.businessId,
    required this.wholesaleCost,
    required this.retailPrice,
    required this.walkInPrice,
    this.bronzePrice,
    this.silverPrice,
    this.goldPrice,
    this.diamondPrice,
    this.platinumPrice,
    required this.grossMarginPercent,
    required this.markupPercent,
    required this.taxRate,
    required this.effectiveDate,
    required this.updatedAt,
  });
}

@immutable
class ListPricingByLocationData {
  final List<ListPricingByLocationProductPricings> productPricings;
  ListPricingByLocationData.fromJson(dynamic json):
  
  productPricings = (json['productPricings'] as List<dynamic>)
        .map((e) => ListPricingByLocationProductPricings.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListPricingByLocationData otherTyped = other as ListPricingByLocationData;
    return productPricings == otherTyped.productPricings;
    
  }
  @override
  int get hashCode => productPricings.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['productPricings'] = productPricings.map((e) => e.toJson()).toList();
    return json;
  }

  ListPricingByLocationData({
    required this.productPricings,
  });
}

@immutable
class ListPricingByLocationVariables {
  final String businessId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListPricingByLocationVariables.fromJson(Map<String, dynamic> json):
  
  businessId = nativeFromJson<String>(json['businessId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListPricingByLocationVariables otherTyped = other as ListPricingByLocationVariables;
    return businessId == otherTyped.businessId;
    
  }
  @override
  int get hashCode => businessId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['businessId'] = nativeToJson<String>(businessId);
    return json;
  }

  ListPricingByLocationVariables({
    required this.businessId,
  });
}

