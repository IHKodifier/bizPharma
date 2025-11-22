part of 'ik_pharma.dart';

class CreateTherapeuticClassVariablesBuilder {
  String code;
  String name;
  Optional<String> _description = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  CreateTherapeuticClassVariablesBuilder description(String? t) {
   _description.value = t;
   return this;
  }

  CreateTherapeuticClassVariablesBuilder(this._dataConnect, {required  this.code,required  this.name,});
  Deserializer<CreateTherapeuticClassData> dataDeserializer = (dynamic json)  => CreateTherapeuticClassData.fromJson(jsonDecode(json));
  Serializer<CreateTherapeuticClassVariables> varsSerializer = (CreateTherapeuticClassVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateTherapeuticClassData, CreateTherapeuticClassVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateTherapeuticClassData, CreateTherapeuticClassVariables> ref() {
    CreateTherapeuticClassVariables vars= CreateTherapeuticClassVariables(code: code,name: name,description: _description,);
    return _dataConnect.mutation("CreateTherapeuticClass", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateTherapeuticClassTherapeuticClassInsert {
  final String id;
  CreateTherapeuticClassTherapeuticClassInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateTherapeuticClassTherapeuticClassInsert otherTyped = other as CreateTherapeuticClassTherapeuticClassInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateTherapeuticClassTherapeuticClassInsert({
    required this.id,
  });
}

@immutable
class CreateTherapeuticClassData {
  final CreateTherapeuticClassTherapeuticClassInsert therapeuticClass_insert;
  CreateTherapeuticClassData.fromJson(dynamic json):
  
  therapeuticClass_insert = CreateTherapeuticClassTherapeuticClassInsert.fromJson(json['therapeuticClass_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateTherapeuticClassData otherTyped = other as CreateTherapeuticClassData;
    return therapeuticClass_insert == otherTyped.therapeuticClass_insert;
    
  }
  @override
  int get hashCode => therapeuticClass_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['therapeuticClass_insert'] = therapeuticClass_insert.toJson();
    return json;
  }

  CreateTherapeuticClassData({
    required this.therapeuticClass_insert,
  });
}

@immutable
class CreateTherapeuticClassVariables {
  final String code;
  final String name;
  late final Optional<String>description;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateTherapeuticClassVariables.fromJson(Map<String, dynamic> json):
  
  code = nativeFromJson<String>(json['code']),
  name = nativeFromJson<String>(json['name']) {
  
  
  
  
    description = Optional.optional(nativeFromJson, nativeToJson);
    description.value = json['description'] == null ? null : nativeFromJson<String>(json['description']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateTherapeuticClassVariables otherTyped = other as CreateTherapeuticClassVariables;
    return code == otherTyped.code && 
    name == otherTyped.name && 
    description == otherTyped.description;
    
  }
  @override
  int get hashCode => Object.hashAll([code.hashCode, name.hashCode, description.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['code'] = nativeToJson<String>(code);
    json['name'] = nativeToJson<String>(name);
    if(description.state == OptionalState.set) {
      json['description'] = description.toJson();
    }
    return json;
  }

  CreateTherapeuticClassVariables({
    required this.code,
    required this.name,
    required this.description,
  });
}

