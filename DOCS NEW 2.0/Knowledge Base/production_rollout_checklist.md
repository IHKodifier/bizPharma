# Production Rollout Checklist: bizPharma

**Target Environment**: `bizpharma-prod`
**Primary Domain**: `api.bizpharma.app` (Backend), `bizpharma.app` (Frontend)
**Date**: 2025-12-25

This document is a step-by-step "Hand-Holding" guide to configuring the Production environment. It incorporates all critical lessons learned from the Staging deployment to prevent common failures (CORS, 404s, 401s).

---

## Phase 1: Google Cloud Platform (GCP) Configuration

**Goal**: Prepare the underlying infrastructure and permissions.

### 1.1. Select Project
1.  Go to [Google Cloud Console](https://console.cloud.google.com/).
2.  Select project `bizpharma-prod`.

### 1.2. Enable Required APIs
Ensure the following APIs are enabled (Search in "APIs & Services"):
-   **Cloud Run Admin API**
-   **Artifact Registry API**
-   **Firebase Data Connect API**
-   **Secret Manager API** (Optional, if using Secret Manager)
-   **IAM credentials API**

### 1.3. Service Account Setup (Critical Lesson)
*Ref: Staging Incident #3 & #7*

1.  Navigate to **IAM & Admin** > **Service Accounts**.
2.  Find the **Default Compute Service Account** (ends in `-compute@developer.gserviceaccount.com`).
3.  Copy its email address.
4.  Click the **Pencil Icon** (Edit Principal) for this account in the IAM page.
5.  **Add Role**: `Firebase Admin SDK Administrator Service Agent` (or `roles/firebase.admin`).
    *   *Why?* Without this, the backend cannot execute Data Connect mutations and will fail with `404` or `401`.

---

## Phase 2: Firebase Console Configuration

**Goal**: Configure client-side security and authentication.

### 2.1. Authentication
1.  Go to [Firebase Console](https://console.firebase.google.com/).
2.  Select `bizpharma-prod`.
3.  Navigate to **Authentication** > **Sign-in method**.
4.  Enable **Email/Password** and **Anonymous** providers.
5.  *Lesson Learned*: Ensure the "Authorized Domains" list includes your production domain (`bizpharma.app`) and `bizpharma-prod.firebaseapp.com`.

### 2.2. App Check (reCAPTCHA Enterprise)
*Ref: Staging Incident #2*

1.  Navigate to **App Check**.
2.  Click **Register** for the Web App.
3.  Select **reCAPTCHA Enterprise**.
4.  **Create a NEW Key** specifically for Production.
    *   *Do NOT* reuse the Staging key.
5.  **Copy this Key**. You will need it for Phase 4.

---

## Phase 3: Data Connect & Database

**Goal**: Deploy the schema and infrastructure.

### 3.1. Infrastructure Creation
*Prerequisite*: Ensure Billing is enabled on `bizpharma-prod`.

1.  In your local terminal (VS Code):
    ```bash
    # Login to the production project context
    firebase login
    firebase use bizpharma-prod
    ```

2.  **Provision Cloud SQL & Data Connect**:
    *   *Note*: Since we want a robust setup, rely on the extension to provision or check `dataconnect.yaml`.
    *   Run:
        ```bash
        firebase init dataconnect
        ```
        *   Select `bizpharma-prod`.
        *   Choose region `asia-south1`.
        *   **Important**: Select "Create a new Cloud SQL instance" (e.g., `bizpharma-prod-sql`) OR use the existing one if you shared it. *Recommendation: Use a separate instance for Prod isolation.*

3.  **Deploy Schema**:
    ```bash
    firebase deploy --only dataconnect
    ```
    *   *Verification*: Go to Firebase Console > Data Connect. Ensure "Schema" and "Connectors" are green.

---

## Phase 4: Codebase Configuration

**Goal**: Update the code to recognize the Production environment.

### 4.1. App Check Key
*Ref: Staging Incident #2*

1.  Open `lib/config/app_check_config.dart`.
2.  Replace:
    ```dart
    static const String _prodSiteKey = 'TODO_PROD_KEY';
    ```
    With the **new key** you generated in Step 2.2.

### 4.2. Verify API URL
1.  Open `lib/config/api_config.dart`.
2.  Ensure `https://api.bizpharma.app` is set for production.
    *   *Warning*: If you haven't mapped the domain yet (Phase 6), you might need to temporarily use the Cloud Run URL (like we did for Staging).

---

## Phase 5: GitHub Actions & Secrets

**Goal**: Connect the CI/CD pipeline.

### 5.1. Generate Service Account Key
1.  In GCP Console (`bizpharma-prod`), go to **IAM & Admin** > **Service Accounts**.
2.  Create a **New Service Account** for GitHub Actions (e.g., `github-deployer`).
3.  Grant it: `Cloud Run Admin`, `Service Account User`, `Artifact Registry Writer`.
4.  **Keys** > **Add Key** > **Create new key** > **JSON**.
5.  Download the file.

### 5.2. GitHub Secrets
Go to GitHub Repo > Settings > Secrets > Actions. Add:

1.  `PROD_GCP_SA_KEY`: Paste the **entire JSON content** from Step 5.1.
2.  `FIREBASE_SERVICE_ACCOUNT_BIZPHARMA_PROD`:
    *   Run `firebase init hosting:github` locally to generate this, OR
    *   Create another SA in GCP with `Firebase App Distribution Admin` + `Firebase Hosting Admin` roles and download its JSON.

---

## Phase 6: Final Deployment & Custom Domain

**Goal**: Go Live.

### 6.1. Trigger Deployment
1.  Push your code changes (App Check Key) to `main`.
2.  Watch the `Deploy to Production` workflow in GitHub Actions.

### 6.2. Mapping Custom Domain (The Final Polish)
*Ref: Staging Incident #1*

1.  Once the Cloud Run service (`bizpharma-api`) is deployed in `bizpharma-prod`:
2.  Go to **Cloud Run** > `bizpharma-api` > **Manage Custom Domains**.
3.  Add mapping for `api.bizpharma.app`.
4.  Update your DNS records (A/AAAA) as prompted.
    *   *Critical*: It prevents `ERR_NAME_NOT_RESOLVED`.

---

## Summary of "Staging Lessons" Applied

| What Failed in Staging? | How We Prevent It in Prod |
| :--- | :--- |
| **Old IAM Config** | We manually added `roles/firebase.admin` (Phase 1.3). |
| **CORS Errors** | Code already has `bizpharma.app` in allowed origins. |
| **Auth 401s** | Code now forces IAM Auth (`id_token=None`) for onboarding. |
| **Wrong Hostname** | Code now points to `firebasedataconnect.googleapis.com`. |
| **Missing Keys** | We explicitly update `app_check_config.dart` (Phase 4.1). |
