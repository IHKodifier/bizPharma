part of 'biz_pharma.dart';

class CreatePurchaseOrderVariablesBuilder {
  String businessId;
  String supplierId;
  String orderNumber;
  Optional<Timestamp> _orderDate = Optional.optional((json) => json['orderDate'] = Timestamp.fromJson(json['orderDate']), defaultSerializer);
  Optional<DateTime> _expectedDeliveryDate = Optional.optional(nativeFromJson, nativeToJson);
  double totalAmount;
  double subtotal;
  double taxAmount;
  PurchaseOrderStatus status;
  String createdById;

  final FirebaseDataConnect _dataConnect;  CreatePurchaseOrderVariablesBuilder orderDate(Timestamp? t) {
   _orderDate.value = t;
   return this;
  }
  CreatePurchaseOrderVariablesBuilder expectedDeliveryDate(DateTime? t) {
   _expectedDeliveryDate.value = t;
   return this;
  }

  CreatePurchaseOrderVariablesBuilder(this._dataConnect, {required  this.businessId,required  this.supplierId,required  this.orderNumber,required  this.totalAmount,required  this.subtotal,required  this.taxAmount,required  this.status,required  this.createdById,});
  Deserializer<CreatePurchaseOrderData> dataDeserializer = (dynamic json)  => CreatePurchaseOrderData.fromJson(jsonDecode(json));
  Serializer<CreatePurchaseOrderVariables> varsSerializer = (CreatePurchaseOrderVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreatePurchaseOrderData, CreatePurchaseOrderVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreatePurchaseOrderData, CreatePurchaseOrderVariables> ref() {
    CreatePurchaseOrderVariables vars= CreatePurchaseOrderVariables(businessId: businessId,supplierId: supplierId,orderNumber: orderNumber,orderDate: _orderDate,expectedDeliveryDate: _expectedDeliveryDate,totalAmount: totalAmount,subtotal: subtotal,taxAmount: taxAmount,status: status,createdById: createdById,);
    return _dataConnect.mutation("CreatePurchaseOrder", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreatePurchaseOrderPurchaseOrderInsert {
  final String id;
  CreatePurchaseOrderPurchaseOrderInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreatePurchaseOrderPurchaseOrderInsert otherTyped = other as CreatePurchaseOrderPurchaseOrderInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreatePurchaseOrderPurchaseOrderInsert({
    required this.id,
  });
}

@immutable
class CreatePurchaseOrderData {
  final CreatePurchaseOrderPurchaseOrderInsert purchaseOrder_insert;
  CreatePurchaseOrderData.fromJson(dynamic json):
  
  purchaseOrder_insert = CreatePurchaseOrderPurchaseOrderInsert.fromJson(json['purchaseOrder_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreatePurchaseOrderData otherTyped = other as CreatePurchaseOrderData;
    return purchaseOrder_insert == otherTyped.purchaseOrder_insert;
    
  }
  @override
  int get hashCode => purchaseOrder_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['purchaseOrder_insert'] = purchaseOrder_insert.toJson();
    return json;
  }

  CreatePurchaseOrderData({
    required this.purchaseOrder_insert,
  });
}

@immutable
class CreatePurchaseOrderVariables {
  final String businessId;
  final String supplierId;
  final String orderNumber;
  late final Optional<Timestamp>orderDate;
  late final Optional<DateTime>expectedDeliveryDate;
  final double totalAmount;
  final double subtotal;
  final double taxAmount;
  final PurchaseOrderStatus status;
  final String createdById;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreatePurchaseOrderVariables.fromJson(Map<String, dynamic> json):
  
  businessId = nativeFromJson<String>(json['businessId']),
  supplierId = nativeFromJson<String>(json['supplierId']),
  orderNumber = nativeFromJson<String>(json['orderNumber']),
  totalAmount = nativeFromJson<double>(json['totalAmount']),
  subtotal = nativeFromJson<double>(json['subtotal']),
  taxAmount = nativeFromJson<double>(json['taxAmount']),
  status = PurchaseOrderStatus.values.byName(json['status']),
  createdById = nativeFromJson<String>(json['createdById']) {
  
  
  
  
  
    orderDate = Optional.optional((json) => json['orderDate'] = Timestamp.fromJson(json['orderDate']), defaultSerializer);
    orderDate.value = json['orderDate'] == null ? null : Timestamp.fromJson(json['orderDate']);
  
  
    expectedDeliveryDate = Optional.optional(nativeFromJson, nativeToJson);
    expectedDeliveryDate.value = json['expectedDeliveryDate'] == null ? null : nativeFromJson<DateTime>(json['expectedDeliveryDate']);
  
  
  
  
  
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreatePurchaseOrderVariables otherTyped = other as CreatePurchaseOrderVariables;
    return businessId == otherTyped.businessId && 
    supplierId == otherTyped.supplierId && 
    orderNumber == otherTyped.orderNumber && 
    orderDate == otherTyped.orderDate && 
    expectedDeliveryDate == otherTyped.expectedDeliveryDate && 
    totalAmount == otherTyped.totalAmount && 
    subtotal == otherTyped.subtotal && 
    taxAmount == otherTyped.taxAmount && 
    status == otherTyped.status && 
    createdById == otherTyped.createdById;
    
  }
  @override
  int get hashCode => Object.hashAll([businessId.hashCode, supplierId.hashCode, orderNumber.hashCode, orderDate.hashCode, expectedDeliveryDate.hashCode, totalAmount.hashCode, subtotal.hashCode, taxAmount.hashCode, status.hashCode, createdById.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['businessId'] = nativeToJson<String>(businessId);
    json['supplierId'] = nativeToJson<String>(supplierId);
    json['orderNumber'] = nativeToJson<String>(orderNumber);
    if(orderDate.state == OptionalState.set) {
      json['orderDate'] = orderDate.toJson();
    }
    if(expectedDeliveryDate.state == OptionalState.set) {
      json['expectedDeliveryDate'] = expectedDeliveryDate.toJson();
    }
    json['totalAmount'] = nativeToJson<double>(totalAmount);
    json['subtotal'] = nativeToJson<double>(subtotal);
    json['taxAmount'] = nativeToJson<double>(taxAmount);
    json['status'] = 
    status.name
    ;
    json['createdById'] = nativeToJson<String>(createdById);
    return json;
  }

  CreatePurchaseOrderVariables({
    required this.businessId,
    required this.supplierId,
    required this.orderNumber,
    required this.orderDate,
    required this.expectedDeliveryDate,
    required this.totalAmount,
    required this.subtotal,
    required this.taxAmount,
    required this.status,
    required this.createdById,
  });
}

