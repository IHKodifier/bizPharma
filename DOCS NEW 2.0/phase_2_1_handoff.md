# Phase 2.1: Product Catalog - Implementation Handoff

**Date:** 2026-02-13  
**Status:** Ready to Start  
**Feature Branch:** `feature/phase2.1-product-catalog-completion`  
**Timeline:** 15 days

---

## 🎯 **Objective**

Implement the Product Catalog feature for bizPharma, including:
1. **Enum-to-Table Migration** (prerequisite)
2. Product List View with infinite scroll
3. Product Detail View with pricing/stock breakdowns
4. Edit Product functionality
5. Category Management
6. Barcode Scanning (web + mobile)
7. Barcode Generation
8. Bulk CSV Import

---

## 📋 **Planning Documents**

All planning is complete and approved. Reference these artifacts:

1. **Main Plan:** `C:\Users\Ihtiram\.gemini\antigravity\brain\ea8bf0c2-462d-4e00-a0e4-86649f8ec7b5\phase_2_1_plan.md`
   - Complete feature breakdown
   - Confirmed design decisions
   - 15-day timeline

2. **Enum Migration Tracking:** `C:\Users\Ihtiram\.gemini\antigravity\brain\ea8bf0c2-462d-4e00-a0e4-86649f8ec7b5\enum_migration_tracking.md`
   - All 36 enum references mapped
   - Exact file locations and line numbers
   - Before/after code examples
   - 85 trackable items

3. **Task Checklist:** `C:\Users\Ihtiram\.gemini\antigravity\brain\ea8bf0c2-462d-4e00-a0e4-86649f8ec7b5\task.md`
   - Day-by-day breakdown
   - 85 checkable items
   - Progress tracking

---

## 🔑 **Key Decisions (Confirmed)**

### **1. Enum-to-Table Migration Strategy**
- ✅ **Clean one-shot migration** (no dual support)
- ✅ Delete all 36 enums, replace with tables in one deployment
- ✅ Only 6 out of 36 enums currently used (minimal impact)
- ✅ Update 2 pages: onboarding + add product
- ✅ All auth levels already use `USER_ANON` (correct)

### **2. Category Deletion**
- ✅ **Option 1: Prevent deletion if products exist**
- ✅ Show error message with product count
- ✅ Suggest soft delete (mark as inactive)
- ✅ Only allow hard delete if product count = 0

### **3. Pagination Strategy**
- ✅ **Option 3: Infinite scroll + "Load More" button**
- ✅ Show total count at top
- ✅ Dynamic button text: "Load More (50)" or "Load More (X)" if <50 remaining
- ✅ Progress indicator: "Showing X of Y"
- ✅ Load 50 items per batch

### **4. Barcode Scanning**
- ✅ **Desktop/Laptop:** USB scanner + manual entry field
- ✅ **Mobile/Tablet:** Camera scanning + manual fallback
- ✅ Auto-detect device type

### **5. Pricing & Stock Display**
- ✅ Show pricing **by location AND customer tier**
- ✅ Show stock **by location** with expand/collapse
- ✅ Hover overlay on product list for per-location stock

### **6. Edit Product**
- ✅ Add unsaved changes prompt when navigating away
- ✅ Use `WillPopScope` or `NavigatorObserver`

---

## 🏗️ **Project Context**

### **Environments**
- **Production:** `bizpharma.app` (Firebase: `bizpharma-prod`)
- **Staging:** `bizpharma-staging.web.app` (Firebase: `bizpharma-staging`)
- **Development:** `localhost` (Firebase: `bizpharma-4e73a`)

### **Current Branch Status**
- All environments synced on commit: `d4d4278`
- Branches: `main` (production), `dev` (staging)
- Next branch: `feature/phase2.1-product-catalog-completion` (to be created from `dev`)

### **Tech Stack**
- **Frontend:** Flutter Web
- **Backend:** Firebase Data Connect (GraphQL)
- **Database:** Cloud SQL (PostgreSQL)
- **Auth:** Firebase Auth (Anonymous + Google)
- **State Management:** Riverpod

### **Auth Levels**
- Use `@auth(level: USER_ANON)` for all mutations/queries
- Supports both authenticated and anonymous users

---

## 📊 **Current Implementation Status**

