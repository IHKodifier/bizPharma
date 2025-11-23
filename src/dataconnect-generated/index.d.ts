import { ConnectorConfig, DataConnect, QueryRef, QueryPromise, MutationRef, MutationPromise } from 'firebase/data-connect';

export const connectorConfig: ConnectorConfig;

export type TimestampString = string;
export type UUIDString = string;
export type Int64String = string;
export type DateString = string;


export enum BusinessTier {
  TRIAL = "TRIAL",
  PAID = "PAID",
  ENTERPRISE = "ENTERPRISE",
};

export enum CustomerTier {
  WALK_IN = "WALK_IN",
  BRONZE = "BRONZE",
  SILVER = "SILVER",
  GOLD = "GOLD",
  DIAMOND = "DIAMOND",
  PLATINUM = "PLATINUM",
};

export enum DosageForm {
  TABLET = "TABLET",
  CAPSULE = "CAPSULE",
  SYRUP = "SYRUP",
  SUSPENSION = "SUSPENSION",
  INJECTION = "INJECTION",
  CREAM = "CREAM",
  OINTMENT = "OINTMENT",
  LOTION = "LOTION",
  GEL = "GEL",
  DROPS = "DROPS",
  INHALER = "INHALER",
  PATCH = "PATCH",
  SUPPOSITORY = "SUPPOSITORY",
  POWDER = "POWDER",
  SOLUTION = "SOLUTION",
  OTHER = "OTHER",
};

export enum DrugSchedule {
  PRESCRIPTION_ONLY = "PRESCRIPTION_ONLY",
  OVER_THE_COUNTER = "OVER_THE_COUNTER",
  BEHIND_THE_COUNTER = "BEHIND_THE_COUNTER",
  CONTROLLED_SUBSTANCE = "CONTROLLED_SUBSTANCE",
  INVESTIGATIONAL = "INVESTIGATIONAL",
};

export enum GoodsReceiptStatus {
  PENDING = "PENDING",
  RECEIVED = "RECEIVED",
  INSPECTED = "INSPECTED",
  ACCEPTED = "ACCEPTED",
  REJECTED = "REJECTED",
};

export enum LocationType {
  HEAD_OFFICE = "HEAD_OFFICE",
  REGIONAL_WAREHOUSE = "REGIONAL_WAREHOUSE",
  RETAIL_STORE = "RETAIL_STORE",
  DISTRIBUTION_CENTER = "DISTRIBUTION_CENTER",
};

export enum PackageUnit {
  BOTTLE = "BOTTLE",
  BOX = "BOX",
  BLISTER_PACK = "BLISTER_PACK",
  VIAL = "VIAL",
  AMPULE = "AMPULE",
  TUBE = "TUBE",
  JAR = "JAR",
  POUCH = "POUCH",
  STRIP = "STRIP",
  OTHER = "OTHER",
};

export enum ProductCategory {
  PHARMACEUTICAL = "PHARMACEUTICAL",
  OTC_MEDICINE = "OTC_MEDICINE",
  MEDICAL_DEVICE = "MEDICAL_DEVICE",
  SUPPLEMENT = "SUPPLEMENT",
  PERSONAL_CARE = "PERSONAL_CARE",
  OTHER = "OTHER",
};

export enum ProductSubcategory {
  ANALGESICS = "ANALGESICS",
  ANTIBIOTICS = "ANTIBIOTICS",
  CARDIOVASCULAR = "CARDIOVASCULAR",
  DIABETES = "DIABETES",
  DERMATOLOGY = "DERMATOLOGY",
  GASTROINTESTINAL = "GASTROINTESTINAL",
  NEUROLOGY = "NEUROLOGY",
  ONCOLOGY = "ONCOLOGY",
  OPHTHALMOLOGY = "OPHTHALMOLOGY",
  PEDIATRICS = "PEDIATRICS",
  PSYCHIATRY = "PSYCHIATRY",
  RESPIRATORY = "RESPIRATORY",
  UROLOGY = "UROLOGY",
  VITAMINS = "VITAMINS",
  MINERALS = "MINERALS",
  HERBALS = "HERBALS",
  COSMETICS = "COSMETICS",
  SKIN_CARE = "SKIN_CARE",
  HAIR_CARE = "HAIR_CARE",
  ORAL_CARE = "ORAL_CARE",
  OTHER = "OTHER",
};

