# Basic Usage

```dart
BizPharmaConnector.instance.ListInventoryByLocation(listInventoryByLocationVariables).execute();
BizPharmaConnector.instance.Uptime().execute();
BizPharmaConnector.instance.CreateBusiness(createBusinessVariables).execute();
BizPharmaConnector.instance.ListAllUsers().execute();
BizPharmaConnector.instance.ListPricingByLocation(listPricingByLocationVariables).execute();
BizPharmaConnector.instance.CreateLocation(createLocationVariables).execute();
BizPharmaConnector.instance.CreatePurchaseOrder(createPurchaseOrderVariables).execute();
BizPharmaConnector.instance.CreateProduct(createProductVariables).execute();
BizPharmaConnector.instance.GetBusinessById(getBusinessByIdVariables).execute();
BizPharmaConnector.instance.UpdateLocation(updateLocationVariables).execute();

```

## Optional Fields

Some operations may have optional fields. In these cases, the Flutter SDK exposes a builder method, and will have to be set separately.

Optional fields can be discovered based on classes that have `Optional` object types.

This is an example of a mutation with an optional field:

```dart
await BizPharmaConnector.instance.CreateCustomer({ ... })
.email(...)
.execute();
```

Note: the above example is a mutation, but the same logic applies to query operations as well. Additionally, `createMovie` is an example, and may not be available to the user.