### **✅ Already Implemented**
1. **User Onboarding** - Anonymous + Google signup
2. **Add Product Page** - Manual product creation
3. **Inventory Page** - Expiry dashboard
4. **Category Management** - Dialog-based creation
5. **Product Queries/Mutations** - Basic CRUD

### **🔴 Currently Using Enums (Need Migration)**
- `BusinessTier`, `UserRole` (onboarding page)
- `DosageForm`, `RouteOfAdministration`, `DrugSchedule`, `PackageUnit` (add product page)

### **✅ Not Yet Implemented (Safe)**
- 30 other enums (supplier, customer, sales, procurement, financial, HR, supporting)
- Product List View
- Product Detail View
- Edit Product
- Barcode features
- CSV Import

---

## 🚀 **Implementation Order**

### **Phase 0: Enum-to-Table Migration (3 days) - START HERE**

**Day 1: Schema Replacement (4 hours)**
1. Review `enum_migration_tracking.md` for complete reference list
2. Create 36 table schema files in `dataconnect/schema/lookups/`
3. Delete all enum definitions from `dataconnect/schema/enums/enums.gql`
4. Update type references in schema files:
   - 4 files for `BusinessTier`
   - 3 files for `UserRole`
   - 12 files for Product enums
   - 30+ files for remaining enums
5. Create seed data mutations for all 36 tables
6. Deploy schema to development: `firebase deploy --only dataconnect`
7. Run seed mutations
8. Regenerate SDK: `flutterfire dataconnect:sdk:generate`

**Day 2: Frontend Updates (8 hours)**
1. Update `lib/pages/onboarding/onboarding_stepper.dart`:
   - Replace `BusinessTier.TRIAL` with table query
   - Replace `UserRole.BUSINESS_ADMIN` with table query
2. Update `lib/features/inventory/presentation/pages/add_product_page.dart`:
   - Replace 4 enum dropdowns with table queries
   - Update mutation calls to use table IDs
3. Test all existing features:
   - User signup (anonymous)
   - User signup (Google)
   - Business creation
   - Product creation
   - Product list display

**Day 3: Admin UI & Production (8 hours)**
1. Create generic lookup table management page
2. Add CRUD operations for all 36 tables
3. Deploy to staging
4. Final testing
5. Deploy to production
6. Update project documentation

### **Phase 1-7: Product Features (12 days)**
Follow the detailed breakdown in `task.md` and `phase_2_1_plan.md`.

---

## 📁 **Key Files to Know**

### **Schema Files**
```
dataconnect/
├── schema/
│   ├── enums/enums.gql          # DELETE all enums from here
│   ├── core/business.gql        # Update BusinessTier reference
│   ├── core/user.gql            # Update UserRole reference
│   ├── products/product.gql     # Update 5 enum references
│   └── lookups/                 # CREATE 36 new table schemas here
├── connector/
│   ├── mutations/
│   │   ├── admin/onboarding.gql # Update BusinessTier, UserRole params
│   │   └── products/create_product.gql # Update 4 enum params
│   └── queries/
│       ├── core/get_business_by_id.gql
│       ├── core/get_user_by_auth_id.gql
│       └── products/list_products_by_business.gql
```

### **Frontend Files**
```
lib/
├── pages/onboarding/onboarding_stepper.dart  # Update 2 enum references
├── features/inventory/
│   ├── presentation/pages/
│   │   ├── add_product_page.dart             # Update 4 enum references
│   │   └── inventory_page.dart               # Already implemented
│   └── data/product_service.dart
└── dataconnect_generated/                    # Regenerate after schema changes
```

---

## 🧪 **Testing Requirements**

### **After Enum Migration (Critical)**
- [ ] Anonymous user signup works
- [ ] Google user signup works
- [ ] Business creation works
- [ ] Product creation works
- [ ] Product list displays correctly
- [ ] No console errors
- [ ] SDK regenerated successfully

### **After Each Feature**
- [ ] Feature works as designed
- [ ] No regressions in existing features
- [ ] UI matches design requirements

---

## ⚠️ **Known Issues & Gotchas**

