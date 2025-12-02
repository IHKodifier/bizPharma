part of 'biz_pharma.dart';

class CreateSupplierVariablesBuilder {
  String businessId;
  String name;
  SupplierType type;
  Optional<String> _contactPerson = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _email = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _phone = Optional.optional(nativeFromJson, nativeToJson);
  String paymentTerms;
  SupplierTier tier;

  final FirebaseDataConnect _dataConnect;  CreateSupplierVariablesBuilder contactPerson(String? t) {
   _contactPerson.value = t;
   return this;
  }
  CreateSupplierVariablesBuilder email(String? t) {
   _email.value = t;
   return this;
  }
  CreateSupplierVariablesBuilder phone(String? t) {
   _phone.value = t;
   return this;
  }

  CreateSupplierVariablesBuilder(this._dataConnect, {required  this.businessId,required  this.name,required  this.type,required  this.paymentTerms,required  this.tier,});
  Deserializer<CreateSupplierData> dataDeserializer = (dynamic json)  => CreateSupplierData.fromJson(jsonDecode(json));
  Serializer<CreateSupplierVariables> varsSerializer = (CreateSupplierVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateSupplierData, CreateSupplierVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateSupplierData, CreateSupplierVariables> ref() {
    CreateSupplierVariables vars= CreateSupplierVariables(businessId: businessId,name: name,type: type,contactPerson: _contactPerson,email: _email,phone: _phone,paymentTerms: paymentTerms,tier: tier,);
    return _dataConnect.mutation("CreateSupplier", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateSupplierSupplierInsert {
  final String id;
  CreateSupplierSupplierInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSupplierSupplierInsert otherTyped = other as CreateSupplierSupplierInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSupplierSupplierInsert({
    required this.id,
  });
}

@immutable
class CreateSupplierData {
  final CreateSupplierSupplierInsert supplier_insert;
  CreateSupplierData.fromJson(dynamic json):
  
  supplier_insert = CreateSupplierSupplierInsert.fromJson(json['supplier_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSupplierData otherTyped = other as CreateSupplierData;
    return supplier_insert == otherTyped.supplier_insert;
    
  }
  @override
  int get hashCode => supplier_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['supplier_insert'] = supplier_insert.toJson();
    return json;
  }

  CreateSupplierData({
    required this.supplier_insert,
  });
}

@immutable
class CreateSupplierVariables {
  final String businessId;
  final String name;
  final SupplierType type;
  late final Optional<String>contactPerson;
  late final Optional<String>email;
  late final Optional<String>phone;
  final String paymentTerms;
  final SupplierTier tier;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateSupplierVariables.fromJson(Map<String, dynamic> json):
  
  businessId = nativeFromJson<String>(json['businessId']),
  name = nativeFromJson<String>(json['name']),
  type = SupplierType.values.byName(json['type']),
  paymentTerms = nativeFromJson<String>(json['paymentTerms']),
  tier = SupplierTier.values.byName(json['tier']) {
  
  
  
  
  
    contactPerson = Optional.optional(nativeFromJson, nativeToJson);
    contactPerson.value = json['contactPerson'] == null ? null : nativeFromJson<String>(json['contactPerson']);
  
  
    email = Optional.optional(nativeFromJson, nativeToJson);
    email.value = json['email'] == null ? null : nativeFromJson<String>(json['email']);
  
  
    phone = Optional.optional(nativeFromJson, nativeToJson);
    phone.value = json['phone'] == null ? null : nativeFromJson<String>(json['phone']);
  
  
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSupplierVariables otherTyped = other as CreateSupplierVariables;
    return businessId == otherTyped.businessId && 
    name == otherTyped.name && 
    type == otherTyped.type && 
    contactPerson == otherTyped.contactPerson && 
    email == otherTyped.email && 
    phone == otherTyped.phone && 
    paymentTerms == otherTyped.paymentTerms && 
    tier == otherTyped.tier;
    
  }
  @override
  int get hashCode => Object.hashAll([businessId.hashCode, name.hashCode, type.hashCode, contactPerson.hashCode, email.hashCode, phone.hashCode, paymentTerms.hashCode, tier.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['businessId'] = nativeToJson<String>(businessId);
    json['name'] = nativeToJson<String>(name);
    json['type'] = 
    type.name
    ;
    if(contactPerson.state == OptionalState.set) {
      json['contactPerson'] = contactPerson.toJson();
    }
    if(email.state == OptionalState.set) {
      json['email'] = email.toJson();
    }
    if(phone.state == OptionalState.set) {
      json['phone'] = phone.toJson();
    }
    json['paymentTerms'] = nativeToJson<String>(paymentTerms);
    json['tier'] = 
    tier.name
    ;
    return json;
  }

  CreateSupplierVariables({
    required this.businessId,
    required this.name,
    required this.type,
    required this.contactPerson,
    required this.email,
    required this.phone,
    required this.paymentTerms,
    required this.tier,
  });
}

