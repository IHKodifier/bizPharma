# Knowledge Base: Staging Environment Setup & Troubleshooting
**Date**: 2025-12-25
**Status**: Stable
**Related Components**: Cloud Run, Firebase Hosting, App Check, Data Connect, Cloud IAM

## Overview
This document serves as the definitive guide for the **bizPharma Staging Environment**. It documents the architecture, configuration, and the troubleshooting journey required to achieve a stable multi-environment setup.

## 1. Environment Architecture

| Component | Dev Config | Staging Config | Notes |
| :--- | :--- | :--- | :--- |
| **Firebase Project** | `bizpharma-4e73a` | `bizpharma-staging` | Separate projects for isolation. |
| **Frontend URL** | `localhost:3000` | `bizpharma-staging.web.app` | Hosted on Firebase Hosting. |
| **Backend URL** | `localhost:8000` | `bizpharma-api-*.a.run.app` | Hosted on Cloud Run. Custom domain `api-staging` pending. |
| **Database** | Cloud SQL (Dev) | Cloud SQL (Prod Instance) | Staging uses a separate database in the same SQL instance. |
| **Auth Provider** | Identity Platform | Identity Platform | Separate user pools. |

---

## 2. Technical Configuration Requirements

### A. Frontend (Flutter Web)
1.  **Environment Awareness**: The app must be built with `--dart-define=ENVIRONMENT=staging`.
2.  **API Config**: `lib/config/api_config.dart` switches the base URL.
    *   *Critical*: Use the **Direct Cloud Run URL** (e.g., `https://bizpharma-api-7rry5wij4a-el.a.run.app`) until the custom domain DNS is fully propagated.
3.  **App Check**: `lib/config/app_check_config.dart` must load the **Staging reCAPTCHA Key** (`6LcqZjUsAAAAAKtTitPrBwz9hJS1DlXqVRa6Yiao`). Using the Dev key will result in `403 Forbidden`.

### B. Backend (FastAPI / Cloud Run)
1.  **Identity (ADC)**: The backend uses **Application Default Credentials**. It does NOT load a service account JSON file.
2.  **Service Account**: The Cloud Run service runs as the **Default Compute Service Account** (`329922858118-compute@developer.gserviceaccount.com`).
3.  **IAM Permissions**: This Service Account **MUST** have the `roles/firebase.admin` role to interact with Data Connect.
4.  **CORS**:
    *   **Prohibited**: `allow_origins=["*"]` with `allow_credentials=True`.
    *   **Required**: Explicit list of origins (e.g., `["https://bizpharma-staging.web.app"]`).

### C. Data Connect (Connectors)
1.  **Endpoint URL**: **MUST** be `https://firebasedataconnect.googleapis.com`.
    *   *Incorrect*: `https://dataconnect.googleapis.com` (Returns 404 HTML).
2.  **API Version**: Use `v1beta`.
3.  **Authentication Context**:
    *   **Public/User Access**: Often restricted by Gateway policies even if schema is `PUBLIC`.
    *   **Admin Access**: Recommendation is to use **Service Account Credentials** (remove `id_token`) for backend-to-backend operations like User Onboarding to avoid `401 Unauthorized`.

---

## 3. Incident Log: The "Staging Blockers" (Dec 23-25, 2025)

We encountered a "Perfect Storm" of configuration errors. Here is how each was diagnosed and fixed.

| # | Error / Symptom | Root Cause | Fix Applied |
| :--- | :--- | :--- | :--- |
| **1** | `ERR_NAME_NOT_RESOLVED` | Frontend tried to hit `api-staging.bizpharma.app` (DNS not ready). | Switched `api_config.dart` to use Cloud Run URL. |
| **2** | `AppCheck Token Failed` | Staging App used Development reCAPTCHA Key. | Created dynamic `AppCheckConfig`. |
| **3** | Backent `404` / `PermissionDenied` | Cloud Run "Identity" lacked `DataConnect` access. | Granted `roles/firebase.admin` to Cloud Run Service Account. |
| **4** | Browser `CORS Error` (Network) | Backend used Wildcard `*` Origin with Credentials. | Updated `main.py` to allow specific origins only. |
| **5** | `500 Internal Server Error` | Backend crashed on logging (`NameError: logger`). | Restored accidentally deleted `logging` setup in `main.py`. |
| **6** | `404 Client Error` (HTML Body) | Backend hit `dataconnect.googleapis.com` (Wrong Host). | Updated settings to `firebasedataconnect.googleapis.com`. |
| **7** | `401 Unauthorized` | Data Connect rejected Anonymous User ID Token. | Refactored `initialization.py` to use IAM (Service Account) Auth. |

## 4. Verification Checklist

To verify the Staging environment anytime:
- [ ] **Frontend**: Loads without console errors. "Free Trial" button works.
- [ ] **Auth**: Popup opens, User created in Firebase Console `bizpharma-staging` > Auth.
- [ ] **Backend**:
    - [ ] Access `/` (Root) -> Returns `{"status": "running"}`.
    - [ ] Access `/api/v1/setup/initialize` (OPTIONS) -> Returns `200 OK`.
- [ ] **Data Connect**:
    - [ ] Backend logs show `EXECUTING GQL` -> `Data Connect Response [200]`.
    - [ ] Business and User records appear in `bizpharma-staging` database.
