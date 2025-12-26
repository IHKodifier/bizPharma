# Basic Usage

```dart
BizPharmaConnector.instance.CreateAddress(createAddressVariables).execute();
BizPharmaConnector.instance.CreateManufacturer(createManufacturerVariables).execute();
BizPharmaConnector.instance.CreateUser(createUserVariables).execute();
BizPharmaConnector.instance.DeleteAllBusinesses().execute();
BizPharmaConnector.instance.CreateLocation(createLocationVariables).execute();
BizPharmaConnector.instance.GetUserByAuthId(getUserByAuthIdVariables).execute();
BizPharmaConnector.instance.ListAllCustomers().execute();
BizPharmaConnector.instance.ListInventoryByLocation(listInventoryByLocationVariables).execute();
BizPharmaConnector.instance.CreateCustomer(createCustomerVariables).execute();
BizPharmaConnector.instance.ListAllBusinesses().execute();

```

## Optional Fields

Some operations may have optional fields. In these cases, the Flutter SDK exposes a builder method, and will have to be set separately.

Optional fields can be discovered based on classes that have `Optional` object types.

This is an example of a mutation with an optional field:

```dart
await BizPharmaConnector.instance.CreateInventoryLevel({ ... })
.batchId(...)
.execute();
```

Note: the above example is a mutation, but the same logic applies to query operations as well. Additionally, `createMovie` is an example, and may not be available to the user.

