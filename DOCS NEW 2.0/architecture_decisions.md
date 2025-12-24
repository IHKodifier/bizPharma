# bizPharma Architecture & Design Decisions

> **Knowledge Document**: Comprehensive record of architectural decisions, design patterns, and coding approaches for the bizPharma multi-environment infrastructure.
> 
> **Created**: 2025-12-21  
> **Purpose**: Reference for future development and AI coding agents

---

## Table of Contents

1. [Multi-Environment Strategy](#multi-environment-strategy)
2. [Backend Architecture](#backend-architecture)
3. [CI/CD Pipeline Design](#cicd-pipeline-design)
4. [Data Connect & Database](#data-connect--database)
5. [Security & Authentication](#security--authentication)
6. [Critical Bug Fixes](#critical-bug-fixes)
7. [Deployment Troubleshooting Patterns](#deployment-troubleshooting-patterns)

---

## Multi-Environment Strategy

### Environment Separation

**Decision**: Implement three distinct Firebase projects for environment isolation.

| Environment | Firebase Project ID | Purpose |
|-------------|-------------------|---------|
| Development | `bizpharma-4e73a` | Local development with emulators |
| Staging | `bizpharma-staging` | Pre-production testing |
| Production | `bizpharma-prod` | Live production system |

**Rationale**:
- **Data Isolation**: Prevents test data from contaminating production
- **Safe Testing**: Allows testing of schema migrations and breaking changes
- **Cost Control**: Staging uses minimal resources (`db-f1-micro`)
- **Deployment Confidence**: Validate changes in Staging before Production

### Branch-to-Environment Mapping

```yaml
Git Branch → Environment
├── dev → Staging (bizpharma-staging)
├── hotfix/* → Staging (bizpharma-staging)
└── main → Production (bizpharma-prod)
```

**Key Files**:
- [.github/workflows/backend-deploy.yml](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/.github/workflows/backend-deploy.yml)
- [.github/workflows/deploy.yml](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/.github/workflows/deploy.yml)

---

## Backend Architecture

### Dockerization Strategy

**Decision**: Containerize FastAPI backend for Cloud Run deployment.

**Dockerfile Design** ([backend/Dockerfile](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/backend/Dockerfile)):

```dockerfile
FROM python:3.11-slim
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Expose port and run
EXPOSE 8080
CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port ${PORT:-8080}"]
```

**Key Decisions**:
1. **Port Configuration**: Use `${PORT:-8080}` to respect Cloud Run's `PORT` env var
2. **Slim Base Image**: `python:3.11-slim` reduces image size
3. **Build Essentials**: Required for compiling Python packages (e.g., `cryptography`)
4. **Layer Optimization**: Dependencies installed before code copy for better caching

### Application Default Credentials (ADC)

**Problem**: Cloud Run containers don't have access to [serviceAccountKey.json](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/backend/serviceAccountKey.json) files.

**Solution**: Implement ADC fallback in [backend/config/firebase_config.py](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/backend/config/firebase_config.py):

```python
def initialize(self) -> firebase_admin.App:
    cred_path = settings.FIREBASE_CREDENTIALS_PATH
    
    # Check if credentials file exists
    if os.path.exists(cred_path):
        print(f"🔑 Using local service account key at: {cred_path}")
        cred = credentials.Certificate(cred_path)
    else:
        if settings.ENV != "DEV":
            print(f"🌐 Service account key not found. Using Application Default Credentials (ADC).")
            cred = None  # Firebase SDK will use ADC
        else:
            raise FileNotFoundError(f"Firebase service account key not found at {cred_path}")
    
    self._app = firebase_admin.initialize_app(cred, {
        'databaseURL': settings.database_url,
        'projectId': settings.FIREBASE_PROJECT_ID,
    })
```

**Rationale**:
- **Cloud-Native**: Leverages Google Cloud's built-in service account authentication
- **Security**: No need to embed credentials in container images
- **Local Development**: Still supports explicit key files for emulator testing

### Environment-Aware Configuration

**Pattern**: Use environment variables to configure project-specific settings.

[backend/config/settings.py](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/backend/config/settings.py):

```python
class Settings(BaseSettings):
    ENV: Literal["DEV", "STAGING", "PROD"] = "DEV"
    
    DEV_PROJECT_ID: str = "bizpharma-4e73a"
    STAGING_PROJECT_ID: str = "bizpharma-staging"
    PROD_PROJECT_ID: str = "bizpharma-prod"
    
    @property
    def FIREBASE_PROJECT_ID(self) -> str:
        if self.ENV == "PROD":
            return self.PROD_PROJECT_ID
        elif self.ENV == "STAGING":
            return self.STAGING_PROJECT_ID
        return self.DEV_PROJECT_ID
    
    @property
    def DATA_CONNECT_ENDPOINT(self) -> str:
        if self.ENV == "DEV":
            return "http://127.0.0.1:9399"
        return "https://dataconnect.googleapis.com"
```

**Benefits**:
- Single codebase for all environments
- Type-safe configuration with Pydantic
- Clear separation of concerns

---

## CI/CD Pipeline Design

### Backend Deployment Workflow

**File**: [.github/workflows/backend-deploy.yml](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/.github/workflows/backend-deploy.yml)

**Key Design Decisions**:

1. **Dynamic Environment Selection**:
```yaml
- name: Set Environment Variables
  run: |
    if [[ "${{ github.ref }}" == "refs/heads/main" ]]; then
      echo "GCP_PROJECT_ID=${{ env.PROJECT_ID_PROD }}" >> $GITHUB_ENV
      echo "ENV_NAME=production" >> $GITHUB_ENV
    else
      echo "GCP_PROJECT_ID=${{ env.PROJECT_ID_STAGING }}" >> $GITHUB_ENV
      echo "ENV_NAME=staging" >> $GITHUB_ENV
    fi
```

2. **Artifact Registry Strategy**:
   - **Repository Name**: [backend](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/backend) (explicit, not auto-generated)
   - **Image Tagging**: `latest` (simplicity over versioning for now)
   - **Location**: `asia-south1` (matches Cloud Run region)

3. **Environment Variables Injection**:
```yaml
env_vars: |
  ENV=${{ env.ENV_NAME == 'production' && 'PROD' || 'STAGING' }}
  FIREBASE_PROJECT_ID=${{ env.GCP_PROJECT_ID }}
```

### Frontend Deployment Workflow

**File**: [.github/workflows/deploy.yml](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/.github/workflows/deploy.yml)

**Critical Pattern**: Direct secret referencing (avoid multi-line JSON issues)

```yaml
# ❌ WRONG - Causes parsing errors
firebaseServiceAccount: ${{ secrets.FIREBASE_SERVICE_ACCOUNT }}

# ✅ CORRECT - Direct reference
firebaseServiceAccount: ${{ github.ref == 'refs/heads/main' && secrets.FIREBASE_SERVICE_ACCOUNT_BIZPHARMA_PROD || secrets.FIREBASE_SERVICE_ACCOUNT_BIZPHARMA_STAGING }}
```

**Lesson Learned**: GitHub Actions has issues with multi-line secrets in YAML. Always use direct `${{ secrets.NAME }}` syntax.

### Required GitHub Secrets

| Secret Name | Type | Purpose |
|-------------|------|---------|
| `PROD_GCP_SA_KEY` | JSON | Service Account for Production Cloud Run |
| `STAGING_GCP_SA_KEY` | JSON | Service Account for Staging Cloud Run |
| `FIREBASE_SERVICE_ACCOUNT_BIZPHARMA_PROD` | JSON | Firebase Hosting deployment (Production) |
| `FIREBASE_SERVICE_ACCOUNT_BIZPHARMA_STAGING` | JSON | Firebase Hosting deployment (Staging) |
| `FIREBASE_SERVICE_ACCOUNT_BIZPHARMA_4E73A` | JSON | Firebase Hosting deployment (Development) |

**Format**: All secrets must contain the **full JSON Service Account Key**, not just the API key.

---

## Data Connect & Database

### Cloud SQL Configuration

**Instance Specifications** (Staging):
```yaml
Instance Name: bizpharma-instance
Database Version: POSTGRES_15
Tier: db-f1-micro
Region: asia-south1
Public IP: Enabled
Authorized Networks: 0.0.0.0/0  # Required for Firebase Data Connect
```

**Rationale**:
- **Public IP Required**: Firebase Data Connect service needs network access to Cloud SQL
- **Minimal Tier**: `db-f1-micro` sufficient for staging workloads
- **Regional Alignment**: Same region as Cloud Run (`asia-south1`) for low latency

### Data Connect Service Configuration

**File**: [dataconnect/dataconnect.yaml](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/dataconnect/dataconnect.yaml)

```yaml
specVersion: 'v1alpha'
serviceId: bizpharma-service
location: asia-south1
schema:
  source: "./schema"
  datasource:
    postgresql:
      database: "bizpharma-db"
      cloudSql:
        instanceId: "bizpharma-instance"
connectorDirs: ["./connector"]
```

**Key Decisions**:
1. **Service ID**: `bizpharma-service` (locked, referenced in backend)
2. **Connector ID**: `biz-pharma` (locked, referenced in backend)
3. **Location**: `asia-south1` (matches Cloud SQL and Cloud Run)

### Schema Deployment Process

**Critical Steps** (in order):

1. **Create Cloud SQL Instance**:
```bash
gcloud sql instances create bizpharma-instance \
  --database-version=POSTGRES_15 \
  --tier=db-f1-micro \
  --region=asia-south1 \
  --project=bizpharma-staging
```

2. **Enable Public IP Access**:
```bash
gcloud sql instances patch bizpharma-instance \
  --assign-ip \
  --authorized-networks=0.0.0.0/0 \
  --project=bizpharma-staging
```

3. **Migrate Database Schema**:
```bash
firebase dataconnect:sql:migrate --project bizpharma-staging --force
```

4. **Deploy Data Connect Service**:
```bash
firebase deploy --only dataconnect --project bizpharma-staging --force
```

**Why `--force` Flag?**:
- Bypasses security warnings for publicly accessible operations
- Required for `@auth(level: PUBLIC)` operations (e.g., `CreateBusinessAndAdmin`)
- Acceptable for onboarding flows that allow anonymous user registration

---

## Security & Authentication

### IAM Permissions for CI/CD

**Problem**: GitHub Actions service account needs permissions to push Docker images and deploy to Cloud Run.

**Solution**: Grant comprehensive roles to Firebase Admin SDK service account:

```bash
# For bizpharma-staging
gcloud projects add-iam-policy-binding bizpharma-staging \
  --member="serviceAccount:firebase-adminsdk-fbsvc@bizpharma-staging.iam.gserviceaccount.com" \
  --role="roles/artifactregistry.admin"

gcloud projects add-iam-policy-binding bizpharma-staging \
  --member="serviceAccount:firebase-adminsdk-fbsvc@bizpharma-staging.iam.gserviceaccount.com" \
  --role="roles/run.admin"

gcloud projects add-iam-policy-binding bizpharma-staging \
  --member="serviceAccount:firebase-adminsdk-fbsvc@bizpharma-staging.iam.gserviceaccount.com" \
  --role="roles/iam.serviceAccountUser"
```

**Rationale**:
- **Artifact Registry Admin**: Push Docker images
- **Cloud Run Admin**: Deploy and manage services
- **Service Account User**: Impersonate service accounts for deployment

### Cloud Run Public Access

**Decision**: Make Cloud Run services publicly accessible for API endpoints.

```bash
gcloud run services add-iam-policy-binding bizpharma-api \
  --member="allUsers" \
  --role="roles/run.invoker" \
  --region asia-south1 \
  --project bizpharma-staging
```

**Rationale**:
- API needs to be accessible from frontend (Firebase Hosting)
- Authentication handled at application level (Firebase ID tokens)
- Standard practice for public APIs

---

## Critical Bug Fixes

### 1. Request Body Stream Consumption

**Problem**: Middleware consumed request body, causing Pydantic validation to fail with 422 errors.

**File**: [backend/main.py](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/backend/main.py)

**Solution**:
```python
class RequestResponseLoggingMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request: Request, call_next):
        # Read body for logging
        request_body = await request.body()
        logger.debug(f"Request Body: {request_body}")
        
        # CRITICAL FIX: Re-create receive channel
        async def receive():
            return {"type": "http.request", "body": request_body, "more_body": False}
        request._receive = receive
        
        response = await call_next(request)
        return response
```

**Lesson**: Always restore request stream after consuming it in middleware.

### 2. Phone Number Field Length

**Problem**: Database schema constraint (`VARCHAR(15)`) caused silent truncation or validation errors.

**File**: [backend/modules/setup/initialization.py](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/backend/modules/setup/initialization.py)

**Solution**:
```python
# Sanitize phone number to match schema constraints
sanitized_phone = (data.phone or "").strip()
if len(sanitized_phone) > 15:
    sanitized_phone = sanitized_phone[:15]
    print(f"⚠️ Truncated phone number: {data.phone} -> {sanitized_phone}")
```

**Lesson**: Always validate data against database constraints before insertion.

### 3. Missing `email-validator` Dependency

**Problem**: Cloud Run container failed to start with `ModuleNotFoundError: No module named 'email_validator'`.

**Root Cause**: `pydantic[email]` requires `email-validator`, but it wasn't in [requirements.txt](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/backend/requirements.txt).

**Solution**: Add to [backend/requirements.txt](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/backend/requirements.txt):
```
email-validator>=2.1.0.post1
```

**Lesson**: Always check Pydantic extras dependencies when using specialized field types.

---

## Deployment Troubleshooting Patterns

### Pattern 1: Cloud Run Health Check Failures

**Symptom**: `The user-provided container failed to start and listen on the port defined by PORT=8080`

**Diagnostic Steps**:
1. Check Cloud Run logs:
```bash
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=bizpharma-api" \
  --project bizpharma-staging \
  --limit 30 \
  --format="value(textPayload,jsonPayload.message)"
```

2. Look for:
   - Import errors (missing dependencies)
   - Configuration errors (missing env vars)
   - Port binding issues

**Common Fixes**:
- Add missing dependencies to [requirements.txt](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/backend/requirements.txt)
- Verify `CMD` in Dockerfile uses `${PORT:-8080}`
- Check application startup logs for exceptions

### Pattern 2: Artifact Registry Permission Denied

**Symptom**: `denied: Permission "artifactregistry.repositories.uploadArtifacts" denied`

**Root Cause**: Service account lacks Artifact Registry permissions.

**Fix**:
```bash
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="serviceAccount:SA_EMAIL" \
  --role="roles/artifactregistry.admin"
```

### Pattern 3: Data Connect Connection Timeout

**Symptom**: `Connection terminated due to connection timeout` during `firebase deploy --only dataconnect`

**Root Cause**: Cloud SQL instance not configured for public IP access.

**Fix**:
```bash
gcloud sql instances patch INSTANCE_NAME \
  --assign-ip \
  --authorized-networks=0.0.0.0/0 \
  --project PROJECT_ID
```

**Security Note**: For production, restrict `authorized-networks` to specific IP ranges.

### Pattern 4: Schema Migration Required

**Symptom**: `Your database schema is incompatible with your Data Connect schema`

**Fix**:
```bash
firebase dataconnect:sql:migrate --project PROJECT_ID --force
```

**Then**:
```bash
firebase deploy --only dataconnect --project PROJECT_ID --force
```

---

## Best Practices Summary

### Development Workflow

1. **Always test in Staging first**: Deploy to `dev` branch → Staging environment
2. **Verify health endpoints**: Check `/health` and `/docs` after deployment
3. **Monitor logs**: Use `gcloud logging read` for real-time debugging
4. **Use `--force` judiciously**: Only for known breaking changes or security warnings

### Code Organization

1. **Environment-specific logic**: Use `settings.ENV` property pattern
2. **Credential management**: Prefer ADC over embedded keys
3. **Error handling**: Always log and re-raise in initialization code
4. **Validation**: Sanitize data before database operations

### CI/CD Hygiene

1. **Secret format**: Always use full JSON Service Account Keys
2. **Direct references**: Avoid intermediate variables for secrets
3. **Explicit naming**: Use descriptive names for Artifact Registry repositories
4. **Region consistency**: Keep all resources in same region (`asia-south1`)

---

## Future Considerations

### Production Deployment Checklist

When deploying to Production (`bizpharma-prod`):

- [ ] Create Cloud SQL instance (`bizpharma-instance`)
- [ ] Deploy Data Connect schema and service
- [ ] Grant IAM permissions to service account
- [ ] Enable required APIs (Cloud Run, Artifact Registry, Data Connect)
- [ ] Configure custom domain (`api.bizpharma.app`)
- [ ] Set up Cloud SQL backups and maintenance windows
- [ ] Restrict Cloud SQL authorized networks to specific IPs
- [ ] Configure alerting and monitoring
- [ ] Test onboarding flow end-to-end

### Scaling Considerations

1. **Cloud SQL Tier**: Upgrade from `db-f1-micro` to `db-n1-standard-1` or higher
2. **Connection Pooling**: Implement PgBouncer for high-concurrency workloads
3. **Cloud Run Concurrency**: Tune `containerConcurrency` based on load testing
4. **Caching**: Add Redis for session management and API response caching

---

## References

### Key Files

- **Backend**: [backend/main.py](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/backend/main.py)
- **Configuration**: [backend/config/settings.py](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/backend/config/settings.py)
- **Firebase Config**: [backend/config/firebase_config.py](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/backend/config/firebase_config.py)
- **Backend CI/CD**: [.github/workflows/backend-deploy.yml](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/.github/workflows/backend-deploy.yml)
- **Frontend CI/CD**: [.github/workflows/deploy.yml](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/.github/workflows/deploy.yml)
- **Data Connect Config**: [dataconnect/dataconnect.yaml](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/dataconnect/dataconnect.yaml)

### Console URLs

- **Staging Project**: https://console.firebase.google.com/project/bizpharma-staging
- **Production Project**: https://console.firebase.google.com/project/bizpharma-prod
- **Data Connect (Staging)**: https://console.firebase.google.com/project/bizpharma-staging/dataconnect

### Deployed Services

- **Staging Backend**: https://bizpharma-api-7rry5wij4a-el.a.run.app
- **Staging Frontend**: https://bizpharma-staging.web.app

---

---

## Firebase Console Configuration Requirements

### Critical Browser-Based Setup (Cannot Be Automated)

**IMPORTANT**: The following configurations **MUST** be done manually via the Firebase Console for each environment. These settings cannot be configured via CLI or CI/CD pipelines.

### 1. Firebase Authentication Sign-In Methods

**Problem**: By default, Firebase projects have **NO** sign-in methods enabled. Applications will fail to authenticate users until these are configured.

**Required for**: Both Staging and Production

**Steps**:

#### For Staging
1. Navigate to: https://console.firebase.google.com/project/bizpharma-staging/authentication/providers
2. Click **"Get Started"** (if shown)
3. Go to **"Sign-in method"** tab
4. Enable the following providers:

**Anonymous Authentication** (CRITICAL):
- Click on "Anonymous"
- Toggle **Enable**
- Click **Save**
- **Why**: Required for initial app access and onboarding flow

**Google Sign-In** (CRITICAL):
- Click on "Google"
- Toggle **Enable**
- Select support email
- Click **Save**
- **Why**: Primary authentication method for user accounts

**Email/Password** (Optional):
- Click on "Email/Password"
- Toggle **Enable**
- Click **Save**
- **Why**: Alternative authentication method

#### For Production
Repeat all steps above for: https://console.firebase.google.com/project/bizpharma-prod/authentication/providers

**Verification**:
```bash
# Check if auth is working
curl https://STAGING_FRONTEND_URL
# Should load without CORS errors
```

---

### 2. OAuth Consent Screen Configuration

**Problem**: Google Sign-In requires OAuth consent screen configuration. Without it, users will see "Error 400: redirect_uri_mismatch" or similar errors.

**Required for**: Both Staging and Production (if using Google Sign-In)

**Steps**:

#### For Staging (Based on Current GCP Interface)

**Starting Point**: You're likely on the "OAuth Overview" page (showing metrics).

1. **Navigate to OAuth consent screen**:
   - In the **left sidebar**, look for "OAuth consent screen" 
   - Click on **"OAuth consent screen"** (it should be in the sidebar under "Google Auth Platform")
   - OR directly navigate to: https://console.cloud.google.com/apis/credentials/consent?project=bizpharma-staging

2. **Initial Setup** (First time only):
   - You'll see a page asking you to configure the consent screen
   - Under "User Type", select **"External"**
   - Click the **"CREATE"** button

3. **OAuth consent screen** (Step 1 of 4):
   - **App information**:
     - **App name**: Enter `bizPharma (Staging)`
     - **User support email**: Select your email from the dropdown
     - **App logo**: (Optional - can skip)
   - **App domain** (Optional - can skip for now):
     - Application home page: (leave blank)
     - Application privacy policy link: (leave blank)
     - Application terms of service link: (leave blank)
   - **Authorized domains**: (leave blank for now, Firebase domains are auto-added)
   - **Developer contact information**:
     - **Email addresses**: Enter your email address
   - Scroll down and click **"SAVE AND CONTINUE"**

4. **Scopes** (Step 2 of 4):
   - Click **"ADD OR REMOVE SCOPES"** button
   - A panel will slide in from the right
   - In the **"Filter"** search box at the top, type: `userinfo.email`
   - Find and check these three scopes:
     - ✅ `.../auth/userinfo.email` - View your email address
     - ✅ `.../auth/userinfo.profile` - See your personal info
     - ✅ `openid` - Associate you with your personal info on Google
   - Click **"UPDATE"** button at the bottom of the panel
   - Click **"SAVE AND CONTINUE"**

5. **Test users** (Step 3 of 4) - **IMPORTANT for Staging**:
   - Click **"+ ADD USERS"** button
   - A dialog will appear
   - Enter email addresses (one per line):
     - Your email address
     - Any team member emails who need to test
   - Click **"ADD"** button
   - Click **"SAVE AND CONTINUE"**

6. **Summary** (Step 4 of 4):
   - Review all your settings
   - Click **"BACK TO DASHBOARD"** button

**Publishing Status**: Your app will be in "Testing" mode. This is perfect for Staging - only the test users you added can sign in.

**Verification**: After completing, you should see:
- Publishing status: "Testing"
- Test users: Your email(s) listed
- User type: External

#### For Production
1. Navigate to: https://console.cloud.google.com/apis/credentials/consent?project=bizpharma-prod
2. Follow same steps as Staging, but:
   - **App name**: `bizPharma` (without "Staging")
   - **Publishing status**: Keep as "Testing" initially, then submit for verification when ready

**Rationale**:
- OAuth consent screen is required by Google for any app using Google Sign-In
- "External" type allows any Google account to sign in (after verification for Production)
- Test users list is required in "Testing" mode

---

### 3. Authorized Domains

**Problem**: Firebase Auth will reject authentication requests from domains not in the authorized list.

**Required for**: Both Staging and Production

**Steps**:

#### For Staging
1. Navigate to: https://console.firebase.google.com/project/bizpharma-staging/authentication/settings
2. Scroll to **"Authorized domains"** section
3. Verify these domains are listed:
   - `bizpharma-staging.web.app` ✅ (Auto-added by Firebase Hosting)
   - `bizpharma-staging.firebaseapp.com` ✅ (Auto-added by Firebase Hosting)
   - `localhost` ✅ (Auto-added for local development)
4. If missing, click **"Add domain"** and add them

#### For Production
1. Navigate to: https://console.firebase.google.com/project/bizpharma-prod/authentication/settings
2. Verify these domains:
   - `bizpharma-prod.web.app` ✅
   - `bizpharma-prod.firebaseapp.com` ✅
   - `localhost` ✅
3. When adding custom domain:
   - Add `bizpharma.app` (or your custom domain)
   - Add `www.bizpharma.app` (if using www subdomain)

**Rationale**:
- Security measure to prevent unauthorized domains from using your Firebase project
- Firebase Hosting domains are usually auto-added, but verify to be safe
- Custom domains must be manually added

---

### 4. API Enablement Verification

**Note**: Most APIs are enabled via CLI during deployment, but it's good to verify in the console.

**Check these are enabled**:

#### For Staging
Navigate to: https://console.cloud.google.com/apis/dashboard?project=bizpharma-staging

Verify:
- ✅ Cloud Run API
- ✅ Artifact Registry API
- ✅ Cloud SQL Admin API
- ✅ Firebase Data Connect API
- ✅ Identity Toolkit API (Firebase Auth)
- ✅ Cloud Build API

#### For Production
Navigate to: https://console.cloud.google.com/apis/dashboard?project=bizpharma-prod

Verify same list as Staging.

**If any are missing**:
```bash
gcloud services enable SERVICE_NAME.googleapis.com --project PROJECT_ID
```

---

### 5. Firebase Hosting Configuration (Auto-Configured)

**Note**: This is automatically configured by `firebase deploy`, but verify if issues occur.

**Staging**: https://console.firebase.google.com/project/bizpharma-staging/hosting/sites  
**Production**: https://console.firebase.google.com/project/bizpharma-prod/hosting/sites

**Expected Configuration**:
- **Site name**: Auto-generated (e.g., `bizpharma-staging`)
- **Domains**: `bizpharma-staging.web.app`, `bizpharma-staging.firebaseapp.com`
- **Deploy status**: Should show recent deployments from GitHub Actions

---

## Pre-Deployment Checklist

### Before Testing Staging

- [ ] **Firebase Auth - Anonymous**: Enabled in Console
- [ ] **Firebase Auth - Google**: Enabled in Console
- [ ] **OAuth Consent Screen**: Configured with app name and support email
- [ ] **Authorized Domains**: Verified `bizpharma-staging.web.app` is listed
- [ ] **Cloud SQL Instance**: Created and running (`bizpharma-instance`)
- [ ] **Data Connect Service**: Deployed (`bizpharma-service`)
- [ ] **Cloud Run Backend**: Deployed and healthy (`bizpharma-api`)
- [ ] **Frontend Hosting**: Deployed (`bizpharma-staging.web.app`)

### Before Deploying to Production

- [ ] **All Staging Checklist Items**: Completed and tested
- [ ] **Firebase Auth - Anonymous**: Enabled in Console (Production)
- [ ] **Firebase Auth - Google**: Enabled in Console (Production)
- [ ] **OAuth Consent Screen**: Configured for Production
- [ ] **Authorized Domains**: Includes production domains
- [ ] **Cloud SQL Instance**: Created with backups enabled
- [ ] **Data Connect Service**: Deployed to Production
- [ ] **Cloud Run Backend**: Deployed to Production
- [ ] **Custom Domain**: Configured (if applicable)
- [ ] **Monitoring & Alerts**: Set up in Cloud Console

---

## Common Authentication Errors

### Error: "auth/operation-not-allowed"

**Symptom**: Users cannot sign in, error message indicates operation not allowed.

**Root Cause**: Sign-in method not enabled in Firebase Console.

**Fix**: Enable the required sign-in method (Anonymous, Google, etc.) in Firebase Console → Authentication → Sign-in method.

---

### Error: "redirect_uri_mismatch"

**Symptom**: Google Sign-In fails with redirect URI mismatch error.

**Root Cause**: OAuth consent screen not configured or authorized domains missing.

**Fix**:
1. Configure OAuth consent screen in Google Cloud Console
2. Verify authorized domains in Firebase Console → Authentication → Settings

---

### Error: "auth/unauthorized-domain"

**Symptom**: Authentication fails with "unauthorized domain" error.

**Root Cause**: Domain not in authorized domains list.

**Fix**: Add the domain to Firebase Console → Authentication → Settings → Authorized domains.

---

## Quick Reference Links

### Staging Configuration URLs

| Configuration | URL |
|---------------|-----|
| Firebase Auth Providers | https://console.firebase.google.com/project/bizpharma-staging/authentication/providers |
| OAuth Consent Screen | https://console.cloud.google.com/apis/credentials/consent?project=bizpharma-staging |
| Authorized Domains | https://console.firebase.google.com/project/bizpharma-staging/authentication/settings |
| API Dashboard | https://console.cloud.google.com/apis/dashboard?project=bizpharma-staging |
| Cloud SQL Instances | https://console.cloud.google.com/sql/instances?project=bizpharma-staging |
| Data Connect | https://console.firebase.google.com/project/bizpharma-staging/dataconnect |
| Cloud Run Services | https://console.cloud.google.com/run?project=bizpharma-staging |

### Production Configuration URLs

| Configuration | URL |
|---------------|-----|
| Firebase Auth Providers | https://console.firebase.google.com/project/bizpharma-prod/authentication/providers |
| OAuth Consent Screen | https://console.cloud.google.com/apis/credentials/consent?project=bizpharma-prod |
| Authorized Domains | https://console.firebase.google.com/project/bizpharma-prod/authentication/settings |
| API Dashboard | https://console.cloud.google.com/apis/dashboard?project=bizpharma-prod |
| Cloud SQL Instances | https://console.cloud.google.com/sql/instances?project=bizpharma-prod |
| Data Connect | https://console.firebase.google.com/project/bizpharma-prod/dataconnect |
| Cloud Run Services | https://console.cloud.google.com/run?project=bizpharma-prod |

---

**Document Version**: 2.0  
**Last Updated**: 2025-12-22  
**Maintained By**: Development Team
