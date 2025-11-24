part of 'ik_pharma.dart';

class CreateBusinessAndAdminVariablesBuilder {
  String businessName;
  String userEmail;
  String userFirstName;
  String userLastName;
  Optional<String> _userPhone = Optional.optional(nativeFromJson, nativeToJson);
  String authUid;

  final FirebaseDataConnect _dataConnect;  CreateBusinessAndAdminVariablesBuilder userPhone(String? t) {
   _userPhone.value = t;
   return this;
  }

  CreateBusinessAndAdminVariablesBuilder(this._dataConnect, {required  this.businessName,required  this.userEmail,required  this.userFirstName,required  this.userLastName,required  this.authUid,});
  Deserializer<CreateBusinessAndAdminData> dataDeserializer = (dynamic json)  => CreateBusinessAndAdminData.fromJson(jsonDecode(json));
  Serializer<CreateBusinessAndAdminVariables> varsSerializer = (CreateBusinessAndAdminVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateBusinessAndAdminData, CreateBusinessAndAdminVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateBusinessAndAdminData, CreateBusinessAndAdminVariables> ref() {
    CreateBusinessAndAdminVariables vars= CreateBusinessAndAdminVariables(businessName: businessName,userEmail: userEmail,userFirstName: userFirstName,userLastName: userLastName,userPhone: _userPhone,authUid: authUid,);
    return _dataConnect.mutation("CreateBusinessAndAdmin", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateBusinessAndAdminBusiness {
  final String id;
  CreateBusinessAndAdminBusiness.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateBusinessAndAdminBusiness otherTyped = other as CreateBusinessAndAdminBusiness;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateBusinessAndAdminBusiness({
    required this.id,
  });
}

@immutable
class CreateBusinessAndAdminUser {
  final String id;
  CreateBusinessAndAdminUser.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateBusinessAndAdminUser otherTyped = other as CreateBusinessAndAdminUser;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateBusinessAndAdminUser({
    required this.id,
  });
}

@immutable
class CreateBusinessAndAdminData {
  final CreateBusinessAndAdminBusiness business;
  final CreateBusinessAndAdminUser user;
  CreateBusinessAndAdminData.fromJson(dynamic json):
  
  business = CreateBusinessAndAdminBusiness.fromJson(json['business']),
  user = CreateBusinessAndAdminUser.fromJson(json['user']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateBusinessAndAdminData otherTyped = other as CreateBusinessAndAdminData;
    return business == otherTyped.business && 
    user == otherTyped.user;
    
  }
  @override
  int get hashCode => Object.hashAll([business.hashCode, user.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['business'] = business.toJson();
    json['user'] = user.toJson();
    return json;
  }

  CreateBusinessAndAdminData({
    required this.business,
    required this.user,
  });
}

@immutable
class CreateBusinessAndAdminVariables {
  final String businessName;
  final String userEmail;
  final String userFirstName;
  final String userLastName;
  late final Optional<String>userPhone;
  final String authUid;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateBusinessAndAdminVariables.fromJson(Map<String, dynamic> json):
  
  businessName = nativeFromJson<String>(json['businessName']),
  userEmail = nativeFromJson<String>(json['userEmail']),
  userFirstName = nativeFromJson<String>(json['userFirstName']),
  userLastName = nativeFromJson<String>(json['userLastName']),
  authUid = nativeFromJson<String>(json['authUid']) {
  
  
  
  
  
  
    userPhone = Optional.optional(nativeFromJson, nativeToJson);
    userPhone.value = json['userPhone'] == null ? null : nativeFromJson<String>(json['userPhone']);
  
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateBusinessAndAdminVariables otherTyped = other as CreateBusinessAndAdminVariables;
    return businessName == otherTyped.businessName && 
    userEmail == otherTyped.userEmail && 
    userFirstName == otherTyped.userFirstName && 
    userLastName == otherTyped.userLastName && 
    userPhone == otherTyped.userPhone && 
    authUid == otherTyped.authUid;
    
  }
  @override
  int get hashCode => Object.hashAll([businessName.hashCode, userEmail.hashCode, userFirstName.hashCode, userLastName.hashCode, userPhone.hashCode, authUid.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['businessName'] = nativeToJson<String>(businessName);
    json['userEmail'] = nativeToJson<String>(userEmail);
    json['userFirstName'] = nativeToJson<String>(userFirstName);
    json['userLastName'] = nativeToJson<String>(userLastName);
    if(userPhone.state == OptionalState.set) {
      json['userPhone'] = userPhone.toJson();
    }
    json['authUid'] = nativeToJson<String>(authUid);
    return json;
  }

  CreateBusinessAndAdminVariables({
    required this.businessName,
    required this.userEmail,
    required this.userFirstName,
    required this.userLastName,
    required this.userPhone,
    required this.authUid,
  });
}

