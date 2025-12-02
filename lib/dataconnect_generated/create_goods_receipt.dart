part of 'biz_pharma.dart';

class CreateGoodsReceiptVariablesBuilder {
  String purchaseOrderId;
  String businessId;
  String receiptNumber;
  Optional<Timestamp> _receiptDate = Optional.optional((json) => json['receiptDate'] = Timestamp.fromJson(json['receiptDate']), defaultSerializer);
  GoodsReceiptStatus status;
  String inspectedById;

  final FirebaseDataConnect _dataConnect;  CreateGoodsReceiptVariablesBuilder receiptDate(Timestamp? t) {
   _receiptDate.value = t;
   return this;
  }

  CreateGoodsReceiptVariablesBuilder(this._dataConnect, {required  this.purchaseOrderId,required  this.businessId,required  this.receiptNumber,required  this.status,required  this.inspectedById,});
  Deserializer<CreateGoodsReceiptData> dataDeserializer = (dynamic json)  => CreateGoodsReceiptData.fromJson(jsonDecode(json));
  Serializer<CreateGoodsReceiptVariables> varsSerializer = (CreateGoodsReceiptVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateGoodsReceiptData, CreateGoodsReceiptVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateGoodsReceiptData, CreateGoodsReceiptVariables> ref() {
    CreateGoodsReceiptVariables vars= CreateGoodsReceiptVariables(purchaseOrderId: purchaseOrderId,businessId: businessId,receiptNumber: receiptNumber,receiptDate: _receiptDate,status: status,inspectedById: inspectedById,);
    return _dataConnect.mutation("CreateGoodsReceipt", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateGoodsReceiptGoodsReceiptInsert {
  final String id;
  CreateGoodsReceiptGoodsReceiptInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateGoodsReceiptGoodsReceiptInsert otherTyped = other as CreateGoodsReceiptGoodsReceiptInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateGoodsReceiptGoodsReceiptInsert({
    required this.id,
  });
}

@immutable
class CreateGoodsReceiptData {
  final CreateGoodsReceiptGoodsReceiptInsert goodsReceipt_insert;
  CreateGoodsReceiptData.fromJson(dynamic json):
  
  goodsReceipt_insert = CreateGoodsReceiptGoodsReceiptInsert.fromJson(json['goodsReceipt_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateGoodsReceiptData otherTyped = other as CreateGoodsReceiptData;
    return goodsReceipt_insert == otherTyped.goodsReceipt_insert;
    
  }
  @override
  int get hashCode => goodsReceipt_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['goodsReceipt_insert'] = goodsReceipt_insert.toJson();
    return json;
  }

  CreateGoodsReceiptData({
    required this.goodsReceipt_insert,
  });
}

@immutable
class CreateGoodsReceiptVariables {
  final String purchaseOrderId;
  final String businessId;
  final String receiptNumber;
  late final Optional<Timestamp>receiptDate;
  final GoodsReceiptStatus status;
  final String inspectedById;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateGoodsReceiptVariables.fromJson(Map<String, dynamic> json):
  
  purchaseOrderId = nativeFromJson<String>(json['purchaseOrderId']),
  businessId = nativeFromJson<String>(json['businessId']),
  receiptNumber = nativeFromJson<String>(json['receiptNumber']),
  status = GoodsReceiptStatus.values.byName(json['status']),
  inspectedById = nativeFromJson<String>(json['inspectedById']) {
  
  
  
  
  
    receiptDate = Optional.optional((json) => json['receiptDate'] = Timestamp.fromJson(json['receiptDate']), defaultSerializer);
    receiptDate.value = json['receiptDate'] == null ? null : Timestamp.fromJson(json['receiptDate']);
  
  
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateGoodsReceiptVariables otherTyped = other as CreateGoodsReceiptVariables;
    return purchaseOrderId == otherTyped.purchaseOrderId && 
    businessId == otherTyped.businessId && 
    receiptNumber == otherTyped.receiptNumber && 
    receiptDate == otherTyped.receiptDate && 
    status == otherTyped.status && 
    inspectedById == otherTyped.inspectedById;
    
  }
  @override
  int get hashCode => Object.hashAll([purchaseOrderId.hashCode, businessId.hashCode, receiptNumber.hashCode, receiptDate.hashCode, status.hashCode, inspectedById.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['purchaseOrderId'] = nativeToJson<String>(purchaseOrderId);
    json['businessId'] = nativeToJson<String>(businessId);
    json['receiptNumber'] = nativeToJson<String>(receiptNumber);
    if(receiptDate.state == OptionalState.set) {
      json['receiptDate'] = receiptDate.toJson();
    }
    json['status'] = 
    status.name
    ;
    json['inspectedById'] = nativeToJson<String>(inspectedById);
    return json;
  }

  CreateGoodsReceiptVariables({
    required this.purchaseOrderId,
    required this.businessId,
    required this.receiptNumber,
    required this.receiptDate,
    required this.status,
    required this.inspectedById,
  });
}

