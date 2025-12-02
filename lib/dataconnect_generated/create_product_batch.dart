part of 'biz_pharma.dart';

class CreateProductBatchVariablesBuilder {
  String productId;
  String businessId;
  String batchNumber;
  String lotNumber;
  DateTime manufacturingDate;
  DateTime expiryDate;
  String supplierId;
  String goodsReceiptId;
  DateTime receivedDate;
  double unitCost;
  double totalCost;
  int totalQuantity;
  int quantityRemaining;
  String locationId;
  String createdById;
  String updatedById;

  final FirebaseDataConnect _dataConnect;
  CreateProductBatchVariablesBuilder(this._dataConnect, {required  this.productId,required  this.businessId,required  this.batchNumber,required  this.lotNumber,required  this.manufacturingDate,required  this.expiryDate,required  this.supplierId,required  this.goodsReceiptId,required  this.receivedDate,required  this.unitCost,required  this.totalCost,required  this.totalQuantity,required  this.quantityRemaining,required  this.locationId,required  this.createdById,required  this.updatedById,});
  Deserializer<CreateProductBatchData> dataDeserializer = (dynamic json)  => CreateProductBatchData.fromJson(jsonDecode(json));
  Serializer<CreateProductBatchVariables> varsSerializer = (CreateProductBatchVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateProductBatchData, CreateProductBatchVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateProductBatchData, CreateProductBatchVariables> ref() {
    CreateProductBatchVariables vars= CreateProductBatchVariables(productId: productId,businessId: businessId,batchNumber: batchNumber,lotNumber: lotNumber,manufacturingDate: manufacturingDate,expiryDate: expiryDate,supplierId: supplierId,goodsReceiptId: goodsReceiptId,receivedDate: receivedDate,unitCost: unitCost,totalCost: totalCost,totalQuantity: totalQuantity,quantityRemaining: quantityRemaining,locationId: locationId,createdById: createdById,updatedById: updatedById,);
    return _dataConnect.mutation("CreateProductBatch", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateProductBatchProductBatchInsert {
  final String id;
  CreateProductBatchProductBatchInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateProductBatchProductBatchInsert otherTyped = other as CreateProductBatchProductBatchInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateProductBatchProductBatchInsert({
    required this.id,
  });
}

@immutable
class CreateProductBatchData {
  final CreateProductBatchProductBatchInsert productBatch_insert;
  CreateProductBatchData.fromJson(dynamic json):
  
  productBatch_insert = CreateProductBatchProductBatchInsert.fromJson(json['productBatch_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateProductBatchData otherTyped = other as CreateProductBatchData;
    return productBatch_insert == otherTyped.productBatch_insert;
    
  }
  @override
  int get hashCode => productBatch_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['productBatch_insert'] = productBatch_insert.toJson();
    return json;
  }

  CreateProductBatchData({
    required this.productBatch_insert,
  });
}

@immutable
class CreateProductBatchVariables {
  final String productId;
  final String businessId;
  final String batchNumber;
  final String lotNumber;
  final DateTime manufacturingDate;
  final DateTime expiryDate;
  final String supplierId;
  final String goodsReceiptId;
  final DateTime receivedDate;
  final double unitCost;
  final double totalCost;
  final int totalQuantity;
  final int quantityRemaining;
  final String locationId;
  final String createdById;
  final String updatedById;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateProductBatchVariables.fromJson(Map<String, dynamic> json):
  
  productId = nativeFromJson<String>(json['productId']),
  businessId = nativeFromJson<String>(json['businessId']),
  batchNumber = nativeFromJson<String>(json['batchNumber']),
  lotNumber = nativeFromJson<String>(json['lotNumber']),
  manufacturingDate = nativeFromJson<DateTime>(json['manufacturingDate']),
  expiryDate = nativeFromJson<DateTime>(json['expiryDate']),
  supplierId = nativeFromJson<String>(json['supplierId']),
  goodsReceiptId = nativeFromJson<String>(json['goodsReceiptId']),
  receivedDate = nativeFromJson<DateTime>(json['receivedDate']),
  unitCost = nativeFromJson<double>(json['unitCost']),
  totalCost = nativeFromJson<double>(json['totalCost']),
  totalQuantity = nativeFromJson<int>(json['totalQuantity']),
  quantityRemaining = nativeFromJson<int>(json['quantityRemaining']),
  locationId = nativeFromJson<String>(json['locationId']),
  createdById = nativeFromJson<String>(json['createdById']),
  updatedById = nativeFromJson<String>(json['updatedById']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateProductBatchVariables otherTyped = other as CreateProductBatchVariables;
    return productId == otherTyped.productId && 
    businessId == otherTyped.businessId && 
    batchNumber == otherTyped.batchNumber && 
    lotNumber == otherTyped.lotNumber && 
    manufacturingDate == otherTyped.manufacturingDate && 
    expiryDate == otherTyped.expiryDate && 
    supplierId == otherTyped.supplierId && 
    goodsReceiptId == otherTyped.goodsReceiptId && 
    receivedDate == otherTyped.receivedDate && 
    unitCost == otherTyped.unitCost && 
    totalCost == otherTyped.totalCost && 
    totalQuantity == otherTyped.totalQuantity && 
    quantityRemaining == otherTyped.quantityRemaining && 
    locationId == otherTyped.locationId && 
    createdById == otherTyped.createdById && 
    updatedById == otherTyped.updatedById;
    
  }
  @override
  int get hashCode => Object.hashAll([productId.hashCode, businessId.hashCode, batchNumber.hashCode, lotNumber.hashCode, manufacturingDate.hashCode, expiryDate.hashCode, supplierId.hashCode, goodsReceiptId.hashCode, receivedDate.hashCode, unitCost.hashCode, totalCost.hashCode, totalQuantity.hashCode, quantityRemaining.hashCode, locationId.hashCode, createdById.hashCode, updatedById.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['productId'] = nativeToJson<String>(productId);
    json['businessId'] = nativeToJson<String>(businessId);
    json['batchNumber'] = nativeToJson<String>(batchNumber);
    json['lotNumber'] = nativeToJson<String>(lotNumber);
    json['manufacturingDate'] = nativeToJson<DateTime>(manufacturingDate);
    json['expiryDate'] = nativeToJson<DateTime>(expiryDate);
    json['supplierId'] = nativeToJson<String>(supplierId);
    json['goodsReceiptId'] = nativeToJson<String>(goodsReceiptId);
    json['receivedDate'] = nativeToJson<DateTime>(receivedDate);
    json['unitCost'] = nativeToJson<double>(unitCost);
    json['totalCost'] = nativeToJson<double>(totalCost);
    json['totalQuantity'] = nativeToJson<int>(totalQuantity);
    json['quantityRemaining'] = nativeToJson<int>(quantityRemaining);
    json['locationId'] = nativeToJson<String>(locationId);
    json['createdById'] = nativeToJson<String>(createdById);
    json['updatedById'] = nativeToJson<String>(updatedById);
    return json;
  }

  CreateProductBatchVariables({
    required this.productId,
    required this.businessId,
    required this.batchNumber,
    required this.lotNumber,
    required this.manufacturingDate,
    required this.expiryDate,
    required this.supplierId,
    required this.goodsReceiptId,
    required this.receivedDate,
    required this.unitCost,
    required this.totalCost,
    required this.totalQuantity,
    required this.quantityRemaining,
    required this.locationId,
    required this.createdById,
    required this.updatedById,
  });
}

