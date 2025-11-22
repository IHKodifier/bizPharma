part of 'ik_pharma.dart';

class ListAllCustomersVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListAllCustomersVariablesBuilder(this._dataConnect, );
  Deserializer<ListAllCustomersData> dataDeserializer = (dynamic json)  => ListAllCustomersData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListAllCustomersData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListAllCustomersData, void> ref() {
    
    return _dataConnect.query("ListAllCustomers", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListAllCustomersCustomers {
  final String id;
  final String businessId;
  final String firstName;
  final String lastName;
  final String? email;
  final String? phone;
  final DateTime? dateOfBirth;
  final EnumValue<CustomerTier> tier;
  final bool isActive;
  final DateTime createdAt;
  ListAllCustomersCustomers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  businessId = nativeFromJson<String>(json['businessId']),
  firstName = nativeFromJson<String>(json['firstName']),
  lastName = nativeFromJson<String>(json['lastName']),
  email = json['email'] == null ? null : nativeFromJson<String>(json['email']),
  phone = json['phone'] == null ? null : nativeFromJson<String>(json['phone']),
  dateOfBirth = json['dateOfBirth'] == null ? null : nativeFromJson<DateTime>(json['dateOfBirth']),
  tier = customerTierDeserializer(json['tier']),
  isActive = nativeFromJson<bool>(json['isActive']),
  createdAt = nativeFromJson<DateTime>(json['createdAt']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAllCustomersCustomers otherTyped = other as ListAllCustomersCustomers;
    return id == otherTyped.id && 
    businessId == otherTyped.businessId && 
    firstName == otherTyped.firstName && 
    lastName == otherTyped.lastName && 
    email == otherTyped.email && 
    phone == otherTyped.phone && 
    dateOfBirth == otherTyped.dateOfBirth && 
    tier == otherTyped.tier && 
    isActive == otherTyped.isActive && 
    createdAt == otherTyped.createdAt;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, businessId.hashCode, firstName.hashCode, lastName.hashCode, email.hashCode, phone.hashCode, dateOfBirth.hashCode, tier.hashCode, isActive.hashCode, createdAt.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['businessId'] = nativeToJson<String>(businessId);
    json['firstName'] = nativeToJson<String>(firstName);
    json['lastName'] = nativeToJson<String>(lastName);
    if (email != null) {
      json['email'] = nativeToJson<String?>(email);
    }
    if (phone != null) {
      json['phone'] = nativeToJson<String?>(phone);
    }
    if (dateOfBirth != null) {
      json['dateOfBirth'] = nativeToJson<DateTime?>(dateOfBirth);
    }
    json['tier'] = 
    customerTierSerializer(tier)
    ;
    json['isActive'] = nativeToJson<bool>(isActive);
    json['createdAt'] = nativeToJson<DateTime>(createdAt);
    return json;
  }

  ListAllCustomersCustomers({
    required this.id,
    required this.businessId,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phone,
    this.dateOfBirth,
    required this.tier,
    required this.isActive,
    required this.createdAt,
  });
}

@immutable
class ListAllCustomersData {
  final List<ListAllCustomersCustomers> customers;
  ListAllCustomersData.fromJson(dynamic json):
  
  customers = (json['customers'] as List<dynamic>)
        .map((e) => ListAllCustomersCustomers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAllCustomersData otherTyped = other as ListAllCustomersData;
    return customers == otherTyped.customers;
    
  }
  @override
  int get hashCode => customers.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['customers'] = customers.map((e) => e.toJson()).toList();
    return json;
  }

  ListAllCustomersData({
    required this.customers,
  });
}