export enum PurchaseOrderStatus {
  DRAFT = "DRAFT",
  PENDING_APPROVAL = "PENDING_APPROVAL",
  APPROVED = "APPROVED",
  ORDERED = "ORDERED",
  PARTIALLY_RECEIVED = "PARTIALLY_RECEIVED",
  RECEIVED = "RECEIVED",
  CANCELLED = "CANCELLED",
};

export enum RouteOfAdministration {
  ORAL = "ORAL",
  TOPICAL = "TOPICAL",
  INTRAVENOUS = "INTRAVENOUS",
  INTRAMUSCULAR = "INTRAMUSCULAR",
  SUBCUTANEOUS = "SUBCUTANEOUS",
  INHALATION = "INHALATION",
  RECTAL = "RECTAL",
  VAGINAL = "VAGINAL",
  OPHTHALMIC = "OPHTHALMIC",
  OTIC = "OTIC",
  NASAL = "NASAL",
  TRANSDERMAL = "TRANSDERMAL",
  OTHER = "OTHER",
};

export enum SupplierTier {
  PREFERRED = "PREFERRED",
  STANDARD = "STANDARD",
  BACKUP = "BACKUP",
  TRIAL = "TRIAL",
};

export enum SupplierType {
  MANUFACTURER = "MANUFACTURER",
  DISTRIBUTOR = "DISTRIBUTOR",
  WHOLESALER = "WHOLESALER",
  IMPORTER = "IMPORTER",
};

export enum UserRole {
  SUPER_ADMIN = "SUPER_ADMIN",
  ADMIN = "ADMIN",
  MANAGER = "MANAGER",
  PHARMACIST = "PHARMACIST",
  PHARMACY_TECH = "PHARMACY_TECH",
  CASHIER = "CASHIER",
  INVENTORY_CLERK = "INVENTORY_CLERK",
};



export interface ActiveIngredient_Key {
  id: UUIDString;
  __typename?: 'ActiveIngredient_Key';
}

export interface Address_Key {
  id: UUIDString;
  __typename?: 'Address_Key';
}

export interface Attendance_Key {
  id: UUIDString;
  __typename?: 'Attendance_Key';
}

export interface BulkPackaging_Key {
  id: UUIDString;
  __typename?: 'BulkPackaging_Key';
}

export interface Business_Key {
  id: UUIDString;
  __typename?: 'Business_Key';
}

export interface Conversation_Key {
  id: UUIDString;
  __typename?: 'Conversation_Key';
}

export interface CreateAddressData {
  address_insert: Address_Key;
}

export interface CreateAddressVariables {
  line1: string;
  line2?: string | null;
  city: string;
  state: string;
  postalCode: string;
  country: string;
}

export interface CreateBusinessData {
  business_insert: Business_Key;
}

export interface CreateBusinessVariables {
  name: string;
  tier: BusinessTier;
  subscriptionStartDate: DateString;
  subscriptionEndDate?: DateString | null;
  maxUsers?: number | null;
  maxLocations?: number | null;
}

export interface CreateCustomerData {
  customer_insert: Customer_Key;
}

export interface CreateCustomerVariables {
  businessId: UUIDString;
  firstName: string;
  lastName: string;
  email?: string | null;
  phone?: string | null;
  dateOfBirth?: DateString | null;
  createdById: string;
}

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

export interface CreateGoodsReceiptData {
  goodsReceipt_insert: GoodsReceipt_Key;
}

export interface CreateGoodsReceiptVariables {
  purchaseOrderId: UUIDString;
  businessId: UUIDString;
  receiptNumber: string;
  receiptDate?: TimestampString | null;
  status: GoodsReceiptStatus;
  inspectedById: string;
}

export interface CreateInventoryLevelData {
  inventoryLevel_insert: InventoryLevel_Key;
}

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

export interface CreateLocationData {
  location_insert: Location_Key;
}

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

export interface CreateManufacturerData {
  manufacturer_insert: Manufacturer_Key;
}

export interface CreateManufacturerVariables {
  name: string;
  country: string;
}

export interface CreateProductBatchData {
  productBatch_insert: ProductBatch_Key;
}

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

export interface CreateProductData {
  product_insert: Product_Key;
}

export interface CreateProductPricingData {
  productPricing_insert: ProductPricing_Key;
}

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

export interface CreatePurchaseOrderData {
  purchaseOrder_insert: PurchaseOrder_Key;
}

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

export interface CreateSupplierData {
  supplier_insert: Supplier_Key;
}

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

