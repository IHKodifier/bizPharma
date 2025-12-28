part of 'biz_pharma.dart';

class CreateBusinessAndAdminVariablesBuilder {
  String businessId;
  String businessName;
  String userEmail;
  String userFirstName;
  String userLastName;
  String userMobile;
  Optional<String> _userProfilePhoto = Optional.optional(nativeFromJson, nativeToJson);
  String authUid;
  DateTime today;
  String defaultLocationId;

  final FirebaseDataConnect _dataConnect;  CreateBusinessAndAdminVariablesBuilder userProfilePhoto(String? t) {
   _userProfilePhoto.value = t;
   return this;
  }

  CreateBusinessAndAdminVariablesBuilder(this._dataConnect, {required  this.businessId,required  this.businessName,required  this.userEmail,required  this.userFirstName,required  this.userLastName,required  this.userMobile,required  this.authUid,required  this.today,required  this.defaultLocationId,});
  Deserializer<CreateBusinessAndAdminData> dataDeserializer = (dynamic json)  => CreateBusinessAndAdminData.fromJson(jsonDecode(json));
  Serializer<CreateBusinessAndAdminVariables> varsSerializer = (CreateBusinessAndAdminVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateBusinessAndAdminData, CreateBusinessAndAdminVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateBusinessAndAdminData, CreateBusinessAndAdminVariables> ref() {
    CreateBusinessAndAdminVariables vars= CreateBusinessAndAdminVariables(businessId: businessId,businessName: businessName,userEmail: userEmail,userFirstName: userFirstName,userLastName: userLastName,userMobile: userMobile,userProfilePhoto: _userProfilePhoto,authUid: authUid,today: today,defaultLocationId: defaultLocationId,);
    return _dataConnect.mutation("CreateBusinessAndAdmin", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateBusinessAndAdminBusinessInsert {
  final String id;
  CreateBusinessAndAdminBusinessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateBusinessAndAdminBusinessInsert otherTyped = other as CreateBusinessAndAdminBusinessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateBusinessAndAdminBusinessInsert({
    required this.id,
  });
}

@immutable
class CreateBusinessAndAdminUserInsert {
  final String id;
  CreateBusinessAndAdminUserInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateBusinessAndAdminUserInsert otherTyped = other as CreateBusinessAndAdminUserInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateBusinessAndAdminUserInsert({
    required this.id,
  });
}

@immutable
class CreateBusinessAndAdminLocationInsert {
  final String id;
  CreateBusinessAndAdminLocationInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateBusinessAndAdminLocationInsert otherTyped = other as CreateBusinessAndAdminLocationInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateBusinessAndAdminLocationInsert({
    required this.id,
  });
}

@immutable
class CreateBusinessAndAdminData {
  final CreateBusinessAndAdminBusinessInsert business_insert;
  final CreateBusinessAndAdminUserInsert user_insert;
  final CreateBusinessAndAdminLocationInsert location_insert;
  CreateBusinessAndAdminData.fromJson(dynamic json):
  
  business_insert = CreateBusinessAndAdminBusinessInsert.fromJson(json['business_insert']),
  user_insert = CreateBusinessAndAdminUserInsert.fromJson(json['user_insert']),
  location_insert = CreateBusinessAndAdminLocationInsert.fromJson(json['location_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateBusinessAndAdminData otherTyped = other as CreateBusinessAndAdminData;
    return business_insert == otherTyped.business_insert && 
    user_insert == otherTyped.user_insert && 
    location_insert == otherTyped.location_insert;
    
  }
  @override
  int get hashCode => Object.hashAll([business_insert.hashCode, user_insert.hashCode, location_insert.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['business_insert'] = business_insert.toJson();
    json['user_insert'] = user_insert.toJson();
    json['location_insert'] = location_insert.toJson();
    return json;
  }

  CreateBusinessAndAdminData({
    required this.business_insert,
    required this.user_insert,
    required this.location_insert,
  });
}

@immutable
class CreateBusinessAndAdminVariables {
  final String businessId;
  final String businessName;
  final String userEmail;
  final String userFirstName;
  final String userLastName;
  final String userMobile;
  late final Optional<String>userProfilePhoto;
  final String authUid;
  final DateTime today;
  final String defaultLocationId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateBusinessAndAdminVariables.fromJson(Map<String, dynamic> json):
  
  businessId = nativeFromJson<String>(json['businessId']),
  businessName = nativeFromJson<String>(json['businessName']),
  userEmail = nativeFromJson<String>(json['userEmail']),
  userFirstName = nativeFromJson<String>(json['userFirstName']),
  userLastName = nativeFromJson<String>(json['userLastName']),
  userMobile = nativeFromJson<String>(json['userMobile']),
  authUid = nativeFromJson<String>(json['authUid']),
  today = nativeFromJson<DateTime>(json['today']),
  defaultLocationId = nativeFromJson<String>(json['defaultLocationId']) {
  
  
  
  
  
  
  
  
    userProfilePhoto = Optional.optional(nativeFromJson, nativeToJson);
    userProfilePhoto.value = json['userProfilePhoto'] == null ? null : nativeFromJson<String>(json['userProfilePhoto']);
  
  
  
  
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
    return businessId == otherTyped.businessId && 
    businessName == otherTyped.businessName && 
    userEmail == otherTyped.userEmail && 
    userFirstName == otherTyped.userFirstName && 
    userLastName == otherTyped.userLastName && 
    userMobile == otherTyped.userMobile && 
    userProfilePhoto == otherTyped.userProfilePhoto && 
    authUid == otherTyped.authUid && 
    today == otherTyped.today && 
    defaultLocationId == otherTyped.defaultLocationId;
    
  }
  @override
  int get hashCode => Object.hashAll([businessId.hashCode, businessName.hashCode, userEmail.hashCode, userFirstName.hashCode, userLastName.hashCode, userMobile.hashCode, userProfilePhoto.hashCode, authUid.hashCode, today.hashCode, defaultLocationId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['businessId'] = nativeToJson<String>(businessId);
    json['businessName'] = nativeToJson<String>(businessName);
    json['userEmail'] = nativeToJson<String>(userEmail);
    json['userFirstName'] = nativeToJson<String>(userFirstName);
    json['userLastName'] = nativeToJson<String>(userLastName);
    json['userMobile'] = nativeToJson<String>(userMobile);
    if(userProfilePhoto.state == OptionalState.set) {
      json['userProfilePhoto'] = userProfilePhoto.toJson();
    }
    json['authUid'] = nativeToJson<String>(authUid);
    json['today'] = nativeToJson<DateTime>(today);
    json['defaultLocationId'] = nativeToJson<String>(defaultLocationId);
    return json;
  }

  CreateBusinessAndAdminVariables({
    required this.businessId,
    required this.businessName,
    required this.userEmail,
    required this.userFirstName,
    required this.userLastName,
    required this.userMobile,
    required this.userProfilePhoto,
    required this.authUid,
    required this.today,
    required this.defaultLocationId,
  });
}

