part of 'ik_pharma.dart';

class ListAllBusinessesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListAllBusinessesVariablesBuilder(this._dataConnect, );
  Deserializer<ListAllBusinessesData> dataDeserializer = (dynamic json)  => ListAllBusinessesData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListAllBusinessesData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListAllBusinessesData, void> ref() {
    
    return _dataConnect.query("ListAllBusinesses", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListAllBusinessesBusinesses {
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
  ListAllBusinessesBusinesses.fromJson(dynamic json):
  
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

    final ListAllBusinessesBusinesses otherTyped = other as ListAllBusinessesBusinesses;
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

  ListAllBusinessesBusinesses({
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
class ListAllBusinessesData {
  final List<ListAllBusinessesBusinesses> businesses;
  ListAllBusinessesData.fromJson(dynamic json):
  
  businesses = (json['businesses'] as List<dynamic>)
        .map((e) => ListAllBusinessesBusinesses.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAllBusinessesData otherTyped = other as ListAllBusinessesData;
    return businesses == otherTyped.businesses;
    
  }
  @override
  int get hashCode => businesses.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['businesses'] = businesses.map((e) => e.toJson()).toList();
    return json;
  }

  ListAllBusinessesData({
    required this.businesses,
  });
}

