# The "Zero to Hero" Production Deployment Cookbook
**For:** bizPharma Projects
**Level:** Absolute Beginner to Pro
**Estimated Time:** 45-60 Minutes

This guide assumes you are starting from scratch. It is a strict, step-by-step tutorial. Do not deviate from the naming conventions unless you know exactly what you are doing.

---

## 🛑 The "Golden Rule" of Naming
Memorize these. We use them in every step.

| Resource Type | **Production Value** (Copy This) | Description |
| :--- | :--- | :--- |
| **Project ID** | `bizpharma-prod` | Unique ID in Google Cloud. |
| **GCP Region** | `asia-south1` | Physical location (Mumbai). |
| **SQL Instance** | `bizpharma-instance` | The Database Server. |
| **SQL Database** | `bizpharma-db` | The specific DB name. |
| **Cloud Run Service** | `bizpharma-api` | The Backend API. |
| **Frontend Domain** | `bizpharma.app` | Main Website. |
| **API Domain** | `api.bizpharma.app` | Backend Address. |

---

## Phase 1: The Foundation (Firebase & GCP)

### Step 1.1: Create the Project
1.  Go to [Firebase Console](https://console.firebase.google.com/).
2.  Click **"Add project"**.
3.  **Name:** `bizPharma Production`.
4.  **Project ID:** Edit this! Change it to `bizpharma-prod`. (If taken, add a number like `bizpharma-prod-01`, but write it down!).
5.  **Google Analytics:** Enable it (Recommended).
6.  Click **Create Project**.

### Step 1.2: Upgrade Billing (MANDATORY)
*Cloud Run and Cloud SQL require a credit card. They won't charge you much (or anything) for low traffic, but you need the "Blaze" plan.*
1.  In Firebase Console, go to **Project Overview (Gear Icon) > Usage and Billing**.
2.  Click **"Details & Settings"** tab.
3.  Change plan from "Spark" to **"Blaze"**.
4.  Set a budget alert (e.g., $10) so you sleep well.

### Step 1.3: Enable APIs
We need to tell Google "Enable the heavy machinery".
1.  Open the [Google Cloud Console](https://console.cloud.google.com/) (select your `bizpharma-prod` project).
2.  Open the **Cloud Shell** (Terminal icon in top right).
3.  Run this command to enable everything we need:
    ```bash
    gcloud services enable \
      run.googleapis.com \
      sqladmin.googleapis.com \
      compute.googleapis.com \
      cloudbuild.googleapis.com \
      secretmanager.googleapis.com \
      firebasedataconnect.googleapis.com
    ```

---

## Phase 2: The Database (Cloud SQL)

### Step 2.1: Create the Instance
1.  Go to **[SQL Instances](https://console.cloud.google.com/sql/instances)**.
2.  Click **Create Instance** -> **PostgreSQL**.
3.  **Instance ID:** `bizpharma-instance`.
4.  **Password:** Click "Generate". **COPY THIS NOW**. Save it as `DB_PASSWORD`.
5.  **Database Version:** PostgreSQL 15 (or latest).
6.  **Configuration Preset:** Choose **"Development"** (cheapest) or "Production" (expensive).
7.  **Region:** `asia-south1` (Mumbai).

### Step 2.2: Networking Security
*Expand the "Connections" section before clicking Create.*
1.  **Public IP:** ✅ CHECKED. (Required for Cloud Run connection).
2.  **Authorized Networks:**
    *   **Leave Empty.** (Do not add 0.0.0.0/0 unless you are actively debugging connection failures).
3.  Click **Create Instance**. (Takes ~5-10 mins).

### Step 2.3: Create the Database & User
1.  Once the instance is ready (Green Checkmark), click on it.
2.  Go to **Databases** tab (Left menu).
    *   Click **Create Database**.
    *   Name: `bizpharma-db`.
    *   Click Create.
3.  Go to **Users** tab.
    *   (Optional) Create a new user for your app, or stick with `postgres`.

---

## Phase 3: The Backend (Cloud Run)

### Step 3.1: Prepare the Code
In your `backend/` folder:
1.  Open `main.py`.
2.  **CRITICAL:** Look for `CORSMiddleware`. Ensure it looks like this:
    ```python
    allow_origins=[
        "https://bizpharma.app",
        "https://www.bizpharma.app",
        "https://api.bizpharma.app",
        # ... other dev URLs
    ]
    ```

### Step 3.2: Deploy to Cloud Run
Run this from your project root in terminal:
```bash
gcloud run deploy bizpharma-api \
  --source ./backend \
  --region asia-south1 \
  --platform managed \
  --allow-unauthenticated \
  --set-env-vars DB_USER=postgres,DB_NAME=bizpharma-db,DB_INSTANCE_CONNECTION_NAME=bizpharma-prod:asia-south1:bizpharma-instance
```
*   `--allow-unauthenticated`: Makes the Login API public (secured by App Check).
*   **Note:** You might need to set `DB_PASS` as a secret instead of a plain env var for security.

---

## Phase 4: Security (App Check & Auth)

### Step 4.1: Configure Firebase
1.  Go to [Firebase App Check](https://console.firebase.google.com/project/bizpharma-prod/app-check).
2.  Click **Get Started**.
3.  Select your **Web App**.
4.  Choose **reCAPTCHA Enterprise**.
5.  It will generate a **Site Key**. Copy this to `lib/config/app_check_config.dart`.

### Step 4.2: The "Double Whitelist" (DO NOT SKIP)
*This is the #1 cause of "403 Forbidden" errors.*

1.  **Google Cloud Credentials:**
    *   Go to [APIs & Services > Credentials](https://console.cloud.google.com/apis/credentials).
    *   Find the **Browser key** (auto-created by Firebase).
    *   Click Edit (Pencil).
    *   Under "Website Restrictions", **Add these 3**:
        1.  `bizpharma.app`
        2.  `bizpharma-prod.firebaseapp.com`
        3.  `bizpharma-prod.web.app`
    *   Click Save.

2.  **ReCAPTCHA Console:**
    *   Go to [Security > reCAPTCHA](https://console.cloud.google.com/security/recaptcha).
    *   Click your Key.
    *   Verify `bizpharma.app` is in the domain list.

---

## Phase 5: Domain & SSL

### Step 5.1: Frontend Domain
1.  Go to [Firebase Hosting](https://console.firebase.google.com/project/bizpharma-prod/hosting).
2.  Click **Add Custom Domain**.
3.  Enter `bizpharma.app`.
4.  Go to your DNS Provider (Namecheap/GoDaddy) and add the **A Records** shown.

### Step 5.2: Backend API Domain
1.  In Firebase Hosting, add another domain: `api.bizpharma.app`.
2.  In DNS Provider, add a **CNAME Record**:
    *   Host: `api`
    *   Value: `bizpharma-prod-api.web.app` (The alias for your API site).
3.  **Wait:** SSL certificates take 30-60 minutes.

---

## Phase 6: The "Pre-Flight" Checklist
**Before you announce "Live", check these:**

*   [ ] **DNS:** Can you ping `api.bizpharma.app`?
*   [ ] **SSL:** does `https://api.bizpharma.app/docs` load with a 🔒 lock icon?
*   [ ] **CORS:** Does `main.py` include the Production Domain?
*   [ ] **App Check:** Is the 403 error gone? (Check Console).
*   [ ] **Database:** Did `firebase deploy --only dataconnect` run successfully? (If failed, use Cloud SQL Studio to create tables).

**Congratulations!** You have deployed a bank-grade secured application. 🚀
