# biz_pharma SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
BizPharmaConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries

### ListAllUsers
#### Required Arguments
```dart
// No required arguments
BizPharmaConnector.instance.listAllUsers().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListAllUsersData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await BizPharmaConnector.instance.listAllUsers();
ListAllUsersData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = BizPharmaConnector.instance.listAllUsers().ref();
ref.execute();

ref.subscribe(...);
```


### ListPricingByLocation
#### Required Arguments
```dart
String businessId = ...;
BizPharmaConnector.instance.listPricingByLocation(
  businessId: businessId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListPricingByLocationData, ListPricingByLocationVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await BizPharmaConnector.instance.listPricingByLocation(
  businessId: businessId,
);
ListPricingByLocationData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String businessId = ...;

final ref = BizPharmaConnector.instance.listPricingByLocation(
  businessId: businessId,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetUserByAuthId
#### Required Arguments
```dart
String id = ...;
BizPharmaConnector.instance.getUserByAuthId(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetUserByAuthIdData, GetUserByAuthIdVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await BizPharmaConnector.instance.getUserByAuthId(
  id: id,
);
GetUserByAuthIdData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = BizPharmaConnector.instance.getUserByAuthId(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListAllCustomers
#### Required Arguments
```dart
// No required arguments
BizPharmaConnector.instance.listAllCustomers().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListAllCustomersData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await BizPharmaConnector.instance.listAllCustomers();
ListAllCustomersData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = BizPharmaConnector.instance.listAllCustomers().ref();
ref.execute();

ref.subscribe(...);
```


### ListProductsByBusiness
#### Required Arguments
```dart
String businessId = ...;
BizPharmaConnector.instance.listProductsByBusiness(
  businessId: businessId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListProductsByBusinessData, ListProductsByBusinessVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await BizPharmaConnector.instance.listProductsByBusiness(
  businessId: businessId,
);
ListProductsByBusinessData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String businessId = ...;

final ref = BizPharmaConnector.instance.listProductsByBusiness(
  businessId: businessId,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListLocationsByBusiness
#### Required Arguments
```dart
String businessId = ...;
BizPharmaConnector.instance.listLocationsByBusiness(
  businessId: businessId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListLocationsByBusinessData, ListLocationsByBusinessVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await BizPharmaConnector.instance.listLocationsByBusiness(
  businessId: businessId,
);
ListLocationsByBusinessData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String businessId = ...;

final ref = BizPharmaConnector.instance.listLocationsByBusiness(
  businessId: businessId,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListAllSuppliers
#### Required Arguments
```dart
// No required arguments
BizPharmaConnector.instance.listAllSuppliers().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListAllSuppliersData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await BizPharmaConnector.instance.listAllSuppliers();
ListAllSuppliersData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = BizPharmaConnector.instance.listAllSuppliers().ref();
ref.execute();

ref.subscribe(...);
```


### GetBusinessById
#### Required Arguments
```dart
String id = ...;
BizPharmaConnector.instance.getBusinessById(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetBusinessByIdData, GetBusinessByIdVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await BizPharmaConnector.instance.getBusinessById(
  id: id,
);
GetBusinessByIdData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = BizPharmaConnector.instance.getBusinessById(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### listAllProducts
#### Required Arguments
```dart
// No required arguments
BizPharmaConnector.instance.listAllProducts().execute();
```



#### Return Type
`execute()` returns a `QueryResult<listAllProductsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await BizPharmaConnector.instance.listAllProducts();
listAllProductsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = BizPharmaConnector.instance.listAllProducts().ref();
ref.execute();

ref.subscribe(...);
```


### ListAllBusinesses
#### Required Arguments
```dart
// No required arguments
BizPharmaConnector.instance.listAllBusinesses().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListAllBusinessesData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await BizPharmaConnector.instance.listAllBusinesses();
ListAllBusinessesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = BizPharmaConnector.instance.listAllBusinesses().ref();
ref.execute();

ref.subscribe(...);
```


### VerifyProduct
#### Required Arguments
```dart
// No required arguments
BizPharmaConnector.instance.verifyProduct().execute();
```



#### Return Type
`execute()` returns a `QueryResult<VerifyProductData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await BizPharmaConnector.instance.verifyProduct();
VerifyProductData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = BizPharmaConnector.instance.verifyProduct().ref();
ref.execute();

ref.subscribe(...);
```


### ListAllLocations
#### Required Arguments
```dart
// No required arguments
BizPharmaConnector.instance.listAllLocations().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListAllLocationsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await BizPharmaConnector.instance.listAllLocations();
ListAllLocationsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = BizPharmaConnector.instance.listAllLocations().ref();
ref.execute();

ref.subscribe(...);
```


### ListInventoryByLocation
#### Required Arguments
```dart
String locationId = ...;
BizPharmaConnector.instance.listInventoryByLocation(
  locationId: locationId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListInventoryByLocationData, ListInventoryByLocationVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await BizPharmaConnector.instance.listInventoryByLocation(
  locationId: locationId,
);
ListInventoryByLocationData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String locationId = ...;

final ref = BizPharmaConnector.instance.listInventoryByLocation(
  locationId: locationId,
).ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### CreateCustomer
#### Required Arguments
```dart
String businessId = ...;
String firstName = ...;
String lastName = ...;
String createdById = ...;
BizPharmaConnector.instance.createCustomer(
  businessId: businessId,
  firstName: firstName,
  lastName: lastName,
  createdById: createdById,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateCustomer, we created `CreateCustomerBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateCustomerVariablesBuilder {
  ...
   CreateCustomerVariablesBuilder email(String? t) {
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

  ...
}
BizPharmaConnector.instance.createCustomer(
  businessId: businessId,
  firstName: firstName,
  lastName: lastName,
  createdById: createdById,
)
.email(email)
.phone(phone)
.dateOfBirth(dateOfBirth)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateCustomerData, CreateCustomerVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await BizPharmaConnector.instance.createCustomer(
  businessId: businessId,
  firstName: firstName,
  lastName: lastName,
  createdById: createdById,
);
CreateCustomerData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String businessId = ...;
String firstName = ...;
String lastName = ...;
String createdById = ...;

final ref = BizPharmaConnector.instance.createCustomer(
  businessId: businessId,
  firstName: firstName,
  lastName: lastName,
  createdById: createdById,
).ref();
ref.execute();
```


### CreateUser
#### Required Arguments
```dart
String id = ...;
String businessId = ...;
String email = ...;
String firstName = ...;
String lastName = ...;
String mobile = ...;
UserRole role = ...;
BizPharmaConnector.instance.createUser(
  id: id,
  businessId: businessId,
  email: email,
  firstName: firstName,
  lastName: lastName,
  mobile: mobile,
  role: role,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateUser, we created `CreateUserBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateUserVariablesBuilder {
  ...
   CreateUserVariablesBuilder permissions(List<String>? t) {
   _permissions.value = t;
   return this;
  }

  ...
}
BizPharmaConnector.instance.createUser(
  id: id,
  businessId: businessId,
  email: email,
  firstName: firstName,
  lastName: lastName,
  mobile: mobile,
  role: role,
)
.permissions(permissions)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateUserData, CreateUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await BizPharmaConnector.instance.createUser(
  id: id,
  businessId: businessId,
  email: email,
  firstName: firstName,
  lastName: lastName,
  mobile: mobile,
  role: role,
);
CreateUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
String businessId = ...;
String email = ...;
String firstName = ...;
String lastName = ...;
String mobile = ...;
UserRole role = ...;

final ref = BizPharmaConnector.instance.createUser(
  id: id,
  businessId: businessId,
  email: email,
  firstName: firstName,
  lastName: lastName,
  mobile: mobile,
  role: role,
).ref();
ref.execute();
```


### DeleteAllUsers
#### Required Arguments
```dart
// No required arguments
BizPharmaConnector.instance.deleteAllUsers().execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteAllUsersData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await BizPharmaConnector.instance.deleteAllUsers();
DeleteAllUsersData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = BizPharmaConnector.instance.deleteAllUsers().ref();
ref.execute();
```


### CreateTherapeuticClass
#### Required Arguments
```dart
String code = ...;
String name = ...;
BizPharmaConnector.instance.createTherapeuticClass(
  code: code,
  name: name,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateTherapeuticClass, we created `CreateTherapeuticClassBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateTherapeuticClassVariablesBuilder {
  ...
   CreateTherapeuticClassVariablesBuilder description(String? t) {
   _description.value = t;
   return this;
  }

  ...
}
BizPharmaConnector.instance.createTherapeuticClass(
  code: code,
  name: name,
)
.description(description)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateTherapeuticClassData, CreateTherapeuticClassVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await BizPharmaConnector.instance.createTherapeuticClass(
  code: code,
  name: name,
);
CreateTherapeuticClassData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String code = ...;
String name = ...;

final ref = BizPharmaConnector.instance.createTherapeuticClass(
  code: code,
  name: name,
).ref();
ref.execute();
```


### CreateSupplier
#### Required Arguments
```dart
String businessId = ...;
String name = ...;
SupplierType type = ...;
String paymentTerms = ...;
SupplierTier tier = ...;
BizPharmaConnector.instance.createSupplier(
  businessId: businessId,
  name: name,
  type: type,
  paymentTerms: paymentTerms,
  tier: tier,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateSupplier, we created `CreateSupplierBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateSupplierVariablesBuilder {
  ...
   CreateSupplierVariablesBuilder contactPerson(String? t) {
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

  ...
}
BizPharmaConnector.instance.createSupplier(
  businessId: businessId,
  name: name,
  type: type,
  paymentTerms: paymentTerms,
  tier: tier,
)
.contactPerson(contactPerson)
.email(email)
.phone(phone)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateSupplierData, CreateSupplierVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await BizPharmaConnector.instance.createSupplier(
  businessId: businessId,
  name: name,
  type: type,
  paymentTerms: paymentTerms,
  tier: tier,
);
CreateSupplierData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String businessId = ...;
String name = ...;
SupplierType type = ...;
String paymentTerms = ...;
SupplierTier tier = ...;

final ref = BizPharmaConnector.instance.createSupplier(
  businessId: businessId,
  name: name,
  type: type,
  paymentTerms: paymentTerms,
  tier: tier,
).ref();
ref.execute();
```


### CreateProductBatch
#### Required Arguments
```dart
String productId = ...;
String businessId = ...;
String batchNumber = ...;
String lotNumber = ...;
DateTime manufacturingDate = ...;
DateTime expiryDate = ...;
String supplierId = ...;
String goodsReceiptId = ...;
DateTime receivedDate = ...;
double unitCost = ...;
double totalCost = ...;
int totalQuantity = ...;
int quantityRemaining = ...;
String locationId = ...;
String createdById = ...;
String updatedById = ...;
BizPharmaConnector.instance.createProductBatch(
  productId: productId,
  businessId: businessId,
  batchNumber: batchNumber,
  lotNumber: lotNumber,
  manufacturingDate: manufacturingDate,
  expiryDate: expiryDate,
  supplierId: supplierId,
  goodsReceiptId: goodsReceiptId,
  receivedDate: receivedDate,
  unitCost: unitCost,
  totalCost: totalCost,
  totalQuantity: totalQuantity,
  quantityRemaining: quantityRemaining,
  locationId: locationId,
  createdById: createdById,
  updatedById: updatedById,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateProductBatchData, CreateProductBatchVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await BizPharmaConnector.instance.createProductBatch(
  productId: productId,
  businessId: businessId,
  batchNumber: batchNumber,
  lotNumber: lotNumber,
  manufacturingDate: manufacturingDate,
  expiryDate: expiryDate,
  supplierId: supplierId,
  goodsReceiptId: goodsReceiptId,
  receivedDate: receivedDate,
  unitCost: unitCost,
  totalCost: totalCost,
  totalQuantity: totalQuantity,
  quantityRemaining: quantityRemaining,
  locationId: locationId,
  createdById: createdById,
  updatedById: updatedById,
);
CreateProductBatchData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String productId = ...;
String businessId = ...;
String batchNumber = ...;
String lotNumber = ...;
DateTime manufacturingDate = ...;
DateTime expiryDate = ...;
String supplierId = ...;
String goodsReceiptId = ...;
DateTime receivedDate = ...;
double unitCost = ...;
double totalCost = ...;
int totalQuantity = ...;
int quantityRemaining = ...;
String locationId = ...;
String createdById = ...;
String updatedById = ...;

final ref = BizPharmaConnector.instance.createProductBatch(
  productId: productId,
  businessId: businessId,
  batchNumber: batchNumber,
  lotNumber: lotNumber,
  manufacturingDate: manufacturingDate,
  expiryDate: expiryDate,
  supplierId: supplierId,
  goodsReceiptId: goodsReceiptId,
  receivedDate: receivedDate,
  unitCost: unitCost,
  totalCost: totalCost,
  totalQuantity: totalQuantity,
  quantityRemaining: quantityRemaining,
  locationId: locationId,
  createdById: createdById,
  updatedById: updatedById,
).ref();
ref.execute();
```


### CreateBusiness
#### Required Arguments
```dart
String name = ...;
BusinessTier tier = ...;
DateTime subscriptionStartDate = ...;
BizPharmaConnector.instance.createBusiness(
  name: name,
  tier: tier,
  subscriptionStartDate: subscriptionStartDate,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateBusiness, we created `CreateBusinessBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateBusinessVariablesBuilder {
  ...
   CreateBusinessVariablesBuilder subscriptionEndDate(DateTime? t) {
   _subscriptionEndDate.value = t;
   return this;
  }
  CreateBusinessVariablesBuilder maxUsers(int? t) {
   _maxUsers.value = t;
   return this;
  }
  CreateBusinessVariablesBuilder maxLocations(int? t) {
   _maxLocations.value = t;
   return this;
  }
  CreateBusinessVariablesBuilder logo(String? t) {
   _logo.value = t;
   return this;
  }
  CreateBusinessVariablesBuilder banner(String? t) {
   _banner.value = t;
   return this;
  }
  CreateBusinessVariablesBuilder phone(String? t) {
   _phone.value = t;
   return this;
  }

  ...
}
BizPharmaConnector.instance.createBusiness(
  name: name,
  tier: tier,
  subscriptionStartDate: subscriptionStartDate,
)
.subscriptionEndDate(subscriptionEndDate)
.maxUsers(maxUsers)
.maxLocations(maxLocations)
.logo(logo)
.banner(banner)
.phone(phone)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateBusinessData, CreateBusinessVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await BizPharmaConnector.instance.createBusiness(
  name: name,
  tier: tier,
  subscriptionStartDate: subscriptionStartDate,
);
CreateBusinessData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
BusinessTier tier = ...;
DateTime subscriptionStartDate = ...;

final ref = BizPharmaConnector.instance.createBusiness(
  name: name,
  tier: tier,
  subscriptionStartDate: subscriptionStartDate,
).ref();
ref.execute();
```


### CreateManufacturer
#### Required Arguments
```dart
String name = ...;
String country = ...;
BizPharmaConnector.instance.createManufacturer(
  name: name,
  country: country,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateManufacturerData, CreateManufacturerVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await BizPharmaConnector.instance.createManufacturer(
  name: name,
  country: country,
);
CreateManufacturerData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
String country = ...;

final ref = BizPharmaConnector.instance.createManufacturer(
  name: name,
  country: country,
).ref();
ref.execute();
```


### DeleteAllBusinesses
#### Required Arguments
```dart
// No required arguments
BizPharmaConnector.instance.deleteAllBusinesses().execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteAllBusinessesData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await BizPharmaConnector.instance.deleteAllBusinesses();
DeleteAllBusinessesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = BizPharmaConnector.instance.deleteAllBusinesses().ref();
ref.execute();
```


### CreateInventoryLevel
#### Required Arguments
```dart
String productId = ...;
String locationId = ...;
String businessId = ...;
int quantityOnHand = ...;
int quantityAvailable = ...;
double averageCost = ...;
double totalValue = ...;
BizPharmaConnector.instance.createInventoryLevel(
  productId: productId,
  locationId: locationId,
  businessId: businessId,
  quantityOnHand: quantityOnHand,
  quantityAvailable: quantityAvailable,
  averageCost: averageCost,
  totalValue: totalValue,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateInventoryLevel, we created `CreateInventoryLevelBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateInventoryLevelVariablesBuilder {
  ...
   CreateInventoryLevelVariablesBuilder batchId(String? t) {
   _batchId.value = t;
   return this;
  }

  ...
}
BizPharmaConnector.instance.createInventoryLevel(
  productId: productId,
  locationId: locationId,
  businessId: businessId,
  quantityOnHand: quantityOnHand,
  quantityAvailable: quantityAvailable,
  averageCost: averageCost,
  totalValue: totalValue,
)
.batchId(batchId)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateInventoryLevelData, CreateInventoryLevelVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await BizPharmaConnector.instance.createInventoryLevel(
  productId: productId,
  locationId: locationId,
  businessId: businessId,
  quantityOnHand: quantityOnHand,
  quantityAvailable: quantityAvailable,
  averageCost: averageCost,
  totalValue: totalValue,
);
CreateInventoryLevelData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String productId = ...;
String locationId = ...;
String businessId = ...;
int quantityOnHand = ...;
int quantityAvailable = ...;
double averageCost = ...;
double totalValue = ...;

final ref = BizPharmaConnector.instance.createInventoryLevel(
  productId: productId,
  locationId: locationId,
  businessId: businessId,
  quantityOnHand: quantityOnHand,
  quantityAvailable: quantityAvailable,
  averageCost: averageCost,
  totalValue: totalValue,
).ref();
ref.execute();
```


### CreateProduct
#### Required Arguments
```dart
String businessId = ...;
String genericName = ...;
String manufacturerId = ...;
String internalSKU = ...;
DosageForm dosageForm = ...;
String strength = ...;
String unit = ...;
RouteOfAdministration routeOfAdministration = ...;
DrugSchedule drugSchedule = ...;
bool requiresPrescription = ...;
String therapeuticClassId = ...;
int packageSize = ...;
PackageUnit packageUnit = ...;
String primarySupplierId = ...;
int leadTimeDays = ...;
int reorderPoint = ...;
int reorderQuantity = ...;
int minimumStockLevel = ...;
ProductCategory category = ...;
String createdById = ...;
String updatedById = ...;
BizPharmaConnector.instance.createProduct(
  businessId: businessId,
  genericName: genericName,
  manufacturerId: manufacturerId,
  internalSKU: internalSKU,
  dosageForm: dosageForm,
  strength: strength,
  unit: unit,
  routeOfAdministration: routeOfAdministration,
  drugSchedule: drugSchedule,
  requiresPrescription: requiresPrescription,
  therapeuticClassId: therapeuticClassId,
  packageSize: packageSize,
  packageUnit: packageUnit,
  primarySupplierId: primarySupplierId,
  leadTimeDays: leadTimeDays,
  reorderPoint: reorderPoint,
  reorderQuantity: reorderQuantity,
  minimumStockLevel: minimumStockLevel,
  category: category,
  createdById: createdById,
  updatedById: updatedById,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateProduct, we created `CreateProductBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateProductVariablesBuilder {
  ...
   CreateProductVariablesBuilder brandName(String? t) {
   _brandName.value = t;
   return this;
  }
  CreateProductVariablesBuilder nationalDrugCode(String? t) {
   _nationalDrugCode.value = t;
   return this;
  }
  CreateProductVariablesBuilder barcode(String? t) {
   _barcode.value = t;
   return this;
  }

  ...
}
BizPharmaConnector.instance.createProduct(
  businessId: businessId,
  genericName: genericName,
  manufacturerId: manufacturerId,
  internalSKU: internalSKU,
  dosageForm: dosageForm,
  strength: strength,
  unit: unit,
  routeOfAdministration: routeOfAdministration,
  drugSchedule: drugSchedule,
  requiresPrescription: requiresPrescription,
  therapeuticClassId: therapeuticClassId,
  packageSize: packageSize,
  packageUnit: packageUnit,
  primarySupplierId: primarySupplierId,
  leadTimeDays: leadTimeDays,
  reorderPoint: reorderPoint,
  reorderQuantity: reorderQuantity,
  minimumStockLevel: minimumStockLevel,
  category: category,
  createdById: createdById,
  updatedById: updatedById,
)
.brandName(brandName)
.nationalDrugCode(nationalDrugCode)
.barcode(barcode)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateProductData, CreateProductVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await BizPharmaConnector.instance.createProduct(
  businessId: businessId,
  genericName: genericName,
  manufacturerId: manufacturerId,
  internalSKU: internalSKU,
  dosageForm: dosageForm,
  strength: strength,
  unit: unit,
  routeOfAdministration: routeOfAdministration,
  drugSchedule: drugSchedule,
  requiresPrescription: requiresPrescription,
  therapeuticClassId: therapeuticClassId,
  packageSize: packageSize,
  packageUnit: packageUnit,
  primarySupplierId: primarySupplierId,
  leadTimeDays: leadTimeDays,
  reorderPoint: reorderPoint,
  reorderQuantity: reorderQuantity,
  minimumStockLevel: minimumStockLevel,
  category: category,
  createdById: createdById,
  updatedById: updatedById,
);
CreateProductData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String businessId = ...;
String genericName = ...;
String manufacturerId = ...;
String internalSKU = ...;
DosageForm dosageForm = ...;
String strength = ...;
String unit = ...;
RouteOfAdministration routeOfAdministration = ...;
DrugSchedule drugSchedule = ...;
bool requiresPrescription = ...;
String therapeuticClassId = ...;
int packageSize = ...;
PackageUnit packageUnit = ...;
String primarySupplierId = ...;
int leadTimeDays = ...;
int reorderPoint = ...;
int reorderQuantity = ...;
int minimumStockLevel = ...;
ProductCategory category = ...;
String createdById = ...;
String updatedById = ...;

final ref = BizPharmaConnector.instance.createProduct(
  businessId: businessId,
  genericName: genericName,
  manufacturerId: manufacturerId,
  internalSKU: internalSKU,
  dosageForm: dosageForm,
  strength: strength,
  unit: unit,
  routeOfAdministration: routeOfAdministration,
  drugSchedule: drugSchedule,
  requiresPrescription: requiresPrescription,
  therapeuticClassId: therapeuticClassId,
  packageSize: packageSize,
  packageUnit: packageUnit,
  primarySupplierId: primarySupplierId,
  leadTimeDays: leadTimeDays,
  reorderPoint: reorderPoint,
  reorderQuantity: reorderQuantity,
  minimumStockLevel: minimumStockLevel,
  category: category,
  createdById: createdById,
  updatedById: updatedById,
).ref();
ref.execute();
```


### CreateBusinessAndAdmin
#### Required Arguments
```dart
String businessId = ...;
String businessName = ...;
String userEmail = ...;
String userFirstName = ...;
String userLastName = ...;
String userMobile = ...;
String authUid = ...;
DateTime today = ...;
BizPharmaConnector.instance.createBusinessAndAdmin(
  businessId: businessId,
  businessName: businessName,
  userEmail: userEmail,
  userFirstName: userFirstName,
  userLastName: userLastName,
  userMobile: userMobile,
  authUid: authUid,
  today: today,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateBusinessAndAdmin, we created `CreateBusinessAndAdminBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateBusinessAndAdminVariablesBuilder {
  ...
   CreateBusinessAndAdminVariablesBuilder userProfilePhoto(String? t) {
   _userProfilePhoto.value = t;
   return this;
  }

  ...
}
BizPharmaConnector.instance.createBusinessAndAdmin(
  businessId: businessId,
  businessName: businessName,
  userEmail: userEmail,
  userFirstName: userFirstName,
  userLastName: userLastName,
  userMobile: userMobile,
  authUid: authUid,
  today: today,
)
.userProfilePhoto(userProfilePhoto)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateBusinessAndAdminData, CreateBusinessAndAdminVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await BizPharmaConnector.instance.createBusinessAndAdmin(
  businessId: businessId,
  businessName: businessName,
  userEmail: userEmail,
  userFirstName: userFirstName,
  userLastName: userLastName,
  userMobile: userMobile,
  authUid: authUid,
  today: today,
);
CreateBusinessAndAdminData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String businessId = ...;
String businessName = ...;
String userEmail = ...;
String userFirstName = ...;
String userLastName = ...;
String userMobile = ...;
String authUid = ...;
DateTime today = ...;

final ref = BizPharmaConnector.instance.createBusinessAndAdmin(
  businessId: businessId,
  businessName: businessName,
  userEmail: userEmail,
  userFirstName: userFirstName,
  userLastName: userLastName,
  userMobile: userMobile,
  authUid: authUid,
  today: today,
).ref();
ref.execute();
```


### CreateProductPricing
#### Required Arguments
```dart
String productId = ...;
String businessId = ...;
double wholesaleCost = ...;
double retailPrice = ...;
double walkInPrice = ...;
double grossMarginPercent = ...;
double markupPercent = ...;
double taxRate = ...;
DateTime effectiveDate = ...;
String updatedById = ...;
BizPharmaConnector.instance.createProductPricing(
  productId: productId,
  businessId: businessId,
  wholesaleCost: wholesaleCost,
  retailPrice: retailPrice,
  walkInPrice: walkInPrice,
  grossMarginPercent: grossMarginPercent,
  markupPercent: markupPercent,
  taxRate: taxRate,
  effectiveDate: effectiveDate,
  updatedById: updatedById,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateProductPricingData, CreateProductPricingVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await BizPharmaConnector.instance.createProductPricing(
  productId: productId,
  businessId: businessId,
  wholesaleCost: wholesaleCost,
  retailPrice: retailPrice,
  walkInPrice: walkInPrice,
  grossMarginPercent: grossMarginPercent,
  markupPercent: markupPercent,
  taxRate: taxRate,
  effectiveDate: effectiveDate,
  updatedById: updatedById,
);
CreateProductPricingData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String productId = ...;
String businessId = ...;
double wholesaleCost = ...;
double retailPrice = ...;
double walkInPrice = ...;
double grossMarginPercent = ...;
double markupPercent = ...;
double taxRate = ...;
DateTime effectiveDate = ...;
String updatedById = ...;

final ref = BizPharmaConnector.instance.createProductPricing(
  productId: productId,
  businessId: businessId,
  wholesaleCost: wholesaleCost,
  retailPrice: retailPrice,
  walkInPrice: walkInPrice,
  grossMarginPercent: grossMarginPercent,
  markupPercent: markupPercent,
  taxRate: taxRate,
  effectiveDate: effectiveDate,
  updatedById: updatedById,
).ref();
ref.execute();
```


### CreateGoodsReceipt
#### Required Arguments
```dart
String purchaseOrderId = ...;
String businessId = ...;
String receiptNumber = ...;
GoodsReceiptStatus status = ...;
String inspectedById = ...;
BizPharmaConnector.instance.createGoodsReceipt(
  purchaseOrderId: purchaseOrderId,
  businessId: businessId,
  receiptNumber: receiptNumber,
  status: status,
  inspectedById: inspectedById,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateGoodsReceipt, we created `CreateGoodsReceiptBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateGoodsReceiptVariablesBuilder {
  ...
   CreateGoodsReceiptVariablesBuilder receiptDate(Timestamp? t) {
   _receiptDate.value = t;
   return this;
  }

  ...
}
BizPharmaConnector.instance.createGoodsReceipt(
  purchaseOrderId: purchaseOrderId,
  businessId: businessId,
  receiptNumber: receiptNumber,
  status: status,
  inspectedById: inspectedById,
)
.receiptDate(receiptDate)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateGoodsReceiptData, CreateGoodsReceiptVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await BizPharmaConnector.instance.createGoodsReceipt(
  purchaseOrderId: purchaseOrderId,
  businessId: businessId,
  receiptNumber: receiptNumber,
  status: status,
  inspectedById: inspectedById,
);
CreateGoodsReceiptData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String purchaseOrderId = ...;
String businessId = ...;
String receiptNumber = ...;
GoodsReceiptStatus status = ...;
String inspectedById = ...;

final ref = BizPharmaConnector.instance.createGoodsReceipt(
  purchaseOrderId: purchaseOrderId,
  businessId: businessId,
  receiptNumber: receiptNumber,
  status: status,
  inspectedById: inspectedById,
).ref();
ref.execute();
```


### CreatePurchaseOrder
#### Required Arguments
```dart
String businessId = ...;
String supplierId = ...;
String orderNumber = ...;
double totalAmount = ...;
double subtotal = ...;
double taxAmount = ...;
PurchaseOrderStatus status = ...;
String createdById = ...;
BizPharmaConnector.instance.createPurchaseOrder(
  businessId: businessId,
  supplierId: supplierId,
  orderNumber: orderNumber,
  totalAmount: totalAmount,
  subtotal: subtotal,
  taxAmount: taxAmount,
  status: status,
  createdById: createdById,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreatePurchaseOrder, we created `CreatePurchaseOrderBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreatePurchaseOrderVariablesBuilder {
  ...
   CreatePurchaseOrderVariablesBuilder orderDate(Timestamp? t) {
   _orderDate.value = t;
   return this;
  }
  CreatePurchaseOrderVariablesBuilder expectedDeliveryDate(DateTime? t) {
   _expectedDeliveryDate.value = t;
   return this;
  }

  ...
}
BizPharmaConnector.instance.createPurchaseOrder(
  businessId: businessId,
  supplierId: supplierId,
  orderNumber: orderNumber,
  totalAmount: totalAmount,
  subtotal: subtotal,
  taxAmount: taxAmount,
  status: status,
  createdById: createdById,
)
.orderDate(orderDate)
.expectedDeliveryDate(expectedDeliveryDate)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreatePurchaseOrderData, CreatePurchaseOrderVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await BizPharmaConnector.instance.createPurchaseOrder(
  businessId: businessId,
  supplierId: supplierId,
  orderNumber: orderNumber,
  totalAmount: totalAmount,
  subtotal: subtotal,
  taxAmount: taxAmount,
  status: status,
  createdById: createdById,
);
CreatePurchaseOrderData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String businessId = ...;
String supplierId = ...;
String orderNumber = ...;
double totalAmount = ...;
double subtotal = ...;
double taxAmount = ...;
PurchaseOrderStatus status = ...;
String createdById = ...;

final ref = BizPharmaConnector.instance.createPurchaseOrder(
  businessId: businessId,
  supplierId: supplierId,
  orderNumber: orderNumber,
  totalAmount: totalAmount,
  subtotal: subtotal,
  taxAmount: taxAmount,
  status: status,
  createdById: createdById,
).ref();
ref.execute();
```


### CreateAddress
#### Required Arguments
```dart
String line1 = ...;
String city = ...;
String state = ...;
String postalCode = ...;
String country = ...;
BizPharmaConnector.instance.createAddress(
  line1: line1,
  city: city,
  state: state,
  postalCode: postalCode,
  country: country,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateAddress, we created `CreateAddressBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateAddressVariablesBuilder {
  ...
   CreateAddressVariablesBuilder line2(String? t) {
   _line2.value = t;
   return this;
  }
  CreateAddressVariablesBuilder phone(String? t) {
   _phone.value = t;
   return this;
  }

  ...
}
BizPharmaConnector.instance.createAddress(
  line1: line1,
  city: city,
  state: state,
  postalCode: postalCode,
  country: country,
)
.line2(line2)
.phone(phone)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateAddressData, CreateAddressVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await BizPharmaConnector.instance.createAddress(
  line1: line1,
  city: city,
  state: state,
  postalCode: postalCode,
  country: country,
);
CreateAddressData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String line1 = ...;
String city = ...;
String state = ...;
String postalCode = ...;
String country = ...;

final ref = BizPharmaConnector.instance.createAddress(
  line1: line1,
  city: city,
  state: state,
  postalCode: postalCode,
  country: country,
).ref();
ref.execute();
```


### CreateLocation
#### Required Arguments
```dart
String businessId = ...;
String name = ...;
String code = ...;
LocationType type = ...;
BizPharmaConnector.instance.createLocation(
  businessId: businessId,
  name: name,
  code: code,
  type: type,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateLocation, we created `CreateLocationBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateLocationVariablesBuilder {
  ...
   CreateLocationVariablesBuilder phone(String? t) {
   _phone.value = t;
   return this;
  }
  CreateLocationVariablesBuilder email(String? t) {
   _email.value = t;
   return this;
  }
  CreateLocationVariablesBuilder operatingHours(String? t) {
   _operatingHours.value = t;
   return this;
  }
  CreateLocationVariablesBuilder licenseNumber(String? t) {
   _licenseNumber.value = t;
   return this;
  }

  ...
}
BizPharmaConnector.instance.createLocation(
  businessId: businessId,
  name: name,
  code: code,
  type: type,
)
.phone(phone)
.email(email)
.operatingHours(operatingHours)
.licenseNumber(licenseNumber)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateLocationData, CreateLocationVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await BizPharmaConnector.instance.createLocation(
  businessId: businessId,
  name: name,
  code: code,
  type: type,
);
CreateLocationData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String businessId = ...;
String name = ...;
String code = ...;
LocationType type = ...;

final ref = BizPharmaConnector.instance.createLocation(
  businessId: businessId,
  name: name,
  code: code,
  type: type,
).ref();
ref.execute();
```

