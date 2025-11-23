part of 'ik_pharma.dart';

class CreateUserVariablesBuilder {
  String id;
  String businessId;
  String email;
  String firstName;
  String lastName;
  Optional<String> _phone = Optional.optional(nativeFromJson, nativeToJson);
  UserRole role;
  Optional<List<String>> _permissions = Optional.optional(listDeserializer(nativeFromJson), listSerializer(nativeToJson));

  final FirebaseDataConnect _dataConnect;  CreateUserVariablesBuilder phone(String? t) {
   _phone.value = t;
   return this;
  }
  CreateUserVariablesBuilder permissions(List<String>? t) {
   _permissions.value = t;
   return this;
  }

  CreateUserVariablesBuilder(this._dataConnect, {required  this.id,required  this.businessId,required  this.email,required  this.firstName,required  this.lastName,required  this.role,});
  Deserializer<CreateUserData> dataDeserializer = (dynamic json)  => CreateUserData.fromJson(jsonDecode(json));
  Serializer<CreateUserVariables> varsSerializer = (CreateUserVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateUserData, CreateUserVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateUserData, CreateUserVariables> ref() {
    CreateUserVariables vars= CreateUserVariables(id: id,businessId: businessId,email: email,firstName: firstName,lastName: lastName,phone: _phone,role: role,permissions: _permissions,);
    return _dataConnect.mutation("CreateUser", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateUserUserInsert {
  final String id;
  CreateUserUserInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateUserUserInsert otherTyped = other as CreateUserUserInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateUserUserInsert({
    required this.id,
  });
}

@immutable
class CreateUserData {
  final CreateUserUserInsert user_insert;
  CreateUserData.fromJson(dynamic json):
  
  user_insert = CreateUserUserInsert.fromJson(json['user_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateUserData otherTyped = other as CreateUserData;
    return user_insert == otherTyped.user_insert;
    
  }
  @override
  int get hashCode => user_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_insert'] = user_insert.toJson();
    return json;
  }

  CreateUserData({
    required this.user_insert,
  });
}

@immutable
class CreateUserVariables {
  final String id;
  final String businessId;
  final String email;
  final String firstName;
  final String lastName;
  late final Optional<String>phone;
  final UserRole role;
  late final Optional<List<String>>permissions;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateUserVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  businessId = nativeFromJson<String>(json['businessId']),
  email = nativeFromJson<String>(json['email']),
  firstName = nativeFromJson<String>(json['firstName']),
  lastName = nativeFromJson<String>(json['lastName']),
  role = UserRole.values.byName(json['role']) {
  
  
  
  
  
  
  
    phone = Optional.optional(nativeFromJson, nativeToJson);
    phone.value = json['phone'] == null ? null : nativeFromJson<String>(json['phone']);
  
  
  
    permissions = Optional.optional(listDeserializer(nativeFromJson), listSerializer(nativeToJson));
    permissions.value = json['permissions'] == null ? null : (json['permissions'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList();
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateUserVariables otherTyped = other as CreateUserVariables;
    return id == otherTyped.id && 
    businessId == otherTyped.businessId && 
    email == otherTyped.email && 
    firstName == otherTyped.firstName && 
    lastName == otherTyped.lastName && 
    phone == otherTyped.phone && 
    role == otherTyped.role && 
    permissions == otherTyped.permissions;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, businessId.hashCode, email.hashCode, firstName.hashCode, lastName.hashCode, phone.hashCode, role.hashCode, permissions.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['businessId'] = nativeToJson<String>(businessId);
    json['email'] = nativeToJson<String>(email);
    json['firstName'] = nativeToJson<String>(firstName);
    json['lastName'] = nativeToJson<String>(lastName);
    if(phone.state == OptionalState.set) {
      json['phone'] = phone.toJson();
    }
    json['role'] = 
    role.name
    ;
    if(permissions.state == OptionalState.set) {
      json['permissions'] = permissions.toJson();
    }
    return json;
  }

  CreateUserVariables({
    required this.id,
    required this.businessId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.role,
    required this.permissions,
  });
}

