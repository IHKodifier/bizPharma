# ikPharma - Cloud Pharmacy Management System

A three-tier SaaS pharmacy management platform built for scale, efficiency, and intelligence. ikPharma offers a comprehensive suite of tools for modern pharmacies, from single stores to large chains, with Trial, Paid, and Enterprise subscription tiers.

Our platform features a mobile-first POS with barcode scanning, multi-location inventory management with batch/expiry tracking, streamlined procurement workflows, integrated financial accounting, HR/payroll, real-time team messaging, and ML-powered reorder suggestions.

## Key Features

- **Subscription Tiers:** Anonymous trial signup with a seamless upgrade path to Paid or Enterprise plans.
- **Point of Sale (POS):** A mobile-first POS with barcode scanning and FEFO (First-Expiry, First-Out) batch selection.
- **Offline Capability:** Offline POS functionality with intelligent conflict resolution upon reconnection.
- **Inventory Management:** Multi-location inventory tracking with detailed batch/expiry information and bin locations.
- **Procurement:** End-to-end procurement workflows including requisitions, goods receipts, and 3-way matching.
- **Financial Accounting:** Integrated journal entries, invoicing, and payment tracking.
- **Team Collaboration:** Real-time team messaging with conversations, read receipts, and attachments, powered by WebSockets.
- **Customer Management:** Tiered customer pricing (Walk-in, Platinum, Diamond, Gold, Silver, Bronze).
- **HR & Payroll:** Manage employees, attendance, shifts, payroll, and sales commissions.
- **Integrations:** Deliver receipts directly to customers via WhatsApp.
- **Business Intelligence:** ML-powered seasonal demand forecasting and reorder suggestions.
- **Hierarchical Management:** Manage complex organizational structures from Head Office to Regional offices to individual stores.
- **Analytics:** Comprehensive reporting and analytics dashboards.

## Technology Stack

- **Frontend:** Flutter
- **Backend:** FastAPI (Python)
- **Infrastructure:** Firebase / Google Cloud Platform (GCP)
- **Database:** PostgreSQL with a multi-tenant architecture

## Core Entities

- **Businesses:** The root entity for multi-tenancy, defined by a subscription tier (TRIAL/PAID/ENTERPRISE).
- **Users:** Feature-rich Role-Based Access Control (RBAC) with customizable roles and permissions.
- **Products:** Manage items with batches, expiry dates, and specific bin locations.
- **Inventory:** Track stock levels across multiple physical locations.
- **Sales Transactions:** Record POS sales, line items, payments, and returns.
- **Purchase Orders:** Manage the entire purchasing lifecycle from requisitions to supplier payment.
- **Suppliers:** Maintain a database of suppliers with performance metrics.
- **Customers:** Manage customer profiles and tiered pricing.
- **Messages:** Real-time chat with conversations, participants, read receipts, and attachments.
- **Financial Records:** Track journal entries, invoices, and payments for full financial visibility.
- **Employees:** Manage staff information, attendance, shifts, payroll, and commissions.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
