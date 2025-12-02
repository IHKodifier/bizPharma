part of 'biz_pharma.dart';

class CreateAddressVariablesBuilder {
  String line1;
  Optional<String> _line2 = Optional.optional(nativeFromJson, nativeToJson);
  String city;
  String state;
  String postalCode;
  String country;
  Optional<String> _phone = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  CreateAddressVariablesBuilder line2(String? t) {
   _line2.value = t;
   return this;
  }
  CreateAddressVariablesBuilder phone(String? t) {
   _phone.value = t;
   return this;
  }

  CreateAddressVariablesBuilder(this._dataConnect, {required  this.line1,required  this.city,required  this.state,required  this.postalCode,required  this.country,});
  Deserializer<CreateAddressData> dataDeserializer = (dynamic json)  => CreateAddressData.fromJson(jsonDecode(json));
  Serializer<CreateAddressVariables> varsSerializer = (CreateAddressVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateAddressData, CreateAddressVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateAddressData, CreateAddressVariables> ref() {
    CreateAddressVariables vars= CreateAddressVariables(line1: line1,line2: _line2,city: city,state: state,postalCode: postalCode,country: country,phone: _phone,);
    return _dataConnect.mutation("CreateAddress", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateAddressAddressInsert {
  final String id;
  CreateAddressAddressInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateAddressAddressInsert otherTyped = other as CreateAddressAddressInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateAddressAddressInsert({
    required this.id,
  });
}

@immutable
class CreateAddressData {
  final CreateAddressAddressInsert address_insert;
  CreateAddressData.fromJson(dynamic json):
  
  address_insert = CreateAddressAddressInsert.fromJson(json['address_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateAddressData otherTyped = other as CreateAddressData;
    return address_insert == otherTyped.address_insert;
    
  }
  @override
  int get hashCode => address_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['address_insert'] = address_insert.toJson();
    return json;
  }

  CreateAddressData({
    required this.address_insert,
  });
}

@immutable
class CreateAddressVariables {
  final String line1;
  late final Optional<String>line2;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  late final Optional<String>phone;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateAddressVariables.fromJson(Map<String, dynamic> json):
  
  line1 = nativeFromJson<String>(json['line1']),
  city = nativeFromJson<String>(json['city']),
  state = nativeFromJson<String>(json['state']),
  postalCode = nativeFromJson<String>(json['postalCode']),
  country = nativeFromJson<String>(json['country']) {
  
  
  
    line2 = Optional.optional(nativeFromJson, nativeToJson);
    line2.value = json['line2'] == null ? null : nativeFromJson<String>(json['line2']);
  
  
  
  
  
  
    phone = Optional.optional(nativeFromJson, nativeToJson);
    phone.value = json['phone'] == null ? null : nativeFromJson<String>(json['phone']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateAddressVariables otherTyped = other as CreateAddressVariables;
    return line1 == otherTyped.line1 && 
    line2 == otherTyped.line2 && 
    city == otherTyped.city && 
    state == otherTyped.state && 
    postalCode == otherTyped.postalCode && 
    country == otherTyped.country && 
    phone == otherTyped.phone;
    
  }
  @override
  int get hashCode => Object.hashAll([line1.hashCode, line2.hashCode, city.hashCode, state.hashCode, postalCode.hashCode, country.hashCode, phone.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['line1'] = nativeToJson<String>(line1);
    if(line2.state == OptionalState.set) {
      json['line2'] = line2.toJson();
    }
    json['city'] = nativeToJson<String>(city);
    json['state'] = nativeToJson<String>(state);
    json['postalCode'] = nativeToJson<String>(postalCode);
    json['country'] = nativeToJson<String>(country);
    if(phone.state == OptionalState.set) {
      json['phone'] = phone.toJson();
    }
    return json;
  }

  CreateAddressVariables({
    required this.line1,
    required this.line2,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.phone,
  });
}

