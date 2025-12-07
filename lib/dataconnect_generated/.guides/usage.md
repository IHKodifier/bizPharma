# Basic Usage

```dart
BizPharmaConnector.instance.ListAllCustomers().execute();
BizPharmaConnector.instance.ListAllLocations().execute();
BizPharmaConnector.instance.listAllProducts().execute();
BizPharmaConnector.instance.ListProductsByBusiness(listProductsByBusinessVariables).execute();
BizPharmaConnector.instance.ListAllSuppliers().execute();
BizPharmaConnector.instance.CreateBusiness(createBusinessVariables).execute();
BizPharmaConnector.instance.CreateCustomer(createCustomerVariables).execute();
BizPharmaConnector.instance.VerifyProduct().execute();
BizPharmaConnector.instance.GetBusinessById(getBusinessByIdVariables).execute();
BizPharmaConnector.instance.CreateGoodsReceipt(createGoodsReceiptVariables).execute();

```

## Optional Fields

Some operations may have optional fields. In these cases, the Flutter SDK exposes a builder method, and will have to be set separately.

Optional fields can be discovered based on classes that have `Optional` object types.

This is an example of a mutation with an optional field:

```dart
await BizPharmaConnector.instance.CreateTherapeuticClass({ ... })
.description(...)
.execute();
```

Note: the above example is a mutation, but the same logic applies to query operations as well. Additionally, `createMovie` is an example, and may not be available to the user.

