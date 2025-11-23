# Generated TypeScript README
This README will guide you through the process of using the generated JavaScript SDK package for the connector `ik_pharma`. It will also provide examples on how to use your generated SDK to call your Data Connect queries and mutations.

***NOTE:** This README is generated alongside the generated SDK. If you make changes to this file, they will be overwritten when the SDK is regenerated.*

# Table of Contents
- [**Overview**](#generated-javascript-readme)
- [**Accessing the connector**](#accessing-the-connector)
  - [*Connecting to the local Emulator*](#connecting-to-the-local-emulator)
- [**Queries**](#queries)
  - [*GetParacetamolProducts*](#getparacetamolproducts)
  - [*ListAllBusinesses*](#listallbusinesses)
  - [*ListAllCustomers*](#listallcustomers)
  - [*ListAllLocations*](#listalllocations)
  - [*listAllProducts*](#listallproducts)
  - [*ListInventoryByLocation*](#listinventorybylocation)
  - [*VerifyProduct*](#verifyproduct)
  - [*GetBusinessById*](#getbusinessbyid)
  - [*ListLocationsByBusiness*](#listlocationsbybusiness)
  - [*ListProductsByBusiness*](#listproductsbybusiness)
  - [*ListAllSuppliers*](#listallsuppliers)
  - [*ListPricingByLocation*](#listpricingbylocation)
- [**Mutations**](#mutations)
  - [*CreateSupplier*](#createsupplier)
  - [*CreatePurchaseOrder*](#createpurchaseorder)
  - [*createDummyProduct*](#createdummyproduct)
  - [*CreateProductBatch*](#createproductbatch)
  - [*CreateProductPricing*](#createproductpricing)
  - [*SeedData*](#seeddata)
  - [*CreateAddress*](#createaddress)
  - [*CreateUser*](#createuser)
  - [*CreateCustomer*](#createcustomer)
  - [*CreateTherapeuticClass*](#createtherapeuticclass)
  - [*CreateBusiness*](#createbusiness)
  - [*CreateManufacturer*](#createmanufacturer)
  - [*CreateLocation*](#createlocation)
  - [*CreateGoodsReceipt*](#creategoodsreceipt)
  - [*CreateInventoryLevel*](#createinventorylevel)
  - [*CreateProduct*](#createproduct)

# Accessing the connector
A connector is a collection of Queries and Mutations. One SDK is generated for each connector - this SDK is generated for the connector `ik_pharma`. You can find more information about connectors in the [Data Connect documentation](https://firebase.google.com/docs/data-connect#how-does).

You can use this generated SDK by importing from the package `@firebasegen/ik-pharma-connector/generated` as shown below. Both CommonJS and ESM imports are supported.

You can also follow the instructions from the [Data Connect documentation](https://firebase.google.com/docs/data-connect/web-sdk#set-client).

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig } from '@firebasegen/ik-pharma-connector/generated';

const dataConnect = getDataConnect(connectorConfig);
```

## Connecting to the local Emulator
By default, the connector will connect to the production service.

To connect to the emulator, you can use the following code.
You can also follow the emulator instructions from the [Data Connect documentation](https://firebase.google.com/docs/data-connect/web-sdk#instrument-clients).

```typescript
import { connectDataConnectEmulator, getDataConnect } from 'firebase/data-connect';
import { connectorConfig } from '@firebasegen/ik-pharma-connector/generated';

const dataConnect = getDataConnect(connectorConfig);
connectDataConnectEmulator(dataConnect, 'localhost', 9399);
```

After it's initialized, you can call your Data Connect [queries](#queries) and [mutations](#mutations) from your generated SDK.

# Queries

There are two ways to execute a Data Connect Query using the generated Web SDK:
- Using a Query Reference function, which returns a `QueryRef`
  - The `QueryRef` can be used as an argument to `executeQuery()`, which will execute the Query and return a `QueryPromise`
- Using an action shortcut function, which returns a `QueryPromise`
  - Calling the action shortcut function will execute the Query and return a `QueryPromise`

The following is true for both the action shortcut function and the `QueryRef` function:
- The `QueryPromise` returned will resolve to the result of the Query once it has finished executing
- If the Query accepts arguments, both the action shortcut function and the `QueryRef` function accept a single argument: an object that contains all the required variables (and the optional variables) for the Query
- Both functions can be called with or without passing in a `DataConnect` instance as an argument. If no `DataConnect` argument is passed in, then the generated SDK will call `getDataConnect(connectorConfig)` behind the scenes for you.

Below are examples of how to use the `ik_pharma` connector's generated functions to execute each query. You can also follow the examples from the [Data Connect documentation](https://firebase.google.com/docs/data-connect/web-sdk#using-queries).

## GetParacetamolProducts
You can execute the `GetParacetamolProducts` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
getParacetamolProducts(): QueryPromise<GetParacetamolProductsData, undefined>;

interface GetParacetamolProductsRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<GetParacetamolProductsData, undefined>;
}
export const getParacetamolProductsRef: GetParacetamolProductsRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
getParacetamolProducts(dc: DataConnect): QueryPromise<GetParacetamolProductsData, undefined>;

interface GetParacetamolProductsRef {
  ...
  (dc: DataConnect): QueryRef<GetParacetamolProductsData, undefined>;
}
export const getParacetamolProductsRef: GetParacetamolProductsRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the getParacetamolProductsRef:
```typescript
const name = getParacetamolProductsRef.operationName;
console.log(name);
```

### Variables
The `GetParacetamolProducts` query has no variables.
### Return Type
Recall that executing the `GetParacetamolProducts` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `GetParacetamolProductsData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface GetParacetamolProductsData {
  products: ({
    id: UUIDString;
    genericName: string;
    brandName?: string | null;
    internalSKU: string;
    manufacturer: {
      name: string;
    };
      business: {
        name: string;
      };
        category: ProductCategory;
        isActive: boolean;
  } & Product_Key)[];
}
```
### Using `GetParacetamolProducts`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, getParacetamolProducts } from '@firebasegen/ik-pharma-connector/generated';


// Call the `getParacetamolProducts()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await getParacetamolProducts();

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await getParacetamolProducts(dataConnect);

console.log(data.products);

// Or, you can use the `Promise` API.
getParacetamolProducts().then((response) => {
  const data = response.data;
  console.log(data.products);
});
```

### Using `GetParacetamolProducts`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, getParacetamolProductsRef } from '@firebasegen/ik-pharma-connector/generated';


// Call the `getParacetamolProductsRef()` function to get a reference to the query.
const ref = getParacetamolProductsRef();

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = getParacetamolProductsRef(dataConnect);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.products);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.products);
});
```

## ListAllBusinesses
You can execute the `ListAllBusinesses` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
listAllBusinesses(): QueryPromise<ListAllBusinessesData, undefined>;

interface ListAllBusinessesRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListAllBusinessesData, undefined>;
}
export const listAllBusinessesRef: ListAllBusinessesRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
listAllBusinesses(dc: DataConnect): QueryPromise<ListAllBusinessesData, undefined>;

interface ListAllBusinessesRef {
  ...
  (dc: DataConnect): QueryRef<ListAllBusinessesData, undefined>;
}
export const listAllBusinessesRef: ListAllBusinessesRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the listAllBusinessesRef:
```typescript
const name = listAllBusinessesRef.operationName;
console.log(name);
```

### Variables
The `ListAllBusinesses` query has no variables.
### Return Type
Recall that executing the `ListAllBusinesses` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `ListAllBusinessesData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface ListAllBusinessesData {
  businesses: ({
    id: UUIDString;
    name: string;
    tier: BusinessTier;
    subscriptionStartDate: DateString;
    subscriptionEndDate?: DateString | null;
    isActive: boolean;
    maxUsers?: number | null;
    maxLocations?: number | null;
    createdAt: DateString;
    updatedAt: DateString;
  } & Business_Key)[];
}
```
### Using `ListAllBusinesses`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, listAllBusinesses } from '@firebasegen/ik-pharma-connector/generated';


// Call the `listAllBusinesses()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await listAllBusinesses();

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await listAllBusinesses(dataConnect);

console.log(data.businesses);

// Or, you can use the `Promise` API.
listAllBusinesses().then((response) => {
  const data = response.data;
  console.log(data.businesses);
});
```

### Using `ListAllBusinesses`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, listAllBusinessesRef } from '@firebasegen/ik-pharma-connector/generated';


// Call the `listAllBusinessesRef()` function to get a reference to the query.
const ref = listAllBusinessesRef();

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = listAllBusinessesRef(dataConnect);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.businesses);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.businesses);
});
```

## ListAllCustomers
You can execute the `ListAllCustomers` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
listAllCustomers(): QueryPromise<ListAllCustomersData, undefined>;

interface ListAllCustomersRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListAllCustomersData, undefined>;
}
export const listAllCustomersRef: ListAllCustomersRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
listAllCustomers(dc: DataConnect): QueryPromise<ListAllCustomersData, undefined>;

interface ListAllCustomersRef {
  ...
  (dc: DataConnect): QueryRef<ListAllCustomersData, undefined>;
}
export const listAllCustomersRef: ListAllCustomersRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the listAllCustomersRef:
```typescript
const name = listAllCustomersRef.operationName;
console.log(name);
```

### Variables
The `ListAllCustomers` query has no variables.
### Return Type
Recall that executing the `ListAllCustomers` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `ListAllCustomersData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface ListAllCustomersData {
  customers: ({
    id: UUIDString;
    businessId: UUIDString;
    firstName: string;
    lastName: string;
    email?: string | null;
    phone?: string | null;
    dateOfBirth?: DateString | null;
    tier: CustomerTier;
    isActive: boolean;
    createdAt: DateString;
  } & Customer_Key)[];
}
```
### Using `ListAllCustomers`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, listAllCustomers } from '@firebasegen/ik-pharma-connector/generated';


// Call the `listAllCustomers()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await listAllCustomers();

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await listAllCustomers(dataConnect);

console.log(data.customers);

// Or, you can use the `Promise` API.
listAllCustomers().then((response) => {
  const data = response.data;
  console.log(data.customers);
});
```

### Using `ListAllCustomers`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, listAllCustomersRef } from '@firebasegen/ik-pharma-connector/generated';


// Call the `listAllCustomersRef()` function to get a reference to the query.
const ref = listAllCustomersRef();

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = listAllCustomersRef(dataConnect);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.customers);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.customers);
});
```

## ListAllLocations
You can execute the `ListAllLocations` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
listAllLocations(): QueryPromise<ListAllLocationsData, undefined>;

interface ListAllLocationsRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListAllLocationsData, undefined>;
}
export const listAllLocationsRef: ListAllLocationsRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
listAllLocations(dc: DataConnect): QueryPromise<ListAllLocationsData, undefined>;

interface ListAllLocationsRef {
  ...
  (dc: DataConnect): QueryRef<ListAllLocationsData, undefined>;
}
export const listAllLocationsRef: ListAllLocationsRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the listAllLocationsRef:
```typescript
const name = listAllLocationsRef.operationName;
console.log(name);
```

### Variables
The `ListAllLocations` query has no variables.
### Return Type
Recall that executing the `ListAllLocations` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `ListAllLocationsData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface ListAllLocationsData {
  locations: ({
    id: UUIDString;
    businessId: UUIDString;
    name: string;
    code: string;
    type: LocationType;
    phone?: string | null;
    email?: string | null;
    isActive: boolean;
    createdAt: TimestampString;
  } & Location_Key)[];
}
```
### Using `ListAllLocations`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, listAllLocations } from '@firebasegen/ik-pharma-connector/generated';


// Call the `listAllLocations()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await listAllLocations();

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await listAllLocations(dataConnect);

console.log(data.locations);

// Or, you can use the `Promise` API.
listAllLocations().then((response) => {
  const data = response.data;
  console.log(data.locations);
});
```

### Using `ListAllLocations`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, listAllLocationsRef } from '@firebasegen/ik-pharma-connector/generated';


// Call the `listAllLocationsRef()` function to get a reference to the query.
const ref = listAllLocationsRef();

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = listAllLocationsRef(dataConnect);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.locations);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.locations);
});
```

## listAllProducts
You can execute the `listAllProducts` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
listAllProducts(): QueryPromise<ListAllProductsData, undefined>;

interface ListAllProductsRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListAllProductsData, undefined>;
}
export const listAllProductsRef: ListAllProductsRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
listAllProducts(dc: DataConnect): QueryPromise<ListAllProductsData, undefined>;

interface ListAllProductsRef {
  ...
  (dc: DataConnect): QueryRef<ListAllProductsData, undefined>;
}
export const listAllProductsRef: ListAllProductsRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the listAllProductsRef:
```typescript
const name = listAllProductsRef.operationName;
console.log(name);
```

### Variables
The `listAllProducts` query has no variables.
### Return Type
Recall that executing the `listAllProducts` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `ListAllProductsData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface ListAllProductsData {
  products: ({
    id: UUIDString;
    genericName: string;
    internalSKU: string;
    manufacturer: {
      name: string;
    };
      business: {
        name: string;
      };
  } & Product_Key)[];
}
```
### Using `listAllProducts`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, listAllProducts } from '@firebasegen/ik-pharma-connector/generated';


// Call the `listAllProducts()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await listAllProducts();

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await listAllProducts(dataConnect);

console.log(data.products);

// Or, you can use the `Promise` API.
listAllProducts().then((response) => {
  const data = response.data;
  console.log(data.products);
});
```

### Using `listAllProducts`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, listAllProductsRef } from '@firebasegen/ik-pharma-connector/generated';


// Call the `listAllProductsRef()` function to get a reference to the query.
const ref = listAllProductsRef();

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = listAllProductsRef(dataConnect);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.products);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.products);
});
```

## ListInventoryByLocation
You can execute the `ListInventoryByLocation` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
listInventoryByLocation(vars: ListInventoryByLocationVariables): QueryPromise<ListInventoryByLocationData, ListInventoryByLocationVariables>;

interface ListInventoryByLocationRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: ListInventoryByLocationVariables): QueryRef<ListInventoryByLocationData, ListInventoryByLocationVariables>;
}
export const listInventoryByLocationRef: ListInventoryByLocationRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
listInventoryByLocation(dc: DataConnect, vars: ListInventoryByLocationVariables): QueryPromise<ListInventoryByLocationData, ListInventoryByLocationVariables>;

interface ListInventoryByLocationRef {
  ...
  (dc: DataConnect, vars: ListInventoryByLocationVariables): QueryRef<ListInventoryByLocationData, ListInventoryByLocationVariables>;
}
export const listInventoryByLocationRef: ListInventoryByLocationRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the listInventoryByLocationRef:
```typescript
const name = listInventoryByLocationRef.operationName;
console.log(name);
```

### Variables
The `ListInventoryByLocation` query requires an argument of type `ListInventoryByLocationVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface ListInventoryByLocationVariables {
  locationId: UUIDString;
}
```
### Return Type
Recall that executing the `ListInventoryByLocation` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `ListInventoryByLocationData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface ListInventoryByLocationData {
  inventoryLevels: ({
    id: UUIDString;
    productId: UUIDString;
    locationId: UUIDString;
    batchId?: UUIDString | null;
    businessId: UUIDString;
    quantityOnHand: number;
    quantityReserved: number;
    quantityAvailable: number;
    quantityInTransit: number;
    averageCost: number;
    totalValue: number;
    lastCountDate?: DateString | null;
    lastDispenseDate?: DateString | null;
    lastRestockDate?: DateString | null;
    updatedAt: TimestampString;
  } & InventoryLevel_Key)[];
}
```
### Using `ListInventoryByLocation`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, listInventoryByLocation, ListInventoryByLocationVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `ListInventoryByLocation` query requires an argument of type `ListInventoryByLocationVariables`:
const listInventoryByLocationVars: ListInventoryByLocationVariables = {
  locationId: ..., 
};

// Call the `listInventoryByLocation()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await listInventoryByLocation(listInventoryByLocationVars);
// Variables can be defined inline as well.
const { data } = await listInventoryByLocation({ locationId: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await listInventoryByLocation(dataConnect, listInventoryByLocationVars);

console.log(data.inventoryLevels);

// Or, you can use the `Promise` API.
listInventoryByLocation(listInventoryByLocationVars).then((response) => {
  const data = response.data;
  console.log(data.inventoryLevels);
});
```

### Using `ListInventoryByLocation`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, listInventoryByLocationRef, ListInventoryByLocationVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `ListInventoryByLocation` query requires an argument of type `ListInventoryByLocationVariables`:
const listInventoryByLocationVars: ListInventoryByLocationVariables = {
  locationId: ..., 
};

// Call the `listInventoryByLocationRef()` function to get a reference to the query.
const ref = listInventoryByLocationRef(listInventoryByLocationVars);
// Variables can be defined inline as well.
const ref = listInventoryByLocationRef({ locationId: ..., });

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = listInventoryByLocationRef(dataConnect, listInventoryByLocationVars);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.inventoryLevels);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.inventoryLevels);
});
```

## VerifyProduct
You can execute the `VerifyProduct` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
verifyProduct(): QueryPromise<VerifyProductData, undefined>;

interface VerifyProductRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<VerifyProductData, undefined>;
}
export const verifyProductRef: VerifyProductRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
verifyProduct(dc: DataConnect): QueryPromise<VerifyProductData, undefined>;

interface VerifyProductRef {
  ...
  (dc: DataConnect): QueryRef<VerifyProductData, undefined>;
}
export const verifyProductRef: VerifyProductRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the verifyProductRef:
```typescript
const name = verifyProductRef.operationName;
console.log(name);
```

### Variables
The `VerifyProduct` query has no variables.
### Return Type
Recall that executing the `VerifyProduct` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `VerifyProductData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface VerifyProductData {
  products: ({
    id: UUIDString;
    genericName: string;
    brandName?: string | null;
    internalSKU: string;
    manufacturer: {
      name: string;
    };
      business: {
        name: string;
      };
        category: ProductCategory;
        isActive: boolean;
  } & Product_Key)[];
}
```
### Using `VerifyProduct`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, verifyProduct } from '@firebasegen/ik-pharma-connector/generated';


// Call the `verifyProduct()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await verifyProduct();

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await verifyProduct(dataConnect);

console.log(data.products);

// Or, you can use the `Promise` API.
verifyProduct().then((response) => {
  const data = response.data;
  console.log(data.products);
});
```

### Using `VerifyProduct`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, verifyProductRef } from '@firebasegen/ik-pharma-connector/generated';


// Call the `verifyProductRef()` function to get a reference to the query.
const ref = verifyProductRef();

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = verifyProductRef(dataConnect);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.products);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.products);
});
```

## GetBusinessById
You can execute the `GetBusinessById` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
getBusinessById(vars: GetBusinessByIdVariables): QueryPromise<GetBusinessByIdData, GetBusinessByIdVariables>;

interface GetBusinessByIdRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetBusinessByIdVariables): QueryRef<GetBusinessByIdData, GetBusinessByIdVariables>;
}
export const getBusinessByIdRef: GetBusinessByIdRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
getBusinessById(dc: DataConnect, vars: GetBusinessByIdVariables): QueryPromise<GetBusinessByIdData, GetBusinessByIdVariables>;

interface GetBusinessByIdRef {
  ...
  (dc: DataConnect, vars: GetBusinessByIdVariables): QueryRef<GetBusinessByIdData, GetBusinessByIdVariables>;
}
export const getBusinessByIdRef: GetBusinessByIdRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the getBusinessByIdRef:
```typescript
const name = getBusinessByIdRef.operationName;
console.log(name);
```

### Variables
The `GetBusinessById` query requires an argument of type `GetBusinessByIdVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface GetBusinessByIdVariables {
  id: UUIDString;
}
```
### Return Type
Recall that executing the `GetBusinessById` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `GetBusinessByIdData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface GetBusinessByIdData {
  business?: {
    id: UUIDString;
    name: string;
    tier: BusinessTier;
    subscriptionStartDate: DateString;
    subscriptionEndDate?: DateString | null;
    isActive: boolean;
    maxUsers?: number | null;
    maxLocations?: number | null;
    createdAt: DateString;
    updatedAt: DateString;
  } & Business_Key;
}
```
### Using `GetBusinessById`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, getBusinessById, GetBusinessByIdVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `GetBusinessById` query requires an argument of type `GetBusinessByIdVariables`:
const getBusinessByIdVars: GetBusinessByIdVariables = {
  id: ..., 
};

// Call the `getBusinessById()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await getBusinessById(getBusinessByIdVars);
// Variables can be defined inline as well.
const { data } = await getBusinessById({ id: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await getBusinessById(dataConnect, getBusinessByIdVars);

console.log(data.business);

// Or, you can use the `Promise` API.
getBusinessById(getBusinessByIdVars).then((response) => {
  const data = response.data;
  console.log(data.business);
});
```

### Using `GetBusinessById`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, getBusinessByIdRef, GetBusinessByIdVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `GetBusinessById` query requires an argument of type `GetBusinessByIdVariables`:
const getBusinessByIdVars: GetBusinessByIdVariables = {
  id: ..., 
};

// Call the `getBusinessByIdRef()` function to get a reference to the query.
const ref = getBusinessByIdRef(getBusinessByIdVars);
// Variables can be defined inline as well.
const ref = getBusinessByIdRef({ id: ..., });

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = getBusinessByIdRef(dataConnect, getBusinessByIdVars);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.business);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.business);
});
```

## ListLocationsByBusiness
You can execute the `ListLocationsByBusiness` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
listLocationsByBusiness(vars: ListLocationsByBusinessVariables): QueryPromise<ListLocationsByBusinessData, ListLocationsByBusinessVariables>;

interface ListLocationsByBusinessRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: ListLocationsByBusinessVariables): QueryRef<ListLocationsByBusinessData, ListLocationsByBusinessVariables>;
}
export const listLocationsByBusinessRef: ListLocationsByBusinessRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
listLocationsByBusiness(dc: DataConnect, vars: ListLocationsByBusinessVariables): QueryPromise<ListLocationsByBusinessData, ListLocationsByBusinessVariables>;

interface ListLocationsByBusinessRef {
  ...
  (dc: DataConnect, vars: ListLocationsByBusinessVariables): QueryRef<ListLocationsByBusinessData, ListLocationsByBusinessVariables>;
}
export const listLocationsByBusinessRef: ListLocationsByBusinessRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the listLocationsByBusinessRef:
```typescript
const name = listLocationsByBusinessRef.operationName;
console.log(name);
```

### Variables
The `ListLocationsByBusiness` query requires an argument of type `ListLocationsByBusinessVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface ListLocationsByBusinessVariables {
  businessId: UUIDString;
}
```
### Return Type
Recall that executing the `ListLocationsByBusiness` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `ListLocationsByBusinessData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface ListLocationsByBusinessData {
  locations: ({
    id: UUIDString;
    businessId: UUIDString;
    name: string;
    code: string;
    type: LocationType;
    phone?: string | null;
    email?: string | null;
    isActive: boolean;
    createdAt: TimestampString;
  } & Location_Key)[];
}
```
### Using `ListLocationsByBusiness`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, listLocationsByBusiness, ListLocationsByBusinessVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `ListLocationsByBusiness` query requires an argument of type `ListLocationsByBusinessVariables`:
const listLocationsByBusinessVars: ListLocationsByBusinessVariables = {
  businessId: ..., 
};

// Call the `listLocationsByBusiness()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await listLocationsByBusiness(listLocationsByBusinessVars);
// Variables can be defined inline as well.
const { data } = await listLocationsByBusiness({ businessId: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await listLocationsByBusiness(dataConnect, listLocationsByBusinessVars);

console.log(data.locations);

// Or, you can use the `Promise` API.
listLocationsByBusiness(listLocationsByBusinessVars).then((response) => {
  const data = response.data;
  console.log(data.locations);
});
```

### Using `ListLocationsByBusiness`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, listLocationsByBusinessRef, ListLocationsByBusinessVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `ListLocationsByBusiness` query requires an argument of type `ListLocationsByBusinessVariables`:
const listLocationsByBusinessVars: ListLocationsByBusinessVariables = {
  businessId: ..., 
};

// Call the `listLocationsByBusinessRef()` function to get a reference to the query.
const ref = listLocationsByBusinessRef(listLocationsByBusinessVars);
// Variables can be defined inline as well.
const ref = listLocationsByBusinessRef({ businessId: ..., });

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = listLocationsByBusinessRef(dataConnect, listLocationsByBusinessVars);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.locations);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.locations);
});
```

## ListProductsByBusiness
You can execute the `ListProductsByBusiness` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
listProductsByBusiness(vars: ListProductsByBusinessVariables): QueryPromise<ListProductsByBusinessData, ListProductsByBusinessVariables>;

interface ListProductsByBusinessRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: ListProductsByBusinessVariables): QueryRef<ListProductsByBusinessData, ListProductsByBusinessVariables>;
}
export const listProductsByBusinessRef: ListProductsByBusinessRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
listProductsByBusiness(dc: DataConnect, vars: ListProductsByBusinessVariables): QueryPromise<ListProductsByBusinessData, ListProductsByBusinessVariables>;

interface ListProductsByBusinessRef {
  ...
  (dc: DataConnect, vars: ListProductsByBusinessVariables): QueryRef<ListProductsByBusinessData, ListProductsByBusinessVariables>;
}
export const listProductsByBusinessRef: ListProductsByBusinessRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the listProductsByBusinessRef:
```typescript
const name = listProductsByBusinessRef.operationName;
console.log(name);
```

### Variables
The `ListProductsByBusiness` query requires an argument of type `ListProductsByBusinessVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface ListProductsByBusinessVariables {
  businessId: UUIDString;
}
```
### Return Type
Recall that executing the `ListProductsByBusiness` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `ListProductsByBusinessData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface ListProductsByBusinessData {
  products: ({
    id: UUIDString;
    businessId: UUIDString;
    genericName: string;
    brandName?: string | null;
    nationalDrugCode?: string | null;
    barcode?: string | null;
    upc?: string | null;
    internalSKU: string;
    dosageForm: DosageForm;
    strength: string;
    unit: string;
    routeOfAdministration: RouteOfAdministration;
    drugSchedule: DrugSchedule;
    requiresPrescription: boolean;
    category: ProductCategory;
    subcategory?: ProductSubcategory | null;
    isActive: boolean;
    isDiscontinued: boolean;
    createdAt: TimestampString;
  } & Product_Key)[];
}
```
### Using `ListProductsByBusiness`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, listProductsByBusiness, ListProductsByBusinessVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `ListProductsByBusiness` query requires an argument of type `ListProductsByBusinessVariables`:
const listProductsByBusinessVars: ListProductsByBusinessVariables = {
  businessId: ..., 
};

// Call the `listProductsByBusiness()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await listProductsByBusiness(listProductsByBusinessVars);
// Variables can be defined inline as well.
const { data } = await listProductsByBusiness({ businessId: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await listProductsByBusiness(dataConnect, listProductsByBusinessVars);

console.log(data.products);

// Or, you can use the `Promise` API.
listProductsByBusiness(listProductsByBusinessVars).then((response) => {
  const data = response.data;
  console.log(data.products);
});
```

### Using `ListProductsByBusiness`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, listProductsByBusinessRef, ListProductsByBusinessVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `ListProductsByBusiness` query requires an argument of type `ListProductsByBusinessVariables`:
const listProductsByBusinessVars: ListProductsByBusinessVariables = {
  businessId: ..., 
};

// Call the `listProductsByBusinessRef()` function to get a reference to the query.
const ref = listProductsByBusinessRef(listProductsByBusinessVars);
// Variables can be defined inline as well.
const ref = listProductsByBusinessRef({ businessId: ..., });

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = listProductsByBusinessRef(dataConnect, listProductsByBusinessVars);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.products);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.products);
});
```

## ListAllSuppliers
You can execute the `ListAllSuppliers` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
listAllSuppliers(): QueryPromise<ListAllSuppliersData, undefined>;

interface ListAllSuppliersRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListAllSuppliersData, undefined>;
}
export const listAllSuppliersRef: ListAllSuppliersRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
listAllSuppliers(dc: DataConnect): QueryPromise<ListAllSuppliersData, undefined>;

interface ListAllSuppliersRef {
  ...
  (dc: DataConnect): QueryRef<ListAllSuppliersData, undefined>;
}
export const listAllSuppliersRef: ListAllSuppliersRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the listAllSuppliersRef:
```typescript
const name = listAllSuppliersRef.operationName;
console.log(name);
```

### Variables
The `ListAllSuppliers` query has no variables.
### Return Type
Recall that executing the `ListAllSuppliers` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `ListAllSuppliersData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface ListAllSuppliersData {
  suppliers: ({
    id: UUIDString;
    businessId: UUIDString;
    name: string;
    type: SupplierType;
    contactPerson?: string | null;
    email?: string | null;
    phone?: string | null;
    paymentTerms: string;
    tier: SupplierTier;
    outstandingBalance: number;
    isActive: boolean;
    isPreferred: boolean;
    createdAt: TimestampString;
  } & Supplier_Key)[];
}
```
### Using `ListAllSuppliers`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, listAllSuppliers } from '@firebasegen/ik-pharma-connector/generated';


// Call the `listAllSuppliers()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await listAllSuppliers();

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await listAllSuppliers(dataConnect);

console.log(data.suppliers);

// Or, you can use the `Promise` API.
listAllSuppliers().then((response) => {
  const data = response.data;
  console.log(data.suppliers);
});
```

### Using `ListAllSuppliers`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, listAllSuppliersRef } from '@firebasegen/ik-pharma-connector/generated';


// Call the `listAllSuppliersRef()` function to get a reference to the query.
const ref = listAllSuppliersRef();

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = listAllSuppliersRef(dataConnect);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.suppliers);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.suppliers);
});
```

## ListPricingByLocation
You can execute the `ListPricingByLocation` query using the following action shortcut function, or by calling `executeQuery()` after calling the following `QueryRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
listPricingByLocation(vars: ListPricingByLocationVariables): QueryPromise<ListPricingByLocationData, ListPricingByLocationVariables>;

interface ListPricingByLocationRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: ListPricingByLocationVariables): QueryRef<ListPricingByLocationData, ListPricingByLocationVariables>;
}
export const listPricingByLocationRef: ListPricingByLocationRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `QueryRef` function.
```typescript
listPricingByLocation(dc: DataConnect, vars: ListPricingByLocationVariables): QueryPromise<ListPricingByLocationData, ListPricingByLocationVariables>;

interface ListPricingByLocationRef {
  ...
  (dc: DataConnect, vars: ListPricingByLocationVariables): QueryRef<ListPricingByLocationData, ListPricingByLocationVariables>;
}
export const listPricingByLocationRef: ListPricingByLocationRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the listPricingByLocationRef:
```typescript
const name = listPricingByLocationRef.operationName;
console.log(name);
```

### Variables
The `ListPricingByLocation` query requires an argument of type `ListPricingByLocationVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface ListPricingByLocationVariables {
  businessId: UUIDString;
}
```
### Return Type
Recall that executing the `ListPricingByLocation` query returns a `QueryPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `ListPricingByLocationData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface ListPricingByLocationData {
  productPricings: ({
    id: UUIDString;
    productId: UUIDString;
    businessId: UUIDString;
    wholesaleCost: number;
    retailPrice: number;
    walkInPrice: number;
    bronzePrice?: number | null;
    silverPrice?: number | null;
    goldPrice?: number | null;
    diamondPrice?: number | null;
    platinumPrice?: number | null;
    grossMarginPercent: number;
    markupPercent: number;
    taxRate: number;
    effectiveDate: DateString;
    updatedAt: TimestampString;
  } & ProductPricing_Key)[];
}
```
### Using `ListPricingByLocation`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, listPricingByLocation, ListPricingByLocationVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `ListPricingByLocation` query requires an argument of type `ListPricingByLocationVariables`:
const listPricingByLocationVars: ListPricingByLocationVariables = {
  businessId: ..., 
};

// Call the `listPricingByLocation()` function to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await listPricingByLocation(listPricingByLocationVars);
// Variables can be defined inline as well.
const { data } = await listPricingByLocation({ businessId: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await listPricingByLocation(dataConnect, listPricingByLocationVars);

console.log(data.productPricings);

// Or, you can use the `Promise` API.
listPricingByLocation(listPricingByLocationVars).then((response) => {
  const data = response.data;
  console.log(data.productPricings);
});
```

### Using `ListPricingByLocation`'s `QueryRef` function

```typescript
import { getDataConnect, executeQuery } from 'firebase/data-connect';
import { connectorConfig, listPricingByLocationRef, ListPricingByLocationVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `ListPricingByLocation` query requires an argument of type `ListPricingByLocationVariables`:
const listPricingByLocationVars: ListPricingByLocationVariables = {
  businessId: ..., 
};

// Call the `listPricingByLocationRef()` function to get a reference to the query.
const ref = listPricingByLocationRef(listPricingByLocationVars);
// Variables can be defined inline as well.
const ref = listPricingByLocationRef({ businessId: ..., });

// You can also pass in a `DataConnect` instance to the `QueryRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = listPricingByLocationRef(dataConnect, listPricingByLocationVars);

// Call `executeQuery()` on the reference to execute the query.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeQuery(ref);

console.log(data.productPricings);

// Or, you can use the `Promise` API.
executeQuery(ref).then((response) => {
  const data = response.data;
  console.log(data.productPricings);
});
```

# Mutations

There are two ways to execute a Data Connect Mutation using the generated Web SDK:
- Using a Mutation Reference function, which returns a `MutationRef`
  - The `MutationRef` can be used as an argument to `executeMutation()`, which will execute the Mutation and return a `MutationPromise`
- Using an action shortcut function, which returns a `MutationPromise`
  - Calling the action shortcut function will execute the Mutation and return a `MutationPromise`

The following is true for both the action shortcut function and the `MutationRef` function:
- The `MutationPromise` returned will resolve to the result of the Mutation once it has finished executing
- If the Mutation accepts arguments, both the action shortcut function and the `MutationRef` function accept a single argument: an object that contains all the required variables (and the optional variables) for the Mutation
- Both functions can be called with or without passing in a `DataConnect` instance as an argument. If no `DataConnect` argument is passed in, then the generated SDK will call `getDataConnect(connectorConfig)` behind the scenes for you.

Below are examples of how to use the `ik_pharma` connector's generated functions to execute each mutation. You can also follow the examples from the [Data Connect documentation](https://firebase.google.com/docs/data-connect/web-sdk#using-mutations).

## CreateSupplier
You can execute the `CreateSupplier` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createSupplier(vars: CreateSupplierVariables): MutationPromise<CreateSupplierData, CreateSupplierVariables>;

interface CreateSupplierRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateSupplierVariables): MutationRef<CreateSupplierData, CreateSupplierVariables>;
}
export const createSupplierRef: CreateSupplierRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createSupplier(dc: DataConnect, vars: CreateSupplierVariables): MutationPromise<CreateSupplierData, CreateSupplierVariables>;

interface CreateSupplierRef {
  ...
  (dc: DataConnect, vars: CreateSupplierVariables): MutationRef<CreateSupplierData, CreateSupplierVariables>;
}
export const createSupplierRef: CreateSupplierRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createSupplierRef:
```typescript
const name = createSupplierRef.operationName;
console.log(name);
```

### Variables
The `CreateSupplier` mutation requires an argument of type `CreateSupplierVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreateSupplierVariables {
  businessId: UUIDString;
  name: string;
  type: SupplierType;
  contactPerson?: string | null;
  email?: string | null;
  phone?: string | null;
  paymentTerms: string;
  tier: SupplierTier;
}
```
### Return Type
Recall that executing the `CreateSupplier` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateSupplierData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateSupplierData {
  supplier_insert: Supplier_Key;
}
```
### Using `CreateSupplier`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createSupplier, CreateSupplierVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateSupplier` mutation requires an argument of type `CreateSupplierVariables`:
const createSupplierVars: CreateSupplierVariables = {
  businessId: ..., 
  name: ..., 
  type: ..., 
  contactPerson: ..., // optional
  email: ..., // optional
  phone: ..., // optional
  paymentTerms: ..., 
  tier: ..., 
};

// Call the `createSupplier()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createSupplier(createSupplierVars);
// Variables can be defined inline as well.
const { data } = await createSupplier({ businessId: ..., name: ..., type: ..., contactPerson: ..., email: ..., phone: ..., paymentTerms: ..., tier: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createSupplier(dataConnect, createSupplierVars);

console.log(data.supplier_insert);

// Or, you can use the `Promise` API.
createSupplier(createSupplierVars).then((response) => {
  const data = response.data;
  console.log(data.supplier_insert);
});
```

### Using `CreateSupplier`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createSupplierRef, CreateSupplierVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateSupplier` mutation requires an argument of type `CreateSupplierVariables`:
const createSupplierVars: CreateSupplierVariables = {
  businessId: ..., 
  name: ..., 
  type: ..., 
  contactPerson: ..., // optional
  email: ..., // optional
  phone: ..., // optional
  paymentTerms: ..., 
  tier: ..., 
};

// Call the `createSupplierRef()` function to get a reference to the mutation.
const ref = createSupplierRef(createSupplierVars);
// Variables can be defined inline as well.
const ref = createSupplierRef({ businessId: ..., name: ..., type: ..., contactPerson: ..., email: ..., phone: ..., paymentTerms: ..., tier: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createSupplierRef(dataConnect, createSupplierVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.supplier_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.supplier_insert);
});
```

## CreatePurchaseOrder
You can execute the `CreatePurchaseOrder` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createPurchaseOrder(vars: CreatePurchaseOrderVariables): MutationPromise<CreatePurchaseOrderData, CreatePurchaseOrderVariables>;

interface CreatePurchaseOrderRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreatePurchaseOrderVariables): MutationRef<CreatePurchaseOrderData, CreatePurchaseOrderVariables>;
}
export const createPurchaseOrderRef: CreatePurchaseOrderRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createPurchaseOrder(dc: DataConnect, vars: CreatePurchaseOrderVariables): MutationPromise<CreatePurchaseOrderData, CreatePurchaseOrderVariables>;

interface CreatePurchaseOrderRef {
  ...
  (dc: DataConnect, vars: CreatePurchaseOrderVariables): MutationRef<CreatePurchaseOrderData, CreatePurchaseOrderVariables>;
}
export const createPurchaseOrderRef: CreatePurchaseOrderRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createPurchaseOrderRef:
```typescript
const name = createPurchaseOrderRef.operationName;
console.log(name);
```

### Variables
The `CreatePurchaseOrder` mutation requires an argument of type `CreatePurchaseOrderVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreatePurchaseOrderVariables {
  businessId: UUIDString;
  supplierId: UUIDString;
  orderNumber: string;
  orderDate?: TimestampString | null;
  expectedDeliveryDate?: DateString | null;
  totalAmount: number;
  subtotal: number;
  taxAmount: number;
  status: PurchaseOrderStatus;
  createdById: string;
}
```
### Return Type
Recall that executing the `CreatePurchaseOrder` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreatePurchaseOrderData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreatePurchaseOrderData {
  purchaseOrder_insert: PurchaseOrder_Key;
}
```
### Using `CreatePurchaseOrder`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createPurchaseOrder, CreatePurchaseOrderVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreatePurchaseOrder` mutation requires an argument of type `CreatePurchaseOrderVariables`:
const createPurchaseOrderVars: CreatePurchaseOrderVariables = {
  businessId: ..., 
  supplierId: ..., 
  orderNumber: ..., 
  orderDate: ..., // optional
  expectedDeliveryDate: ..., // optional
  totalAmount: ..., 
  subtotal: ..., 
  taxAmount: ..., 
  status: ..., 
  createdById: ..., 
};

// Call the `createPurchaseOrder()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createPurchaseOrder(createPurchaseOrderVars);
// Variables can be defined inline as well.
const { data } = await createPurchaseOrder({ businessId: ..., supplierId: ..., orderNumber: ..., orderDate: ..., expectedDeliveryDate: ..., totalAmount: ..., subtotal: ..., taxAmount: ..., status: ..., createdById: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createPurchaseOrder(dataConnect, createPurchaseOrderVars);

console.log(data.purchaseOrder_insert);

// Or, you can use the `Promise` API.
createPurchaseOrder(createPurchaseOrderVars).then((response) => {
  const data = response.data;
  console.log(data.purchaseOrder_insert);
});
```

### Using `CreatePurchaseOrder`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createPurchaseOrderRef, CreatePurchaseOrderVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreatePurchaseOrder` mutation requires an argument of type `CreatePurchaseOrderVariables`:
const createPurchaseOrderVars: CreatePurchaseOrderVariables = {
  businessId: ..., 
  supplierId: ..., 
  orderNumber: ..., 
  orderDate: ..., // optional
  expectedDeliveryDate: ..., // optional
  totalAmount: ..., 
  subtotal: ..., 
  taxAmount: ..., 
  status: ..., 
  createdById: ..., 
};

// Call the `createPurchaseOrderRef()` function to get a reference to the mutation.
const ref = createPurchaseOrderRef(createPurchaseOrderVars);
// Variables can be defined inline as well.
const ref = createPurchaseOrderRef({ businessId: ..., supplierId: ..., orderNumber: ..., orderDate: ..., expectedDeliveryDate: ..., totalAmount: ..., subtotal: ..., taxAmount: ..., status: ..., createdById: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createPurchaseOrderRef(dataConnect, createPurchaseOrderVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.purchaseOrder_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.purchaseOrder_insert);
});
```

## createDummyProduct
You can execute the `createDummyProduct` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createDummyProduct(): MutationPromise<CreateDummyProductData, undefined>;

interface CreateDummyProductRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (): MutationRef<CreateDummyProductData, undefined>;
}
export const createDummyProductRef: CreateDummyProductRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createDummyProduct(dc: DataConnect): MutationPromise<CreateDummyProductData, undefined>;

interface CreateDummyProductRef {
  ...
  (dc: DataConnect): MutationRef<CreateDummyProductData, undefined>;
}
export const createDummyProductRef: CreateDummyProductRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createDummyProductRef:
```typescript
const name = createDummyProductRef.operationName;
console.log(name);
```

### Variables
The `createDummyProduct` mutation has no variables.
### Return Type
Recall that executing the `createDummyProduct` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateDummyProductData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateDummyProductData {
  business_insert: Business_Key;
  user_insert: User_Key;
  manufacturer_insert: Manufacturer_Key;
  therapeuticClass_insert: TherapeuticClass_Key;
  address_insert: Address_Key;
  dateRange_insert: DateRange_Key;
  supplier_insert: Supplier_Key;
  supplierPerformanceScore_insert: SupplierPerformanceScore_Key;
  product_insert: Product_Key;
  productPricing_insert: ProductPricing_Key;
  expiryWarningThresholds_insert: ExpiryWarningThresholds_Key;
}
```
### Using `createDummyProduct`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createDummyProduct } from '@firebasegen/ik-pharma-connector/generated';


// Call the `createDummyProduct()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createDummyProduct();

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createDummyProduct(dataConnect);

console.log(data.business_insert);
console.log(data.user_insert);
console.log(data.manufacturer_insert);
console.log(data.therapeuticClass_insert);
console.log(data.address_insert);
console.log(data.dateRange_insert);
console.log(data.supplier_insert);
console.log(data.supplierPerformanceScore_insert);
console.log(data.product_insert);
console.log(data.productPricing_insert);
console.log(data.expiryWarningThresholds_insert);

// Or, you can use the `Promise` API.
createDummyProduct().then((response) => {
  const data = response.data;
  console.log(data.business_insert);
  console.log(data.user_insert);
  console.log(data.manufacturer_insert);
  console.log(data.therapeuticClass_insert);
  console.log(data.address_insert);
  console.log(data.dateRange_insert);
  console.log(data.supplier_insert);
  console.log(data.supplierPerformanceScore_insert);
  console.log(data.product_insert);
  console.log(data.productPricing_insert);
  console.log(data.expiryWarningThresholds_insert);
});
```

### Using `createDummyProduct`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createDummyProductRef } from '@firebasegen/ik-pharma-connector/generated';


// Call the `createDummyProductRef()` function to get a reference to the mutation.
const ref = createDummyProductRef();

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createDummyProductRef(dataConnect);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.business_insert);
console.log(data.user_insert);
console.log(data.manufacturer_insert);
console.log(data.therapeuticClass_insert);
console.log(data.address_insert);
console.log(data.dateRange_insert);
console.log(data.supplier_insert);
console.log(data.supplierPerformanceScore_insert);
console.log(data.product_insert);
console.log(data.productPricing_insert);
console.log(data.expiryWarningThresholds_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.business_insert);
  console.log(data.user_insert);
  console.log(data.manufacturer_insert);
  console.log(data.therapeuticClass_insert);
  console.log(data.address_insert);
  console.log(data.dateRange_insert);
  console.log(data.supplier_insert);
  console.log(data.supplierPerformanceScore_insert);
  console.log(data.product_insert);
  console.log(data.productPricing_insert);
  console.log(data.expiryWarningThresholds_insert);
});
```

## CreateProductBatch
You can execute the `CreateProductBatch` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createProductBatch(vars: CreateProductBatchVariables): MutationPromise<CreateProductBatchData, CreateProductBatchVariables>;

interface CreateProductBatchRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateProductBatchVariables): MutationRef<CreateProductBatchData, CreateProductBatchVariables>;
}
export const createProductBatchRef: CreateProductBatchRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createProductBatch(dc: DataConnect, vars: CreateProductBatchVariables): MutationPromise<CreateProductBatchData, CreateProductBatchVariables>;

interface CreateProductBatchRef {
  ...
  (dc: DataConnect, vars: CreateProductBatchVariables): MutationRef<CreateProductBatchData, CreateProductBatchVariables>;
}
export const createProductBatchRef: CreateProductBatchRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createProductBatchRef:
```typescript
const name = createProductBatchRef.operationName;
console.log(name);
```

### Variables
The `CreateProductBatch` mutation requires an argument of type `CreateProductBatchVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreateProductBatchVariables {
  productId: UUIDString;
  businessId: UUIDString;
  batchNumber: string;
  lotNumber: string;
  manufacturingDate: DateString;
  expiryDate: DateString;
  supplierId: UUIDString;
  goodsReceiptId: UUIDString;
  receivedDate: DateString;
  unitCost: number;
  totalCost: number;
  totalQuantity: number;
  quantityRemaining: number;
  locationId: UUIDString;
  createdById: string;
  updatedById: string;
}
```
### Return Type
Recall that executing the `CreateProductBatch` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateProductBatchData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateProductBatchData {
  productBatch_insert: ProductBatch_Key;
}
```
### Using `CreateProductBatch`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createProductBatch, CreateProductBatchVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateProductBatch` mutation requires an argument of type `CreateProductBatchVariables`:
const createProductBatchVars: CreateProductBatchVariables = {
  productId: ..., 
  businessId: ..., 
  batchNumber: ..., 
  lotNumber: ..., 
  manufacturingDate: ..., 
  expiryDate: ..., 
  supplierId: ..., 
  goodsReceiptId: ..., 
  receivedDate: ..., 
  unitCost: ..., 
  totalCost: ..., 
  totalQuantity: ..., 
  quantityRemaining: ..., 
  locationId: ..., 
  createdById: ..., 
  updatedById: ..., 
};

// Call the `createProductBatch()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createProductBatch(createProductBatchVars);
// Variables can be defined inline as well.
const { data } = await createProductBatch({ productId: ..., businessId: ..., batchNumber: ..., lotNumber: ..., manufacturingDate: ..., expiryDate: ..., supplierId: ..., goodsReceiptId: ..., receivedDate: ..., unitCost: ..., totalCost: ..., totalQuantity: ..., quantityRemaining: ..., locationId: ..., createdById: ..., updatedById: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createProductBatch(dataConnect, createProductBatchVars);

console.log(data.productBatch_insert);

// Or, you can use the `Promise` API.
createProductBatch(createProductBatchVars).then((response) => {
  const data = response.data;
  console.log(data.productBatch_insert);
});
```

### Using `CreateProductBatch`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createProductBatchRef, CreateProductBatchVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateProductBatch` mutation requires an argument of type `CreateProductBatchVariables`:
const createProductBatchVars: CreateProductBatchVariables = {
  productId: ..., 
  businessId: ..., 
  batchNumber: ..., 
  lotNumber: ..., 
  manufacturingDate: ..., 
  expiryDate: ..., 
  supplierId: ..., 
  goodsReceiptId: ..., 
  receivedDate: ..., 
  unitCost: ..., 
  totalCost: ..., 
  totalQuantity: ..., 
  quantityRemaining: ..., 
  locationId: ..., 
  createdById: ..., 
  updatedById: ..., 
};

// Call the `createProductBatchRef()` function to get a reference to the mutation.
const ref = createProductBatchRef(createProductBatchVars);
// Variables can be defined inline as well.
const ref = createProductBatchRef({ productId: ..., businessId: ..., batchNumber: ..., lotNumber: ..., manufacturingDate: ..., expiryDate: ..., supplierId: ..., goodsReceiptId: ..., receivedDate: ..., unitCost: ..., totalCost: ..., totalQuantity: ..., quantityRemaining: ..., locationId: ..., createdById: ..., updatedById: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createProductBatchRef(dataConnect, createProductBatchVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.productBatch_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.productBatch_insert);
});
```

## CreateProductPricing
You can execute the `CreateProductPricing` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createProductPricing(vars: CreateProductPricingVariables): MutationPromise<CreateProductPricingData, CreateProductPricingVariables>;

interface CreateProductPricingRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateProductPricingVariables): MutationRef<CreateProductPricingData, CreateProductPricingVariables>;
}
export const createProductPricingRef: CreateProductPricingRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createProductPricing(dc: DataConnect, vars: CreateProductPricingVariables): MutationPromise<CreateProductPricingData, CreateProductPricingVariables>;

interface CreateProductPricingRef {
  ...
  (dc: DataConnect, vars: CreateProductPricingVariables): MutationRef<CreateProductPricingData, CreateProductPricingVariables>;
}
export const createProductPricingRef: CreateProductPricingRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createProductPricingRef:
```typescript
const name = createProductPricingRef.operationName;
console.log(name);
```

### Variables
The `CreateProductPricing` mutation requires an argument of type `CreateProductPricingVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreateProductPricingVariables {
  productId: UUIDString;
  businessId: UUIDString;
  wholesaleCost: number;
  retailPrice: number;
  walkInPrice: number;
  grossMarginPercent: number;
  markupPercent: number;
  taxRate: number;
  effectiveDate: DateString;
  updatedById: string;
}
```
### Return Type
Recall that executing the `CreateProductPricing` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateProductPricingData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateProductPricingData {
  productPricing_insert: ProductPricing_Key;
}
```
### Using `CreateProductPricing`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createProductPricing, CreateProductPricingVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateProductPricing` mutation requires an argument of type `CreateProductPricingVariables`:
const createProductPricingVars: CreateProductPricingVariables = {
  productId: ..., 
  businessId: ..., 
  wholesaleCost: ..., 
  retailPrice: ..., 
  walkInPrice: ..., 
  grossMarginPercent: ..., 
  markupPercent: ..., 
  taxRate: ..., 
  effectiveDate: ..., 
  updatedById: ..., 
};

// Call the `createProductPricing()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createProductPricing(createProductPricingVars);
// Variables can be defined inline as well.
const { data } = await createProductPricing({ productId: ..., businessId: ..., wholesaleCost: ..., retailPrice: ..., walkInPrice: ..., grossMarginPercent: ..., markupPercent: ..., taxRate: ..., effectiveDate: ..., updatedById: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createProductPricing(dataConnect, createProductPricingVars);

console.log(data.productPricing_insert);

// Or, you can use the `Promise` API.
createProductPricing(createProductPricingVars).then((response) => {
  const data = response.data;
  console.log(data.productPricing_insert);
});
```

### Using `CreateProductPricing`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createProductPricingRef, CreateProductPricingVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateProductPricing` mutation requires an argument of type `CreateProductPricingVariables`:
const createProductPricingVars: CreateProductPricingVariables = {
  productId: ..., 
  businessId: ..., 
  wholesaleCost: ..., 
  retailPrice: ..., 
  walkInPrice: ..., 
  grossMarginPercent: ..., 
  markupPercent: ..., 
  taxRate: ..., 
  effectiveDate: ..., 
  updatedById: ..., 
};

// Call the `createProductPricingRef()` function to get a reference to the mutation.
const ref = createProductPricingRef(createProductPricingVars);
// Variables can be defined inline as well.
const ref = createProductPricingRef({ productId: ..., businessId: ..., wholesaleCost: ..., retailPrice: ..., walkInPrice: ..., grossMarginPercent: ..., markupPercent: ..., taxRate: ..., effectiveDate: ..., updatedById: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createProductPricingRef(dataConnect, createProductPricingVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.productPricing_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.productPricing_insert);
});
```

## SeedData
You can execute the `SeedData` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
seedData(): MutationPromise<SeedDataData, undefined>;

interface SeedDataRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (): MutationRef<SeedDataData, undefined>;
}
export const seedDataRef: SeedDataRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
seedData(dc: DataConnect): MutationPromise<SeedDataData, undefined>;

interface SeedDataRef {
  ...
  (dc: DataConnect): MutationRef<SeedDataData, undefined>;
}
export const seedDataRef: SeedDataRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the seedDataRef:
```typescript
const name = seedDataRef.operationName;
console.log(name);
```

### Variables
The `SeedData` mutation has no variables.
### Return Type
Recall that executing the `SeedData` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `SeedDataData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface SeedDataData {
  b1: Business_Key;
  u1: User_Key;
  m1: Manufacturer_Key;
  tc1: TherapeuticClass_Key;
  s1: Supplier_Key;
  p1: Product_Key;
}
```
### Using `SeedData`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, seedData } from '@firebasegen/ik-pharma-connector/generated';


// Call the `seedData()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await seedData();

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await seedData(dataConnect);

console.log(data.b1);
console.log(data.u1);
console.log(data.m1);
console.log(data.tc1);
console.log(data.s1);
console.log(data.p1);

// Or, you can use the `Promise` API.
seedData().then((response) => {
  const data = response.data;
  console.log(data.b1);
  console.log(data.u1);
  console.log(data.m1);
  console.log(data.tc1);
  console.log(data.s1);
  console.log(data.p1);
});
```

### Using `SeedData`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, seedDataRef } from '@firebasegen/ik-pharma-connector/generated';


// Call the `seedDataRef()` function to get a reference to the mutation.
const ref = seedDataRef();

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = seedDataRef(dataConnect);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.b1);
console.log(data.u1);
console.log(data.m1);
console.log(data.tc1);
console.log(data.s1);
console.log(data.p1);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.b1);
  console.log(data.u1);
  console.log(data.m1);
  console.log(data.tc1);
  console.log(data.s1);
  console.log(data.p1);
});
```

## CreateAddress
You can execute the `CreateAddress` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createAddress(vars: CreateAddressVariables): MutationPromise<CreateAddressData, CreateAddressVariables>;

interface CreateAddressRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateAddressVariables): MutationRef<CreateAddressData, CreateAddressVariables>;
}
export const createAddressRef: CreateAddressRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createAddress(dc: DataConnect, vars: CreateAddressVariables): MutationPromise<CreateAddressData, CreateAddressVariables>;

interface CreateAddressRef {
  ...
  (dc: DataConnect, vars: CreateAddressVariables): MutationRef<CreateAddressData, CreateAddressVariables>;
}
export const createAddressRef: CreateAddressRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createAddressRef:
```typescript
const name = createAddressRef.operationName;
console.log(name);
```

### Variables
The `CreateAddress` mutation requires an argument of type `CreateAddressVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreateAddressVariables {
  line1: string;
  line2?: string | null;
  city: string;
  state: string;
  postalCode: string;
  country: string;
}
```
### Return Type
Recall that executing the `CreateAddress` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateAddressData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateAddressData {
  address_insert: Address_Key;
}
```
### Using `CreateAddress`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createAddress, CreateAddressVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateAddress` mutation requires an argument of type `CreateAddressVariables`:
const createAddressVars: CreateAddressVariables = {
  line1: ..., 
  line2: ..., // optional
  city: ..., 
  state: ..., 
  postalCode: ..., 
  country: ..., 
};

// Call the `createAddress()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createAddress(createAddressVars);
// Variables can be defined inline as well.
const { data } = await createAddress({ line1: ..., line2: ..., city: ..., state: ..., postalCode: ..., country: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createAddress(dataConnect, createAddressVars);

console.log(data.address_insert);

// Or, you can use the `Promise` API.
createAddress(createAddressVars).then((response) => {
  const data = response.data;
  console.log(data.address_insert);
});
```

### Using `CreateAddress`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createAddressRef, CreateAddressVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateAddress` mutation requires an argument of type `CreateAddressVariables`:
const createAddressVars: CreateAddressVariables = {
  line1: ..., 
  line2: ..., // optional
  city: ..., 
  state: ..., 
  postalCode: ..., 
  country: ..., 
};

// Call the `createAddressRef()` function to get a reference to the mutation.
const ref = createAddressRef(createAddressVars);
// Variables can be defined inline as well.
const ref = createAddressRef({ line1: ..., line2: ..., city: ..., state: ..., postalCode: ..., country: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createAddressRef(dataConnect, createAddressVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.address_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.address_insert);
});
```

## CreateUser
You can execute the `CreateUser` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createUser(vars: CreateUserVariables): MutationPromise<CreateUserData, CreateUserVariables>;

interface CreateUserRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateUserVariables): MutationRef<CreateUserData, CreateUserVariables>;
}
export const createUserRef: CreateUserRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createUser(dc: DataConnect, vars: CreateUserVariables): MutationPromise<CreateUserData, CreateUserVariables>;

interface CreateUserRef {
  ...
  (dc: DataConnect, vars: CreateUserVariables): MutationRef<CreateUserData, CreateUserVariables>;
}
export const createUserRef: CreateUserRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createUserRef:
```typescript
const name = createUserRef.operationName;
console.log(name);
```

### Variables
The `CreateUser` mutation requires an argument of type `CreateUserVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreateUserVariables {
  id: string;
  businessId: UUIDString;
  email: string;
  firstName: string;
  lastName: string;
  phone?: string | null;
  role: UserRole;
  permissions?: string[] | null;
}
```
### Return Type
Recall that executing the `CreateUser` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateUserData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateUserData {
  user_insert: User_Key;
}
```
### Using `CreateUser`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createUser, CreateUserVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateUser` mutation requires an argument of type `CreateUserVariables`:
const createUserVars: CreateUserVariables = {
  id: ..., 
  businessId: ..., 
  email: ..., 
  firstName: ..., 
  lastName: ..., 
  phone: ..., // optional
  role: ..., 
  permissions: ..., // optional
};

// Call the `createUser()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createUser(createUserVars);
// Variables can be defined inline as well.
const { data } = await createUser({ id: ..., businessId: ..., email: ..., firstName: ..., lastName: ..., phone: ..., role: ..., permissions: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createUser(dataConnect, createUserVars);

console.log(data.user_insert);

// Or, you can use the `Promise` API.
createUser(createUserVars).then((response) => {
  const data = response.data;
  console.log(data.user_insert);
});
```

### Using `CreateUser`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createUserRef, CreateUserVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateUser` mutation requires an argument of type `CreateUserVariables`:
const createUserVars: CreateUserVariables = {
  id: ..., 
  businessId: ..., 
  email: ..., 
  firstName: ..., 
  lastName: ..., 
  phone: ..., // optional
  role: ..., 
  permissions: ..., // optional
};

// Call the `createUserRef()` function to get a reference to the mutation.
const ref = createUserRef(createUserVars);
// Variables can be defined inline as well.
const ref = createUserRef({ id: ..., businessId: ..., email: ..., firstName: ..., lastName: ..., phone: ..., role: ..., permissions: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createUserRef(dataConnect, createUserVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.user_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.user_insert);
});
```

## CreateCustomer
You can execute the `CreateCustomer` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createCustomer(vars: CreateCustomerVariables): MutationPromise<CreateCustomerData, CreateCustomerVariables>;

interface CreateCustomerRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateCustomerVariables): MutationRef<CreateCustomerData, CreateCustomerVariables>;
}
export const createCustomerRef: CreateCustomerRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createCustomer(dc: DataConnect, vars: CreateCustomerVariables): MutationPromise<CreateCustomerData, CreateCustomerVariables>;

interface CreateCustomerRef {
  ...
  (dc: DataConnect, vars: CreateCustomerVariables): MutationRef<CreateCustomerData, CreateCustomerVariables>;
}
export const createCustomerRef: CreateCustomerRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createCustomerRef:
```typescript
const name = createCustomerRef.operationName;
console.log(name);
```

### Variables
The `CreateCustomer` mutation requires an argument of type `CreateCustomerVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreateCustomerVariables {
  businessId: UUIDString;
  firstName: string;
  lastName: string;
  email?: string | null;
  phone?: string | null;
  dateOfBirth?: DateString | null;
  createdById: string;
}
```
### Return Type
Recall that executing the `CreateCustomer` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateCustomerData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateCustomerData {
  customer_insert: Customer_Key;
}
```
### Using `CreateCustomer`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createCustomer, CreateCustomerVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateCustomer` mutation requires an argument of type `CreateCustomerVariables`:
const createCustomerVars: CreateCustomerVariables = {
  businessId: ..., 
  firstName: ..., 
  lastName: ..., 
  email: ..., // optional
  phone: ..., // optional
  dateOfBirth: ..., // optional
  createdById: ..., 
};

// Call the `createCustomer()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createCustomer(createCustomerVars);
// Variables can be defined inline as well.
const { data } = await createCustomer({ businessId: ..., firstName: ..., lastName: ..., email: ..., phone: ..., dateOfBirth: ..., createdById: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createCustomer(dataConnect, createCustomerVars);

console.log(data.customer_insert);

// Or, you can use the `Promise` API.
createCustomer(createCustomerVars).then((response) => {
  const data = response.data;
  console.log(data.customer_insert);
});
```

### Using `CreateCustomer`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createCustomerRef, CreateCustomerVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateCustomer` mutation requires an argument of type `CreateCustomerVariables`:
const createCustomerVars: CreateCustomerVariables = {
  businessId: ..., 
  firstName: ..., 
  lastName: ..., 
  email: ..., // optional
  phone: ..., // optional
  dateOfBirth: ..., // optional
  createdById: ..., 
};

// Call the `createCustomerRef()` function to get a reference to the mutation.
const ref = createCustomerRef(createCustomerVars);
// Variables can be defined inline as well.
const ref = createCustomerRef({ businessId: ..., firstName: ..., lastName: ..., email: ..., phone: ..., dateOfBirth: ..., createdById: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createCustomerRef(dataConnect, createCustomerVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.customer_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.customer_insert);
});
```

## CreateTherapeuticClass
You can execute the `CreateTherapeuticClass` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createTherapeuticClass(vars: CreateTherapeuticClassVariables): MutationPromise<CreateTherapeuticClassData, CreateTherapeuticClassVariables>;

interface CreateTherapeuticClassRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateTherapeuticClassVariables): MutationRef<CreateTherapeuticClassData, CreateTherapeuticClassVariables>;
}
export const createTherapeuticClassRef: CreateTherapeuticClassRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createTherapeuticClass(dc: DataConnect, vars: CreateTherapeuticClassVariables): MutationPromise<CreateTherapeuticClassData, CreateTherapeuticClassVariables>;

interface CreateTherapeuticClassRef {
  ...
  (dc: DataConnect, vars: CreateTherapeuticClassVariables): MutationRef<CreateTherapeuticClassData, CreateTherapeuticClassVariables>;
}
export const createTherapeuticClassRef: CreateTherapeuticClassRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createTherapeuticClassRef:
```typescript
const name = createTherapeuticClassRef.operationName;
console.log(name);
```

### Variables
The `CreateTherapeuticClass` mutation requires an argument of type `CreateTherapeuticClassVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreateTherapeuticClassVariables {
  code: string;
  name: string;
  description?: string | null;
}
```
### Return Type
Recall that executing the `CreateTherapeuticClass` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateTherapeuticClassData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateTherapeuticClassData {
  therapeuticClass_insert: TherapeuticClass_Key;
}
```
### Using `CreateTherapeuticClass`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createTherapeuticClass, CreateTherapeuticClassVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateTherapeuticClass` mutation requires an argument of type `CreateTherapeuticClassVariables`:
const createTherapeuticClassVars: CreateTherapeuticClassVariables = {
  code: ..., 
  name: ..., 
  description: ..., // optional
};

// Call the `createTherapeuticClass()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createTherapeuticClass(createTherapeuticClassVars);
// Variables can be defined inline as well.
const { data } = await createTherapeuticClass({ code: ..., name: ..., description: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createTherapeuticClass(dataConnect, createTherapeuticClassVars);

console.log(data.therapeuticClass_insert);

// Or, you can use the `Promise` API.
createTherapeuticClass(createTherapeuticClassVars).then((response) => {
  const data = response.data;
  console.log(data.therapeuticClass_insert);
});
```

### Using `CreateTherapeuticClass`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createTherapeuticClassRef, CreateTherapeuticClassVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateTherapeuticClass` mutation requires an argument of type `CreateTherapeuticClassVariables`:
const createTherapeuticClassVars: CreateTherapeuticClassVariables = {
  code: ..., 
  name: ..., 
  description: ..., // optional
};

// Call the `createTherapeuticClassRef()` function to get a reference to the mutation.
const ref = createTherapeuticClassRef(createTherapeuticClassVars);
// Variables can be defined inline as well.
const ref = createTherapeuticClassRef({ code: ..., name: ..., description: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createTherapeuticClassRef(dataConnect, createTherapeuticClassVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.therapeuticClass_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.therapeuticClass_insert);
});
```

## CreateBusiness
You can execute the `CreateBusiness` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createBusiness(vars: CreateBusinessVariables): MutationPromise<CreateBusinessData, CreateBusinessVariables>;

interface CreateBusinessRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateBusinessVariables): MutationRef<CreateBusinessData, CreateBusinessVariables>;
}
export const createBusinessRef: CreateBusinessRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createBusiness(dc: DataConnect, vars: CreateBusinessVariables): MutationPromise<CreateBusinessData, CreateBusinessVariables>;

interface CreateBusinessRef {
  ...
  (dc: DataConnect, vars: CreateBusinessVariables): MutationRef<CreateBusinessData, CreateBusinessVariables>;
}
export const createBusinessRef: CreateBusinessRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createBusinessRef:
```typescript
const name = createBusinessRef.operationName;
console.log(name);
```

### Variables
The `CreateBusiness` mutation requires an argument of type `CreateBusinessVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreateBusinessVariables {
  name: string;
  tier: BusinessTier;
  subscriptionStartDate: DateString;
  subscriptionEndDate?: DateString | null;
  maxUsers?: number | null;
  maxLocations?: number | null;
}
```
### Return Type
Recall that executing the `CreateBusiness` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateBusinessData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateBusinessData {
  business_insert: Business_Key;
}
```
### Using `CreateBusiness`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createBusiness, CreateBusinessVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateBusiness` mutation requires an argument of type `CreateBusinessVariables`:
const createBusinessVars: CreateBusinessVariables = {
  name: ..., 
  tier: ..., 
  subscriptionStartDate: ..., 
  subscriptionEndDate: ..., // optional
  maxUsers: ..., // optional
  maxLocations: ..., // optional
};

// Call the `createBusiness()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createBusiness(createBusinessVars);
// Variables can be defined inline as well.
const { data } = await createBusiness({ name: ..., tier: ..., subscriptionStartDate: ..., subscriptionEndDate: ..., maxUsers: ..., maxLocations: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createBusiness(dataConnect, createBusinessVars);

console.log(data.business_insert);

// Or, you can use the `Promise` API.
createBusiness(createBusinessVars).then((response) => {
  const data = response.data;
  console.log(data.business_insert);
});
```

### Using `CreateBusiness`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createBusinessRef, CreateBusinessVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateBusiness` mutation requires an argument of type `CreateBusinessVariables`:
const createBusinessVars: CreateBusinessVariables = {
  name: ..., 
  tier: ..., 
  subscriptionStartDate: ..., 
  subscriptionEndDate: ..., // optional
  maxUsers: ..., // optional
  maxLocations: ..., // optional
};

// Call the `createBusinessRef()` function to get a reference to the mutation.
const ref = createBusinessRef(createBusinessVars);
// Variables can be defined inline as well.
const ref = createBusinessRef({ name: ..., tier: ..., subscriptionStartDate: ..., subscriptionEndDate: ..., maxUsers: ..., maxLocations: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createBusinessRef(dataConnect, createBusinessVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.business_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.business_insert);
});
```

## CreateManufacturer
You can execute the `CreateManufacturer` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createManufacturer(vars: CreateManufacturerVariables): MutationPromise<CreateManufacturerData, CreateManufacturerVariables>;

interface CreateManufacturerRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateManufacturerVariables): MutationRef<CreateManufacturerData, CreateManufacturerVariables>;
}
export const createManufacturerRef: CreateManufacturerRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createManufacturer(dc: DataConnect, vars: CreateManufacturerVariables): MutationPromise<CreateManufacturerData, CreateManufacturerVariables>;

interface CreateManufacturerRef {
  ...
  (dc: DataConnect, vars: CreateManufacturerVariables): MutationRef<CreateManufacturerData, CreateManufacturerVariables>;
}
export const createManufacturerRef: CreateManufacturerRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createManufacturerRef:
```typescript
const name = createManufacturerRef.operationName;
console.log(name);
```

### Variables
The `CreateManufacturer` mutation requires an argument of type `CreateManufacturerVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreateManufacturerVariables {
  name: string;
  country: string;
}
```
### Return Type
Recall that executing the `CreateManufacturer` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateManufacturerData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateManufacturerData {
  manufacturer_insert: Manufacturer_Key;
}
```
### Using `CreateManufacturer`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createManufacturer, CreateManufacturerVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateManufacturer` mutation requires an argument of type `CreateManufacturerVariables`:
const createManufacturerVars: CreateManufacturerVariables = {
  name: ..., 
  country: ..., 
};

// Call the `createManufacturer()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createManufacturer(createManufacturerVars);
// Variables can be defined inline as well.
const { data } = await createManufacturer({ name: ..., country: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createManufacturer(dataConnect, createManufacturerVars);

console.log(data.manufacturer_insert);

// Or, you can use the `Promise` API.
createManufacturer(createManufacturerVars).then((response) => {
  const data = response.data;
  console.log(data.manufacturer_insert);
});
```

### Using `CreateManufacturer`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createManufacturerRef, CreateManufacturerVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateManufacturer` mutation requires an argument of type `CreateManufacturerVariables`:
const createManufacturerVars: CreateManufacturerVariables = {
  name: ..., 
  country: ..., 
};

// Call the `createManufacturerRef()` function to get a reference to the mutation.
const ref = createManufacturerRef(createManufacturerVars);
// Variables can be defined inline as well.
const ref = createManufacturerRef({ name: ..., country: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createManufacturerRef(dataConnect, createManufacturerVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.manufacturer_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.manufacturer_insert);
});
```

## CreateLocation
You can execute the `CreateLocation` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createLocation(vars: CreateLocationVariables): MutationPromise<CreateLocationData, CreateLocationVariables>;

interface CreateLocationRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateLocationVariables): MutationRef<CreateLocationData, CreateLocationVariables>;
}
export const createLocationRef: CreateLocationRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createLocation(dc: DataConnect, vars: CreateLocationVariables): MutationPromise<CreateLocationData, CreateLocationVariables>;

interface CreateLocationRef {
  ...
  (dc: DataConnect, vars: CreateLocationVariables): MutationRef<CreateLocationData, CreateLocationVariables>;
}
export const createLocationRef: CreateLocationRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createLocationRef:
```typescript
const name = createLocationRef.operationName;
console.log(name);
```

### Variables
The `CreateLocation` mutation requires an argument of type `CreateLocationVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreateLocationVariables {
  businessId: UUIDString;
  name: string;
  code: string;
  type: LocationType;
  phone?: string | null;
  email?: string | null;
  operatingHours?: string | null;
  licenseNumber?: string | null;
}
```
### Return Type
Recall that executing the `CreateLocation` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateLocationData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateLocationData {
  location_insert: Location_Key;
}
```
### Using `CreateLocation`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createLocation, CreateLocationVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateLocation` mutation requires an argument of type `CreateLocationVariables`:
const createLocationVars: CreateLocationVariables = {
  businessId: ..., 
  name: ..., 
  code: ..., 
  type: ..., 
  phone: ..., // optional
  email: ..., // optional
  operatingHours: ..., // optional
  licenseNumber: ..., // optional
};

// Call the `createLocation()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createLocation(createLocationVars);
// Variables can be defined inline as well.
const { data } = await createLocation({ businessId: ..., name: ..., code: ..., type: ..., phone: ..., email: ..., operatingHours: ..., licenseNumber: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createLocation(dataConnect, createLocationVars);

console.log(data.location_insert);

// Or, you can use the `Promise` API.
createLocation(createLocationVars).then((response) => {
  const data = response.data;
  console.log(data.location_insert);
});
```

### Using `CreateLocation`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createLocationRef, CreateLocationVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateLocation` mutation requires an argument of type `CreateLocationVariables`:
const createLocationVars: CreateLocationVariables = {
  businessId: ..., 
  name: ..., 
  code: ..., 
  type: ..., 
  phone: ..., // optional
  email: ..., // optional
  operatingHours: ..., // optional
  licenseNumber: ..., // optional
};

// Call the `createLocationRef()` function to get a reference to the mutation.
const ref = createLocationRef(createLocationVars);
// Variables can be defined inline as well.
const ref = createLocationRef({ businessId: ..., name: ..., code: ..., type: ..., phone: ..., email: ..., operatingHours: ..., licenseNumber: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createLocationRef(dataConnect, createLocationVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.location_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.location_insert);
});
```

## CreateGoodsReceipt
You can execute the `CreateGoodsReceipt` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createGoodsReceipt(vars: CreateGoodsReceiptVariables): MutationPromise<CreateGoodsReceiptData, CreateGoodsReceiptVariables>;

interface CreateGoodsReceiptRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateGoodsReceiptVariables): MutationRef<CreateGoodsReceiptData, CreateGoodsReceiptVariables>;
}
export const createGoodsReceiptRef: CreateGoodsReceiptRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createGoodsReceipt(dc: DataConnect, vars: CreateGoodsReceiptVariables): MutationPromise<CreateGoodsReceiptData, CreateGoodsReceiptVariables>;

interface CreateGoodsReceiptRef {
  ...
  (dc: DataConnect, vars: CreateGoodsReceiptVariables): MutationRef<CreateGoodsReceiptData, CreateGoodsReceiptVariables>;
}
export const createGoodsReceiptRef: CreateGoodsReceiptRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createGoodsReceiptRef:
```typescript
const name = createGoodsReceiptRef.operationName;
console.log(name);
```

### Variables
The `CreateGoodsReceipt` mutation requires an argument of type `CreateGoodsReceiptVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreateGoodsReceiptVariables {
  purchaseOrderId: UUIDString;
  businessId: UUIDString;
  receiptNumber: string;
  receiptDate?: TimestampString | null;
  status: GoodsReceiptStatus;
  inspectedById: string;
}
```
### Return Type
Recall that executing the `CreateGoodsReceipt` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateGoodsReceiptData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateGoodsReceiptData {
  goodsReceipt_insert: GoodsReceipt_Key;
}
```
### Using `CreateGoodsReceipt`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createGoodsReceipt, CreateGoodsReceiptVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateGoodsReceipt` mutation requires an argument of type `CreateGoodsReceiptVariables`:
const createGoodsReceiptVars: CreateGoodsReceiptVariables = {
  purchaseOrderId: ..., 
  businessId: ..., 
  receiptNumber: ..., 
  receiptDate: ..., // optional
  status: ..., 
  inspectedById: ..., 
};

// Call the `createGoodsReceipt()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createGoodsReceipt(createGoodsReceiptVars);
// Variables can be defined inline as well.
const { data } = await createGoodsReceipt({ purchaseOrderId: ..., businessId: ..., receiptNumber: ..., receiptDate: ..., status: ..., inspectedById: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createGoodsReceipt(dataConnect, createGoodsReceiptVars);

console.log(data.goodsReceipt_insert);

// Or, you can use the `Promise` API.
createGoodsReceipt(createGoodsReceiptVars).then((response) => {
  const data = response.data;
  console.log(data.goodsReceipt_insert);
});
```

### Using `CreateGoodsReceipt`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createGoodsReceiptRef, CreateGoodsReceiptVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateGoodsReceipt` mutation requires an argument of type `CreateGoodsReceiptVariables`:
const createGoodsReceiptVars: CreateGoodsReceiptVariables = {
  purchaseOrderId: ..., 
  businessId: ..., 
  receiptNumber: ..., 
  receiptDate: ..., // optional
  status: ..., 
  inspectedById: ..., 
};

// Call the `createGoodsReceiptRef()` function to get a reference to the mutation.
const ref = createGoodsReceiptRef(createGoodsReceiptVars);
// Variables can be defined inline as well.
const ref = createGoodsReceiptRef({ purchaseOrderId: ..., businessId: ..., receiptNumber: ..., receiptDate: ..., status: ..., inspectedById: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createGoodsReceiptRef(dataConnect, createGoodsReceiptVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.goodsReceipt_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.goodsReceipt_insert);
});
```

## CreateInventoryLevel
You can execute the `CreateInventoryLevel` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createInventoryLevel(vars: CreateInventoryLevelVariables): MutationPromise<CreateInventoryLevelData, CreateInventoryLevelVariables>;

interface CreateInventoryLevelRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateInventoryLevelVariables): MutationRef<CreateInventoryLevelData, CreateInventoryLevelVariables>;
}
export const createInventoryLevelRef: CreateInventoryLevelRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createInventoryLevel(dc: DataConnect, vars: CreateInventoryLevelVariables): MutationPromise<CreateInventoryLevelData, CreateInventoryLevelVariables>;

interface CreateInventoryLevelRef {
  ...
  (dc: DataConnect, vars: CreateInventoryLevelVariables): MutationRef<CreateInventoryLevelData, CreateInventoryLevelVariables>;
}
export const createInventoryLevelRef: CreateInventoryLevelRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createInventoryLevelRef:
```typescript
const name = createInventoryLevelRef.operationName;
console.log(name);
```

### Variables
The `CreateInventoryLevel` mutation requires an argument of type `CreateInventoryLevelVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreateInventoryLevelVariables {
  productId: UUIDString;
  locationId: UUIDString;
  businessId: UUIDString;
  batchId?: UUIDString | null;
  quantityOnHand: number;
  quantityAvailable: number;
  averageCost: number;
  totalValue: number;
}
```
### Return Type
Recall that executing the `CreateInventoryLevel` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateInventoryLevelData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateInventoryLevelData {
  inventoryLevel_insert: InventoryLevel_Key;
}
```
### Using `CreateInventoryLevel`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createInventoryLevel, CreateInventoryLevelVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateInventoryLevel` mutation requires an argument of type `CreateInventoryLevelVariables`:
const createInventoryLevelVars: CreateInventoryLevelVariables = {
  productId: ..., 
  locationId: ..., 
  businessId: ..., 
  batchId: ..., // optional
  quantityOnHand: ..., 
  quantityAvailable: ..., 
  averageCost: ..., 
  totalValue: ..., 
};

// Call the `createInventoryLevel()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createInventoryLevel(createInventoryLevelVars);
// Variables can be defined inline as well.
const { data } = await createInventoryLevel({ productId: ..., locationId: ..., businessId: ..., batchId: ..., quantityOnHand: ..., quantityAvailable: ..., averageCost: ..., totalValue: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createInventoryLevel(dataConnect, createInventoryLevelVars);

console.log(data.inventoryLevel_insert);

// Or, you can use the `Promise` API.
createInventoryLevel(createInventoryLevelVars).then((response) => {
  const data = response.data;
  console.log(data.inventoryLevel_insert);
});
```

### Using `CreateInventoryLevel`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createInventoryLevelRef, CreateInventoryLevelVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateInventoryLevel` mutation requires an argument of type `CreateInventoryLevelVariables`:
const createInventoryLevelVars: CreateInventoryLevelVariables = {
  productId: ..., 
  locationId: ..., 
  businessId: ..., 
  batchId: ..., // optional
  quantityOnHand: ..., 
  quantityAvailable: ..., 
  averageCost: ..., 
  totalValue: ..., 
};

// Call the `createInventoryLevelRef()` function to get a reference to the mutation.
const ref = createInventoryLevelRef(createInventoryLevelVars);
// Variables can be defined inline as well.
const ref = createInventoryLevelRef({ productId: ..., locationId: ..., businessId: ..., batchId: ..., quantityOnHand: ..., quantityAvailable: ..., averageCost: ..., totalValue: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createInventoryLevelRef(dataConnect, createInventoryLevelVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.inventoryLevel_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.inventoryLevel_insert);
});
```

## CreateProduct
You can execute the `CreateProduct` mutation using the following action shortcut function, or by calling `executeMutation()` after calling the following `MutationRef` function, both of which are defined in [dataconnect-generated/index.d.ts](./index.d.ts):
```typescript
createProduct(vars: CreateProductVariables): MutationPromise<CreateProductData, CreateProductVariables>;

interface CreateProductRef {
  ...
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateProductVariables): MutationRef<CreateProductData, CreateProductVariables>;
}
export const createProductRef: CreateProductRef;
```
You can also pass in a `DataConnect` instance to the action shortcut function or `MutationRef` function.
```typescript
createProduct(dc: DataConnect, vars: CreateProductVariables): MutationPromise<CreateProductData, CreateProductVariables>;

interface CreateProductRef {
  ...
  (dc: DataConnect, vars: CreateProductVariables): MutationRef<CreateProductData, CreateProductVariables>;
}
export const createProductRef: CreateProductRef;
```

If you need the name of the operation without creating a ref, you can retrieve the operation name by calling the `operationName` property on the createProductRef:
```typescript
const name = createProductRef.operationName;
console.log(name);
```

### Variables
The `CreateProduct` mutation requires an argument of type `CreateProductVariables`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:

```typescript
export interface CreateProductVariables {
  businessId: UUIDString;
  genericName: string;
  brandName?: string | null;
  manufacturerId: UUIDString;
  nationalDrugCode?: string | null;
  barcode?: string | null;
  internalSKU: string;
  dosageForm: DosageForm;
  strength: string;
  unit: string;
  routeOfAdministration: RouteOfAdministration;
  drugSchedule: DrugSchedule;
  requiresPrescription: boolean;
  therapeuticClassId: UUIDString;
  packageSize: number;
  packageUnit: PackageUnit;
  primarySupplierId: UUIDString;
  leadTimeDays: number;
  reorderPoint: number;
  reorderQuantity: number;
  minimumStockLevel: number;
  category: ProductCategory;
  createdById: string;
  updatedById: string;
}
```
### Return Type
Recall that executing the `CreateProduct` mutation returns a `MutationPromise` that resolves to an object with a `data` property.

The `data` property is an object of type `CreateProductData`, which is defined in [dataconnect-generated/index.d.ts](./index.d.ts). It has the following fields:
```typescript
export interface CreateProductData {
  product_insert: Product_Key;
}
```
### Using `CreateProduct`'s action shortcut function

```typescript
import { getDataConnect } from 'firebase/data-connect';
import { connectorConfig, createProduct, CreateProductVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateProduct` mutation requires an argument of type `CreateProductVariables`:
const createProductVars: CreateProductVariables = {
  businessId: ..., 
  genericName: ..., 
  brandName: ..., // optional
  manufacturerId: ..., 
  nationalDrugCode: ..., // optional
  barcode: ..., // optional
  internalSKU: ..., 
  dosageForm: ..., 
  strength: ..., 
  unit: ..., 
  routeOfAdministration: ..., 
  drugSchedule: ..., 
  requiresPrescription: ..., 
  therapeuticClassId: ..., 
  packageSize: ..., 
  packageUnit: ..., 
  primarySupplierId: ..., 
  leadTimeDays: ..., 
  reorderPoint: ..., 
  reorderQuantity: ..., 
  minimumStockLevel: ..., 
  category: ..., 
  createdById: ..., 
  updatedById: ..., 
};

// Call the `createProduct()` function to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await createProduct(createProductVars);
// Variables can be defined inline as well.
const { data } = await createProduct({ businessId: ..., genericName: ..., brandName: ..., manufacturerId: ..., nationalDrugCode: ..., barcode: ..., internalSKU: ..., dosageForm: ..., strength: ..., unit: ..., routeOfAdministration: ..., drugSchedule: ..., requiresPrescription: ..., therapeuticClassId: ..., packageSize: ..., packageUnit: ..., primarySupplierId: ..., leadTimeDays: ..., reorderPoint: ..., reorderQuantity: ..., minimumStockLevel: ..., category: ..., createdById: ..., updatedById: ..., });

// You can also pass in a `DataConnect` instance to the action shortcut function.
const dataConnect = getDataConnect(connectorConfig);
const { data } = await createProduct(dataConnect, createProductVars);

console.log(data.product_insert);

// Or, you can use the `Promise` API.
createProduct(createProductVars).then((response) => {
  const data = response.data;
  console.log(data.product_insert);
});
```

### Using `CreateProduct`'s `MutationRef` function

```typescript
import { getDataConnect, executeMutation } from 'firebase/data-connect';
import { connectorConfig, createProductRef, CreateProductVariables } from '@firebasegen/ik-pharma-connector/generated';

// The `CreateProduct` mutation requires an argument of type `CreateProductVariables`:
const createProductVars: CreateProductVariables = {
  businessId: ..., 
  genericName: ..., 
  brandName: ..., // optional
  manufacturerId: ..., 
  nationalDrugCode: ..., // optional
  barcode: ..., // optional
  internalSKU: ..., 
  dosageForm: ..., 
  strength: ..., 
  unit: ..., 
  routeOfAdministration: ..., 
  drugSchedule: ..., 
  requiresPrescription: ..., 
  therapeuticClassId: ..., 
  packageSize: ..., 
  packageUnit: ..., 
  primarySupplierId: ..., 
  leadTimeDays: ..., 
  reorderPoint: ..., 
  reorderQuantity: ..., 
  minimumStockLevel: ..., 
  category: ..., 
  createdById: ..., 
  updatedById: ..., 
};

// Call the `createProductRef()` function to get a reference to the mutation.
const ref = createProductRef(createProductVars);
// Variables can be defined inline as well.
const ref = createProductRef({ businessId: ..., genericName: ..., brandName: ..., manufacturerId: ..., nationalDrugCode: ..., barcode: ..., internalSKU: ..., dosageForm: ..., strength: ..., unit: ..., routeOfAdministration: ..., drugSchedule: ..., requiresPrescription: ..., therapeuticClassId: ..., packageSize: ..., packageUnit: ..., primarySupplierId: ..., leadTimeDays: ..., reorderPoint: ..., reorderQuantity: ..., minimumStockLevel: ..., category: ..., createdById: ..., updatedById: ..., });

// You can also pass in a `DataConnect` instance to the `MutationRef` function.
const dataConnect = getDataConnect(connectorConfig);
const ref = createProductRef(dataConnect, createProductVars);

// Call `executeMutation()` on the reference to execute the mutation.
// You can use the `await` keyword to wait for the promise to resolve.
const { data } = await executeMutation(ref);

console.log(data.product_insert);

// Or, you can use the `Promise` API.
executeMutation(ref).then((response) => {
  const data = response.data;
  console.log(data.product_insert);
});
```

