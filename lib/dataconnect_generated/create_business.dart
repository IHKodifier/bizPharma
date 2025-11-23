part of 'ik_pharma.dart';

class CreateBusinessVariablesBuilder {
  String name;
  BusinessTier tier;
  DateTime subscriptionStartDate;
  Optional<DateTime> _subscriptionEndDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<int> _maxUsers = Optional.optional(nativeFromJson, nativeToJson);
  Optional<int> _maxLocations = Optional.optional(nativeFromJson, nativeToJson);

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

  CreateBusinessVariablesBuilder(this._dataConnect, {required  this.name,required  this.tier,required  this.subscriptionStartDate,});
  Deserializer<CreateBusinessData> dataDeserializer = (dynamic json)  => CreateBusinessData.fromJson(jsonDecode(json));
  Serializer<CreateBusinessVariables> varsSerializer = (CreateBusinessVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateBusinessData, CreateBusinessVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateBusinessData, CreateBusinessVariables> ref() {
    CreateBusinessVariables vars= CreateBusinessVariables(name: name,tier: tier,subscriptionStartDate: subscriptionStartDate,subscriptionEndDate: _subscriptionEndDate,maxUsers: _maxUsers,maxLocations: _maxLocations,);
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
    maxLocations == otherTyped.maxLocations;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, tier.hashCode, subscriptionStartDate.hashCode, subscriptionEndDate.hashCode, maxUsers.hashCode, maxLocations.hashCode]);
  

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
    return json;
  }

  CreateBusinessVariables({
    required this.name,
    required this.tier,
    required this.subscriptionStartDate,
    required this.subscriptionEndDate,
    required this.maxUsers,
    required this.maxLocations,
  });
}

