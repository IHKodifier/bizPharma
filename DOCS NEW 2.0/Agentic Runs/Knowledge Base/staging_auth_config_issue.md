# Staging Environment Configuration Mismatch

**Date**: 2025-12-23  
**Status**: Resolved  
**Component**: Frontend (Flutter Web) / Firebase Auth

## 1. Issue Description

The Staging environment (`https://bizpharma-staging.web.app`) was failing to function correctly.
- **Symptom 1**: The "Start Free Trial" button was unresponsive.
- **Symptom 2**: Anonymous user creation was failing, despite being enabled in the Staging Firebase Console.
- **Symptom 3**: The app behaved as if it was disconnected or stuck, leading to suspicions of backend infinite loops or crashes.

## 2. Investigation & Line of Action

We initially suspected backend issues due to the unresponsiveness of the UI.

1.  **Backend Health Check**:
    *   **Action**: Checked Cloud Run logs and health endpoints for `bizpharma-api` in the Staging project.
    *   **Result**: Backend was healthy (`HTTP 200`), initialized correctly, and had no infinite loops or stuck requests.

2.  **Configuration Audit**:
    *   **Action**: Inspected `lib/firebase_options.dart` to see how the Flutter app initializes Firebase.
    *   **Result**: Found that the file contained **hardcoded configuration** for the Development project (`bizpharma-4e73a`).
    *   **Root Cause Identified**: The Staging deployment was initializing with the Development Firebase project credentials. It was trying to talk to the wrong project, which likely had mismatching configurations or was blocking the requests (CORS/Auth).

3.  **Build Process Review**:
    *   **Action**: Checked `.github/workflows/deploy.yml`.
    *   **Result**: The workflow correctly passed an `ENVIRONMENT` dart-define variable (e.g., `--dart-define=ENVIRONMENT=staging`), but the Dart code wasn't using it to switch configurations.

## 3. Resolution Plan

To fix this, we needed to make the `firebase_options.dart` file **environment-aware**.

1.  **Obtain Configuration**: Retrieved the correct Firebase Web Config objects for Staging (`bizpharma-staging`) and Production (`bizpharma-prod`) from the user.
2.  **Refactor Code**: Modified `DefaultFirebaseOptions` in `lib/firebase_options.dart` to:
    *   Read the `ENVIRONMENT` dart-define variable.
    *   Switch between `webDev`, `webStaging`, and `webProd` configurations based on that variable.
3.  **Deploy**: Committed the changes to `dev` branch to trigger the Staging CI/CD pipeline.

## 4. Steps Followed

1.  Verified backend health via Cloud CLI (`gcloud log read`, `curl /health`).
2.  Identified hardcoded project ID in `lib/firebase_options.dart`.
3.  Requested correct config values from user.
4.  Implemented `String.fromEnvironment('ENVIRONMENT')` logic in `firebase_options.dart`.
5.  Added static constants for `webStaging` and `webProd`.
6.  Pushed changes to `dev` branch.

## 5. Outcome

The Staging web app now initializes with the correct `bizpharma-staging` configuration. Authentication and API calls are correctly directed to the Staging backend and services.
