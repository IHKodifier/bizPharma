part of 'ik_pharma.dart';

class ListAllSuppliersVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListAllSuppliersVariablesBuilder(this._dataConnect, );
  Deserializer<ListAllSuppliersData> dataDeserializer = (dynamic json)  => ListAllSuppliersData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListAllSuppliersData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListAllSuppliersData, void> ref() {
    
    return _dataConnect.query("ListAllSuppliers", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListAllSuppliersSuppliers {
  final String id;
  final String businessId;
  final String name;
  final EnumValue<SupplierType> type;
  final String? contactPerson;
  final String? email;
  final String? phone;
  final String paymentTerms;
  final EnumValue<SupplierTier> tier;
  final double outstandingBalance;
  final bool isActive;
  final bool isPreferred;
  final Timestamp createdAt;
  ListAllSuppliersSuppliers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  businessId = nativeFromJson<String>(json['businessId']),
  name = nativeFromJson<String>(json['name']),
  type = supplierTypeDeserializer(json['type']),
  contactPerson = json['contactPerson'] == null ? null : nativeFromJson<String>(json['contactPerson']),
  email = json['email'] == null ? null : nativeFromJson<String>(json['email']),
  phone = json['phone'] == null ? null : nativeFromJson<String>(json['phone']),
  paymentTerms = nativeFromJson<String>(json['paymentTerms']),
  tier = supplierTierDeserializer(json['tier']),
  outstandingBalance = nativeFromJson<double>(json['outstandingBalance']),
  isActive = nativeFromJson<bool>(json['isActive']),
  isPreferred = nativeFromJson<bool>(json['isPreferred']),
  createdAt = Timestamp.fromJson(json['createdAt']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAllSuppliersSuppliers otherTyped = other as ListAllSuppliersSuppliers;
    return id == otherTyped.id && 
    businessId == otherTyped.businessId && 
    name == otherTyped.name && 
    type == otherTyped.type && 
    contactPerson == otherTyped.contactPerson && 
    email == otherTyped.email && 
    phone == otherTyped.phone && 
    paymentTerms == otherTyped.paymentTerms && 
    tier == otherTyped.tier && 
    outstandingBalance == otherTyped.outstandingBalance && 
    isActive == otherTyped.isActive && 
    isPreferred == otherTyped.isPreferred && 
    createdAt == otherTyped.createdAt;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, businessId.hashCode, name.hashCode, type.hashCode, contactPerson.hashCode, email.hashCode, phone.hashCode, paymentTerms.hashCode, tier.hashCode, outstandingBalance.hashCode, isActive.hashCode, isPreferred.hashCode, createdAt.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['businessId'] = nativeToJson<String>(businessId);
    json['name'] = nativeToJson<String>(name);
    json['type'] = 
    supplierTypeSerializer(type)
    ;
    if (contactPerson != null) {
      json['contactPerson'] = nativeToJson<String?>(contactPerson);
    }
    if (email != null) {
      json['email'] = nativeToJson<String?>(email);
    }
    if (phone != null) {
      json['phone'] = nativeToJson<String?>(phone);
    }
    json['paymentTerms'] = nativeToJson<String>(paymentTerms);
    json['tier'] = 
    supplierTierSerializer(tier)
    ;
    json['outstandingBalance'] = nativeToJson<double>(outstandingBalance);
    json['isActive'] = nativeToJson<bool>(isActive);
    json['isPreferred'] = nativeToJson<bool>(isPreferred);
    json['createdAt'] = createdAt.toJson();
    return json;
  }

  ListAllSuppliersSuppliers({
    required this.id,
    required this.businessId,
    required this.name,
    required this.type,
    this.contactPerson,
    this.email,
    this.phone,
    required this.paymentTerms,
    required this.tier,
    required this.outstandingBalance,
    required this.isActive,
    required this.isPreferred,
    required this.createdAt,
  });
}

@immutable
class ListAllSuppliersData {
  final List<ListAllSuppliersSuppliers> suppliers;
  ListAllSuppliersData.fromJson(dynamic json):
  
  suppliers = (json['suppliers'] as List<dynamic>)
        .map((e) => ListAllSuppliersSuppliers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAllSuppliersData otherTyped = other as ListAllSuppliersData;
    return suppliers == otherTyped.suppliers;
    
  }
  @override
  int get hashCode => suppliers.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['suppliers'] = suppliers.map((e) => e.toJson()).toList();
    return json;
  }

  ListAllSuppliersData({
    required this.suppliers,
  });
}

