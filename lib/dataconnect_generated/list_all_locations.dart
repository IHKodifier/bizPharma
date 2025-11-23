part of 'ik_pharma.dart';

class ListAllLocationsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListAllLocationsVariablesBuilder(this._dataConnect, );
  Deserializer<ListAllLocationsData> dataDeserializer = (dynamic json)  => ListAllLocationsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListAllLocationsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListAllLocationsData, void> ref() {
    
    return _dataConnect.query("ListAllLocations", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListAllLocationsLocations {
  final String id;
  final String businessId;
  final String name;
  final String code;
  final EnumValue<LocationType> type;
  final String? phone;
  final String? email;
  final bool isActive;
  final Timestamp createdAt;
  ListAllLocationsLocations.fromJson(dynamic json):
  
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

    final ListAllLocationsLocations otherTyped = other as ListAllLocationsLocations;
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

  ListAllLocationsLocations({
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
class ListAllLocationsData {
  final List<ListAllLocationsLocations> locations;
  ListAllLocationsData.fromJson(dynamic json):
  
  locations = (json['locations'] as List<dynamic>)
        .map((e) => ListAllLocationsLocations.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAllLocationsData otherTyped = other as ListAllLocationsData;
    return locations == otherTyped.locations;
    
  }
  @override
  int get hashCode => locations.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['locations'] = locations.map((e) => e.toJson()).toList();
    return json;
  }

  ListAllLocationsData({
    required this.locations,
  });
}

