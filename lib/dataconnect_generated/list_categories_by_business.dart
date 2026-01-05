part of 'biz_pharma.dart';

class ListCategoriesByBusinessVariablesBuilder {
  String businessId;

  final FirebaseDataConnect _dataConnect;
  ListCategoriesByBusinessVariablesBuilder(this._dataConnect, {required  this.businessId,});
  Deserializer<ListCategoriesByBusinessData> dataDeserializer = (dynamic json)  => ListCategoriesByBusinessData.fromJson(jsonDecode(json));
  Serializer<ListCategoriesByBusinessVariables> varsSerializer = (ListCategoriesByBusinessVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListCategoriesByBusinessData, ListCategoriesByBusinessVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListCategoriesByBusinessData, ListCategoriesByBusinessVariables> ref() {
    ListCategoriesByBusinessVariables vars= ListCategoriesByBusinessVariables(businessId: businessId,);
    return _dataConnect.query("ListCategoriesByBusiness", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListCategoriesByBusinessCategories {
  final String id;
  final String name;
  final String? description;
  final String? parentId;
  ListCategoriesByBusinessCategories.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  description = json['description'] == null ? null : nativeFromJson<String>(json['description']),
  parentId = json['parentId'] == null ? null : nativeFromJson<String>(json['parentId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListCategoriesByBusinessCategories otherTyped = other as ListCategoriesByBusinessCategories;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    description == otherTyped.description && 
    parentId == otherTyped.parentId;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, description.hashCode, parentId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    if (parentId != null) {
      json['parentId'] = nativeToJson<String?>(parentId);
    }
    return json;
  }

  ListCategoriesByBusinessCategories({
    required this.id,
    required this.name,
    this.description,
    this.parentId,
  });
}

@immutable
class ListCategoriesByBusinessData {
  final List<ListCategoriesByBusinessCategories> categories;
  ListCategoriesByBusinessData.fromJson(dynamic json):
  
  categories = (json['categories'] as List<dynamic>)
        .map((e) => ListCategoriesByBusinessCategories.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListCategoriesByBusinessData otherTyped = other as ListCategoriesByBusinessData;
    return categories == otherTyped.categories;
    
  }
  @override
  int get hashCode => categories.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['categories'] = categories.map((e) => e.toJson()).toList();
    return json;
  }

  ListCategoriesByBusinessData({
    required this.categories,
  });
}

@immutable
class ListCategoriesByBusinessVariables {
  final String businessId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListCategoriesByBusinessVariables.fromJson(Map<String, dynamic> json):
  
  businessId = nativeFromJson<String>(json['businessId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListCategoriesByBusinessVariables otherTyped = other as ListCategoriesByBusinessVariables;
    return businessId == otherTyped.businessId;
    
  }
  @override
  int get hashCode => businessId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['businessId'] = nativeToJson<String>(businessId);
    return json;
  }

  ListCategoriesByBusinessVariables({
    required this.businessId,
  });
}

