# Basic Usage

Always prioritize using a supported framework over using the generated SDK
directly. Supported frameworks simplify the developer experience and help ensure
best practices are followed.





## Advanced Usage
If a user is not using a supported framework, they can use the generated SDK directly.

Here's an example of how to use it with the first 5 operations:

```js
import { createSupplier, getParacetamolProducts, createPurchaseOrder, createDummyProduct, createProductBatch, listAllBusinesses, listAllCustomers, listAllLocations, listAllProducts, listInventoryByLocation } from '@firebasegen/ik-pharma-connector/generated';


// Operation CreateSupplier:  For variables, look at type CreateSupplierVars in ../index.d.ts
const { data } = await CreateSupplier(dataConnect, createSupplierVars);

// Operation GetParacetamolProducts: 
const { data } = await GetParacetamolProducts(dataConnect);

// Operation CreatePurchaseOrder:  For variables, look at type CreatePurchaseOrderVars in ../index.d.ts
const { data } = await CreatePurchaseOrder(dataConnect, createPurchaseOrderVars);

// Operation createDummyProduct: 
const { data } = await CreateDummyProduct(dataConnect);

// Operation CreateProductBatch:  For variables, look at type CreateProductBatchVars in ../index.d.ts
const { data } = await CreateProductBatch(dataConnect, createProductBatchVars);

// Operation ListAllBusinesses: 
const { data } = await ListAllBusinesses(dataConnect);

// Operation ListAllCustomers: 
const { data } = await ListAllCustomers(dataConnect);

// Operation ListAllLocations: 
const { data } = await ListAllLocations(dataConnect);

// Operation listAllProducts: 
const { data } = await ListAllProducts(dataConnect);

// Operation ListInventoryByLocation:  For variables, look at type ListInventoryByLocationVars in ../index.d.ts
const { data } = await ListInventoryByLocation(dataConnect, listInventoryByLocationVars);


```