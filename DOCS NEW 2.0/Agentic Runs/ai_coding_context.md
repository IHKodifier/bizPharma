# bizPharma - Technical Context for AI Agents
**Version:** 2.0 (Production Ready)
**Last Updated:** Dec 2025

## 1. Project Overview & Philosophy
**bizPharma** is a multi-tenant pharmacy management system designed for high availability and strict security.
*   **Core Philosophy:** "Secure by Default". App Check is enforced, CORS is restricted, and environment detection is strict.
*   **Architecture:** Decoupled Frontend (Flutter) and Backend (FastAPI), connected via a secure API Gateway pattern (Firebase Hosting Proxy).

## 2. Infrastructure Map (The "Territory")

### Frontend (Flutter Web)
*   **Hosting:** Firebase Hosting (Target: `bizpharma-prod`).
*   **Domain:** `https://bizpharma.app`
*   **Environment Detection:** 
    *   **Logic:** `lib/firebase_options.dart` uses `Uri.base.host`.
    *   **Rule:** If host is `bizpharma.app`, force `webProd` options. Do NOT rely on `kReleaseMode` alone.

### Backend (Python FastAPI)
*   **Compute:** Google Cloud Run.
*   **Service Name:** `bizpharma-api`.
*   **Region:** `asia-south1` (Mumbai).
*   **Public Access:** Enabled (IAM off), but secured via Application Layer (Firebase Auth + App Check).
*   **Domain:** `https://api.bizpharma.app` (Proxied via Firebase Hosting Rewrites).

### Database (PostgreSQL)
*   **Instance:** Cloud SQL `bizpharma-instance`.
*   **Database:** `bizpharma-db`.
*   **Management:** Firebase Data Connect (`bizpharma-service`).
*   **Schema:** Defined in `.gql` files, NOT SQL. Data Connect manages the migrations.

## 3. Directory Structure & Key Files
```text
bizPharma/
├── backend/                  # FastAPI Application
│   ├── main.py               # Entry Point & CORS Config (CRITICAL)
│   ├── Dockerfile            # Cloud Run Build Instructions
│   └── ...
├── dataconnect/              # Database Schema
│   ├── schema/               # GraphQL Source of Truth
│   ├── connector/            # Pre-defined Queries/Mutations
│   └── dataconnect.yaml      # Service Configuration
├── lib/                      # Flutter Application
│   ├── config/               
│   │   ├── api_config.dart   # API Base URL Logic (Dev vs Prod)
│   │   └── app_check_config.dart # reCAPTCHA Keys
│   ├── services/
│   │   └── api_client.dart   # Http Client (Interceptors for Auth)
│   └── firebase_options.dart # Firebase Config (Auto-generated + Custom Logic)
├── firebase.json             # Hosting Rewrites (Proxy Logic)
└── .firebaserc               # Project Aliases (default, staging, prod)
```

## 4. Critical Implementation Details

### A. Environment Switching
*   **Anti-Pattern:** Using `.env` files for Flutter Web production builds.
*   **Pattern:** Runtime detection.
    *   **Code:** `Uri.base.host` check in `firebase_options.dart`.
    *   **Why?** A single build artifact can be promoted from Staging to Prod.

### B. Authentication & App Check
*   **Token Flow:**
    1.  User signs in (Frontend) -> Gets ID Token.
    2.  `ApiClient` adds `Authorization: Bearer <token>`.
    3.  `ApiClient` adds `X-Firebase-AppCheck: <token>`.
*   **Backend Validation:**
    *   `main.py` -> `core/security.py`.
    *   Verifies ID Token signature.
    *   Verifies App Check token against Firebase Admin SDK.

### C. Data Connect (The "Tricky" Part)
*   **Schema Source:** You do NOT create tables manually (usually). You edit `.gql` files.
*   **Network Requirement:** Requires access to Cloud SQL port 5432. Often blocked by local ISPs. **Workaround:** Run SQL DDL manually in Cloud SQL Studio if CLI times out.

### 5. Deployment & Release Pipeline
The "Golden Workflow" for shipping features:

#### A. Staging Release
1.  Merge feature branch to `dev`.
2.  Deploy Backend: `gcloud run deploy ...` (or CI/CD).
3.  **Run Smoke Tests (Mandatory):**
    ```bash
    flutter test test/staging_config_test.dart --dart-define=ENVIRONMENT=staging
    ```
    *   **Purpose:** Verifies Staging Config is active AND Backend is reachable.
    *   **Success:** "All tests passed!" 🟢

#### B. Production Release
1.  If Staging Smoke Test passed: Merge `dev` to `main`.
2.  Tag release: `git tag v1.x`.

## 6. Critical Files Map
*   `lib/firebase_options.dart`: **DO NOT OVERWRITE** without checking the custom Environment Detection logic at the top.
*   `test/staging_config_test.dart`: **The Staging Smoke Test.** Checks ApiConfig and Network Reachability.

## 7. Development Guidelines for Agents

### When modifying API Logic:
1.  **Check `api_config.dart`:** Ensure you aren't hardcoding `localhost`.
2.  **Check `main.py`:** If adding a new domain, update CORS `allow_origins`.

### When modifying Database Schema:
1.  Edit `.gql` files in `dataconnect/schema/`.
2.  **Do NOT** suggest SQL migrations unless `firebase deploy` fails.
3.  **Verify:** Ask user to check Cloud SQL Studio after deployment.

### When Debugging "Network Errors":
1.  **CORS:** Check Browser Console.
2.  **App Check:** Check for 403 Forbidden.
3.  **DNS:** Verify `api.bizpharma.app` resolves.

## 6. Known "Gotchas" (History)
*   **Dec 2025:** Fixed infinite 403 loop by whitelisting `firebaseapp.com` in Google Cloud Credentials.
*   **Dec 2025:** Fixed SSL error by re-adding custom domain in Hosting.
*   **Dec 2025:** Fixed Database Timeout by manual SQL injection via Cloud Console.