export interface CreateTherapeuticClassData {
  therapeuticClass_insert: TherapeuticClass_Key;
}

export interface CreateTherapeuticClassVariables {
  code: string;
  name: string;
  description?: string | null;
}

export interface CreateUserData {
  user_insert: User_Key;
}

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

export interface Customer_Key {
  id: UUIDString;
  __typename?: 'Customer_Key';
}

export interface DateRange_Key {
  id: UUIDString;
  __typename?: 'DateRange_Key';
}

export interface Dimensions_Key {
  id: UUIDString;
  __typename?: 'Dimensions_Key';
}

export interface DrugInteraction_Key {
  id: UUIDString;
  __typename?: 'DrugInteraction_Key';
}

export interface Employee_Key {
  id: UUIDString;
  __typename?: 'Employee_Key';
}

export interface ExpiryWarningThresholds_Key {
  id: UUIDString;
  __typename?: 'ExpiryWarningThresholds_Key';
}

export interface FinancialRecord_Key {
  id: UUIDString;
  __typename?: 'FinancialRecord_Key';
}

export interface FormularyStatus_Key {
  id: UUIDString;
  __typename?: 'FormularyStatus_Key';
}

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

export interface GetBusinessByIdVariables {
  id: UUIDString;
}

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

export interface GoodsReceipt_Key {
  id: UUIDString;
  __typename?: 'GoodsReceipt_Key';
}

export interface InsuranceReimbursement_Key {
  id: UUIDString;
  __typename?: 'InsuranceReimbursement_Key';
}

export interface InventoryLevel_Key {
  id: UUIDString;
  __typename?: 'InventoryLevel_Key';
}

export interface Invoice_Key {
  id: UUIDString;
  __typename?: 'Invoice_Key';
}

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

export interface ListInventoryByLocationVariables {
  locationId: UUIDString;
}

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

export interface ListLocationsByBusinessVariables {
  businessId: UUIDString;
}

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

export interface ListPricingByLocationVariables {
  businessId: UUIDString;
}

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

export interface ListProductsByBusinessVariables {
  businessId: UUIDString;
}

export interface Location_Key {
  id: UUIDString;
  __typename?: 'Location_Key';
}

export interface Manufacturer_Key {
  id: UUIDString;
  __typename?: 'Manufacturer_Key';
}

export interface MessageAttachment_Key {
  id: UUIDString;
  __typename?: 'MessageAttachment_Key';
}

export interface MessageReadReceipt_Key {
  id: UUIDString;
  __typename?: 'MessageReadReceipt_Key';
}

export interface Message_Key {
  id: UUIDString;
  __typename?: 'Message_Key';
}

export interface Payment_Key {
  id: UUIDString;
  __typename?: 'Payment_Key';
}

export interface Payroll_Key {
  id: UUIDString;
  __typename?: 'Payroll_Key';
}

export interface ProductBatch_Key {
  id: UUIDString;
  __typename?: 'ProductBatch_Key';
}

export interface ProductPricing_Key {
  id: UUIDString;
  __typename?: 'ProductPricing_Key';
}

export interface ProductSupplier_Key {
  productId: UUIDString;
  supplierId: UUIDString;
  __typename?: 'ProductSupplier_Key';
}

export interface Product_Key {
  id: UUIDString;
  __typename?: 'Product_Key';
}

export interface PromotionalDiscount_Key {
  id: UUIDString;
  __typename?: 'PromotionalDiscount_Key';
}

export interface PurchaseOrderLineItem_Key {
  id: UUIDString;
  __typename?: 'PurchaseOrderLineItem_Key';
}

export interface PurchaseOrder_Key {
  id: UUIDString;
  __typename?: 'PurchaseOrder_Key';
}

export interface PurchaseRequisition_Key {
  id: UUIDString;
  __typename?: 'PurchaseRequisition_Key';
}

export interface RecallDetails_Key {
  id: UUIDString;
  __typename?: 'RecallDetails_Key';
}

export interface ReorderSuggestion_Key {
  id: UUIDString;
  __typename?: 'ReorderSuggestion_Key';
}

export interface SalesLineItem_Key {
  id: UUIDString;
  __typename?: 'SalesLineItem_Key';
}

export interface SalesTransaction_Key {
  id: UUIDString;
  __typename?: 'SalesTransaction_Key';
}

