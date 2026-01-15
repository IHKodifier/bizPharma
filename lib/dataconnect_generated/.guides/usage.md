# Basic Usage

```dart
BizPharmaConnector.instance.CreateBusiness(createBusinessVariables).execute();
BizPharmaConnector.instance.DeleteAllUsers().execute();
BizPharmaConnector.instance.CreateCustomer(createCustomerVariables).execute();
BizPharmaConnector.instance.DeleteAllLocations().execute();
BizPharmaConnector.instance.CreateGoodsReceipt(createGoodsReceiptVariables).execute();
BizPharmaConnector.instance.CreateProductBatch(createProductBatchVariables).execute();
BizPharmaConnector.instance.CreateAddress(createAddressVariables).execute();
BizPharmaConnector.instance.CreatePurchaseOrder(createPurchaseOrderVariables).execute();
BizPharmaConnector.instance.GetUserByAuthId(getUserByAuthIdVariables).execute();
BizPharmaConnector.instance.CreateSupplier(createSupplierVariables).execute();

```

## Optional Fields

Some operations may have optional fields. In these cases, the Flutter SDK exposes a builder method, and will have to be set separately.

Optional fields can be discovered based on classes that have `Optional` object types.

This is an example of a mutation with an optional field:

```dart
await BizPharmaConnector.instance.CreateCategory({ ... })
.description(...)
.execute();
```

Note: the above example is a mutation, but the same logic applies to query operations as well. Additionally, `createMovie` is an example, and may not be available to the user.

