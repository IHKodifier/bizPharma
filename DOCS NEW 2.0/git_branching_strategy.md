# bizPharma Git Branching Strategy

**Version**: 1.0  
**Last Updated**: 2026-02-11 09:52:44 +05:00  
**Project**: bizPharma - Cloud-Based Pharmacy Management System

---

## 📊 Current Branch Analysis

### Existing Branches
```
* dev (current)
  feature/location_implementation
  feature/product-catalog-phase2
  fix/staging-app-check
  hotfix/user-and-business-creation-in-production
  main
```

### Current State
- **Active Branch**: `dev`
- **Staged Changes**: 7 files (docs + data connect updates)
- **Main Branch**: Production-ready code
- **Dev Branch**: Integration branch for features

---

## 🌳 Branching Model: GitFlow (Modified)

We'll use a modified GitFlow model optimized for a small team with staging/production environments.

### Branch Hierarchy

```
main (production)
  ↑
  └── dev (staging/integration)
        ↑
        ├── feature/* (new features)
        ├── fix/* (bug fixes)
        └── hotfix/* (production emergencies)
```

---

## 📋 Branch Types & Naming Conventions

### 1. **Main Branch** (`main`)
- **Purpose**: Production-ready code
- **Protection**: Protected, requires PR approval
- **Deployment**: Auto-deploys to production (bizpharma-prod)
- **Merge From**: `dev` only (via PR)
- **Merge To**: Never (only receives merges)

**Rules**:
- ✅ Always deployable
- ✅ Tagged with version numbers (v1.0.0, v1.1.0)
- ❌ No direct commits
- ❌ No force push

---

### 2. **Development Branch** (`dev`)
- **Purpose**: Integration branch for staging
- **Protection**: Protected, requires PR approval
- **Deployment**: Auto-deploys to staging (bizpharma-staging)
- **Merge From**: `feature/*`, `fix/*`
- **Merge To**: `main` (via PR after testing)

**Rules**:
- ✅ Should be stable (all tests passing)
- ✅ Reflects latest integrated features
- ❌ No direct commits (except urgent fixes)
- ❌ No force push

---

### 3. **Feature Branches** (`feature/*`)
- **Purpose**: New feature development
- **Naming**: `feature/<phase>-<feature-name>`
- **Branch From**: `dev`
- **Merge To**: `dev` (via PR)
- **Lifespan**: Until feature complete and merged

**Naming Examples**:
```
feature/phase2-product-catalog
feature/phase2-inventory-core
feature/phase2-pos-core
feature/phase2-customer-management
feature/phase3-batch-tracking
feature/phase3-multi-counter-pos
```

**Rules**:
- ✅ One feature per branch
- ✅ Regular rebases from `dev` to stay current
- ✅ Delete after merge
- ❌ Don't merge other features into your feature branch

---

### 4. **Fix Branches** (`fix/*`)
- **Purpose**: Bug fixes for staging/dev
- **Naming**: `fix/<issue-description>`
- **Branch From**: `dev`
- **Merge To**: `dev` (via PR)
- **Lifespan**: Short (1-2 days max)

**Naming Examples**:
```
fix/auth-token-expiry
fix/inventory-count-mismatch
fix/pos-calculation-error
fix/staging-app-check
```

**Rules**:
- ✅ Fix one bug per branch
- ✅ Include issue/ticket number if available
- ✅ Delete after merge

---

### 5. **Hotfix Branches** (`hotfix/*`)
- **Purpose**: Critical production bugs
- **Naming**: `hotfix/<critical-issue>`
- **Branch From**: `main`
- **Merge To**: `main` AND `dev` (via separate PRs)
- **Lifespan**: Very short (hours)

**Naming Examples**:
```
hotfix/payment-gateway-down
hotfix/user-creation-failure
hotfix/data-loss-bug
```

**Rules**:
- ✅ Only for production emergencies
- ✅ Must merge to both `main` and `dev`
- ✅ Tag with patch version (v1.0.1)
- ⚠️ Requires immediate review and deployment

---

## 🚀 Workflow for Phase 2 Development

### Starting a New Feature

