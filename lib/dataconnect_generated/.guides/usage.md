# Basic Usage

```dart
BizPharmaConnector.instance.ListAllSuppliers().execute();
BizPharmaConnector.instance.CreateBusinessAndAdmin(createBusinessAndAdminVariables).execute();
BizPharmaConnector.instance.CreateUser(createUserVariables).execute();
BizPharmaConnector.instance.CreateTherapeuticClass(createTherapeuticClassVariables).execute();
BizPharmaConnector.instance.ListLocationsByBusiness(listLocationsByBusinessVariables).execute();
BizPharmaConnector.instance.listAllProducts().execute();
BizPharmaConnector.instance.CreateGoodsReceipt(createGoodsReceiptVariables).execute();
BizPharmaConnector.instance.CreateInventoryLevel(createInventoryLevelVariables).execute();
BizPharmaConnector.instance.ListAllCustomers().execute();
BizPharmaConnector.instance.ListInventoryByLocation(listInventoryByLocationVariables).execute();

```

## Optional Fields

Some operations may have optional fields. In these cases, the Flutter SDK exposes a builder method, and will have to be set separately.

Optional fields can be discovered based on classes that have `Optional` object types.

This is an example of a mutation with an optional field:

```dart
await BizPharmaConnector.instance.CreateProduct({ ... })
.brandName(...)
.execute();
```

Note: the above example is a mutation, but the same logic applies to query operations as well. Additionally, `createMovie` is an example, and may not be available to the user.

