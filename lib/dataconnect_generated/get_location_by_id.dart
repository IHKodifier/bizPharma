part of 'biz_pharma.dart';

class GetLocationByIdVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetLocationByIdVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetLocationByIdData> dataDeserializer = (dynamic json)  => GetLocationByIdData.fromJson(jsonDecode(json));
  Serializer<GetLocationByIdVariables> varsSerializer = (GetLocationByIdVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetLocationByIdData, GetLocationByIdVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetLocationByIdData, GetLocationByIdVariables> ref() {
    GetLocationByIdVariables vars= GetLocationByIdVariables(id: id,);
    return _dataConnect.query("GetLocationById", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetLocationByIdLocation {
  final String id;
  final String businessId;
  final String name;
  final String code;
  final EnumValue<LocationType> type;
  final String? parentId;
  final String? phone;
  final String? email;
  final String? operatingHours;
  final String? licenseNumber;
  final bool isActive;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final GetLocationByIdLocationAddress? address;
  GetLocationByIdLocation.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  businessId = nativeFromJson<String>(json['businessId']),
  name = nativeFromJson<String>(json['name']),
  code = nativeFromJson<String>(json['code']),
  type = locationTypeDeserializer(json['type']),
  parentId = json['parentId'] == null ? null : nativeFromJson<String>(json['parentId']),
  phone = json['phone'] == null ? null : nativeFromJson<String>(json['phone']),
  email = json['email'] == null ? null : nativeFromJson<String>(json['email']),
  operatingHours = json['operatingHours'] == null ? null : nativeFromJson<String>(json['operatingHours']),
  licenseNumber = json['licenseNumber'] == null ? null : nativeFromJson<String>(json['licenseNumber']),
  isActive = nativeFromJson<bool>(json['isActive']),
  createdAt = Timestamp.fromJson(json['createdAt']),
  updatedAt = Timestamp.fromJson(json['updatedAt']),
  address = json['address'] == null ? null : GetLocationByIdLocationAddress.fromJson(json['address']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetLocationByIdLocation otherTyped = other as GetLocationByIdLocation;
    return id == otherTyped.id && 
    businessId == otherTyped.businessId && 
    name == otherTyped.name && 
    code == otherTyped.code && 
    type == otherTyped.type && 
    parentId == otherTyped.parentId && 
    phone == otherTyped.phone && 
    email == otherTyped.email && 
    operatingHours == otherTyped.operatingHours && 
    licenseNumber == otherTyped.licenseNumber && 
    isActive == otherTyped.isActive && 
    createdAt == otherTyped.createdAt && 
    updatedAt == otherTyped.updatedAt && 
    address == otherTyped.address;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, businessId.hashCode, name.hashCode, code.hashCode, type.hashCode, parentId.hashCode, phone.hashCode, email.hashCode, operatingHours.hashCode, licenseNumber.hashCode, isActive.hashCode, createdAt.hashCode, updatedAt.hashCode, address.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['businessId'] = nativeToJson<String>(businessId);
    json['name'] = nativeToJson<String>(name);
    json['code'] = nativeToJson<String>(code);
    json['type'] = 
    locationTypeSerializer(type)
    ;
    if (parentId != null) {
      json['parentId'] = nativeToJson<String?>(parentId);
    }
    if (phone != null) {
      json['phone'] = nativeToJson<String?>(phone);
    }
    if (email != null) {
      json['email'] = nativeToJson<String?>(email);
    }
    if (operatingHours != null) {
      json['operatingHours'] = nativeToJson<String?>(operatingHours);
    }
    if (licenseNumber != null) {
      json['licenseNumber'] = nativeToJson<String?>(licenseNumber);
    }
    json['isActive'] = nativeToJson<bool>(isActive);
    json['createdAt'] = createdAt.toJson();
    json['updatedAt'] = updatedAt.toJson();
    if (address != null) {
      json['address'] = address!.toJson();
    }
    return json;
  }

  GetLocationByIdLocation({
    required this.id,
    required this.businessId,
    required this.name,
    required this.code,
    required this.type,
    this.parentId,
    this.phone,
    this.email,
    this.operatingHours,
    this.licenseNumber,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.address,
  });
}

@immutable
class GetLocationByIdLocationAddress {
  final String id;
  final String line1;
  final String? line2;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String? phone;
  GetLocationByIdLocationAddress.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  line1 = nativeFromJson<String>(json['line1']),
  line2 = json['line2'] == null ? null : nativeFromJson<String>(json['line2']),
  city = nativeFromJson<String>(json['city']),
  state = nativeFromJson<String>(json['state']),
  postalCode = nativeFromJson<String>(json['postalCode']),
  country = nativeFromJson<String>(json['country']),
  phone = json['phone'] == null ? null : nativeFromJson<String>(json['phone']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetLocationByIdLocationAddress otherTyped = other as GetLocationByIdLocationAddress;
    return id == otherTyped.id && 
    line1 == otherTyped.line1 && 
    line2 == otherTyped.line2 && 
    city == otherTyped.city && 
    state == otherTyped.state && 
    postalCode == otherTyped.postalCode && 
    country == otherTyped.country && 
    phone == otherTyped.phone;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, line1.hashCode, line2.hashCode, city.hashCode, state.hashCode, postalCode.hashCode, country.hashCode, phone.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['line1'] = nativeToJson<String>(line1);
    if (line2 != null) {
      json['line2'] = nativeToJson<String?>(line2);
    }
    json['city'] = nativeToJson<String>(city);
    json['state'] = nativeToJson<String>(state);
    json['postalCode'] = nativeToJson<String>(postalCode);
    json['country'] = nativeToJson<String>(country);
    if (phone != null) {
      json['phone'] = nativeToJson<String?>(phone);
    }
    return json;
  }

  GetLocationByIdLocationAddress({
    required this.id,
    required this.line1,
    this.line2,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.phone,
  });
}

@immutable
class GetLocationByIdData {
  final GetLocationByIdLocation? location;
  GetLocationByIdData.fromJson(dynamic json):
  
  location = json['location'] == null ? null : GetLocationByIdLocation.fromJson(json['location']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetLocationByIdData otherTyped = other as GetLocationByIdData;
    return location == otherTyped.location;
    
  }
  @override
  int get hashCode => location.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (location != null) {
      json['location'] = location!.toJson();
    }
    return json;
  }

  GetLocationByIdData({
    this.location,
  });
}

@immutable
class GetLocationByIdVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetLocationByIdVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetLocationByIdVariables otherTyped = other as GetLocationByIdVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetLocationByIdVariables({
    required this.id,
  });
}