```bash
# 1. Ensure dev is up to date
git checkout dev
git pull origin dev

# 2. Create feature branch
git checkout -b feature/phase2-product-catalog

# 3. Work on feature
# ... make changes ...

# 4. Commit regularly
git add .
git commit -m "feat: implement product list view"

# 5. Push to remote
git push -u origin feature/phase2-product-catalog

# 6. Keep branch updated (daily)
git checkout dev
git pull origin dev
git checkout feature/phase2-product-catalog
git rebase dev

# 7. When complete, create PR to dev
# (via GitHub/GitLab UI)
```

---

### Merging to Dev (Integration)

```bash
# After PR approval:
git checkout dev
git pull origin dev
git merge --no-ff feature/phase2-product-catalog
git push origin dev

# Delete feature branch
git branch -d feature/phase2-product-catalog
git push origin --delete feature/phase2-product-catalog
```

---

### Releasing to Production

```bash
# 1. Ensure dev is tested and stable
# 2. Create PR from dev to main
# 3. After approval and final testing:

git checkout main
git pull origin main
git merge --no-ff dev
git tag -a v1.1.0 -m "Release v1.1.0: Product Catalog"
git push origin main --tags

# 4. Production auto-deploys
```

---

### Hotfix Workflow

```bash
# 1. Branch from main
git checkout main
git pull origin main
git checkout -b hotfix/critical-bug

# 2. Fix the bug
# ... make changes ...
git commit -m "hotfix: fix critical payment bug"

# 3. Merge to main
git checkout main
git merge --no-ff hotfix/critical-bug
git tag -a v1.0.1 -m "Hotfix v1.0.1: Payment bug"
git push origin main --tags

# 4. Merge to dev
git checkout dev
git merge --no-ff hotfix/critical-bug
git push origin dev

# 5. Delete hotfix branch
git branch -d hotfix/critical-bug
git push origin --delete hotfix/critical-bug
```

---

## 📝 Commit Message Conventions

### Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Code style (formatting, no logic change)
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Build/tooling changes

### Examples
```bash
feat(products): implement product list view with search
fix(auth): resolve token expiry issue in staging
docs(api): update Data Connect mutation documentation
refactor(inventory): extract stock calculation to service
test(pos): add unit tests for cart calculations
chore(deps): update Flutter SDK to 3.19.0
```

---

## 🎯 Phase 2 Branching Plan

### Product Catalog Implementation

```
dev
  ├── feature/phase2-product-list-view (Days 1-2)
  ├── feature/phase2-category-management (Days 3-4)
  ├── feature/phase2-product-crud (Days 5-7)
  ├── feature/phase2-product-detail (Days 8-9)
  ├── feature/phase2-barcode-generation (Day 10)
  ├── feature/phase2-barcode-scanning (Days 11-12)
  └── feature/phase2-bulk-import (Days 13-15)
```

### Parallel Development Strategy

**Week 1-2: Product List + Categories**
```bash
# Day 1-2: Product List View
git checkout -b feature/phase2-product-list-view

# Day 3-4: Category Management (can start in parallel)
git checkout -b feature/phase2-category-management
```

**Week 3: Product CRUD**
```bash
# Day 5-7: Product Creation/Edit (depends on categories)
git checkout -b feature/phase2-product-crud
```

**Week 4: Details + Barcodes**
```bash
# Day 8-9: Product Detail View
git checkout -b feature/phase2-product-detail

# Day 10-12: Barcode features (can be parallel)
git checkout -b feature/phase2-barcode-generation
git checkout -b feature/phase2-barcode-scanning
```

**Week 5: Bulk Import**
```bash
# Day 13-15: CSV Import
git checkout -b feature/phase2-bulk-import
```

---

## 🔒 Branch Protection Rules

### For `main` branch:
- ✅ Require pull request reviews (1 approver minimum)
- ✅ Require status checks to pass
- ✅ Require branches to be up to date
- ✅ Require linear history
- ❌ Allow force pushes
- ❌ Allow deletions

### For `dev` branch:
- ✅ Require pull request reviews (1 approver minimum)
- ✅ Require status checks to pass
- ⚠️ Allow force pushes (admin only)
- ❌ Allow deletions

### For `feature/*` branches:
- ❌ No protection (developer freedom)
- ✅ Auto-delete after merge

---

## 📊 Merge Strategies

### Feature → Dev
- **Strategy**: `--no-ff` (create merge commit)
- **Reason**: Preserve feature history
- **Command**: `git merge --no-ff feature/phase2-product-catalog`

