const { queryRef, executeQuery, mutationRef, executeMutation, validateArgs } = require('firebase/data-connect');

const BusinessTier = {
  TRIAL: "TRIAL",
  PAID: "PAID",
  ENTERPRISE: "ENTERPRISE",
}
exports.BusinessTier = BusinessTier;

const CustomerTier = {
  WALK_IN: "WALK_IN",
  BRONZE: "BRONZE",
  SILVER: "SILVER",
  GOLD: "GOLD",
  DIAMOND: "DIAMOND",
  PLATINUM: "PLATINUM",
}
exports.CustomerTier = CustomerTier;

const DosageForm = {
  TABLET: "TABLET",
  CAPSULE: "CAPSULE",
  SYRUP: "SYRUP",
  SUSPENSION: "SUSPENSION",
  INJECTION: "INJECTION",
  CREAM: "CREAM",
  OINTMENT: "OINTMENT",
  LOTION: "LOTION",
  GEL: "GEL",
  DROPS: "DROPS",
  INHALER: "INHALER",
  PATCH: "PATCH",
  SUPPOSITORY: "SUPPOSITORY",
  POWDER: "POWDER",
  SOLUTION: "SOLUTION",
  OTHER: "OTHER",
}
exports.DosageForm = DosageForm;

const DrugSchedule = {
  PRESCRIPTION_ONLY: "PRESCRIPTION_ONLY",
  OVER_THE_COUNTER: "OVER_THE_COUNTER",
  BEHIND_THE_COUNTER: "BEHIND_THE_COUNTER",
  CONTROLLED_SUBSTANCE: "CONTROLLED_SUBSTANCE",
  INVESTIGATIONAL: "INVESTIGATIONAL",
}
exports.DrugSchedule = DrugSchedule;

const GoodsReceiptStatus = {
  PENDING: "PENDING",
  RECEIVED: "RECEIVED",
  INSPECTED: "INSPECTED",
  ACCEPTED: "ACCEPTED",
  REJECTED: "REJECTED",
}
exports.GoodsReceiptStatus = GoodsReceiptStatus;

const LocationType = {
  HEAD_OFFICE: "HEAD_OFFICE",
  REGIONAL_WAREHOUSE: "REGIONAL_WAREHOUSE",
  RETAIL_STORE: "RETAIL_STORE",
  DISTRIBUTION_CENTER: "DISTRIBUTION_CENTER",
}
exports.LocationType = LocationType;

const PackageUnit = {
  BOTTLE: "BOTTLE",
  BOX: "BOX",
  BLISTER_PACK: "BLISTER_PACK",
  VIAL: "VIAL",
  AMPULE: "AMPULE",
  TUBE: "TUBE",
  JAR: "JAR",
  POUCH: "POUCH",
  STRIP: "STRIP",
  OTHER: "OTHER",
}
exports.PackageUnit = PackageUnit;

const ProductCategory = {
  PHARMACEUTICAL: "PHARMACEUTICAL",
  OTC_MEDICINE: "OTC_MEDICINE",
  MEDICAL_DEVICE: "MEDICAL_DEVICE",
  SUPPLEMENT: "SUPPLEMENT",
  PERSONAL_CARE: "PERSONAL_CARE",
  OTHER: "OTHER",
}
exports.ProductCategory = ProductCategory;

const ProductSubcategory = {
  ANALGESICS: "ANALGESICS",
  ANTIBIOTICS: "ANTIBIOTICS",
  CARDIOVASCULAR: "CARDIOVASCULAR",
  DIABETES: "DIABETES",
  DERMATOLOGY: "DERMATOLOGY",
  GASTROINTESTINAL: "GASTROINTESTINAL",
  NEUROLOGY: "NEUROLOGY",
  ONCOLOGY: "ONCOLOGY",
  OPHTHALMOLOGY: "OPHTHALMOLOGY",
  PEDIATRICS: "PEDIATRICS",
  PSYCHIATRY: "PSYCHIATRY",
  RESPIRATORY: "RESPIRATORY",
  UROLOGY: "UROLOGY",
  VITAMINS: "VITAMINS",
  MINERALS: "MINERALS",
  HERBALS: "HERBALS",
  COSMETICS: "COSMETICS",
  SKIN_CARE: "SKIN_CARE",
  HAIR_CARE: "HAIR_CARE",
  ORAL_CARE: "ORAL_CARE",
  OTHER: "OTHER",
}
exports.ProductSubcategory = ProductSubcategory;

