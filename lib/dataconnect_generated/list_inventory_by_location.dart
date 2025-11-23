part of 'ik_pharma.dart';

class ListInventoryByLocationVariablesBuilder {
  String locationId;

  final FirebaseDataConnect _dataConnect;
  ListInventoryByLocationVariablesBuilder(this._dataConnect, {required  this.locationId,});
  Deserializer<ListInventoryByLocationData> dataDeserializer = (dynamic json)  => ListInventoryByLocationData.fromJson(jsonDecode(json));
  Serializer<ListInventoryByLocationVariables> varsSerializer = (ListInventoryByLocationVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListInventoryByLocationData, ListInventoryByLocationVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListInventoryByLocationData, ListInventoryByLocationVariables> ref() {
    ListInventoryByLocationVariables vars= ListInventoryByLocationVariables(locationId: locationId,);
    return _dataConnect.query("ListInventoryByLocation", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListInventoryByLocationInventoryLevels {
  final String id;
  final String productId;
  final String locationId;
  final String? batchId;
  final String businessId;
  final int quantityOnHand;
  final int quantityReserved;
  final int quantityAvailable;
  final int quantityInTransit;
  final double averageCost;
  final double totalValue;
  final DateTime? lastCountDate;
  final DateTime? lastDispenseDate;
  final DateTime? lastRestockDate;
  final Timestamp updatedAt;
  ListInventoryByLocationInventoryLevels.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  productId = nativeFromJson<String>(json['productId']),
  locationId = nativeFromJson<String>(json['locationId']),
  batchId = json['batchId'] == null ? null : nativeFromJson<String>(json['batchId']),
  businessId = nativeFromJson<String>(json['businessId']),
  quantityOnHand = nativeFromJson<int>(json['quantityOnHand']),
  quantityReserved = nativeFromJson<int>(json['quantityReserved']),
  quantityAvailable = nativeFromJson<int>(json['quantityAvailable']),
  quantityInTransit = nativeFromJson<int>(json['quantityInTransit']),
  averageCost = nativeFromJson<double>(json['averageCost']),
  totalValue = nativeFromJson<double>(json['totalValue']),
  lastCountDate = json['lastCountDate'] == null ? null : nativeFromJson<DateTime>(json['lastCountDate']),
  lastDispenseDate = json['lastDispenseDate'] == null ? null : nativeFromJson<DateTime>(json['lastDispenseDate']),
  lastRestockDate = json['lastRestockDate'] == null ? null : nativeFromJson<DateTime>(json['lastRestockDate']),
  updatedAt = Timestamp.fromJson(json['updatedAt']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListInventoryByLocationInventoryLevels otherTyped = other as ListInventoryByLocationInventoryLevels;
    return id == otherTyped.id && 
    productId == otherTyped.productId && 
    locationId == otherTyped.locationId && 
    batchId == otherTyped.batchId && 
    businessId == otherTyped.businessId && 
    quantityOnHand == otherTyped.quantityOnHand && 
    quantityReserved == otherTyped.quantityReserved && 
    quantityAvailable == otherTyped.quantityAvailable && 
    quantityInTransit == otherTyped.quantityInTransit && 
    averageCost == otherTyped.averageCost && 
    totalValue == otherTyped.totalValue && 
    lastCountDate == otherTyped.lastCountDate && 
    lastDispenseDate == otherTyped.lastDispenseDate && 
    lastRestockDate == otherTyped.lastRestockDate && 
    updatedAt == otherTyped.updatedAt;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, productId.hashCode, locationId.hashCode, batchId.hashCode, businessId.hashCode, quantityOnHand.hashCode, quantityReserved.hashCode, quantityAvailable.hashCode, quantityInTransit.hashCode, averageCost.hashCode, totalValue.hashCode, lastCountDate.hashCode, lastDispenseDate.hashCode, lastRestockDate.hashCode, updatedAt.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['productId'] = nativeToJson<String>(productId);
    json['locationId'] = nativeToJson<String>(locationId);
    if (batchId != null) {
      json['batchId'] = nativeToJson<String?>(batchId);
    }
    json['businessId'] = nativeToJson<String>(businessId);
    json['quantityOnHand'] = nativeToJson<int>(quantityOnHand);
    json['quantityReserved'] = nativeToJson<int>(quantityReserved);
    json['quantityAvailable'] = nativeToJson<int>(quantityAvailable);
    json['quantityInTransit'] = nativeToJson<int>(quantityInTransit);
    json['averageCost'] = nativeToJson<double>(averageCost);
    json['totalValue'] = nativeToJson<double>(totalValue);
    if (lastCountDate != null) {
      json['lastCountDate'] = nativeToJson<DateTime?>(lastCountDate);
    }
    if (lastDispenseDate != null) {
      json['lastDispenseDate'] = nativeToJson<DateTime?>(lastDispenseDate);
    }
    if (lastRestockDate != null) {
      json['lastRestockDate'] = nativeToJson<DateTime?>(lastRestockDate);
    }
    json['updatedAt'] = updatedAt.toJson();
    return json;
  }

  ListInventoryByLocationInventoryLevels({
    required this.id,
    required this.productId,
    required this.locationId,
    this.batchId,
    required this.businessId,
    required this.quantityOnHand,
    required this.quantityReserved,
    required this.quantityAvailable,
    required this.quantityInTransit,
    required this.averageCost,
    required this.totalValue,
    this.lastCountDate,
    this.lastDispenseDate,
    this.lastRestockDate,
    required this.updatedAt,
  });
}

@immutable
class ListInventoryByLocationData {
  final List<ListInventoryByLocationInventoryLevels> inventoryLevels;
  ListInventoryByLocationData.fromJson(dynamic json):
  
  inventoryLevels = (json['inventoryLevels'] as List<dynamic>)
        .map((e) => ListInventoryByLocationInventoryLevels.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListInventoryByLocationData otherTyped = other as ListInventoryByLocationData;
    return inventoryLevels == otherTyped.inventoryLevels;
    
  }
  @override
  int get hashCode => inventoryLevels.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['inventoryLevels'] = inventoryLevels.map((e) => e.toJson()).toList();
    return json;
  }

  ListInventoryByLocationData({
    required this.inventoryLevels,
  });
}

@immutable
class ListInventoryByLocationVariables {
  final String locationId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListInventoryByLocationVariables.fromJson(Map<String, dynamic> json):
  
  locationId = nativeFromJson<String>(json['locationId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListInventoryByLocationVariables otherTyped = other as ListInventoryByLocationVariables;
    return locationId == otherTyped.locationId;
    
  }
  @override
  int get hashCode => locationId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['locationId'] = nativeToJson<String>(locationId);
    return json;
  }

  ListInventoryByLocationVariables({
    required this.locationId,
  });
}