### Dev → Main
- **Strategy**: `--no-ff` (create merge commit)
- **Reason**: Clear release points
- **Command**: `git merge --no-ff dev`

### Hotfix → Main/Dev
- **Strategy**: `--no-ff` (create merge commit)
- **Reason**: Track emergency fixes
- **Command**: `git merge --no-ff hotfix/critical-bug`

---

## 🧹 Branch Cleanup Policy

### When to Delete
- ✅ After feature merged to dev
- ✅ After fix merged to dev
- ✅ After hotfix merged to main and dev
- ✅ If feature abandoned

### How to Delete
```bash
# Local
git branch -d feature/phase2-product-catalog

# Remote
git push origin --delete feature/phase2-product-catalog
```

### Stale Branch Review
- **Frequency**: Weekly
- **Criteria**: No commits in 14 days
- **Action**: Contact owner, then delete if inactive

---

## 🔄 Rebase vs Merge

### Use Rebase When:
- ✅ Updating feature branch from dev
- ✅ Cleaning up local commits before PR
- ✅ Keeping feature branch current

```bash
git checkout feature/phase2-product-catalog
git rebase dev
```

### Use Merge When:
- ✅ Integrating feature to dev
- ✅ Releasing dev to main
- ✅ Applying hotfixes

```bash
git merge --no-ff feature/phase2-product-catalog
```

---

## 📅 Release Versioning

### Semantic Versioning: `MAJOR.MINOR.PATCH`

- **MAJOR** (v2.0.0): Breaking changes, major architecture updates
- **MINOR** (v1.1.0): New features, backward compatible
- **PATCH** (v1.0.1): Bug fixes, no new features

### Phase-to-Version Mapping
- **Phase 1 Complete**: v1.0.0 (Foundation)
- **Phase 2 Complete**: v1.1.0 (Core Operations)
- **Phase 3 Complete**: v1.2.0 (Advanced Operations)
- **Phase 4 Complete**: v1.3.0 (Intelligence)
- **Phase 5 Complete**: v2.0.0 (Production Ready)

### Tagging Releases
```bash
# After merging to main
git tag -a v1.1.0 -m "Release v1.1.0: Product Catalog Complete"
git push origin v1.1.0
```

---

## 🚨 Emergency Procedures

### Production is Broken
1. Create hotfix branch from `main`
2. Fix the issue
3. Test locally
4. Merge to `main` (emergency approval)
5. Deploy immediately
6. Merge to `dev`
7. Post-mortem documentation

### Staging is Broken
1. Create fix branch from `dev`
2. Fix the issue
3. Test locally
4. Merge to `dev` (fast-track approval)
5. Verify in staging

### Bad Merge to Dev
```bash
# Revert the merge commit
git revert -m 1 <merge-commit-hash>
git push origin dev
```

---

## 📋 Pre-Merge Checklist

### Before Creating PR
- [ ] All tests passing locally
- [ ] Code follows style guide
- [ ] No console.log or debug code
- [ ] Documentation updated
- [ ] Commit messages follow convention
- [ ] Branch rebased with latest dev

### Before Approving PR
- [ ] Code review completed
- [ ] Tests passing in CI
- [ ] No merge conflicts
- [ ] Feature tested in staging (if merged to dev)
- [ ] Documentation reviewed

---

## 🎯 Immediate Next Steps

### 1. Commit Current Changes
```bash
# Currently on dev with staged changes
git commit -m "docs: add roadmap progress tracking and update implementation plan"
git push origin dev
```

### 2. Create First Feature Branch
```bash
# Start Product List View
git checkout -b feature/phase2-product-list-view
```

### 3. Set Up Branch Protection
- Configure GitHub/GitLab branch protection for `main` and `dev`
- Enable required reviews
- Enable status checks

---

## 📚 Resources

### Git Commands Reference
```bash
# View all branches
git branch -a

# Switch branches
git checkout <branch-name>

# Create and switch
git checkout -b <branch-name>

# Update from remote
git pull origin <branch-name>

# Rebase current branch
git rebase dev

# View commit history
git log --oneline --graph --all

# Clean up merged branches
git branch --merged | grep -v "\\*\\|main\\|dev" | xargs -n 1 git branch -d
```

---

*This branching strategy is designed for the bizPharma project and should be reviewed quarterly as the team and project evolve.*