export interface SeasonalPattern_Key {
  id: UUIDString;
  __typename?: 'SeasonalPattern_Key';
}

export interface SeedDataData {
  b1: Business_Key;
  u1: User_Key;
  m1: Manufacturer_Key;
  tc1: TherapeuticClass_Key;
  s1: Supplier_Key;
  p1: Product_Key;
}

export interface Shift_Key {
  id: UUIDString;
  __typename?: 'Shift_Key';
}

export interface StorageLocation_Key {
  id: UUIDString;
  __typename?: 'StorageLocation_Key';
}

export interface SubstitutionRules_Key {
  id: UUIDString;
  __typename?: 'SubstitutionRules_Key';
}

export interface SupplierPerformanceScore_Key {
  id: UUIDString;
  __typename?: 'SupplierPerformanceScore_Key';
}

export interface Supplier_Key {
  id: UUIDString;
  __typename?: 'Supplier_Key';
}

export interface TemperatureRange_Key {
  id: UUIDString;
  __typename?: 'TemperatureRange_Key';
}

export interface TemperatureReading_Key {
  id: UUIDString;
  __typename?: 'TemperatureReading_Key';
}

export interface TherapeuticClass_Key {
  id: UUIDString;
  __typename?: 'TherapeuticClass_Key';
}

export interface TherapeuticSubclass_Key {
  id: UUIDString;
  __typename?: 'TherapeuticSubclass_Key';
}

export interface User_Key {
  id: string;
  __typename?: 'User_Key';
}

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

export interface VolumeDiscount_Key {
  id: UUIDString;
  __typename?: 'VolumeDiscount_Key';
}

interface CreateSupplierRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateSupplierVariables): MutationRef<CreateSupplierData, CreateSupplierVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreateSupplierVariables): MutationRef<CreateSupplierData, CreateSupplierVariables>;
  operationName: string;
}
export const createSupplierRef: CreateSupplierRef;

export function createSupplier(vars: CreateSupplierVariables): MutationPromise<CreateSupplierData, CreateSupplierVariables>;
export function createSupplier(dc: DataConnect, vars: CreateSupplierVariables): MutationPromise<CreateSupplierData, CreateSupplierVariables>;

interface GetParacetamolProductsRef {
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<GetParacetamolProductsData, undefined>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect): QueryRef<GetParacetamolProductsData, undefined>;
  operationName: string;
}
export const getParacetamolProductsRef: GetParacetamolProductsRef;

export function getParacetamolProducts(): QueryPromise<GetParacetamolProductsData, undefined>;
export function getParacetamolProducts(dc: DataConnect): QueryPromise<GetParacetamolProductsData, undefined>;

interface CreatePurchaseOrderRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreatePurchaseOrderVariables): MutationRef<CreatePurchaseOrderData, CreatePurchaseOrderVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreatePurchaseOrderVariables): MutationRef<CreatePurchaseOrderData, CreatePurchaseOrderVariables>;
  operationName: string;
}
export const createPurchaseOrderRef: CreatePurchaseOrderRef;

export function createPurchaseOrder(vars: CreatePurchaseOrderVariables): MutationPromise<CreatePurchaseOrderData, CreatePurchaseOrderVariables>;
export function createPurchaseOrder(dc: DataConnect, vars: CreatePurchaseOrderVariables): MutationPromise<CreatePurchaseOrderData, CreatePurchaseOrderVariables>;

interface CreateDummyProductRef {
  /* Allow users to create refs without passing in DataConnect */
  (): MutationRef<CreateDummyProductData, undefined>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect): MutationRef<CreateDummyProductData, undefined>;
  operationName: string;
}
export const createDummyProductRef: CreateDummyProductRef;

export function createDummyProduct(): MutationPromise<CreateDummyProductData, undefined>;
export function createDummyProduct(dc: DataConnect): MutationPromise<CreateDummyProductData, undefined>;

interface CreateProductBatchRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateProductBatchVariables): MutationRef<CreateProductBatchData, CreateProductBatchVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreateProductBatchVariables): MutationRef<CreateProductBatchData, CreateProductBatchVariables>;
  operationName: string;
}
export const createProductBatchRef: CreateProductBatchRef;

export function createProductBatch(vars: CreateProductBatchVariables): MutationPromise<CreateProductBatchData, CreateProductBatchVariables>;
export function createProductBatch(dc: DataConnect, vars: CreateProductBatchVariables): MutationPromise<CreateProductBatchData, CreateProductBatchVariables>;

