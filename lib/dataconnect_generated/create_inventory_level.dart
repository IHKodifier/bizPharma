part of 'ik_pharma.dart';

class CreateInventoryLevelVariablesBuilder {
  String productId;
  String locationId;
  String businessId;
  Optional<String> _batchId = Optional.optional(nativeFromJson, nativeToJson);
  int quantityOnHand;
  int quantityAvailable;
  double averageCost;
  double totalValue;

  final FirebaseDataConnect _dataConnect;  CreateInventoryLevelVariablesBuilder batchId(String? t) {
   _batchId.value = t;
   return this;
  }

  CreateInventoryLevelVariablesBuilder(this._dataConnect, {required  this.productId,required  this.locationId,required  this.businessId,required  this.quantityOnHand,required  this.quantityAvailable,required  this.averageCost,required  this.totalValue,});
  Deserializer<CreateInventoryLevelData> dataDeserializer = (dynamic json)  => CreateInventoryLevelData.fromJson(jsonDecode(json));
  Serializer<CreateInventoryLevelVariables> varsSerializer = (CreateInventoryLevelVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateInventoryLevelData, CreateInventoryLevelVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateInventoryLevelData, CreateInventoryLevelVariables> ref() {
    CreateInventoryLevelVariables vars= CreateInventoryLevelVariables(productId: productId,locationId: locationId,businessId: businessId,batchId: _batchId,quantityOnHand: quantityOnHand,quantityAvailable: quantityAvailable,averageCost: averageCost,totalValue: totalValue,);
    return _dataConnect.mutation("CreateInventoryLevel", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateInventoryLevelInventoryLevelInsert {
  final String id;
  CreateInventoryLevelInventoryLevelInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateInventoryLevelInventoryLevelInsert otherTyped = other as CreateInventoryLevelInventoryLevelInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateInventoryLevelInventoryLevelInsert({
    required this.id,
  });
}

@immutable
class CreateInventoryLevelData {
  final CreateInventoryLevelInventoryLevelInsert inventoryLevel_insert;
  CreateInventoryLevelData.fromJson(dynamic json):
  
  inventoryLevel_insert = CreateInventoryLevelInventoryLevelInsert.fromJson(json['inventoryLevel_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateInventoryLevelData otherTyped = other as CreateInventoryLevelData;
    return inventoryLevel_insert == otherTyped.inventoryLevel_insert;
    
  }
  @override
  int get hashCode => inventoryLevel_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['inventoryLevel_insert'] = inventoryLevel_insert.toJson();
    return json;
  }

  CreateInventoryLevelData({
    required this.inventoryLevel_insert,
  });
}

@immutable
class CreateInventoryLevelVariables {
  final String productId;
  final String locationId;
  final String businessId;
  late final Optional<String>batchId;
  final int quantityOnHand;
  final int quantityAvailable;
  final double averageCost;
  final double totalValue;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateInventoryLevelVariables.fromJson(Map<String, dynamic> json):
  
  productId = nativeFromJson<String>(json['productId']),
  locationId = nativeFromJson<String>(json['locationId']),
  businessId = nativeFromJson<String>(json['businessId']),
  quantityOnHand = nativeFromJson<int>(json['quantityOnHand']),
  quantityAvailable = nativeFromJson<int>(json['quantityAvailable']),
  averageCost = nativeFromJson<double>(json['averageCost']),
  totalValue = nativeFromJson<double>(json['totalValue']) {
  
  
  
  
  
    batchId = Optional.optional(nativeFromJson, nativeToJson);
    batchId.value = json['batchId'] == null ? null : nativeFromJson<String>(json['batchId']);
  
  
  
  
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateInventoryLevelVariables otherTyped = other as CreateInventoryLevelVariables;
    return productId == otherTyped.productId && 
    locationId == otherTyped.locationId && 
    businessId == otherTyped.businessId && 
    batchId == otherTyped.batchId && 
    quantityOnHand == otherTyped.quantityOnHand && 
    quantityAvailable == otherTyped.quantityAvailable && 
    averageCost == otherTyped.averageCost && 
    totalValue == otherTyped.totalValue;
    
  }
  @override
  int get hashCode => Object.hashAll([productId.hashCode, locationId.hashCode, businessId.hashCode, batchId.hashCode, quantityOnHand.hashCode, quantityAvailable.hashCode, averageCost.hashCode, totalValue.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['productId'] = nativeToJson<String>(productId);
    json['locationId'] = nativeToJson<String>(locationId);
    json['businessId'] = nativeToJson<String>(businessId);
    if(batchId.state == OptionalState.set) {
      json['batchId'] = batchId.toJson();
    }
    json['quantityOnHand'] = nativeToJson<int>(quantityOnHand);
    json['quantityAvailable'] = nativeToJson<int>(quantityAvailable);
    json['averageCost'] = nativeToJson<double>(averageCost);
    json['totalValue'] = nativeToJson<double>(totalValue);
    return json;
  }

  CreateInventoryLevelVariables({
    required this.productId,
    required this.locationId,
    required this.businessId,
    required this.batchId,
    required this.quantityOnHand,
    required this.quantityAvailable,
    required this.averageCost,
    required this.totalValue,
  });
}

