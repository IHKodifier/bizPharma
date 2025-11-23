part of 'ik_pharma.dart';

class CreateCustomerVariablesBuilder {
  String businessId;
  String firstName;
  String lastName;
  Optional<String> _email = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _phone = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _dateOfBirth = Optional.optional(nativeFromJson, nativeToJson);
  String createdById;

  final FirebaseDataConnect _dataConnect;  CreateCustomerVariablesBuilder email(String? t) {
   _email.value = t;
   return this;
  }
  CreateCustomerVariablesBuilder phone(String? t) {
   _phone.value = t;
   return this;
  }
  CreateCustomerVariablesBuilder dateOfBirth(DateTime? t) {
   _dateOfBirth.value = t;
   return this;
  }

  CreateCustomerVariablesBuilder(this._dataConnect, {required  this.businessId,required  this.firstName,required  this.lastName,required  this.createdById,});
  Deserializer<CreateCustomerData> dataDeserializer = (dynamic json)  => CreateCustomerData.fromJson(jsonDecode(json));
  Serializer<CreateCustomerVariables> varsSerializer = (CreateCustomerVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateCustomerData, CreateCustomerVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateCustomerData, CreateCustomerVariables> ref() {
    CreateCustomerVariables vars= CreateCustomerVariables(businessId: businessId,firstName: firstName,lastName: lastName,email: _email,phone: _phone,dateOfBirth: _dateOfBirth,createdById: createdById,);
    return _dataConnect.mutation("CreateCustomer", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateCustomerCustomerInsert {
  final String id;
  CreateCustomerCustomerInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateCustomerCustomerInsert otherTyped = other as CreateCustomerCustomerInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateCustomerCustomerInsert({
    required this.id,
  });
}

@immutable
class CreateCustomerData {
  final CreateCustomerCustomerInsert customer_insert;
  CreateCustomerData.fromJson(dynamic json):
  
  customer_insert = CreateCustomerCustomerInsert.fromJson(json['customer_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateCustomerData otherTyped = other as CreateCustomerData;
    return customer_insert == otherTyped.customer_insert;
    
  }
  @override
  int get hashCode => customer_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['customer_insert'] = customer_insert.toJson();
    return json;
  }

  CreateCustomerData({
    required this.customer_insert,
  });
}

@immutable
class CreateCustomerVariables {
  final String businessId;
  final String firstName;
  final String lastName;
  late final Optional<String>email;
  late final Optional<String>phone;
  late final Optional<DateTime>dateOfBirth;
  final String createdById;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateCustomerVariables.fromJson(Map<String, dynamic> json):
  
  businessId = nativeFromJson<String>(json['businessId']),
  firstName = nativeFromJson<String>(json['firstName']),
  lastName = nativeFromJson<String>(json['lastName']),
  createdById = nativeFromJson<String>(json['createdById']) {
  
  
  
  
  
    email = Optional.optional(nativeFromJson, nativeToJson);
    email.value = json['email'] == null ? null : nativeFromJson<String>(json['email']);
  
  
    phone = Optional.optional(nativeFromJson, nativeToJson);
    phone.value = json['phone'] == null ? null : nativeFromJson<String>(json['phone']);
  
  
    dateOfBirth = Optional.optional(nativeFromJson, nativeToJson);
    dateOfBirth.value = json['dateOfBirth'] == null ? null : nativeFromJson<DateTime>(json['dateOfBirth']);
  
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateCustomerVariables otherTyped = other as CreateCustomerVariables;
    return businessId == otherTyped.businessId && 
    firstName == otherTyped.firstName && 
    lastName == otherTyped.lastName && 
    email == otherTyped.email && 
    phone == otherTyped.phone && 
    dateOfBirth == otherTyped.dateOfBirth && 
    createdById == otherTyped.createdById;
    
  }
  @override
  int get hashCode => Object.hashAll([businessId.hashCode, firstName.hashCode, lastName.hashCode, email.hashCode, phone.hashCode, dateOfBirth.hashCode, createdById.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['businessId'] = nativeToJson<String>(businessId);
    json['firstName'] = nativeToJson<String>(firstName);
    json['lastName'] = nativeToJson<String>(lastName);
    if(email.state == OptionalState.set) {
      json['email'] = email.toJson();
    }
    if(phone.state == OptionalState.set) {
      json['phone'] = phone.toJson();
    }
    if(dateOfBirth.state == OptionalState.set) {
      json['dateOfBirth'] = dateOfBirth.toJson();
    }
    json['createdById'] = nativeToJson<String>(createdById);
    return json;
  }

  CreateCustomerVariables({
    required this.businessId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.createdById,
  });
}

