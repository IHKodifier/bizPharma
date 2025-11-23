const admin = require('firebase-admin');
const { v4: uuidv4 } = require('uuid');

// Initialize Firebase Admin SDK
const serviceAccount = require('../firebase-service-account.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://ikpharma-dev.firebaseio.com'
});

// Helper to execute raw SQL via Cloud SQL
async function executeSql(sql) {
  const { Connector } = await import('@google-cloud/cloud-sql-connector');
  const connector = new Connector();
  const clientOpts = await connector.getOptions({
    instanceConnectionName: 'ikpharma-dev:asia-south1:ikpharma-dev-instance',
    authType: 'IAM',
  });
  
  const { Pool } = require('pg');
  const pool = new Pool({
    ...clientOpts,
    user: 'postgres',
    database: 'ikpharma-dev-database',
  });
  
  const result = await pool.query(sql);
  await pool.end();
  connector.close();
  return result;
}

async function seedDatabase() {
  console.log('🌱 Starting database seeding...\n');

  // 1. Create Business
  console.log('📊 Creating business...');
  const businessId = uuidv4();
  await executeSql(`
    INSERT INTO "public"."business" (id, name, tier, subscription_start_date, is_active, created_at, updated_at)
    VALUES (
      '${businessId}',
      'PharmaCare Solutions',
      'PAID',
      CURRENT_DATE,
      true,
      CURRENT_DATE,
      CURRENT_DATE
    );
  `);
  console.log('✅ Business created\n');

  // 2. Create Users
  console.log('👥 Creating users...');
  const userId1 = 'admin-user-001';
  const userId2 = 'pharmacist-user-001';
  
  await executeSql(`
    INSERT INTO "public"."user" (id, business_id, email, first_name, last_name, role, is_active, created_at, updated_at)
    VALUES
      ('${userId1}', '${businessId}', 'admin@pharmacare.com', 'John', 'Doe', 'ADMIN', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
      ('${userId2}', '${businessId}', 'pharmacist@pharmacare.com', 'Jane', 'Smith', 'PHARMACIST', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
  `);
  console.log('✅ Users created\n');

  // 3. Create Manufacturers
  console.log('🏭 Creating manufacturers...');
  const manufacturers = [
    { name: 'Pfizer Inc', country: 'USA' },
    { name: 'GlaxoSmithKline', country: 'UK' },
    { name: 'Novartis AG', country: 'Switzerland' },
    { name: 'Sanofi', country: 'France' },
    { name: 'Johnson & Johnson', country: 'USA' },
    { name: 'Bayer AG', country: 'Germany' },
    { name: 'AstraZeneca', country: 'UK' },
    { name: 'Merck & Co', country: 'USA' },
    { name: 'Abbott Laboratories', country: 'USA' },
    { name: 'Roche Holding AG', country: 'Switzerland' }
  ];
  
  const manufacturerIds = {};
  for (const mfr of manufacturers) {
    const id = uuidv4();
    manufacturerIds[mfr.name] = id;
    await executeSql(`
      INSERT INTO "public"."manufacturer" (id, name, country, is_active)
      VALUES ('${id}', '${mfr.name}', '${mfr.country}', true);
    `);
  }
  console.log(`✅ ${manufacturers.length} manufacturers created\n`);

  // 4. Create Therapeutic Classes
  console.log('💊 Creating therapeutic classes...');
  const therapeuticClasses = [
    'Analgesics',
    'Antibiotics',
    'Antihypertensives',
    'Antidiabetics',
    'Antihistamines',
    'Antacids',
    'Cardiovascular',
    'Respiratory',
    'Psychiatric',
    'Dermatological'
  ];
  
  const classIds = {};
  for (const className of therapeuticClasses) {
    const id = uuidv4();
    classIds[className] = id;
    await executeSql(`
      INSERT INTO "public"."therapeutic_class" (id, business_id, name, description)
      VALUES ('${id}', '${businessId}', '${className}', 'Therapeutic class for ${className.toLowerCase()}');
    `);
  }
  console.log(`✅ ${therapeuticClasses.length} therapeutic classes created\n`);

  // 5. Create Suppliers
  console.log('🚚 Creating suppliers...');
  const suppliers = [
    { name: 'MedSupply Distribution', type: 'DISTRIBUTOR' },
    { name: 'PharmaDirect Wholesale', type: 'WHOLESALER' },
    { name: 'Global Pharma Imports', type: 'IMPORTER' }
  ];
  
  const supplierIds = {};
  for (const supplier of suppliers) {
    const id = uuidv4();
    supplierIds[supplier.name] = id;
    await executeSql(`
      INSERT INTO "public"."supplier" (
        id, business_id, name, type, payment_terms, outstanding_balance, tier, is_active, created_at, updated_at
      )
      VALUES (
        '${id}',
        '${businessId}',
        '${supplier.name}',
        '${supplier.type}',
        'Net 30',
        0,
        'PREFERRED',
        true,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
      );
    `);
  }
  console.log(`✅ ${suppliers.length} suppliers created\n`);

  // 6. Create 50 Products
  console.log('💊 Creating 50 pharmaceutical products...');
  
  const products = [
    { generic: 'Paracetamol', brand: 'Tylenol', strength: '500mg', form: 'TABLET', class: 'Analgesics', mfr: 'Johnson & Johnson', route: 'ORAL', schedule: 'OVER_THE_COUNTER', category: 'OTC_MEDICINE' },
    { generic: 'Ibuprofen', brand: 'Advil', strength: '400mg', form: 'TABLET', class: 'Analgesics', mfr: 'Pfizer Inc', route: 'ORAL', schedule: 'OVER_THE_COUNTER', category: 'OTC_MEDICINE' },
    { generic: 'Amoxicillin', brand: 'Amoxil', strength: '500mg', form: 'CAPSULE', class: 'Antibiotics', mfr: 'GlaxoSmithKline', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Azithromycin', brand: 'Zithromax', strength: '250mg', form: 'TABLET', class: 'Antibiotics', mfr: 'Pfizer Inc', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Ciprofloxacin', brand: 'Cipro', strength: '500mg', form: 'TABLET', class: 'Antibiotics', mfr: 'Bayer AG', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    
    { generic: 'Amlodipine', brand: 'Norvasc', strength: '5mg', form: 'TABLET', class: 'Antihypertensives', mfr: 'Pfizer Inc', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Losartan', brand: 'Cozaar', strength: '50mg', form: 'TABLET', class: 'Antihypertensives', mfr: 'Merck & Co', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Enalapril', brand: 'Vasotec', strength: '10mg', form: 'TABLET', class: 'Antihypertensives', mfr: 'Merck & Co', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    
    { generic: 'Metformin', brand: 'Glucophage', strength: '500mg', form: 'TABLET', class: 'Antidiabetics', mfr: 'Sanofi', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Glipizide', brand: 'Glucotrol', strength: '5mg', form: 'TABLET', class: 'Antidiabetics', mfr: 'Pfizer Inc', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Insulin Glargine', brand: 'Lantus', strength: '100U/mL', form: 'INJECTION', class: 'Antidiabetics', mfr: 'Sanofi', route: 'SUBCUTANEOUS', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    
    { generic: 'Cetirizine', brand: 'Zyrtec', strength: '10mg', form: 'TABLET', class: 'Antihistamines', mfr: 'Johnson & Johnson', route: 'ORAL', schedule: 'OVER_THE_COUNTER', category: 'OTC_MEDICINE' },
    { generic: 'Loratadine', brand: 'Claritin', strength: '10mg', form: 'TABLET', class: 'Antihistamines', mfr: 'Bayer AG', route: 'ORAL', schedule: 'OVER_THE_COUNTER', category: 'OTC_MEDICINE' },
    { generic: 'Fexofenadine', brand: 'Allegra', strength: '180mg', form: 'TABLET', class: 'Antihistamines', mfr: 'Sanofi', route: 'ORAL', schedule: 'OVER_THE_COUNTER', category: 'OTC_MEDICINE' },
    
    { generic: 'Omeprazole', brand: 'Prilosec', strength: '20mg', form: 'CAPSULE', class: 'Antacids', mfr: 'AstraZeneca', route: 'ORAL', schedule: 'OVER_THE_COUNTER', category: 'OTC_MEDICINE' },
    { generic: 'Ranitidine', brand: 'Zantac', strength: '150mg', form: 'TABLET', class: 'Antacids', mfr: 'GlaxoSmithKline', route: 'ORAL', schedule: 'OVER_THE_COUNTER', category: 'OTC_MEDICINE' },
    { generic: 'Pantoprazole', brand: 'Protonix', strength: '40mg', form: 'TABLET', class: 'Antacids', mfr: 'Pfizer Inc', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    
    { generic: 'Atorvastatin', brand: 'Lipitor', strength: '20mg', form: 'TABLET', class: 'Cardiovascular', mfr: 'Pfizer Inc', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Simvastatin', brand: 'Zocor', strength: '20mg', form: 'TABLET', class: 'Cardiovascular', mfr: 'Merck & Co', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Aspirin', brand: 'Bayer Aspirin', strength: '81mg', form: 'TABLET', class: 'Cardiovascular', mfr: 'Bayer AG', route: 'ORAL', schedule: 'OVER_THE_COUNTER', category: 'OTC_MEDICINE' },
    
    { generic: 'Salbutamol', brand: 'Ventolin', strength: '100mcg', form: 'INHALER', class: 'Respiratory', mfr: 'GlaxoSmithKline', route: 'INHALATION', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Montelukast', brand: 'Singulair', strength: '10mg', form: 'TABLET', class: 'Respiratory', mfr: 'Merck & Co', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Budesonide', brand: 'Pulmicort', strength: '200mcg', form: 'INHALER', class: 'Respiratory', mfr: 'AstraZeneca', route: 'INHALATION', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    
    { generic: 'Sertraline', brand: 'Zoloft', strength: '50mg', form: 'TABLET', class: 'Psychiatric', mfr: 'Pfizer Inc', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Fluoxetine', brand: 'Prozac', strength: '20mg', form: 'CAPSULE', class: 'Psychiatric', mfr: 'Pfizer Inc', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Escitalopram', brand: 'Lexapro', strength: '10mg', form: 'TABLET', class: 'Psychiatric', mfr: 'Pfizer Inc', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    
    { generic: 'Hydrocortisone', brand: 'Cortaid', strength: '1%', form: 'CREAM', class: 'Dermatological', mfr: 'Johnson & Johnson', route: 'TOPICAL', schedule: 'OVER_THE_COUNTER', category: 'OTC_MEDICINE' },
    { generic: 'Clotrimazole', brand: 'Lotrimin', strength: '1%', form: 'CREAM', class: 'Dermatological', mfr: 'Bayer AG', route: 'TOPICAL', schedule: 'OVER_THE_COUNTER', category: 'OTC_MEDICINE' },
    { generic: 'Betamethasone', brand: 'Diprolene', strength: '0.05%', form: 'OINTMENT', class: 'Dermatological', mfr: 'Merck & Co', route: 'TOPICAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    
    { generic: 'Levothyroxine', brand: 'Synthroid', strength: '100mcg', form: 'TABLET', class: 'Cardiovascular', mfr: 'Abbott Laboratories', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Warfarin', brand: 'Coumadin', strength: '5mg', form: 'TABLET', class: 'Cardiovascular', mfr: 'Bristol-Myers Squibb', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Clopidogrel', brand: 'Plavix', strength: '75mg', form: 'TABLET', class: 'Cardiovascular', mfr: 'Sanofi', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    
    { generic: 'Gabapentin', brand: 'Neurontin', strength: '300mg', form: 'CAPSULE', class: 'Analgesics', mfr: 'Pfizer Inc', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Tramadol', brand: 'Ultram', strength: '50mg', form: 'TABLET', class: 'Analgesics', mfr: 'Johnson & Johnson', route: 'ORAL', schedule: 'CONTROLLED_SUBSTANCE', category: 'PHARMACEUTICAL' },
    { generic: 'Diclofenac', brand: 'Voltaren', strength: '50mg', form: 'TABLET', class: 'Analgesics', mfr: 'Novartis AG', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    
    { generic: 'Prednisone', brand: 'Deltasone', strength: '10mg', form: 'TABLET', class: 'Analgesics', mfr: 'Pfizer Inc', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Dexamethasone', brand: 'Decadron', strength: '4mg', form: 'TABLET', class: 'Analgesics', mfr: 'Merck & Co', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    
    { generic: 'Levofloxacin', brand: 'Levaquin', strength: '500mg', form: 'TABLET', class: 'Antibiotics', mfr: 'Johnson & Johnson', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Doxycycline', brand: 'Vibramycin', strength: '100mg', form: 'CAPSULE', class: 'Antibiotics', mfr: 'Pfizer Inc', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Cephalexin', brand: 'Keflex', strength: '500mg', form: 'CAPSULE', class: 'Antibiotics', mfr: 'Pfizer Inc', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    
    { generic: 'Lisinopril', brand: 'Prinivil', strength: '10mg', form: 'TABLET', class: 'Antihypertensives', mfr: 'Merck & Co', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Metoprolol', brand: 'Lopressor', strength: '50mg', form: 'TABLET', class: 'Antihypertensives', mfr: 'AstraZeneca', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Carvedilol', brand: 'Coreg', strength: '25mg', form: 'TABLET', class: 'Antihypertensives', mfr: 'GlaxoSmithKline', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    
    { generic: 'Alprazolam', brand: 'Xanax', strength: '0.5mg', form: 'TABLET', class: 'Psychiatric', mfr: 'Pfizer Inc', route: 'ORAL', schedule: 'CONTROLLED_SUBSTANCE', category: 'PHARMACEUTICAL' },
    { generic: 'Lorazepam', brand: 'Ativan', strength: '1mg', form: 'TABLET', class: 'Psychiatric', mfr: 'Pfizer Inc', route: 'ORAL', schedule: 'CONTROLLED_SUBSTANCE', category: 'PHARMACEUTICAL' },
    { generic: 'Diazepam', brand: 'Valium', strength: '5mg', form: 'TABLET', class: 'Psychiatric', mfr: 'Roche Holding AG', route: 'ORAL', schedule: 'CONTROLLED_SUBSTANCE', category: 'PHARMACEUTICAL' },
    
    { generic: 'Furosemide', brand: 'Lasix', strength: '40mg', form: 'TABLET', class: 'Cardiovascular', mfr: 'Sanofi', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Spironolactone', brand: 'Aldactone', strength: '25mg', form: 'TABLET', class: 'Cardiovascular', mfr: 'Pfizer Inc', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Hydrochlorothiazide', brand: 'Microzide', strength: '25mg', form: 'CAPSULE', class: 'Cardiovascular', mfr: 'Abbott Laboratories', route: 'ORAL', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    
    { generic: 'Albuterol', brand: 'ProAir', strength: '90mcg', form: 'INHALER', class: 'Respiratory', mfr: 'GlaxoSmithKline', route: 'INHALATION', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' },
    { generic: 'Ipratropium', brand: 'Atrovent', strength: '20mcg', form: 'INHALER', class: 'Respiratory', mfr: 'Boehringer Ingelheim', route: 'INHALATION', schedule: 'PRESCRIPTION_ONLY', category: 'PHARMACEUTICAL' }
  ];

  let insertedCount = 0;
  
  for (const prod of products) {
    const productId = uuidv4();
    const internalSKU = `${prod.generic.substring(0, 4).toUpperCase()}-${prod.strength.replace(/[^0-9]/g, '')}-${insertedCount + 1}`;
    const mfrId = manufacturerIds[prod.mfr];
    const classId = classIds[prod.class];
    const supplierId = supplierIds['MedSupply Distribution'];
    
    await executeSql(`
      INSERT INTO "public"."product" (
        id, business_id, generic_name, brand_name, manufacturer_id, internal_sku,
        dosage_form, strength, unit, route_of_administration, drug_schedule,
        requires_prescription, therapeutic_class_id, package_size, package_unit,
        primary_supplier_id, lead_time_days, reorder_point, reorder_quantity,
        minimum_stock_level, is_active, is_discontinued, requires_refrigeration,
        requires_controlled_substance_vault, is_light_sensitive, is_hazardous_drug,
        requires_reconstitution, is_fast_mover, category, created_at, updated_at,
        created_by_id, updated_by_id
      )
      VALUES (
        '${productId}',
        '${businessId}',
        '${prod.generic}',
        '${prod.brand}',
        '${mfrId}',
        '${internalSKU}',
        '${prod.form}',
        '${prod.strength}',
        'units',
        '${prod.route}',
        '${prod.schedule}',
        ${prod.schedule !== 'OVER_THE_COUNTER'},
        '${classId}',
        30,
        'BOTTLE',
        '${supplierId}',
        7,
        50,
        100,
        10,
        true,
        false,
        false,
        ${prod.schedule === 'CONTROLLED_SUBSTANCE'},
        false,
        false,
        false,
        ${prod.category === 'OTC_MEDICINE'},
        '${prod.category}',
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        '${userId1}',
        '${userId1}'
      );
    `);
    
    insertedCount++;
    if (insertedCount % 10 === 0) {
      console.log(`  ✓ Inserted ${insertedCount} products...`);
    }
  }
  
  console.log(`✅ All ${products.length} products created\n`);
  
  console.log('🎉 Database seeding completed successfully!\n');
  console.log('Summary:');
  console.log(`  - 1 Business`);
  console.log(`  - 2 Users`);
  console.log(`  - ${manufacturers.length} Manufacturers`);
  console.log(`  - ${therapeuticClasses.length} Therapeutic Classes`);
  console.log(`  - ${suppliers.length} Suppliers`);
  console.log(`  - ${products.length} Products`);
}

// Run the seeding
seedDatabase()
  .then(() => {
    console.log('\n✨ Seeding completed!');
    process.exit(0);
  })
  .catch((error) => {
    console.error('\n❌ Error during seeding:', error);
    process.exit(1);
  });
