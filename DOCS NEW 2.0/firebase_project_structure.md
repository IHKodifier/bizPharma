# Firebase Project Structure - bizPharma

## Project Environments

### 🔧 Development: `bizpharma-4e73a`
**Purpose:** Local development and hotfix testing

**Triggers:**
- Hotfix branches (`hotfix/*`)
- Manual local development

**Configuration:**
- Project Number: 381385750800
- Region: asia-south1
- App Check: Debug mode
- GitHub Secret: `FIREBASE_SERVICE_ACCOUNT_BIZPHARMA_4E73A`

---

### 🧪 Staging: `bizpharma-staging`
**Purpose:** Pre-production testing and verification

**Triggers:**
- `dev` branch pushes
- Manual deployments for testing

**Configuration:**
- Project Number: 563584335869
- Region: asia-south1
- Data Connect Service: bizpharma-service
- Connector: biz-pharma
- App Check: Currently ENABLED (re-enabled 2026-02-08)
- GitHub Secret: `FIREBASE_SERVICE_ACCOUNT_BIZPHARMA_STAGING`
- URL: https://bizpharma-staging.web.app

---

### 🚀 Production: `bizpharma-prod`
**Purpose:** Live production environment

**Triggers:**
- `main` branch pushes
- Production releases

**Configuration:**
- Region: asia-south1
- App Check: **MUST BE ENABLED** (production reCAPTCHA)
- Connectivity Overlay: **MUST BE DISABLED**
- GitHub Secret: `FIREBASE_SERVICE_ACCOUNT_BIZPHARMA_PROD`
- URL: https://bizpharma.app (or production domain)

---

## GitHub Actions Workflow Mapping

From `.github/workflows/deploy.yml`:

```yaml
if [[ "${{ github.ref }}" == "refs/heads/main" ]]; then
  echo "PROJECT_ID=bizpharma-prod" >> $GITHUB_ENV      # ✅ PRODUCTION
  echo "BUILD_ENV=production" >> $GITHUB_ENV
elif [[ "${{ github.ref }}" == "refs/heads/dev" ]]; then
  echo "PROJECT_ID=bizpharma-staging" >> $GITHUB_ENV   # ✅ STAGING
  echo "BUILD_ENV=staging" >> $GITHUB_ENV
else
  echo "PROJECT_ID=bizpharma-4e73a" >> $GITHUB_ENV     # ✅ DEVELOPMENT
  echo "BUILD_ENV=development" >> $GITHUB_ENV
fi
```

---

## Deployment Commands

### Deploy to Development
```bash
firebase deploy --only dataconnect --project bizpharma-4e73a
```

### Deploy to Staging
```bash
firebase deploy --only dataconnect --project bizpharma-staging
```

### Deploy to Production
```bash
firebase deploy --only dataconnect --project bizpharma-prod
```

---

## Key Takeaways

1. **bizpharma-4e73a** = Development (NOT production!)
2. **bizpharma-staging** = Staging
3. **bizpharma-prod** = Production ✅

**For production deployment, always use `bizpharma-prod`!**
