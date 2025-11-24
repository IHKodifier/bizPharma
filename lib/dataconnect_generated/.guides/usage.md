# Basic Usage

```dart
IkPharmaConnector.instance.VerifyProduct().execute();
IkPharmaConnector.instance.GetBusinessById(getBusinessByIdVariables).execute();
IkPharmaConnector.instance.ListAllBusinesses().execute();
IkPharmaConnector.instance.ListAllSuppliers().execute();
IkPharmaConnector.instance.CreateUser(createUserVariables).execute();
IkPharmaConnector.instance.CreateCustomer(createCustomerVariables).execute();
IkPharmaConnector.instance.CreateGoodsReceipt(createGoodsReceiptVariables).execute();
IkPharmaConnector.instance.CreatePurchaseOrder(createPurchaseOrderVariables).execute();
IkPharmaConnector.instance.CreateProduct(createProductVariables).execute();
IkPharmaConnector.instance.CreateTherapeuticClass(createTherapeuticClassVariables).execute();

```

## Optional Fields

Some operations may have optional fields. In these cases, the Flutter SDK exposes a builder method, and will have to be set separately.

Optional fields can be discovered based on classes that have `Optional` object types.

This is an example of a mutation with an optional field:

```dart
await IkPharmaConnector.instance.CreateAddress({ ... })
.line2(...)
.execute();
```

Note: the above example is a mutation, but the same logic applies to query operations as well. Additionally, `createMovie` is an example, and may not be available to the user.

