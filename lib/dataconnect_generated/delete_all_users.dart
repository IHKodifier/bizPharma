part of 'biz_pharma.dart';

class DeleteAllUsersVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  DeleteAllUsersVariablesBuilder(this._dataConnect, );
  Deserializer<DeleteAllUsersData> dataDeserializer = (dynamic json)  => DeleteAllUsersData.fromJson(jsonDecode(json));
  
  Future<OperationResult<DeleteAllUsersData, void>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteAllUsersData, void> ref() {
    
    return _dataConnect.mutation("DeleteAllUsers", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class DeleteAllUsersData {
  final int deleteUsers;
  DeleteAllUsersData.fromJson(dynamic json):
  
  deleteUsers = nativeFromJson<int>(json['deleteUsers']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteAllUsersData otherTyped = other as DeleteAllUsersData;
    return deleteUsers == otherTyped.deleteUsers;
    
  }
  @override
  int get hashCode => deleteUsers.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['deleteUsers'] = nativeToJson<int>(deleteUsers);
    return json;
  }

  DeleteAllUsersData({
    required this.deleteUsers,
  });
}

