# Basic Usage

```dart
IkPharmaConnector.instance.CreatePurchaseOrder(createPurchaseOrderVariables).execute();
IkPharmaConnector.instance.VerifyProduct().execute();
IkPharmaConnector.instance.GetBusinessById(getBusinessByIdVariables).execute();
IkPharmaConnector.instance.ListAllBusinesses().execute();
IkPharmaConnector.instance.GetUserByAuthId(getUserByAuthIdVariables).execute();
IkPharmaConnector.instance.ListAllUsers().execute();
IkPharmaConnector.instance.listAllProducts().execute();
IkPharmaConnector.instance.DeleteAllBusinesses().execute();
IkPharmaConnector.instance.CreateGoodsReceipt(createGoodsReceiptVariables).execute();
IkPharmaConnector.instance.ListPricingByLocation(listPricingByLocationVariables).execute();

```

## Optional Fields

Some operations may have optional fields. In these cases, the Flutter SDK exposes a builder method, and will have to be set separately.

Optional fields can be discovered based on classes that have `Optional` object types.

This is an example of a mutation with an optional field:

```dart
await IkPharmaConnector.instance.CreateCustomer({ ... })
.email(...)
.execute();
```

Note: the above example is a mutation, but the same logic applies to query operations as well. Additionally, `createMovie` is an example, and may not be available to the user.

