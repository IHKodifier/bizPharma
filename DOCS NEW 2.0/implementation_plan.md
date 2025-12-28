# bizPharma Feature Development Roadmap

**Version:** 1.1 (Updated with Current Progress)  
**Date:** December 28, 2024  
**Based On:** Feature Stories, State Expansion Parts 1-7, AI Coding Context

---

## Current Implementation Status

> [!TIP]
> ✅ = Completed | 🔄 = Partial | 🔲 = Not Started

### Existing Files Reference
| Component | File Path | Status |
|-----------|-----------|--------|
| Auth Service | [auth_service.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/services/auth_service.dart) | ✅ |
| Auth Provider | [auth_provider.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/providers/auth_provider.dart) | ✅ |
| Auth Wrapper | [auth_wrapper.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/widgets/auth_wrapper.dart) | ✅ |
| Landing Page | [landing_page.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/pages/landing/landing_page.dart) | ✅ |
| Onboarding | [onboarding_stepper.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/pages/onboarding/onboarding_stepper.dart) | ✅ |
| Dashboard | [dashboard_page.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/features/dashboard/presentation/pages/dashboard_page.dart) | ✅ |
| Inventory Page | [inventory_page.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/features/inventory/presentation/pages/inventory_page.dart) | 🔄 |
| API Client | [api_client.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/services/api_client.dart) | ✅ |

---

# Phase 1: Foundation (Weeks 1-6) — MOSTLY COMPLETE ✅

## 1.1 Authentication System ✅