const PurchaseOrderStatus = {
  DRAFT: "DRAFT",
  PENDING_APPROVAL: "PENDING_APPROVAL",
  APPROVED: "APPROVED",
  ORDERED: "ORDERED",
  PARTIALLY_RECEIVED: "PARTIALLY_RECEIVED",
  RECEIVED: "RECEIVED",
  CANCELLED: "CANCELLED",
}
exports.PurchaseOrderStatus = PurchaseOrderStatus;

const RouteOfAdministration = {
  ORAL: "ORAL",
  TOPICAL: "TOPICAL",
  INTRAVENOUS: "INTRAVENOUS",
  INTRAMUSCULAR: "INTRAMUSCULAR",
  SUBCUTANEOUS: "SUBCUTANEOUS",
  INHALATION: "INHALATION",
  RECTAL: "RECTAL",
  VAGINAL: "VAGINAL",
  OPHTHALMIC: "OPHTHALMIC",
  OTIC: "OTIC",
  NASAL: "NASAL",
  TRANSDERMAL: "TRANSDERMAL",
  OTHER: "OTHER",
}
exports.RouteOfAdministration = RouteOfAdministration;

const SupplierTier = {
  PREFERRED: "PREFERRED",
  STANDARD: "STANDARD",
  BACKUP: "BACKUP",
  TRIAL: "TRIAL",
}
exports.SupplierTier = SupplierTier;

const SupplierType = {
  MANUFACTURER: "MANUFACTURER",
  DISTRIBUTOR: "DISTRIBUTOR",
  WHOLESALER: "WHOLESALER",
  IMPORTER: "IMPORTER",
}
exports.SupplierType = SupplierType;

const UserRole = {
  SUPER_ADMIN: "SUPER_ADMIN",
  ADMIN: "ADMIN",
  MANAGER: "MANAGER",
  PHARMACIST: "PHARMACIST",
  PHARMACY_TECH: "PHARMACY_TECH",
  CASHIER: "CASHIER",
  INVENTORY_CLERK: "INVENTORY_CLERK",
}
exports.UserRole = UserRole;

const connectorConfig = {
  connector: 'ik_pharma',
  service: 'ikpharma-dev-database',
  location: 'asia-south1'
};
exports.connectorConfig = connectorConfig;

const createSupplierRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateSupplier', inputVars);
}
createSupplierRef.operationName = 'CreateSupplier';
exports.createSupplierRef = createSupplierRef;

exports.createSupplier = function createSupplier(dcOrVars, vars) {
  return executeMutation(createSupplierRef(dcOrVars, vars));
};

const getParacetamolProductsRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetParacetamolProducts');
}
getParacetamolProductsRef.operationName = 'GetParacetamolProducts';
exports.getParacetamolProductsRef = getParacetamolProductsRef;

exports.getParacetamolProducts = function getParacetamolProducts(dc) {
  return executeQuery(getParacetamolProductsRef(dc));
};

const createPurchaseOrderRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreatePurchaseOrder', inputVars);
}
createPurchaseOrderRef.operationName = 'CreatePurchaseOrder';
exports.createPurchaseOrderRef = createPurchaseOrderRef;

exports.createPurchaseOrder = function createPurchaseOrder(dcOrVars, vars) {
  return executeMutation(createPurchaseOrderRef(dcOrVars, vars));
};

const createDummyProductRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'createDummyProduct');
}
createDummyProductRef.operationName = 'createDummyProduct';
exports.createDummyProductRef = createDummyProductRef;

