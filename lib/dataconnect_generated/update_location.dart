part of 'biz_pharma.dart';

class UpdateLocationVariablesBuilder {
  String id;
  Optional<String> _name = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _code = Optional.optional(nativeFromJson, nativeToJson);
  Optional<LocationType> _type = Optional.optional((data) => LocationType.values.byName(data), enumSerializer);
  Optional<String> _phone = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _email = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _operatingHours = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _licenseNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<bool> _isActive = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  UpdateLocationVariablesBuilder name(String? t) {
   _name.value = t;
   return this;
  }
  UpdateLocationVariablesBuilder code(String? t) {
   _code.value = t;
   return this;
  }
  UpdateLocationVariablesBuilder type(LocationType? t) {
   _type.value = t;
   return this;
  }
  UpdateLocationVariablesBuilder phone(String? t) {
   _phone.value = t;
   return this;
  }
  UpdateLocationVariablesBuilder email(String? t) {
   _email.value = t;
   return this;
  }
  UpdateLocationVariablesBuilder operatingHours(String? t) {
   _operatingHours.value = t;
   return this;
  }
  UpdateLocationVariablesBuilder licenseNumber(String? t) {
   _licenseNumber.value = t;
   return this;
  }
  UpdateLocationVariablesBuilder isActive(bool? t) {
   _isActive.value = t;
   return this;
  }

  UpdateLocationVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<UpdateLocationData> dataDeserializer = (dynamic json)  => UpdateLocationData.fromJson(jsonDecode(json));
  Serializer<UpdateLocationVariables> varsSerializer = (UpdateLocationVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateLocationData, UpdateLocationVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateLocationData, UpdateLocationVariables> ref() {
    UpdateLocationVariables vars= UpdateLocationVariables(id: id,name: _name,code: _code,type: _type,phone: _phone,email: _email,operatingHours: _operatingHours,licenseNumber: _licenseNumber,isActive: _isActive,);
    return _dataConnect.mutation("UpdateLocation", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateLocationLocationUpdate {
  final String id;
  UpdateLocationLocationUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateLocationLocationUpdate otherTyped = other as UpdateLocationLocationUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateLocationLocationUpdate({
    required this.id,
  });
}

@immutable
class UpdateLocationData {
  final UpdateLocationLocationUpdate? location_update;
  UpdateLocationData.fromJson(dynamic json):
  
  location_update = json['location_update'] == null ? null : UpdateLocationLocationUpdate.fromJson(json['location_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateLocationData otherTyped = other as UpdateLocationData;
    return location_update == otherTyped.location_update;
    
  }
  @override
  int get hashCode => location_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (location_update != null) {
      json['location_update'] = location_update!.toJson();
    }
    return json;
  }

  UpdateLocationData({
    this.location_update,
  });
}

@immutable
class UpdateLocationVariables {
  final String id;
  late final Optional<String>name;
  late final Optional<String>code;
  late final Optional<LocationType>type;
  late final Optional<String>phone;
  late final Optional<String>email;
  late final Optional<String>operatingHours;
  late final Optional<String>licenseNumber;
  late final Optional<bool>isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateLocationVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']) {
  
  
  
    name = Optional.optional(nativeFromJson, nativeToJson);
    name.value = json['name'] == null ? null : nativeFromJson<String>(json['name']);
  
  
    code = Optional.optional(nativeFromJson, nativeToJson);
    code.value = json['code'] == null ? null : nativeFromJson<String>(json['code']);
  
  
    type = Optional.optional((data) => LocationType.values.byName(data), enumSerializer);
    type.value = json['type'] == null ? null : LocationType.values.byName(json['type']);
  
  
    phone = Optional.optional(nativeFromJson, nativeToJson);
    phone.value = json['phone'] == null ? null : nativeFromJson<String>(json['phone']);
  
  
    email = Optional.optional(nativeFromJson, nativeToJson);
    email.value = json['email'] == null ? null : nativeFromJson<String>(json['email']);
  
  
    operatingHours = Optional.optional(nativeFromJson, nativeToJson);
    operatingHours.value = json['operatingHours'] == null ? null : nativeFromJson<String>(json['operatingHours']);
  
  
    licenseNumber = Optional.optional(nativeFromJson, nativeToJson);
    licenseNumber.value = json['licenseNumber'] == null ? null : nativeFromJson<String>(json['licenseNumber']);
  
  
    isActive = Optional.optional(nativeFromJson, nativeToJson);
    isActive.value = json['isActive'] == null ? null : nativeFromJson<bool>(json['isActive']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateLocationVariables otherTyped = other as UpdateLocationVariables;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    code == otherTyped.code && 
    type == otherTyped.type && 
    phone == otherTyped.phone && 
    email == otherTyped.email && 
    operatingHours == otherTyped.operatingHours && 
    licenseNumber == otherTyped.licenseNumber && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, code.hashCode, type.hashCode, phone.hashCode, email.hashCode, operatingHours.hashCode, licenseNumber.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if(name.state == OptionalState.set) {
      json['name'] = name.toJson();
    }
    if(code.state == OptionalState.set) {
      json['code'] = code.toJson();
    }
    if(type.state == OptionalState.set) {
      json['type'] = type.toJson();
    }
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
    if(isActive.state == OptionalState.set) {
      json['isActive'] = isActive.toJson();
    }
    return json;
  }

  UpdateLocationVariables({
    required this.id,
    required this.name,
    required this.code,
    required this.type,
    required this.phone,
    required this.email,
    required this.operatingHours,
    required this.licenseNumber,
    required this.isActive,
  });
}

