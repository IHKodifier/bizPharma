part of 'biz_pharma.dart';

class CreateLocationVariablesBuilder {
  String businessId;
  String name;
  String code;
  LocationType type;
  Optional<String> _phone = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _email = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _operatingHours = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _licenseNumber = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  CreateLocationVariablesBuilder phone(String? t) {
   _phone.value = t;
   return this;
  }
  CreateLocationVariablesBuilder email(String? t) {
   _email.value = t;
   return this;
  }
  CreateLocationVariablesBuilder operatingHours(String? t) {
   _operatingHours.value = t;
   return this;
  }
  CreateLocationVariablesBuilder licenseNumber(String? t) {
   _licenseNumber.value = t;
   return this;
  }

  CreateLocationVariablesBuilder(this._dataConnect, {required  this.businessId,required  this.name,required  this.code,required  this.type,});
  Deserializer<CreateLocationData> dataDeserializer = (dynamic json)  => CreateLocationData.fromJson(jsonDecode(json));
  Serializer<CreateLocationVariables> varsSerializer = (CreateLocationVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateLocationData, CreateLocationVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateLocationData, CreateLocationVariables> ref() {
    CreateLocationVariables vars= CreateLocationVariables(businessId: businessId,name: name,code: code,type: type,phone: _phone,email: _email,operatingHours: _operatingHours,licenseNumber: _licenseNumber,);
    return _dataConnect.mutation("CreateLocation", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateLocationLocationInsert {
  final String id;
  CreateLocationLocationInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateLocationLocationInsert otherTyped = other as CreateLocationLocationInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateLocationLocationInsert({
    required this.id,
  });
}

@immutable
class CreateLocationData {
  final CreateLocationLocationInsert location_insert;
  CreateLocationData.fromJson(dynamic json):
  
  location_insert = CreateLocationLocationInsert.fromJson(json['location_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateLocationData otherTyped = other as CreateLocationData;
    return location_insert == otherTyped.location_insert;
    
  }
  @override
  int get hashCode => location_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['location_insert'] = location_insert.toJson();
    return json;
  }

  CreateLocationData({
    required this.location_insert,
  });
}

@immutable
class CreateLocationVariables {
  final String businessId;
  final String name;
  final String code;
  final LocationType type;
  late final Optional<String>phone;
  late final Optional<String>email;
  late final Optional<String>operatingHours;
  late final Optional<String>licenseNumber;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateLocationVariables.fromJson(Map<String, dynamic> json):
  
  businessId = nativeFromJson<String>(json['businessId']),
  name = nativeFromJson<String>(json['name']),
  code = nativeFromJson<String>(json['code']),
  type = LocationType.values.byName(json['type']) {
  
  
  
  
  
  
    phone = Optional.optional(nativeFromJson, nativeToJson);
    phone.value = json['phone'] == null ? null : nativeFromJson<String>(json['phone']);
  
  
    email = Optional.optional(nativeFromJson, nativeToJson);
    email.value = json['email'] == null ? null : nativeFromJson<String>(json['email']);
  
  
    operatingHours = Optional.optional(nativeFromJson, nativeToJson);
    operatingHours.value = json['operatingHours'] == null ? null : nativeFromJson<String>(json['operatingHours']);
  
  
    licenseNumber = Optional.optional(nativeFromJson, nativeToJson);
    licenseNumber.value = json['licenseNumber'] == null ? null : nativeFromJson<String>(json['licenseNumber']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateLocationVariables otherTyped = other as CreateLocationVariables;
    return businessId == otherTyped.businessId && 
    name == otherTyped.name && 
    code == otherTyped.code && 
    type == otherTyped.type && 
    phone == otherTyped.phone && 
    email == otherTyped.email && 
    operatingHours == otherTyped.operatingHours && 
    licenseNumber == otherTyped.licenseNumber;
    
  }
  @override
  int get hashCode => Object.hashAll([businessId.hashCode, name.hashCode, code.hashCode, type.hashCode, phone.hashCode, email.hashCode, operatingHours.hashCode, licenseNumber.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['businessId'] = nativeToJson<String>(businessId);
    json['name'] = nativeToJson<String>(name);
    json['code'] = nativeToJson<String>(code);
    json['type'] = 
    type.name
    ;
    if(phone.state == OptionalState.set) {
      json['phone'] = phone.toJson();
    }
    if(email.state == OptionalState.set) {
      json['email'] = email.toJson();
    }
    if(operatingHours.state == OptionalState.set) {
      json['operatingHours'] = operatingHours.toJson();
    }
    if(licenseNumber.state == OptionalState.set) {
      json['licenseNumber'] = licenseNumber.toJson();
    }
    return json;
  }

  CreateLocationVariables({
    required this.businessId,
    required this.name,
    required this.code,
    required this.type,
    required this.phone,
    required this.email,
    required this.operatingHours,
    required this.licenseNumber,
  });
}

