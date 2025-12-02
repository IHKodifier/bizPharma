part of 'biz_pharma.dart';

class CreateBusinessVariablesBuilder {
  String name;
  BusinessTier tier;
  DateTime subscriptionStartDate;
  Optional<DateTime> _subscriptionEndDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<int> _maxUsers = Optional.optional(nativeFromJson, nativeToJson);
  Optional<int> _maxLocations = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _logo = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _banner = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _phone = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  CreateBusinessVariablesBuilder subscriptionEndDate(DateTime? t) {
   _subscriptionEndDate.value = t;
   return this;
  }
  CreateBusinessVariablesBuilder maxUsers(int? t) {
   _maxUsers.value = t;
   return this;
  }
  CreateBusinessVariablesBuilder maxLocations(int? t) {
   _maxLocations.value = t;
   return this;
  }
  CreateBusinessVariablesBuilder logo(String? t) {
   _logo.value = t;
   return this;
  }
  CreateBusinessVariablesBuilder banner(String? t) {
   _banner.value = t;
   return this;
  }
  CreateBusinessVariablesBuilder phone(String? t) {
   _phone.value = t;
   return this;
  }

  CreateBusinessVariablesBuilder(this._dataConnect, {required  this.name,required  this.tier,required  this.subscriptionStartDate,});
  Deserializer<CreateBusinessData> dataDeserializer = (dynamic json)  => CreateBusinessData.fromJson(jsonDecode(json));
  Serializer<CreateBusinessVariables> varsSerializer = (CreateBusinessVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateBusinessData, CreateBusinessVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateBusinessData, CreateBusinessVariables> ref() {
    CreateBusinessVariables vars= CreateBusinessVariables(name: name,tier: tier,subscriptionStartDate: subscriptionStartDate,subscriptionEndDate: _subscriptionEndDate,maxUsers: _maxUsers,maxLocations: _maxLocations,logo: _logo,banner: _banner,phone: _phone,);
    return _dataConnect.mutation("CreateBusiness", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateBusinessBusinessInsert {
  final String id;
  CreateBusinessBusinessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateBusinessBusinessInsert otherTyped = other as CreateBusinessBusinessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateBusinessBusinessInsert({
    required this.id,
  });
}

@immutable
class CreateBusinessData {
  final CreateBusinessBusinessInsert business_insert;
  CreateBusinessData.fromJson(dynamic json):
  
  business_insert = CreateBusinessBusinessInsert.fromJson(json['business_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateBusinessData otherTyped = other as CreateBusinessData;
    return business_insert == otherTyped.business_insert;
    
  }
  @override
  int get hashCode => business_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['business_insert'] = business_insert.toJson();
    return json;
  }

  CreateBusinessData({
    required this.business_insert,
  });
}

@immutable
class CreateBusinessVariables {
  final String name;
  final BusinessTier tier;
  final DateTime subscriptionStartDate;
  late final Optional<DateTime>subscriptionEndDate;
  late final Optional<int>maxUsers;
  late final Optional<int>maxLocations;
  late final Optional<String>logo;
  late final Optional<String>banner;
  late final Optional<String>phone;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateBusinessVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']),
  tier = BusinessTier.values.byName(json['tier']),
  subscriptionStartDate = nativeFromJson<DateTime>(json['subscriptionStartDate']) {
  
  
  
  
  
    subscriptionEndDate = Optional.optional(nativeFromJson, nativeToJson);
    subscriptionEndDate.value = json['subscriptionEndDate'] == null ? null : nativeFromJson<DateTime>(json['subscriptionEndDate']);
  
  
    maxUsers = Optional.optional(nativeFromJson, nativeToJson);
    maxUsers.value = json['maxUsers'] == null ? null : nativeFromJson<int>(json['maxUsers']);
  
  
    maxLocations = Optional.optional(nativeFromJson, nativeToJson);
    maxLocations.value = json['maxLocations'] == null ? null : nativeFromJson<int>(json['maxLocations']);
  
  
    logo = Optional.optional(nativeFromJson, nativeToJson);
    logo.value = json['logo'] == null ? null : nativeFromJson<String>(json['logo']);
  
  
    banner = Optional.optional(nativeFromJson, nativeToJson);
    banner.value = json['banner'] == null ? null : nativeFromJson<String>(json['banner']);
  
  
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

    final CreateBusinessVariables otherTyped = other as CreateBusinessVariables;
    return name == otherTyped.name && 
    tier == otherTyped.tier && 
    subscriptionStartDate == otherTyped.subscriptionStartDate && 
    subscriptionEndDate == otherTyped.subscriptionEndDate && 
    maxUsers == otherTyped.maxUsers && 
    maxLocations == otherTyped.maxLocations && 
    logo == otherTyped.logo && 
    banner == otherTyped.banner && 
    phone == otherTyped.phone;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, tier.hashCode, subscriptionStartDate.hashCode, subscriptionEndDate.hashCode, maxUsers.hashCode, maxLocations.hashCode, logo.hashCode, banner.hashCode, phone.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['tier'] = 
    tier.name
    ;
    json['subscriptionStartDate'] = nativeToJson<DateTime>(subscriptionStartDate);
    if(subscriptionEndDate.state == OptionalState.set) {
      json['subscriptionEndDate'] = subscriptionEndDate.toJson();
    }
    if(maxUsers.state == OptionalState.set) {
      json['maxUsers'] = maxUsers.toJson();
    }
    if(maxLocations.state == OptionalState.set) {
      json['maxLocations'] = maxLocations.toJson();
    }
    if(logo.state == OptionalState.set) {
      json['logo'] = logo.toJson();
    }
    if(banner.state == OptionalState.set) {
      json['banner'] = banner.toJson();
    }
    if(phone.state == OptionalState.set) {
      json['phone'] = phone.toJson();
    }
    return json;
  }

  CreateBusinessVariables({
    required this.name,
    required this.tier,
    required this.subscriptionStartDate,
    required this.subscriptionEndDate,
    required this.maxUsers,
    required this.maxLocations,
    required this.logo,
    required this.banner,
    required this.phone,
  });
}

