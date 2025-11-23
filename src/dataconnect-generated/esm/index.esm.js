import { queryRef, executeQuery, mutationRef, executeMutation, validateArgs } from 'firebase/data-connect';

export const BusinessTier = {
  TRIAL: "TRIAL",
  PAID: "PAID",
  ENTERPRISE: "ENTERPRISE",
}

export const CustomerTier = {
  WALK_IN: "WALK_IN",
  BRONZE: "BRONZE",
  SILVER: "SILVER",
  GOLD: "GOLD",
  DIAMOND: "DIAMOND",
  PLATINUM: "PLATINUM",
}

export const DosageForm = {
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

export const DrugSchedule = {
  PRESCRIPTION_ONLY: "PRESCRIPTION_ONLY",
  OVER_THE_COUNTER: "OVER_THE_COUNTER",
  BEHIND_THE_COUNTER: "BEHIND_THE_COUNTER",
  CONTROLLED_SUBSTANCE: "CONTROLLED_SUBSTANCE",
  INVESTIGATIONAL: "INVESTIGATIONAL",
}

export const GoodsReceiptStatus = {
  PENDING: "PENDING",
  RECEIVED: "RECEIVED",
  INSPECTED: "INSPECTED",
  ACCEPTED: "ACCEPTED",
  REJECTED: "REJECTED",
}

export const LocationType = {
  HEAD_OFFICE: "HEAD_OFFICE",
  REGIONAL_WAREHOUSE: "REGIONAL_WAREHOUSE",
  RETAIL_STORE: "RETAIL_STORE",
  DISTRIBUTION_CENTER: "DISTRIBUTION_CENTER",
}

export const PackageUnit = {
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

export const ProductCategory = {
  PHARMACEUTICAL: "PHARMACEUTICAL",
  OTC_MEDICINE: "OTC_MEDICINE",
  MEDICAL_DEVICE: "MEDICAL_DEVICE",
  SUPPLEMENT: "SUPPLEMENT",
  PERSONAL_CARE: "PERSONAL_CARE",
  OTHER: "OTHER",
}

export const ProductSubcategory = {
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

export const PurchaseOrderStatus = {
  DRAFT: "DRAFT",
  PENDING_APPROVAL: "PENDING_APPROVAL",
  APPROVED: "APPROVED",
  ORDERED: "ORDERED",
  PARTIALLY_RECEIVED: "PARTIALLY_RECEIVED",
  RECEIVED: "RECEIVED",
  CANCELLED: "CANCELLED",
}

export const RouteOfAdministration = {
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

export const SupplierTier = {
  PREFERRED: "PREFERRED",
  STANDARD: "STANDARD",
  BACKUP: "BACKUP",
  TRIAL: "TRIAL",
}

export const SupplierType = {
  MANUFACTURER: "MANUFACTURER",
  DISTRIBUTOR: "DISTRIBUTOR",
  WHOLESALER: "WHOLESALER",
  IMPORTER: "IMPORTER",
}

export const UserRole = {
  SUPER_ADMIN: "SUPER_ADMIN",
  ADMIN: "ADMIN",
  MANAGER: "MANAGER",
  PHARMACIST: "PHARMACIST",
  PHARMACY_TECH: "PHARMACY_TECH",
  CASHIER: "CASHIER",
  INVENTORY_CLERK: "INVENTORY_CLERK",
}

export const connectorConfig = {
  connector: 'ik_pharma',
  service: 'ikpharma-dev-database',
  location: 'asia-south1'
};

export const createSupplierRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateSupplier', inputVars);
}
createSupplierRef.operationName = 'CreateSupplier';

export function createSupplier(dcOrVars, vars) {
  return executeMutation(createSupplierRef(dcOrVars, vars));
}

export const getParacetamolProductsRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetParacetamolProducts');
}
getParacetamolProductsRef.operationName = 'GetParacetamolProducts';

export function getParacetamolProducts(dc) {
  return executeQuery(getParacetamolProductsRef(dc));
}

export const createPurchaseOrderRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreatePurchaseOrder', inputVars);
}
createPurchaseOrderRef.operationName = 'CreatePurchaseOrder';

export function createPurchaseOrder(dcOrVars, vars) {
  return executeMutation(createPurchaseOrderRef(dcOrVars, vars));
}

export const createDummyProductRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'createDummyProduct');
}
createDummyProductRef.operationName = 'createDummyProduct';

export function createDummyProduct(dc) {
  return executeMutation(createDummyProductRef(dc));
}

export const createProductBatchRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateProductBatch', inputVars);
}
createProductBatchRef.operationName = 'CreateProductBatch';

export function createProductBatch(dcOrVars, vars) {
  return executeMutation(createProductBatchRef(dcOrVars, vars));
}

export const listAllBusinessesRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListAllBusinesses');
}
listAllBusinessesRef.operationName = 'ListAllBusinesses';

export function listAllBusinesses(dc) {
  return executeQuery(listAllBusinessesRef(dc));
}

export const listAllCustomersRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListAllCustomers');
}
listAllCustomersRef.operationName = 'ListAllCustomers';

export function listAllCustomers(dc) {
  return executeQuery(listAllCustomersRef(dc));
}

export const listAllLocationsRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListAllLocations');
}
listAllLocationsRef.operationName = 'ListAllLocations';

export function listAllLocations(dc) {
  return executeQuery(listAllLocationsRef(dc));
}

