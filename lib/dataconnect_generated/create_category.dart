part of 'biz_pharma.dart';

class CreateCategoryVariablesBuilder {
  String businessId;
  String name;
  Optional<String> _description = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _parentId = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _metadata = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  CreateCategoryVariablesBuilder description(String? t) {
   _description.value = t;
   return this;
  }
  CreateCategoryVariablesBuilder parentId(String? t) {
   _parentId.value = t;
   return this;
  }
  CreateCategoryVariablesBuilder metadata(String? t) {
   _metadata.value = t;
   return this;
  }

  CreateCategoryVariablesBuilder(this._dataConnect, {required  this.businessId,required  this.name,});
  Deserializer<CreateCategoryData> dataDeserializer = (dynamic json)  => CreateCategoryData.fromJson(jsonDecode(json));
  Serializer<CreateCategoryVariables> varsSerializer = (CreateCategoryVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateCategoryData, CreateCategoryVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateCategoryData, CreateCategoryVariables> ref() {
    CreateCategoryVariables vars= CreateCategoryVariables(businessId: businessId,name: name,description: _description,parentId: _parentId,metadata: _metadata,);
    return _dataConnect.mutation("CreateCategory", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateCategoryCategoryInsert {
  final String id;
  CreateCategoryCategoryInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateCategoryCategoryInsert otherTyped = other as CreateCategoryCategoryInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateCategoryCategoryInsert({
    required this.id,
  });
}

@immutable
class CreateCategoryData {
  final CreateCategoryCategoryInsert category_insert;
  CreateCategoryData.fromJson(dynamic json):
  
  category_insert = CreateCategoryCategoryInsert.fromJson(json['category_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateCategoryData otherTyped = other as CreateCategoryData;
    return category_insert == otherTyped.category_insert;
    
  }
  @override
  int get hashCode => category_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['category_insert'] = category_insert.toJson();
    return json;
  }

  CreateCategoryData({
    required this.category_insert,
  });
}

@immutable
class CreateCategoryVariables {
  final String businessId;
  final String name;
  late final Optional<String>description;
  late final Optional<String>parentId;
  late final Optional<String>metadata;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateCategoryVariables.fromJson(Map<String, dynamic> json):
  
  businessId = nativeFromJson<String>(json['businessId']),
  name = nativeFromJson<String>(json['name']) {
  
  
  
  
    description = Optional.optional(nativeFromJson, nativeToJson);
    description.value = json['description'] == null ? null : nativeFromJson<String>(json['description']);
  
  
    parentId = Optional.optional(nativeFromJson, nativeToJson);
    parentId.value = json['parentId'] == null ? null : nativeFromJson<String>(json['parentId']);
  
  
    metadata = Optional.optional(nativeFromJson, nativeToJson);
    metadata.value = json['metadata'] == null ? null : nativeFromJson<String>(json['metadata']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateCategoryVariables otherTyped = other as CreateCategoryVariables;
    return businessId == otherTyped.businessId && 
    name == otherTyped.name && 
    description == otherTyped.description && 
    parentId == otherTyped.parentId && 
    metadata == otherTyped.metadata;
    
  }
  @override
  int get hashCode => Object.hashAll([businessId.hashCode, name.hashCode, description.hashCode, parentId.hashCode, metadata.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['businessId'] = nativeToJson<String>(businessId);
    json['name'] = nativeToJson<String>(name);
    if(description.state == OptionalState.set) {
      json['description'] = description.toJson();
    }
    if(parentId.state == OptionalState.set) {
      json['parentId'] = parentId.toJson();
    }
    if(metadata.state == OptionalState.set) {
      json['metadata'] = metadata.toJson();
    }
    return json;
  }

  CreateCategoryVariables({
    required this.businessId,
    required this.name,
    required this.description,
    required this.parentId,
    required this.metadata,
  });
}

