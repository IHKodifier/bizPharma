part of 'biz_pharma.dart';

class CreateManufacturerVariablesBuilder {
  String name;
  String country;

  final FirebaseDataConnect _dataConnect;
  CreateManufacturerVariablesBuilder(this._dataConnect, {required  this.name,required  this.country,});
  Deserializer<CreateManufacturerData> dataDeserializer = (dynamic json)  => CreateManufacturerData.fromJson(jsonDecode(json));
  Serializer<CreateManufacturerVariables> varsSerializer = (CreateManufacturerVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateManufacturerData, CreateManufacturerVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateManufacturerData, CreateManufacturerVariables> ref() {
    CreateManufacturerVariables vars= CreateManufacturerVariables(name: name,country: country,);
    return _dataConnect.mutation("CreateManufacturer", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateManufacturerManufacturerInsert {
  final String id;
  CreateManufacturerManufacturerInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateManufacturerManufacturerInsert otherTyped = other as CreateManufacturerManufacturerInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateManufacturerManufacturerInsert({
    required this.id,
  });
}

@immutable
class CreateManufacturerData {
  final CreateManufacturerManufacturerInsert manufacturer_insert;
  CreateManufacturerData.fromJson(dynamic json):
  
  manufacturer_insert = CreateManufacturerManufacturerInsert.fromJson(json['manufacturer_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateManufacturerData otherTyped = other as CreateManufacturerData;
    return manufacturer_insert == otherTyped.manufacturer_insert;
    
  }
  @override
  int get hashCode => manufacturer_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['manufacturer_insert'] = manufacturer_insert.toJson();
    return json;
  }

  CreateManufacturerData({
    required this.manufacturer_insert,
  });
}

@immutable
class CreateManufacturerVariables {
  final String name;
  final String country;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateManufacturerVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']),
  country = nativeFromJson<String>(json['country']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateManufacturerVariables otherTyped = other as CreateManufacturerVariables;
    return name == otherTyped.name && 
    country == otherTyped.country;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, country.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['country'] = nativeToJson<String>(country);
    return json;
  }

  CreateManufacturerVariables({
    required this.name,
    required this.country,
  });
}