export const listAllProductsRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'listAllProducts');
}
listAllProductsRef.operationName = 'listAllProducts';

export function listAllProducts(dc) {
  return executeQuery(listAllProductsRef(dc));
}

export const listInventoryByLocationRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListInventoryByLocation', inputVars);
}
listInventoryByLocationRef.operationName = 'ListInventoryByLocation';

export function listInventoryByLocation(dcOrVars, vars) {
  return executeQuery(listInventoryByLocationRef(dcOrVars, vars));
}

export const createProductPricingRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateProductPricing', inputVars);
}
createProductPricingRef.operationName = 'CreateProductPricing';

export function createProductPricing(dcOrVars, vars) {
  return executeMutation(createProductPricingRef(dcOrVars, vars));
}

export const verifyProductRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'VerifyProduct');
}
verifyProductRef.operationName = 'VerifyProduct';

export function verifyProduct(dc) {
  return executeQuery(verifyProductRef(dc));
}

export const getBusinessByIdRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'GetBusinessById', inputVars);
}
getBusinessByIdRef.operationName = 'GetBusinessById';

export function getBusinessById(dcOrVars, vars) {
  return executeQuery(getBusinessByIdRef(dcOrVars, vars));
}

export const listLocationsByBusinessRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListLocationsByBusiness', inputVars);
}
listLocationsByBusinessRef.operationName = 'ListLocationsByBusiness';

export function listLocationsByBusiness(dcOrVars, vars) {
  return executeQuery(listLocationsByBusinessRef(dcOrVars, vars));
}

export const listProductsByBusinessRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListProductsByBusiness', inputVars);
}
listProductsByBusinessRef.operationName = 'ListProductsByBusiness';

export function listProductsByBusiness(dcOrVars, vars) {
  return executeQuery(listProductsByBusinessRef(dcOrVars, vars));
}

export const listAllSuppliersRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListAllSuppliers');
}
listAllSuppliersRef.operationName = 'ListAllSuppliers';

export function listAllSuppliers(dc) {
  return executeQuery(listAllSuppliersRef(dc));
}

export const seedDataRef = (dc) => {
  const { dc: dcInstance} = validateArgs(connectorConfig, dc, undefined);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'SeedData');
}
seedDataRef.operationName = 'SeedData';

export function seedData(dc) {
  return executeMutation(seedDataRef(dc));
}

export const createAddressRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateAddress', inputVars);
}
createAddressRef.operationName = 'CreateAddress';

export function createAddress(dcOrVars, vars) {
  return executeMutation(createAddressRef(dcOrVars, vars));
}

export const createUserRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateUser', inputVars);
}
createUserRef.operationName = 'CreateUser';

export function createUser(dcOrVars, vars) {
  return executeMutation(createUserRef(dcOrVars, vars));
}

export const createCustomerRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateCustomer', inputVars);
}
createCustomerRef.operationName = 'CreateCustomer';

export function createCustomer(dcOrVars, vars) {
  return executeMutation(createCustomerRef(dcOrVars, vars));
}

export const createTherapeuticClassRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateTherapeuticClass', inputVars);
}
createTherapeuticClassRef.operationName = 'CreateTherapeuticClass';

export function createTherapeuticClass(dcOrVars, vars) {
  return executeMutation(createTherapeuticClassRef(dcOrVars, vars));
}

export const listPricingByLocationRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return queryRef(dcInstance, 'ListPricingByLocation', inputVars);
}
listPricingByLocationRef.operationName = 'ListPricingByLocation';

export function listPricingByLocation(dcOrVars, vars) {
  return executeQuery(listPricingByLocationRef(dcOrVars, vars));
}

export const createBusinessRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateBusiness', inputVars);
}
createBusinessRef.operationName = 'CreateBusiness';

export function createBusiness(dcOrVars, vars) {
  return executeMutation(createBusinessRef(dcOrVars, vars));
}

export const createManufacturerRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateManufacturer', inputVars);
}
createManufacturerRef.operationName = 'CreateManufacturer';

export function createManufacturer(dcOrVars, vars) {
  return executeMutation(createManufacturerRef(dcOrVars, vars));
}

export const createLocationRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateLocation', inputVars);
}
createLocationRef.operationName = 'CreateLocation';

export function createLocation(dcOrVars, vars) {
  return executeMutation(createLocationRef(dcOrVars, vars));
}

export const createGoodsReceiptRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateGoodsReceipt', inputVars);
}
createGoodsReceiptRef.operationName = 'CreateGoodsReceipt';

export function createGoodsReceipt(dcOrVars, vars) {
  return executeMutation(createGoodsReceiptRef(dcOrVars, vars));
}

export const createInventoryLevelRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateInventoryLevel', inputVars);
}
createInventoryLevelRef.operationName = 'CreateInventoryLevel';

export function createInventoryLevel(dcOrVars, vars) {
  return executeMutation(createInventoryLevelRef(dcOrVars, vars));
}

export const createProductRef = (dcOrVars, vars) => {
  const { dc: dcInstance, vars: inputVars} = validateArgs(connectorConfig, dcOrVars, vars, true);
  dcInstance._useGeneratedSdk();
  return mutationRef(dcInstance, 'CreateProduct', inputVars);
}
createProductRef.operationName = 'CreateProduct';

export function createProduct(dcOrVars, vars) {
  return executeMutation(createProductRef(dcOrVars, vars));
}

