part of 'ik_pharma.dart';

class GetUserByAuthIdVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetUserByAuthIdVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetUserByAuthIdData> dataDeserializer = (dynamic json)  => GetUserByAuthIdData.fromJson(jsonDecode(json));
  Serializer<GetUserByAuthIdVariables> varsSerializer = (GetUserByAuthIdVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetUserByAuthIdData, GetUserByAuthIdVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetUserByAuthIdData, GetUserByAuthIdVariables> ref() {
    GetUserByAuthIdVariables vars= GetUserByAuthIdVariables(id: id,);
    return _dataConnect.query("GetUserByAuthId", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetUserByAuthIdUser {
  final String id;
  final String businessId;
  final EnumValue<UserRole> role;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final bool isActive;
  GetUserByAuthIdUser.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  businessId = nativeFromJson<String>(json['businessId']),
  role = userRoleDeserializer(json['role']),
  firstName = nativeFromJson<String>(json['firstName']),
  lastName = nativeFromJson<String>(json['lastName']),
  email = nativeFromJson<String>(json['email']),
  phone = json['phone'] == null ? null : nativeFromJson<String>(json['phone']),
  isActive = nativeFromJson<bool>(json['isActive']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByAuthIdUser otherTyped = other as GetUserByAuthIdUser;
    return id == otherTyped.id && 
    businessId == otherTyped.businessId && 
    role == otherTyped.role && 
    firstName == otherTyped.firstName && 
    lastName == otherTyped.lastName && 
    email == otherTyped.email && 
    phone == otherTyped.phone && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, businessId.hashCode, role.hashCode, firstName.hashCode, lastName.hashCode, email.hashCode, phone.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['businessId'] = nativeToJson<String>(businessId);
    json['role'] = 
    userRoleSerializer(role)
    ;
    json['firstName'] = nativeToJson<String>(firstName);
    json['lastName'] = nativeToJson<String>(lastName);
    json['email'] = nativeToJson<String>(email);
    if (phone != null) {
      json['phone'] = nativeToJson<String?>(phone);
    }
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  GetUserByAuthIdUser({
    required this.id,
    required this.businessId,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    required this.isActive,
  });
}

@immutable
class GetUserByAuthIdData {
  final GetUserByAuthIdUser? user;
  GetUserByAuthIdData.fromJson(dynamic json):
  
  user = json['user'] == null ? null : GetUserByAuthIdUser.fromJson(json['user']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByAuthIdData otherTyped = other as GetUserByAuthIdData;
    return user == otherTyped.user;
    
  }
  @override
  int get hashCode => user.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user != null) {
      json['user'] = user!.toJson();
    }
    return json;
  }

  GetUserByAuthIdData({
    this.user,
  });
}

@immutable
class GetUserByAuthIdVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetUserByAuthIdVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByAuthIdVariables otherTyped = other as GetUserByAuthIdVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetUserByAuthIdVariables({
    required this.id,
  });
}

