part of 'biz_pharma.dart';

class DeleteAllBusinessesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  DeleteAllBusinessesVariablesBuilder(this._dataConnect, );
  Deserializer<DeleteAllBusinessesData> dataDeserializer = (dynamic json)  => DeleteAllBusinessesData.fromJson(jsonDecode(json));
  
  Future<OperationResult<DeleteAllBusinessesData, void>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteAllBusinessesData, void> ref() {
    
    return _dataConnect.mutation("DeleteAllBusinesses", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class DeleteAllBusinessesData {
  final int deleteBusinesses;
  DeleteAllBusinessesData.fromJson(dynamic json):
  
  deleteBusinesses = nativeFromJson<int>(json['deleteBusinesses']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteAllBusinessesData otherTyped = other as DeleteAllBusinessesData;
    return deleteBusinesses == otherTyped.deleteBusinesses;
    
  }
  @override
  int get hashCode => deleteBusinesses.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['deleteBusinesses'] = nativeToJson<int>(deleteBusinesses);
    return json;
  }

  DeleteAllBusinessesData({
    required this.deleteBusinesses,
  });
}

