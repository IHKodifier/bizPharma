part of 'biz_pharma.dart';

class GetUserBusinessAndDefaultLocationVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetUserBusinessAndDefaultLocationVariablesBuilder(this._dataConnect, );
  Deserializer<GetUserBusinessAndDefaultLocationData> dataDeserializer = (dynamic json)  => GetUserBusinessAndDefaultLocationData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetUserBusinessAndDefaultLocationData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetUserBusinessAndDefaultLocationData, void> ref() {
    
    return _dataConnect.query("GetUserBusinessAndDefaultLocation", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class GetUserBusinessAndDefaultLocationUsers {
  final String firstName;
  final String lastName;
  final GetUserBusinessAndDefaultLocationUsersBusiness business;
  GetUserBusinessAndDefaultLocationUsers.fromJson(dynamic json):
  
  firstName = nativeFromJson<String>(json['firstName']),
  lastName = nativeFromJson<String>(json['lastName']),
  business = GetUserBusinessAndDefaultLocationUsersBusiness.fromJson(json['business']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserBusinessAndDefaultLocationUsers otherTyped = other as GetUserBusinessAndDefaultLocationUsers;
    return firstName == otherTyped.firstName && 
    lastName == otherTyped.lastName && 
    business == otherTyped.business;
    
  }
  @override
  int get hashCode => Object.hashAll([firstName.hashCode, lastName.hashCode, business.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['firstName'] = nativeToJson<String>(firstName);
    json['lastName'] = nativeToJson<String>(lastName);
    json['business'] = business.toJson();
    return json;
  }

  GetUserBusinessAndDefaultLocationUsers({
    required this.firstName,
    required this.lastName,
    required this.business,
  });
}

@immutable
class GetUserBusinessAndDefaultLocationUsersBusiness {
  final String name;
  final List<GetUserBusinessAndDefaultLocationUsersBusinessLocations> locations;
  GetUserBusinessAndDefaultLocationUsersBusiness.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']),
  locations = (json['locations'] as List<dynamic>)
        .map((e) => GetUserBusinessAndDefaultLocationUsersBusinessLocations.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserBusinessAndDefaultLocationUsersBusiness otherTyped = other as GetUserBusinessAndDefaultLocationUsersBusiness;
    return name == otherTyped.name && 
    locations == otherTyped.locations;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, locations.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['locations'] = locations.map((e) => e.toJson()).toList();
    return json;
  }

  GetUserBusinessAndDefaultLocationUsersBusiness({
    required this.name,
    required this.locations,
  });
}

@immutable
class GetUserBusinessAndDefaultLocationUsersBusinessLocations {
  final String name;
  GetUserBusinessAndDefaultLocationUsersBusinessLocations.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserBusinessAndDefaultLocationUsersBusinessLocations otherTyped = other as GetUserBusinessAndDefaultLocationUsersBusinessLocations;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  GetUserBusinessAndDefaultLocationUsersBusinessLocations({
    required this.name,
  });
}

@immutable
class GetUserBusinessAndDefaultLocationData {
  final List<GetUserBusinessAndDefaultLocationUsers> users;
  GetUserBusinessAndDefaultLocationData.fromJson(dynamic json):
  
  users = (json['users'] as List<dynamic>)
        .map((e) => GetUserBusinessAndDefaultLocationUsers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserBusinessAndDefaultLocationData otherTyped = other as GetUserBusinessAndDefaultLocationData;
    return users == otherTyped.users;
    
  }
  @override
  int get hashCode => users.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  GetUserBusinessAndDefaultLocationData({
    required this.users,
  });
}

