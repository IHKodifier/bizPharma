part of 'ik_pharma.dart';

class GetBusinessByIdVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetBusinessByIdVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetBusinessByIdData> dataDeserializer = (dynamic json)  => GetBusinessByIdData.fromJson(jsonDecode(json));
  Serializer<GetBusinessByIdVariables> varsSerializer = (GetBusinessByIdVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetBusinessByIdData, GetBusinessByIdVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetBusinessByIdData, GetBusinessByIdVariables> ref() {
    GetBusinessByIdVariables vars= GetBusinessByIdVariables(id: id,);
    return _dataConnect.query("GetBusinessById", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetBusinessByIdBusiness {
  final String id;
  final String name;
  final EnumValue<BusinessTier> tier;
  final DateTime subscriptionStartDate;
  final DateTime? subscriptionEndDate;
  final bool isActive;
  final int? maxUsers;
  final int? maxLocations;
  final String? logo;
  final String? banner;
  final String? phone;
  final DateTime createdAt;
  final DateTime updatedAt;
  GetBusinessByIdBusiness.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  tier = businessTierDeserializer(json['tier']),
  subscriptionStartDate = nativeFromJson<DateTime>(json['subscriptionStartDate']),
  subscriptionEndDate = json['subscriptionEndDate'] == null ? null : nativeFromJson<DateTime>(json['subscriptionEndDate']),
  isActive = nativeFromJson<bool>(json['isActive']),
  maxUsers = json['maxUsers'] == null ? null : nativeFromJson<int>(json['maxUsers']),
  maxLocations = json['maxLocations'] == null ? null : nativeFromJson<int>(json['maxLocations']),
  logo = json['logo'] == null ? null : nativeFromJson<String>(json['logo']),
  banner = json['banner'] == null ? null : nativeFromJson<String>(json['banner']),
  phone = json['phone'] == null ? null : nativeFromJson<String>(json['phone']),
  createdAt = nativeFromJson<DateTime>(json['createdAt']),
  updatedAt = nativeFromJson<DateTime>(json['updatedAt']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetBusinessByIdBusiness otherTyped = other as GetBusinessByIdBusiness;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    tier == otherTyped.tier && 
    subscriptionStartDate == otherTyped.subscriptionStartDate && 
    subscriptionEndDate == otherTyped.subscriptionEndDate && 
    isActive == otherTyped.isActive && 
    maxUsers == otherTyped.maxUsers && 
    maxLocations == otherTyped.maxLocations && 
    logo == otherTyped.logo && 
    banner == otherTyped.banner && 
    phone == otherTyped.phone && 
    createdAt == otherTyped.createdAt && 
    updatedAt == otherTyped.updatedAt;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, tier.hashCode, subscriptionStartDate.hashCode, subscriptionEndDate.hashCode, isActive.hashCode, maxUsers.hashCode, maxLocations.hashCode, logo.hashCode, banner.hashCode, phone.hashCode, createdAt.hashCode, updatedAt.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['tier'] = 
    businessTierSerializer(tier)
    ;
    json['subscriptionStartDate'] = nativeToJson<DateTime>(subscriptionStartDate);
    if (subscriptionEndDate != null) {
      json['subscriptionEndDate'] = nativeToJson<DateTime?>(subscriptionEndDate);
    }
    json['isActive'] = nativeToJson<bool>(isActive);
    if (maxUsers != null) {
      json['maxUsers'] = nativeToJson<int?>(maxUsers);
    }
    if (maxLocations != null) {
      json['maxLocations'] = nativeToJson<int?>(maxLocations);
    }
    if (logo != null) {
      json['logo'] = nativeToJson<String?>(logo);
    }
    if (banner != null) {
      json['banner'] = nativeToJson<String?>(banner);
    }
    if (phone != null) {
      json['phone'] = nativeToJson<String?>(phone);
    }
    json['createdAt'] = nativeToJson<DateTime>(createdAt);
    json['updatedAt'] = nativeToJson<DateTime>(updatedAt);
    return json;
  }

  GetBusinessByIdBusiness({
    required this.id,
    required this.name,
    required this.tier,
    required this.subscriptionStartDate,
    this.subscriptionEndDate,
    required this.isActive,
    this.maxUsers,
    this.maxLocations,
    this.logo,
    this.banner,
    this.phone,
    required this.createdAt,
    required this.updatedAt,
  });
}

@immutable
class GetBusinessByIdData {
  final GetBusinessByIdBusiness? business;
  GetBusinessByIdData.fromJson(dynamic json):
  
  business = json['business'] == null ? null : GetBusinessByIdBusiness.fromJson(json['business']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetBusinessByIdData otherTyped = other as GetBusinessByIdData;
    return business == otherTyped.business;
    
  }
  @override
  int get hashCode => business.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (business != null) {
      json['business'] = business!.toJson();
    }
    return json;
  }

  GetBusinessByIdData({
    this.business,
  });
}

@immutable
class GetBusinessByIdVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetBusinessByIdVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetBusinessByIdVariables otherTyped = other as GetBusinessByIdVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetBusinessByIdVariables({
    required this.id,
  });
}

