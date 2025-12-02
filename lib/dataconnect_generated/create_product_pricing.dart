part of 'biz_pharma.dart';

class CreateProductPricingVariablesBuilder {
  String productId;
  String businessId;
  double wholesaleCost;
  double retailPrice;
  double walkInPrice;
  double grossMarginPercent;
  double markupPercent;
  double taxRate;
  DateTime effectiveDate;
  String updatedById;

  final FirebaseDataConnect _dataConnect;
  CreateProductPricingVariablesBuilder(this._dataConnect, {required  this.productId,required  this.businessId,required  this.wholesaleCost,required  this.retailPrice,required  this.walkInPrice,required  this.grossMarginPercent,required  this.markupPercent,required  this.taxRate,required  this.effectiveDate,required  this.updatedById,});
  Deserializer<CreateProductPricingData> dataDeserializer = (dynamic json)  => CreateProductPricingData.fromJson(jsonDecode(json));
  Serializer<CreateProductPricingVariables> varsSerializer = (CreateProductPricingVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateProductPricingData, CreateProductPricingVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateProductPricingData, CreateProductPricingVariables> ref() {
    CreateProductPricingVariables vars= CreateProductPricingVariables(productId: productId,businessId: businessId,wholesaleCost: wholesaleCost,retailPrice: retailPrice,walkInPrice: walkInPrice,grossMarginPercent: grossMarginPercent,markupPercent: markupPercent,taxRate: taxRate,effectiveDate: effectiveDate,updatedById: updatedById,);
    return _dataConnect.mutation("CreateProductPricing", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateProductPricingProductPricingInsert {
  final String id;
  CreateProductPricingProductPricingInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateProductPricingProductPricingInsert otherTyped = other as CreateProductPricingProductPricingInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateProductPricingProductPricingInsert({
    required this.id,
  });
}

@immutable
class CreateProductPricingData {
  final CreateProductPricingProductPricingInsert productPricing_insert;
  CreateProductPricingData.fromJson(dynamic json):
  
  productPricing_insert = CreateProductPricingProductPricingInsert.fromJson(json['productPricing_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateProductPricingData otherTyped = other as CreateProductPricingData;
    return productPricing_insert == otherTyped.productPricing_insert;
    
  }
  @override
  int get hashCode => productPricing_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['productPricing_insert'] = productPricing_insert.toJson();
    return json;
  }

  CreateProductPricingData({
    required this.productPricing_insert,
  });
}

@immutable
class CreateProductPricingVariables {
  final String productId;
  final String businessId;
  final double wholesaleCost;
  final double retailPrice;
  final double walkInPrice;
  final double grossMarginPercent;
  final double markupPercent;
  final double taxRate;
  final DateTime effectiveDate;
  final String updatedById;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateProductPricingVariables.fromJson(Map<String, dynamic> json):
  
  productId = nativeFromJson<String>(json['productId']),
  businessId = nativeFromJson<String>(json['businessId']),
  wholesaleCost = nativeFromJson<double>(json['wholesaleCost']),
  retailPrice = nativeFromJson<double>(json['retailPrice']),
  walkInPrice = nativeFromJson<double>(json['walkInPrice']),
  grossMarginPercent = nativeFromJson<double>(json['grossMarginPercent']),
  markupPercent = nativeFromJson<double>(json['markupPercent']),
  taxRate = nativeFromJson<double>(json['taxRate']),
  effectiveDate = nativeFromJson<DateTime>(json['effectiveDate']),
  updatedById = nativeFromJson<String>(json['updatedById']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateProductPricingVariables otherTyped = other as CreateProductPricingVariables;
    return productId == otherTyped.productId && 
    businessId == otherTyped.businessId && 
    wholesaleCost == otherTyped.wholesaleCost && 
    retailPrice == otherTyped.retailPrice && 
    walkInPrice == otherTyped.walkInPrice && 
    grossMarginPercent == otherTyped.grossMarginPercent && 
    markupPercent == otherTyped.markupPercent && 
    taxRate == otherTyped.taxRate && 
    effectiveDate == otherTyped.effectiveDate && 
    updatedById == otherTyped.updatedById;
    
  }
  @override
  int get hashCode => Object.hashAll([productId.hashCode, businessId.hashCode, wholesaleCost.hashCode, retailPrice.hashCode, walkInPrice.hashCode, grossMarginPercent.hashCode, markupPercent.hashCode, taxRate.hashCode, effectiveDate.hashCode, updatedById.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['productId'] = nativeToJson<String>(productId);
    json['businessId'] = nativeToJson<String>(businessId);
    json['wholesaleCost'] = nativeToJson<double>(wholesaleCost);
    json['retailPrice'] = nativeToJson<double>(retailPrice);
    json['walkInPrice'] = nativeToJson<double>(walkInPrice);
    json['grossMarginPercent'] = nativeToJson<double>(grossMarginPercent);
    json['markupPercent'] = nativeToJson<double>(markupPercent);
    json['taxRate'] = nativeToJson<double>(taxRate);
    json['effectiveDate'] = nativeToJson<DateTime>(effectiveDate);
    json['updatedById'] = nativeToJson<String>(updatedById);
    return json;
  }

  CreateProductPricingVariables({
    required this.productId,
    required this.businessId,
    required this.wholesaleCost,
    required this.retailPrice,
    required this.walkInPrice,
    required this.grossMarginPercent,
    required this.markupPercent,
    required this.taxRate,
    required this.effectiveDate,
    required this.updatedById,
  });
}