exports.createDummyProduct = function createDummyProduct(dc) {
  return executeMutation(createDummyProductRef(dc));
};

const createProductBatchRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateProductBatch', inputVars);
}
createProductBatchRef.operationName = 'CreateProductBatch';
exports.createProductBatchRef = createProductBatchRef;

exports.createProductBatch = function createProductBatch(dcOrVars, vars) {
  return executeMutation(createProductBatchRef(dcOrVars, vars));
};

const listAllBusinessesRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListAllBusinesses');
}
listAllBusinessesRef.operationName = 'ListAllBusinesses';
exports.listAllBusinessesRef = listAllBusinessesRef;

exports.listAllBusinesses = function listAllBusinesses(dc) {
  return executeQuery(listAllBusinessesRef(dc));
};

const listAllCustomersRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListAllCustomers');
}
listAllCustomersRef.operationName = 'ListAllCustomers';
exports.listAllCustomersRef = listAllCustomersRef;

exports.listAllCustomers = function listAllCustomers(dc) {
  return executeQuery(listAllCustomersRef(dc));
};

const listAllLocationsRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListAllLocations');
}
listAllLocationsRef.operationName = 'ListAllLocations';
exports.listAllLocationsRef = listAllLocationsRef;

exports.listAllLocations = function listAllLocations(dc) {
  return executeQuery(listAllLocationsRef(dc));
};

const listAllProductsRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'listAllProducts');
}
listAllProductsRef.operationName = 'listAllProducts';
exports.listAllProductsRef = listAllProductsRef;

exports.listAllProducts = function listAllProducts(dc) {
  return executeQuery(listAllProductsRef(dc));
};

const listInventoryByLocationRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListInventoryByLocation', inputVars);
}
listInventoryByLocationRef.operationName = 'ListInventoryByLocation';
exports.listInventoryByLocationRef = listInventoryByLocationRef;

exports.listInventoryByLocation = function listInventoryByLocation(dcOrVars, vars) {
  return executeQuery(listInventoryByLocationRef(dcOrVars, vars));
};

const createProductPricingRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateProductPricing', inputVars);
}
createProductPricingRef.operationName = 'CreateProductPricing';
exports.createProductPricingRef = createProductPricingRef;

exports.createProductPricing = function createProductPricing(dcOrVars, vars) {
  return executeMutation(createProductPricingRef(dcOrVars, vars));
};

const verifyProductRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'VerifyProduct');
}
verifyProductRef.operationName = 'VerifyProduct';
exports.verifyProductRef = verifyProductRef;

exports.verifyProduct = function verifyProduct(dc) {
  return executeQuery(verifyProductRef(dc));
};

const getBusinessByIdRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetBusinessById', inputVars);
}
getBusinessByIdRef.operationName = 'GetBusinessById';
exports.getBusinessByIdRef = getBusinessByIdRef;

exports.getBusinessById = function getBusinessById(dcOrVars, vars) {
  return executeQuery(getBusinessByIdRef(dcOrVars, vars));
};

const listLocationsByBusinessRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListLocationsByBusiness', inputVars);
}
listLocationsByBusinessRef.operationName = 'ListLocationsByBusiness';
exports.listLocationsByBusinessRef = listLocationsByBusinessRef;

exports.listLocationsByBusiness = function listLocationsByBusiness(dcOrVars, vars) {
  return executeQuery(listLocationsByBusinessRef(dcOrVars, vars));
};

const listProductsByBusinessRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListProductsByBusiness', inputVars);
}
listProductsByBusinessRef.operationName = 'ListProductsByBusiness';
exports.listProductsByBusinessRef = listProductsByBusinessRef;

exports.listProductsByBusiness = function listProductsByBusiness(dcOrVars, vars) {
  return executeQuery(listProductsByBusinessRef(dcOrVars, vars));
};

const listAllSuppliersRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListAllSuppliers');
}
listAllSuppliersRef.operationName = 'ListAllSuppliers';
exports.listAllSuppliersRef = listAllSuppliersRef;