| Priority | Feature | Status | Existing File |
|----------|---------|--------|---------------|
| P0 | **Anonymous Trial Signup** | ✅ Done | [auth_service.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/services/auth_service.dart) → [signInAnonymously()](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/services/auth_service.dart#40-50) |
| P0 | **Google Sign-In** | ✅ Done | [auth_service.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/services/auth_service.dart) → [signInWithGoogle()](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/services/auth_service.dart#17-38) |
| P1 | **Anonymous to Google Link** | ✅ Done | [auth_service.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/services/auth_service.dart) → [linkWithGoogle()](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/services/auth_service.dart#52-69) |
| P0 | **Auth State Management** | ✅ Done | [auth_provider.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/providers/auth_provider.dart), [auth_wrapper.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/widgets/auth_wrapper.dart) |
| P1 | **Email/Password Signup** | 🔲 TODO | — |
| P1 | **Phone Number Signup** | 🔲 TODO | — |
| P1 | **Password Reset Flow** | 🔲 TODO | — |

---

## 1.2 Business Onboarding ✅

| Priority | Feature | Status | Existing File |
|----------|---------|--------|---------------|
| P0 | **3-Step Onboarding Wizard** | ✅ Done | [onboarding_stepper.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/pages/onboarding/onboarding_stepper.dart) |
| P0 | **Step 1: Business Info** | ✅ Done | fields: `businessName`, `phone`, `email` |
| P0 | **Step 2: User Details** | ✅ Done | fields: `firstName`, `lastName` |
| P0 | **Step 3: Review & Submit** | ✅ Done | creates business + admin via Data Connect |
| P0 | **CreateBusinessAndAdmin Mutation** | ✅ Done | [auth_service.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/services/auth_service.dart) → [createBusinessAndUser()](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/services/auth_service.dart#96-126) |
| P1 | **Sample Data Option** | 🔲 TODO | — |
| P1 | **Currency & Tax Config** | 🔲 TODO | — |

---

## 1.3 Landing Page ✅

| Priority | Feature | Status | Existing File |
|----------|---------|--------|---------------|
| P0 | **Landing Page Framework** | ✅ Done | [landing_page.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/pages/landing/landing_page.dart) |
| P0 | **Navbar** | ✅ Done | [navbar.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/pages/landing/widgets/navbar.dart) |
| P0 | **Hero Section** | ✅ Done | [hero_section.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/pages/landing/widgets/hero_section.dart) |
| P0 | **Value Props Section** | ✅ Done | [value_props_section.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/pages/landing/widgets/value_props_section.dart) |
| P0 | **Pricing Section** | ✅ Done | [pricing_section.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/pages/landing/widgets/pricing_section.dart) |
| P0 | **Footer** | ✅ Done | [footer.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/pages/landing/widgets/footer.dart) |

---

## 1.4 Dashboard Framework ✅

| Priority | Feature | Status | Existing File |
|----------|---------|--------|---------------|
| P0 | **Dashboard Page** | ✅ Done | [dashboard_page.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/features/dashboard/presentation/pages/dashboard_page.dart) |
| P0 | **KPI Cards** | ✅ Done | [kpi_card.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/features/dashboard/presentation/widgets/kpi_card.dart) + shimmer loading |
| P0 | **Sidebar Navigation** | ✅ Done | [sidebar_navigation.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/features/dashboard/presentation/widgets/sidebar_navigation.dart) |
| P0 | **Quick Action Cards** | ✅ Done | [quick_action_card.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/features/dashboard/presentation/widgets/quick_action_card.dart) |
| P0 | **Sales Chart Widget** | ✅ Done | [sales_chart_widget.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/features/dashboard/presentation/widgets/sales_chart_widget.dart) |
| P0 | **Activity Feed** | ✅ Done | [activity_feed_widget.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/features/dashboard/presentation/widgets/activity_feed_widget.dart) |
| P0 | **Critical Alerts** | ✅ Done | [critical_alerts_widget.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/features/dashboard/presentation/widgets/critical_alerts_widget.dart) |

---

## 1.5 RBAC & Location — NOT STARTED

| Priority | Feature | Status | Est. Effort |
|----------|---------|--------|-------------|
| P0 | User Management Dashboard | 🔲 TODO | 3 days |
| P0 | 5 Base Roles Implementation | 🔲 TODO | 3 days |
| P1 | Permission Matrix View | 🔲 TODO | 2 days |
| P0 | Location Hierarchy Builder | 🔲 TODO | 2 days |
| P1 | User-Location Assignment | 🔲 TODO | 1 day |

---

# Phase 2: Core Operations (Weeks 7-12)

## 2.1 Product Catalog

| Priority | Feature | Dependencies | Status | Est. Effort |
|----------|---------|--------------|--------|-------------|
| P0 | Product List View | Locations | 🔲 | 2 days |
| P0 | Add Product (Manual) | Schema | 🔲 | 3 days |
| P0 | Product Detail View | Products | 🔲 | 2 days |
| P1 | Category Management | Products | 🔲 | 2 days |
| P1 | Barcode Scanning | Camera | 🔲 | 2 days |
| P1 | Barcode Generation | Products | 🔲 | 1 day |
| P2 | Bulk Import (CSV) | Products | 🔲 | 3 days |

---

## 2.2 Inventory Core

| Priority | Feature | Dependencies | Status | Est. Effort |
|----------|---------|--------------|--------|-------------|
| P0 | Stock Level Tracking | Products | 🔲 | 3 days |
| P0 | Stock Adjustment | Stock Levels | 🔲 | 3 days |
| P0 | Low Stock Alerts | Stock Levels | 🔲 | 2 days |
| P1 | Stock Movement History | Adjustments | 🔲 | 2 days |

> [!NOTE]
> **Existing:** [inventory_page.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/features/inventory/presentation/pages/inventory_page.dart) has expiry dashboard (partial implementation)

---

## 2.3 POS Core

| Priority | Feature | Dependencies | Status | Est. Effort |
|----------|---------|--------------|--------|-------------|
| P0 | POS Home Screen | Products + Inventory | 🔲 | 3 days |
| P0 | Product Search | Products | 🔲 | 2 days |
| P0 | Cart Management | Products | 🔲 | 3 days |
| P0 | Cash Payment | Cart | 🔲 | 2 days |
| P0 | Receipt Generation | Payment | 🔲 | 2 days |
| P1 | Barcode Scanner | Camera | 🔲 | 2 days |
| P1 | WhatsApp Receipt | WhatsApp API | 🔲 | 2 days |

---

## 2.4 Customer Management

| Priority | Feature | Dependencies | Status | Est. Effort |
|----------|---------|--------------|--------|-------------|
| P0 | Customer List View | Business Setup | 🔲 | 2 days |
| P0 | Add/Edit Customer | Schema | 🔲 | 2 days |
| P1 | Customer Tiers | Customers | 🔲 | 2 days |
| P1 | Credit Limit Management | Customers | 🔲 | 2 days |

---

# Phase 3: Advanced Operations (Weeks 13-18)

## 3.1 Multi-Counter POS

| Priority | Feature | Dependencies | Est. Effort |
|----------|---------|--------------|-------------|
| P0 | Counter Selection | POS Core | 2 days |
| P0 | Session Management | Counters | 2 days |
| P1 | EOD Reconciliation | Sessions | 3 days |
| P1 | Cash Denomination Counter | EOD | 2 days |

---

## 3.2 Batch & Expiry

| Priority | Feature | Dependencies | Est. Effort |
|----------|---------|--------------|-------------|
| P0 | Batch Tracking Toggle | Products | 1 day |
| P0 | FEFO Selection in POS | POS + Batches | 2 days |
| P1 | Expiry Alerts (30/60/90) | Batches | 2 days |
| P1 | Near-Expiry Discounts | Alerts | 2 days |

---

## 3.3 Transfers & GRN

| Priority | Feature | Dependencies | Est. Effort |
|----------|---------|--------------|-------------|
| P0 | Transfer Request | Locations | 2 days |
| P0 | Transfer Approval | RBAC | 2 days |
| P0 | GRN Entry | Procurement | 3 days |
| P1 | Partial Receiving | GRN | 2 days |

---

## 3.4 Procurement

| Priority | Feature | Dependencies | Est. Effort |
|----------|---------|--------------|-------------|
| P0 | Supplier Management | Business | 2 days |
| P0 | Purchase Order Creation | Suppliers | 3 days |
| P1 | PO Approval Workflow | RBAC | 2 days |
| P2 | Auto-Reorder Suggestions | Stock | 3 days |

---

# Phase 4: Intelligence (Weeks 19-24)

## 4.1 Reports

| Priority | Feature | Dependencies | Est. Effort |
|----------|---------|--------------|-------------|
| P0 | Sales Reports | POS | 4 days |
| P0 | Inventory Reports | Inventory | 3 days |
| P1 | Financial Reports | Payments | 3 days |
| P2 | Custom Report Builder | All | 5 days |

---

## 4.2 Role Dashboards

| Priority | Feature | Dependencies | Est. Effort |
|----------|---------|--------------|-------------|
| P1 | Cashier Dashboard | POS | 2 days |
| P1 | Warehouse Manager Dashboard | Inventory | 2 days |
| P2 | Dashboard Customization | Widgets | 3 days |

---

# Phase 5: Polish & Scale (Weeks 25-30)

## 5.1 Offline Mode

| Priority | Feature | Est. Effort |
|----------|---------|-------------|
| P1 | Offline POS | 5 days |
| P1 | Transaction Sync | 3 days |
| P1 | Conflict Resolution | 3 days |

---

## 5.2 Enterprise

| Priority | Feature | Est. Effort |
|----------|---------|-------------|
| P2 | Audit Logs | 3 days |
| P2 | Two-Factor Auth | 2 days |
| P2 | API Rate Limiting | 2 days |

---

# Summary: Remaining Work

| Phase | Status | Remaining Features |
|-------|--------|-------------------|
| **Phase 1** | 🟢 ~80% Complete | RBAC, Locations, Email/Phone Auth |
| **Phase 2** | 🔴 Not Started | Products, Inventory CRUD, POS, Customers |
| **Phase 3** | 🔴 Not Started | Multi-Counter, Batches, Transfers, Procurement |
| **Phase 4** | 🔴 Not Started | Reports, Role Dashboards |
| **Phase 5** | 🔴 Not Started | Offline, Enterprise Features |

**Estimated Remaining Time:** 20-26 weeks (from current state)

---

# Next Steps

1. ✅ Review completed Phase 1 features
2. ⬜ Complete Phase 1: Add RBAC & Location Management
3. ⬜ Begin Phase 2: Product Catalog & Inventory CRUD operations
