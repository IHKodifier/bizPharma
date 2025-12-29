part of 'biz_pharma.dart';

class DeleteAllLocationsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  DeleteAllLocationsVariablesBuilder(this._dataConnect, );
  Deserializer<DeleteAllLocationsData> dataDeserializer = (dynamic json)  => DeleteAllLocationsData.fromJson(jsonDecode(json));
  
  Future<OperationResult<DeleteAllLocationsData, void>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteAllLocationsData, void> ref() {
    
    return _dataConnect.mutation("DeleteAllLocations", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class DeleteAllLocationsData {
  final int deleteLocations;
  DeleteAllLocationsData.fromJson(dynamic json):
  
  deleteLocations = nativeFromJson<int>(json['deleteLocations']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteAllLocationsData otherTyped = other as DeleteAllLocationsData;
    return deleteLocations == otherTyped.deleteLocations;
    
  }
  @override
  int get hashCode => deleteLocations.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['deleteLocations'] = nativeToJson<int>(deleteLocations);
    return json;
  }

  DeleteAllLocationsData({
    required this.deleteLocations,
  });
}