exports.listAllSuppliers = function listAllSuppliers(dc) {
  return executeQuery(listAllSuppliersRef(dc));
};

const seedDataRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'SeedData');
}
seedDataRef.operationName = 'SeedData';
exports.seedDataRef = seedDataRef;

exports.seedData = function seedData(dc) {
  return executeMutation(seedDataRef(dc));
};

const createAddressRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateAddress', inputVars);
}
createAddressRef.operationName = 'CreateAddress';
exports.createAddressRef = createAddressRef;

exports.createAddress = function createAddress(dcOrVars, vars) {
  return executeMutation(createAddressRef(dcOrVars, vars));
};

const createUserRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateUser', inputVars);
}
createUserRef.operationName = 'CreateUser';
exports.createUserRef = createUserRef;

exports.createUser = function createUser(dcOrVars, vars) {
  return executeMutation(createUserRef(dcOrVars, vars));
};

const createCustomerRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateCustomer', inputVars);
}
createCustomerRef.operationName = 'CreateCustomer';
exports.createCustomerRef = createCustomerRef;

exports.createCustomer = function createCustomer(dcOrVars, vars) {
  return executeMutation(createCustomerRef(dcOrVars, vars));
};

const createTherapeuticClassRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateTherapeuticClass', inputVars);
}
createTherapeuticClassRef.operationName = 'CreateTherapeuticClass';
exports.createTherapeuticClassRef = createTherapeuticClassRef;

exports.createTherapeuticClass = function createTherapeuticClass(dcOrVars, vars) {
  return executeMutation(createTherapeuticClassRef(dcOrVars, vars));
};

const listPricingByLocationRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListPricingByLocation', inputVars);
}
listPricingByLocationRef.operationName = 'ListPricingByLocation';
exports.listPricingByLocationRef = listPricingByLocationRef;

exports.listPricingByLocation = function listPricingByLocation(dcOrVars, vars) {
  return executeQuery(listPricingByLocationRef(dcOrVars, vars));
};

const createBusinessRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateBusiness', inputVars);
}
createBusinessRef.operationName = 'CreateBusiness';
exports.createBusinessRef = createBusinessRef;

exports.createBusiness = function createBusiness(dcOrVars, vars) {
  return executeMutation(createBusinessRef(dcOrVars, vars));
};

const createManufacturerRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateManufacturer', inputVars);
}
createManufacturerRef.operationName = 'CreateManufacturer';
exports.createManufacturerRef = createManufacturerRef;

exports.createManufacturer = function createManufacturer(dcOrVars, vars) {
  return executeMutation(createManufacturerRef(dcOrVars, vars));
};

const createLocationRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateLocation', inputVars);
}
createLocationRef.operationName = 'CreateLocation';
exports.createLocationRef = createLocationRef;

exports.createLocation = function createLocation(dcOrVars, vars) {
  return executeMutation(createLocationRef(dcOrVars, vars));
};

const createGoodsReceiptRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateGoodsReceipt', inputVars);
}
createGoodsReceiptRef.operationName = 'CreateGoodsReceipt';
exports.createGoodsReceiptRef = createGoodsReceiptRef;

exports.createGoodsReceipt = function createGoodsReceipt(dcOrVars, vars) {
  return executeMutation(createGoodsReceiptRef(dcOrVars, vars));
};

const createInventoryLevelRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateInventoryLevel', inputVars);
}
createInventoryLevelRef.operationName = 'CreateInventoryLevel';
exports.createInventoryLevelRef = createInventoryLevelRef;

exports.createInventoryLevel = function createInventoryLevel(dcOrVars, vars) {
  return executeMutation(createInventoryLevelRef(dcOrVars, vars));
};

const createProductRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateProduct', inputVars);
}
createProductRef.operationName = 'CreateProduct';
exports.createProductRef = createProductRef;

exports.createProduct = function createProduct(dcOrVars, vars) {
  return executeMutation(createProductRef(dcOrVars, vars));
};
