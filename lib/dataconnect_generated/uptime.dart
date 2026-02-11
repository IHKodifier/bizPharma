part of 'biz_pharma.dart';

class UptimeVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  UptimeVariablesBuilder(this._dataConnect, );
  Deserializer<UptimeData> dataDeserializer = (dynamic json)  => UptimeData.fromJson(jsonDecode(json));
  
  Future<QueryResult<UptimeData, void>> execute() {
    return ref().execute();
  }

  QueryRef<UptimeData, void> ref() {
    
    return _dataConnect.query("Uptime", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class UptimeUsers {
  final String id;
  UptimeUsers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UptimeUsers otherTyped = other as UptimeUsers;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UptimeUsers({
    required this.id,
  });
}

@immutable
class UptimeData {
  final List<UptimeUsers> users;
  UptimeData.fromJson(dynamic json):
  
  users = (json['users'] as List<dynamic>)
        .map((e) => UptimeUsers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UptimeData otherTyped = other as UptimeData;
    return users == otherTyped.users;
    
  }
  @override
  int get hashCode => users.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  UptimeData({
    required this.users,
  });
}