interface ListAllBusinessesRef {
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListAllBusinessesData, undefined>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect): QueryRef<ListAllBusinessesData, undefined>;
  operationName: string;
}
export const listAllBusinessesRef: ListAllBusinessesRef;

export function listAllBusinesses(): QueryPromise<ListAllBusinessesData, undefined>;
export function listAllBusinesses(dc: DataConnect): QueryPromise<ListAllBusinessesData, undefined>;

interface ListAllCustomersRef {
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListAllCustomersData, undefined>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect): QueryRef<ListAllCustomersData, undefined>;
  operationName: string;
}
export const listAllCustomersRef: ListAllCustomersRef;

export function listAllCustomers(): QueryPromise<ListAllCustomersData, undefined>;
export function listAllCustomers(dc: DataConnect): QueryPromise<ListAllCustomersData, undefined>;

interface ListAllLocationsRef {
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListAllLocationsData, undefined>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect): QueryRef<ListAllLocationsData, undefined>;
  operationName: string;
}
export const listAllLocationsRef: ListAllLocationsRef;

export function listAllLocations(): QueryPromise<ListAllLocationsData, undefined>;
export function listAllLocations(dc: DataConnect): QueryPromise<ListAllLocationsData, undefined>;

interface ListAllProductsRef {
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListAllProductsData, undefined>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect): QueryRef<ListAllProductsData, undefined>;
  operationName: string;
}
export const listAllProductsRef: ListAllProductsRef;

export function listAllProducts(): QueryPromise<ListAllProductsData, undefined>;
export function listAllProducts(dc: DataConnect): QueryPromise<ListAllProductsData, undefined>;

interface ListInventoryByLocationRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: ListInventoryByLocationVariables): QueryRef<ListInventoryByLocationData, ListInventoryByLocationVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: ListInventoryByLocationVariables): QueryRef<ListInventoryByLocationData, ListInventoryByLocationVariables>;
  operationName: string;
}
export const listInventoryByLocationRef: ListInventoryByLocationRef;

export function listInventoryByLocation(vars: ListInventoryByLocationVariables): QueryPromise<ListInventoryByLocationData, ListInventoryByLocationVariables>;
export function listInventoryByLocation(dc: DataConnect, vars: ListInventoryByLocationVariables): QueryPromise<ListInventoryByLocationData, ListInventoryByLocationVariables>;

interface CreateProductPricingRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateProductPricingVariables): MutationRef<CreateProductPricingData, CreateProductPricingVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreateProductPricingVariables): MutationRef<CreateProductPricingData, CreateProductPricingVariables>;
  operationName: string;
}
export const createProductPricingRef: CreateProductPricingRef;

export function createProductPricing(vars: CreateProductPricingVariables): MutationPromise<CreateProductPricingData, CreateProductPricingVariables>;
export function createProductPricing(dc: DataConnect, vars: CreateProductPricingVariables): MutationPromise<CreateProductPricingData, CreateProductPricingVariables>;

interface VerifyProductRef {
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<VerifyProductData, undefined>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect): QueryRef<VerifyProductData, undefined>;
  operationName: string;
}
export const verifyProductRef: VerifyProductRef;

export function verifyProduct(): QueryPromise<VerifyProductData, undefined>;
export function verifyProduct(dc: DataConnect): QueryPromise<VerifyProductData, undefined>;

interface GetBusinessByIdRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: GetBusinessByIdVariables): QueryRef<GetBusinessByIdData, GetBusinessByIdVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: GetBusinessByIdVariables): QueryRef<GetBusinessByIdData, GetBusinessByIdVariables>;
  operationName: string;
}
export const getBusinessByIdRef: GetBusinessByIdRef;

export function getBusinessById(vars: GetBusinessByIdVariables): QueryPromise<GetBusinessByIdData, GetBusinessByIdVariables>;
export function getBusinessById(dc: DataConnect, vars: GetBusinessByIdVariables): QueryPromise<GetBusinessByIdData, GetBusinessByIdVariables>;

interface ListLocationsByBusinessRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: ListLocationsByBusinessVariables): QueryRef<ListLocationsByBusinessData, ListLocationsByBusinessVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: ListLocationsByBusinessVariables): QueryRef<ListLocationsByBusinessData, ListLocationsByBusinessVariables>;
  operationName: string;
}
export const listLocationsByBusinessRef: ListLocationsByBusinessRef;

