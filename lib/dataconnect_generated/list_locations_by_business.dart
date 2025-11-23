part of 'ik_pharma.dart';

class ListLocationsByBusinessVariablesBuilder {
  String businessId;

  final FirebaseDataConnect _dataConnect;
  ListLocationsByBusinessVariablesBuilder(this._dataConnect, {required  this.businessId,});
  Deserializer<ListLocationsByBusinessData> dataDeserializer = (dynamic json)  => ListLocationsByBusinessData.fromJson(jsonDecode(json));
  Serializer<ListLocationsByBusinessVariables> varsSerializer = (ListLocationsByBusinessVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListLocationsByBusinessData, ListLocationsByBusinessVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListLocationsByBusinessData, ListLocationsByBusinessVariables> ref() {
    ListLocationsByBusinessVariables vars= ListLocationsByBusinessVariables(businessId: businessId,);
    return _dataConnect.query("ListLocationsByBusiness", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListLocationsByBusinessLocations {
  final String id;
  final String businessId;
  final String name;
  final String code;
  final EnumValue<LocationType> type;
  final String? phone;
  final String? email;
  final bool isActive;
  final Timestamp createdAt;
  ListLocationsByBusinessLocations.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  businessId = nativeFromJson<String>(json['businessId']),
  name = nativeFromJson<String>(json['name']),
  code = nativeFromJson<String>(json['code']),
  type = locationTypeDeserializer(json['type']),
  phone = json['phone'] == null ? null : nativeFromJson<String>(json['phone']),
  email = json['email'] == null ? null : nativeFromJson<String>(json['email']),
  isActive = nativeFromJson<bool>(json['isActive']),
  createdAt = Timestamp.fromJson(json['createdAt']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListLocationsByBusinessLocations otherTyped = other as ListLocationsByBusinessLocations;
    return id == otherTyped.id && 
    businessId == otherTyped.businessId && 
    name == otherTyped.name && 
    code == otherTyped.code && 
    type == otherTyped.type && 
    phone == otherTyped.phone && 
    email == otherTyped.email && 
    isActive == otherTyped.isActive && 
    createdAt == otherTyped.createdAt;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, businessId.hashCode, name.hashCode, code.hashCode, type.hashCode, phone.hashCode, email.hashCode, isActive.hashCode, createdAt.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['businessId'] = nativeToJson<String>(businessId);
    json['name'] = nativeToJson<String>(name);
    json['code'] = nativeToJson<String>(code);
    json['type'] = 
    locationTypeSerializer(type)
    ;
    if (phone != null) {
      json['phone'] = nativeToJson<String?>(phone);
    }
    if (email != null) {
      json['email'] = nativeToJson<String?>(email);
    }
    json['isActive'] = nativeToJson<bool>(isActive);
    json['createdAt'] = createdAt.toJson();
    return json;
  }

  ListLocationsByBusinessLocations({
    required this.id,
    required this.businessId,
    required this.name,
    required this.code,
    required this.type,
    this.phone,
    this.email,
    required this.isActive,
    required this.createdAt,
  });
}

@immutable
class ListLocationsByBusinessData {
  final List<ListLocationsByBusinessLocations> locations;
  ListLocationsByBusinessData.fromJson(dynamic json):
  
  locations = (json['locations'] as List<dynamic>)
        .map((e) => ListLocationsByBusinessLocations.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListLocationsByBusinessData otherTyped = other as ListLocationsByBusinessData;
    return locations == otherTyped.locations;
    
  }
  @override
  int get hashCode => locations.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['locations'] = locations.map((e) => e.toJson()).toList();
    return json;
  }

  ListLocationsByBusinessData({
    required this.locations,
  });
}

@immutable
class ListLocationsByBusinessVariables {
  final String businessId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListLocationsByBusinessVariables.fromJson(Map<String, dynamic> json):
  
  businessId = nativeFromJson<String>(json['businessId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListLocationsByBusinessVariables otherTyped = other as ListLocationsByBusinessVariables;
    return businessId == otherTyped.businessId;
    
  }
  @override
  int get hashCode => businessId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['businessId'] = nativeToJson<String>(businessId);
    return json;
  }

  ListLocationsByBusinessVariables({
    required this.businessId,
  });
}

