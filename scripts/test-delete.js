#!/usr/bin/env node

/**
 * Simple test to execute delete mutation on both local and cloud
 */

async function executeGraphQL(endpoint, query, variables = {}) {
    const response = await fetch(`${endpoint}:executeMutation`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            name: 'DeleteAllData',
            operationName: 'DeleteAllData',
            query,
            variables
        })
    });

    const result = await response.json();
    if (result.errors) {
        console.error('GraphQL Error:', JSON.stringify(result.errors, null, 2));
        throw new Error(`GraphQL execution failed: ${result.errors[0].message}`);
    }

    return result.data;
}

async function main() {
    const useLocal = process.argv.includes('--local');

    const endpoint = useLocal
        ? 'http://127.0.0.1:9399/v1beta/projects/ikpharma-dev/locations/asia-south1/services/ikpharma/connectors/default'
        : 'https://firebasedataconnect.googleapis.com/v1beta/projects/ikpharma-dev/locations/asia-south1/services/ikpharma/connectors/default';

    console.log(`Executing on: ${useLocal ? 'LOCAL EMULATOR' : 'CLOUD'}`);
    console.log(`Endpoint: ${endpoint}\n`);

    const deleteQuery = `
    mutation DeleteAllData {
      salesLineItem_deleteMany
      payment_deleteMany
      salesTransaction_deleteMany
      temperatureReading_deleteMany
      recallDetails_deleteMany
      productBatch_deleteMany
      inventoryLevel_deleteMany
      storageLocation_deleteMany
      productSupplier_deleteMany
      activeIngredient_deleteMany
      productPricing_deleteMany
      product_deleteMany
      goodsReceipt_deleteMany
      purchaseOrderLineItem_deleteMany
      purchaseOrder_deleteMany
      purchaseRequisition_deleteMany
      reorderSuggestion_deleteMany
      seasonalPattern_deleteMany
      insuranceReimbursement_deleteMany
      volumeDiscount_deleteMany
      promotionalDiscount_deleteMany
      supplierPerformanceScore_deleteMany
      supplier_deleteMany
      customer_deleteMany
      payroll_deleteMany
      attendance_deleteMany
      shift_deleteMany
      employee_deleteMany
      invoice_deleteMany
      financialRecord_deleteMany
      messageReadReceipt_deleteMany
      messageAttachment_deleteMany
      message_deleteMany
      conversation_deleteMany
      formularyStatus_deleteMany
      substitutionRules_deleteMany
      expiryWarningThresholds_deleteMany
      bulkPackaging_deleteMany
      temperatureRange_deleteMany
      dimensions_deleteMany
      drugInteraction_deleteMany
      therapeuticSubclass_deleteMany
      therapeuticClass_deleteMany
      location_deleteMany
      user_deleteMany
      manufacturer_deleteMany
      dateRange_deleteMany
      address_deleteMany
      business_deleteMany
    }
  `;

    try {
        console.log('Executing DeleteAllData mutation...');
        const result = await executeGraphQL(endpoint, deleteQuery);
        console.log('\n✅ Success! Deleted all data.');
        console.log(JSON.stringify(result, null, 2));
    } catch (error) {
        console.error('\n❌ Error:', error.message);
        process.exit(1);
    }
}

main();
