part of 'ik_pharma.dart';

class SeedDataVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedDataVariablesBuilder(this._dataConnect, );
  Deserializer<SeedDataData> dataDeserializer = (dynamic json)  => SeedDataData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedDataData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedDataData, void> ref() {
    
    return _dataConnect.mutation("SeedData", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedDataB1 {
  final String id;
  SeedDataB1.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedDataB1 otherTyped = other as SeedDataB1;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedDataB1({
    required this.id,
  });
}

@immutable
class SeedDataU1 {
  final String id;
  SeedDataU1.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedDataU1 otherTyped = other as SeedDataU1;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedDataU1({
    required this.id,
  });
}

@immutable
class SeedDataM1 {
  final String id;
  SeedDataM1.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedDataM1 otherTyped = other as SeedDataM1;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedDataM1({
    required this.id,
  });
}

@immutable
class SeedDataTc1 {
  final String id;
  SeedDataTc1.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedDataTc1 otherTyped = other as SeedDataTc1;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedDataTc1({
    required this.id,
  });
}

@immutable
class SeedDataS1 {
  final String id;
  SeedDataS1.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedDataS1 otherTyped = other as SeedDataS1;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedDataS1({
    required this.id,
  });
}

@immutable
class SeedDataP1 {
  final String id;
  SeedDataP1.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedDataP1 otherTyped = other as SeedDataP1;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedDataP1({
    required this.id,
  });
}

@immutable
class SeedDataData {
  final SeedDataB1 b1;
  final SeedDataU1 u1;
  final SeedDataM1 m1;
  final SeedDataTc1 tc1;
  final SeedDataS1 s1;
  final SeedDataP1 p1;
  SeedDataData.fromJson(dynamic json):
  
  b1 = SeedDataB1.fromJson(json['b1']),
  u1 = SeedDataU1.fromJson(json['u1']),
  m1 = SeedDataM1.fromJson(json['m1']),
  tc1 = SeedDataTc1.fromJson(json['tc1']),
  s1 = SeedDataS1.fromJson(json['s1']),
  p1 = SeedDataP1.fromJson(json['p1']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedDataData otherTyped = other as SeedDataData;
    return b1 == otherTyped.b1 && 
    u1 == otherTyped.u1 && 
    m1 == otherTyped.m1 && 
    tc1 == otherTyped.tc1 && 
    s1 == otherTyped.s1 && 
    p1 == otherTyped.p1;
    
  }
  @override
  int get hashCode => Object.hashAll([b1.hashCode, u1.hashCode, m1.hashCode, tc1.hashCode, s1.hashCode, p1.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['b1'] = b1.toJson();
    json['u1'] = u1.toJson();
    json['m1'] = m1.toJson();
    json['tc1'] = tc1.toJson();
    json['s1'] = s1.toJson();
    json['p1'] = p1.toJson();
    return json;
  }

  SeedDataData({
    required this.b1,
    required this.u1,
    required this.m1,
    required this.tc1,
    required this.s1,
    required this.p1,
  });
}

