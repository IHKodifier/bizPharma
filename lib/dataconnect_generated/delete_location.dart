part of 'biz_pharma.dart';

class DeleteLocationVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteLocationVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteLocationData> dataDeserializer = (dynamic json)  => DeleteLocationData.fromJson(jsonDecode(json));
  Serializer<DeleteLocationVariables> varsSerializer = (DeleteLocationVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteLocationData, DeleteLocationVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteLocationData, DeleteLocationVariables> ref() {
    DeleteLocationVariables vars= DeleteLocationVariables(id: id,);
    return _dataConnect.mutation("DeleteLocation", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteLocationLocationDelete {
  final String id;
  DeleteLocationLocationDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteLocationLocationDelete otherTyped = other as DeleteLocationLocationDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteLocationLocationDelete({
    required this.id,
  });
}

@immutable
class DeleteLocationData {
  final DeleteLocationLocationDelete? location_delete;
  DeleteLocationData.fromJson(dynamic json):
  
  location_delete = json['location_delete'] == null ? null : DeleteLocationLocationDelete.fromJson(json['location_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteLocationData otherTyped = other as DeleteLocationData;
    return location_delete == otherTyped.location_delete;
    
  }
  @override
  int get hashCode => location_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (location_delete != null) {
      json['location_delete'] = location_delete!.toJson();
    }
    return json;
  }

  DeleteLocationData({
    this.location_delete,
  });
}

@immutable
class DeleteLocationVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteLocationVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteLocationVariables otherTyped = other as DeleteLocationVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteLocationVariables({
    required this.id,
  });
}