export function listLocationsByBusiness(vars: ListLocationsByBusinessVariables): QueryPromise<ListLocationsByBusinessData, ListLocationsByBusinessVariables>;
export function listLocationsByBusiness(dc: DataConnect, vars: ListLocationsByBusinessVariables): QueryPromise<ListLocationsByBusinessData, ListLocationsByBusinessVariables>;

interface ListProductsByBusinessRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: ListProductsByBusinessVariables): QueryRef<ListProductsByBusinessData, ListProductsByBusinessVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: ListProductsByBusinessVariables): QueryRef<ListProductsByBusinessData, ListProductsByBusinessVariables>;
  operationName: string;
}
export const listProductsByBusinessRef: ListProductsByBusinessRef;

export function listProductsByBusiness(vars: ListProductsByBusinessVariables): QueryPromise<ListProductsByBusinessData, ListProductsByBusinessVariables>;
export function listProductsByBusiness(dc: DataConnect, vars: ListProductsByBusinessVariables): QueryPromise<ListProductsByBusinessData, ListProductsByBusinessVariables>;

interface ListAllSuppliersRef {
  /* Allow users to create refs without passing in DataConnect */
  (): QueryRef<ListAllSuppliersData, undefined>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect): QueryRef<ListAllSuppliersData, undefined>;
  operationName: string;
}
export const listAllSuppliersRef: ListAllSuppliersRef;

export function listAllSuppliers(): QueryPromise<ListAllSuppliersData, undefined>;
export function listAllSuppliers(dc: DataConnect): QueryPromise<ListAllSuppliersData, undefined>;

interface SeedDataRef {
  /* Allow users to create refs without passing in DataConnect */
  (): MutationRef<SeedDataData, undefined>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect): MutationRef<SeedDataData, undefined>;
  operationName: string;
}
export const seedDataRef: SeedDataRef;

export function seedData(): MutationPromise<SeedDataData, undefined>;
export function seedData(dc: DataConnect): MutationPromise<SeedDataData, undefined>;

interface CreateAddressRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateAddressVariables): MutationRef<CreateAddressData, CreateAddressVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreateAddressVariables): MutationRef<CreateAddressData, CreateAddressVariables>;
  operationName: string;
}
export const createAddressRef: CreateAddressRef;

export function createAddress(vars: CreateAddressVariables): MutationPromise<CreateAddressData, CreateAddressVariables>;
export function createAddress(dc: DataConnect, vars: CreateAddressVariables): MutationPromise<CreateAddressData, CreateAddressVariables>;

interface CreateUserRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateUserVariables): MutationRef<CreateUserData, CreateUserVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreateUserVariables): MutationRef<CreateUserData, CreateUserVariables>;
  operationName: string;
}
export const createUserRef: CreateUserRef;

export function createUser(vars: CreateUserVariables): MutationPromise<CreateUserData, CreateUserVariables>;
export function createUser(dc: DataConnect, vars: CreateUserVariables): MutationPromise<CreateUserData, CreateUserVariables>;

interface CreateCustomerRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateCustomerVariables): MutationRef<CreateCustomerData, CreateCustomerVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreateCustomerVariables): MutationRef<CreateCustomerData, CreateCustomerVariables>;
  operationName: string;
}
export const createCustomerRef: CreateCustomerRef;

export function createCustomer(vars: CreateCustomerVariables): MutationPromise<CreateCustomerData, CreateCustomerVariables>;
export function createCustomer(dc: DataConnect, vars: CreateCustomerVariables): MutationPromise<CreateCustomerData, CreateCustomerVariables>;

interface CreateTherapeuticClassRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateTherapeuticClassVariables): MutationRef<CreateTherapeuticClassData, CreateTherapeuticClassVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreateTherapeuticClassVariables): MutationRef<CreateTherapeuticClassData, CreateTherapeuticClassVariables>;
  operationName: string;
}
export const createTherapeuticClassRef: CreateTherapeuticClassRef;

export function createTherapeuticClass(vars: CreateTherapeuticClassVariables): MutationPromise<CreateTherapeuticClassData, CreateTherapeuticClassVariables>;
export function createTherapeuticClass(dc: DataConnect, vars: CreateTherapeuticClassVariables): MutationPromise<CreateTherapeuticClassData, CreateTherapeuticClassVariables>;

