# Basic Usage

```dart
BizPharmaConnector.instance.ListProductsByBusiness(listProductsByBusinessVariables).execute();
BizPharmaConnector.instance.DeleteAllBusinesses().execute();
BizPharmaConnector.instance.CreateCustomer(createCustomerVariables).execute();
BizPharmaConnector.instance.CreateInventoryLevel(createInventoryLevelVariables).execute();
BizPharmaConnector.instance.CreateProductBatch(createProductBatchVariables).execute();
BizPharmaConnector.instance.DeleteAllUsers().execute();
BizPharmaConnector.instance.CreateProductPricing(createProductPricingVariables).execute();
BizPharmaConnector.instance.CreateProduct(createProductVariables).execute();
BizPharmaConnector.instance.ListAllUsers().execute();
BizPharmaConnector.instance.CreateUser(createUserVariables).execute();

```

## Optional Fields

Some operations may have optional fields. In these cases, the Flutter SDK exposes a builder method, and will have to be set separately.

Optional fields can be discovered based on classes that have `Optional` object types.

This is an example of a mutation with an optional field:

```dart
await BizPharmaConnector.instance.CreatePurchaseOrder({ ... })
.orderDate(...)
.execute();
```

Note: the above example is a mutation, but the same logic applies to query operations as well. Additionally, `createMovie` is an example, and may not be available to the user.