### **App Check (Production)**
- **Issue:** reCAPTCHA Enterprise key not registered in Firebase Console
- **Impact:** App Check failing in production (403 errors)
- **Workaround:** Onboarding works because it uses `USER_ANON` auth level
- **Fix Needed:** Register key `6LdmAzgsAAAAALi4XGcnxBgs_TJmDOJfnURMsLJH` in Firebase Console
- **Reference:** `C:\Users\Ihtiram\.gemini\antigravity\brain\ea8bf0c2-462d-4e00-a0e4-86649f8ec7b5\appcheck_diagnosis.md`

### **Environment Detection**
- **Pattern:** Use `Uri.base.host` for environment detection (not `kDebugMode`)
- **Reason:** `kDebugMode` is true even in production web builds
- **Example:** See `lib/main.dart` and `lib/firebase_options.dart`

### **Cloud SQL**
- **Status:** Hardened with backups, SSL, IAM auth
- **Pending:** Private IP (VPC) configuration (manual setup required)

---

## 📝 **Important Commands**

### **Schema Deployment**
```bash
# Development
firebase use bizpharma-4e73a
firebase deploy --only dataconnect

# Staging
firebase use bizpharma-staging
firebase deploy --only dataconnect

# Production
firebase use bizpharma-prod
firebase deploy --only dataconnect
```

### **SDK Regeneration**
```bash
flutterfire dataconnect:sdk:generate
```

### **Git Workflow**
```bash
# Create feature branch
git checkout dev
git pull origin dev
git checkout -b feature/phase2.1-product-catalog-completion

# Commit changes
git add .
git commit -m "feat: [description]"
git push origin feature/phase2.1-product-catalog-completion

# Merge to dev (after testing)
git checkout dev
git merge feature/phase2.1-product-catalog-completion
git push origin dev

# Deploy to staging (automatic via GitHub Actions)

# Merge to main (after staging verification)
git checkout main
git merge dev
git push origin main

# Deploy to production (automatic via GitHub Actions)
```

---

## 🎯 **Success Criteria**

Phase 2.1 is complete when:
- [ ] All 36 enums converted to tables with CRUD
- [ ] Product list displays with infinite scroll + load more
- [ ] Stock hover overlay shows per-location breakdown
- [ ] Product detail shows pricing by customer tier
- [ ] Product detail shows expandable stock by location
- [ ] Edit form prompts for unsaved changes
- [ ] Category deletion validates product usage
- [ ] Barcode scanning works on web (USB + manual) and mobile (camera)
- [ ] Products can have auto-generated barcodes
- [ ] Bulk CSV import functional
- [ ] 81% of tests automated
- [ ] No regressions in existing features

---

## 📞 **Next Steps for New Conversation**

1. **Review Planning Documents:**
   - Read `phase_2_1_plan.md` for complete feature details
   - Read `enum_migration_tracking.md` for migration specifics
   - Read `task.md` for day-by-day breakdown

2. **Create Feature Branch:**
   ```bash
   git checkout dev
   git pull origin dev
   git checkout -b feature/phase2.1-product-catalog-completion
   ```

3. **Start with Phase 0, Day 1:**
   - Begin enum-to-table migration
   - Follow the detailed steps in `enum_migration_tracking.md`
   - Update `task.md` as you complete items

4. **Maintain Communication:**
   - Update task checklist regularly
   - Document any deviations from plan
   - Test thoroughly after each phase

---

## 📚 **Additional Resources**

### **Project Documentation**
- `DOCS NEW 2.0/project_memory.md` - Critical gotchas and lessons learned
- `DOCS NEW 2.0/roadmap_progress.md` - Overall project roadmap

### **Deployment Status**
- `C:\Users\Ihtiram\.gemini\antigravity\brain\ea8bf0c2-462d-4e00-a0e4-86649f8ec7b5\deployment_status.md`

### **Git Workflow**
- `C:\Users\Ihtiram\.gemini\antigravity\brain\ea8bf0c2-462d-4e00-a0e4-86649f8ec7b5\git_workflow_guide.md`

---

## ✅ **Handoff Checklist**

Before starting implementation, ensure:
- [ ] All planning documents reviewed
- [ ] Project context understood
- [ ] Environment setup verified
- [ ] Git branch strategy clear
- [ ] Testing requirements understood
- [ ] Known issues acknowledged
- [ ] Success criteria clear

---

**Ready to implement Phase 2.1: Product Catalog!** 🚀