interface ListPricingByLocationRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: ListPricingByLocationVariables): QueryRef<ListPricingByLocationData, ListPricingByLocationVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: ListPricingByLocationVariables): QueryRef<ListPricingByLocationData, ListPricingByLocationVariables>;
  operationName: string;
}
export const listPricingByLocationRef: ListPricingByLocationRef;

export function listPricingByLocation(vars: ListPricingByLocationVariables): QueryPromise<ListPricingByLocationData, ListPricingByLocationVariables>;
export function listPricingByLocation(dc: DataConnect, vars: ListPricingByLocationVariables): QueryPromise<ListPricingByLocationData, ListPricingByLocationVariables>;

interface CreateBusinessRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateBusinessVariables): MutationRef<CreateBusinessData, CreateBusinessVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreateBusinessVariables): MutationRef<CreateBusinessData, CreateBusinessVariables>;
  operationName: string;
}
export const createBusinessRef: CreateBusinessRef;

export function createBusiness(vars: CreateBusinessVariables): MutationPromise<CreateBusinessData, CreateBusinessVariables>;
export function createBusiness(dc: DataConnect, vars: CreateBusinessVariables): MutationPromise<CreateBusinessData, CreateBusinessVariables>;

interface CreateManufacturerRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateManufacturerVariables): MutationRef<CreateManufacturerData, CreateManufacturerVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreateManufacturerVariables): MutationRef<CreateManufacturerData, CreateManufacturerVariables>;
  operationName: string;
}
export const createManufacturerRef: CreateManufacturerRef;

export function createManufacturer(vars: CreateManufacturerVariables): MutationPromise<CreateManufacturerData, CreateManufacturerVariables>;
export function createManufacturer(dc: DataConnect, vars: CreateManufacturerVariables): MutationPromise<CreateManufacturerData, CreateManufacturerVariables>;

interface CreateLocationRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateLocationVariables): MutationRef<CreateLocationData, CreateLocationVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreateLocationVariables): MutationRef<CreateLocationData, CreateLocationVariables>;
  operationName: string;
}
export const createLocationRef: CreateLocationRef;

export function createLocation(vars: CreateLocationVariables): MutationPromise<CreateLocationData, CreateLocationVariables>;
export function createLocation(dc: DataConnect, vars: CreateLocationVariables): MutationPromise<CreateLocationData, CreateLocationVariables>;

interface CreateGoodsReceiptRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateGoodsReceiptVariables): MutationRef<CreateGoodsReceiptData, CreateGoodsReceiptVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreateGoodsReceiptVariables): MutationRef<CreateGoodsReceiptData, CreateGoodsReceiptVariables>;
  operationName: string;
}
export const createGoodsReceiptRef: CreateGoodsReceiptRef;

export function createGoodsReceipt(vars: CreateGoodsReceiptVariables): MutationPromise<CreateGoodsReceiptData, CreateGoodsReceiptVariables>;
export function createGoodsReceipt(dc: DataConnect, vars: CreateGoodsReceiptVariables): MutationPromise<CreateGoodsReceiptData, CreateGoodsReceiptVariables>;

interface CreateInventoryLevelRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateInventoryLevelVariables): MutationRef<CreateInventoryLevelData, CreateInventoryLevelVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreateInventoryLevelVariables): MutationRef<CreateInventoryLevelData, CreateInventoryLevelVariables>;
  operationName: string;
}
export const createInventoryLevelRef: CreateInventoryLevelRef;

export function createInventoryLevel(vars: CreateInventoryLevelVariables): MutationPromise<CreateInventoryLevelData, CreateInventoryLevelVariables>;
export function createInventoryLevel(dc: DataConnect, vars: CreateInventoryLevelVariables): MutationPromise<CreateInventoryLevelData, CreateInventoryLevelVariables>;

interface CreateProductRef {
  /* Allow users to create refs without passing in DataConnect */
  (vars: CreateProductVariables): MutationRef<CreateProductData, CreateProductVariables>;
  /* Allow users to pass in custom DataConnect instances */
  (dc: DataConnect, vars: CreateProductVariables): MutationRef<CreateProductData, CreateProductVariables>;
  operationName: string;
}
export const createProductRef: CreateProductRef;

export function createProduct(vars: CreateProductVariables): MutationPromise<CreateProductData, CreateProductVariables>;
export function createProduct(dc: DataConnect, vars: CreateProductVariables): MutationPromise<CreateProductData, CreateProductVariables>;

