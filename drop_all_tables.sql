-- Complete DROP script for fresh schema deployment
-- Execute this in Cloud SQL Studio to resolve migration conflicts

DROP TABLE IF EXISTS "public"."active_ingredient" CASCADE;
DROP TABLE IF EXISTS "public"."address" CASCADE;
DROP TABLE IF EXISTS "public"."business" CASCADE;
DROP TABLE IF EXISTS "public"."customer" CASCADE;
DROP TABLE IF EXISTS "public"."customer_purchase_history" CASCADE;
DROP TABLE IF EXISTS "public"."date_range" CASCADE;
DROP TABLE IF EXISTS "public"."expiry_warning_thresholds" CASCADE;
DROP TABLE IF EXISTS "public"."goods_receipt" CASCADE;
DROP TABLE IF EXISTS "public"."goods_receipt_line_item" CASCADE;
DROP TABLE IF EXISTS "public"."inventory" CASCADE;
DROP TABLE IF EXISTS "public"."location" CASCADE;
DROP TABLE IF EXISTS "public"."manufacturer" CASCADE;
DROP TABLE IF EXISTS "public"."message" CASCADE;
DROP TABLE IF EXISTS "public"."product" CASCADE;
DROP TABLE IF EXISTS "public"."product_batch" CASCADE;
DROP TABLE IF EXISTS "public"."product_pricing" CASCADE;
DROP TABLE IF EXISTS "public"."product_substitution" CASCADE;
DROP TABLE IF EXISTS "public"."product_supplier" CASCADE;
DROP TABLE IF EXISTS "public"."purchase_order" CASCADE;
DROP TABLE IF EXISTS "public"."purchase_order_line_item" CASCADE;
DROP TABLE IF EXISTS "public"."reorder_suggestion" CASCADE;
DROP TABLE IF EXISTS "public"."sales_line_item" CASCADE;
DROP TABLE IF EXISTS "public"."sales_transaction" CASCADE;
DROP TABLE IF EXISTS "public"."supplier" CASCADE;
DROP TABLE IF EXISTS "public"."supplier_performance_score" CASCADE;
DROP TABLE IF EXISTS "public"."test_entity" CASCADE;
DROP TABLE IF EXISTS "public"."therapeutic_class" CASCADE;
DROP TABLE IF EXISTS "public"."therapeutic_subclass" CASCADE;
DROP TABLE IF EXISTS "public"."user" CASCADE;

-- Drop all enum types
DROP TYPE IF EXISTS "public"."business_tier" CASCADE;
DROP TYPE IF EXISTS "public"."user_role" CASCADE;
DROP TYPE IF EXISTS "public"."dosage_form" CASCADE;
DROP TYPE IF EXISTS "public"."route_of_administration" CASCADE;
DROP TYPE IF EXISTS "public"."drug_schedule" CASCADE;
DROP TYPE IF EXISTS "public"."dea_schedule" CASCADE;
DROP TYPE IF EXISTS "public"."pregnancy_category" CASCADE;
DROP TYPE IF EXISTS "public"."fda_approval_status" CASCADE;
DROP TYPE IF EXISTS "public"."package_unit" CASCADE;
DROP TYPE IF EXISTS "public"."supplier_type" CASCADE;
DROP TYPE IF EXISTS "public"."supplier_tier" CASCADE;
DROP TYPE IF EXISTS "public"."product_category" CASCADE;
DROP TYPE IF EXISTS "public"."product_subcategory" CASCADE;
DROP TYPE IF EXISTS "public"."transaction_type" CASCADE;
DROP TYPE IF EXISTS "public"."transaction_status" CASCADE;
DROP TYPE IF EXISTS "public"."payment_method" CASCADE;
DROP TYPE IF EXISTS "public"."purchase_order_status" CASCADE;
DROP TYPE IF EXISTS "public"."goods_receipt_status" CASCADE;
DROP TYPE IF EXISTS "public"."customer_tier" CASCADE;
