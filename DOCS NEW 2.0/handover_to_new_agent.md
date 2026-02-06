# Handover: Debugging Staging Auth (401 Unauthorized)

**Date:** 2026-02-04
**Critical Finding:** **Deployment Mismatch** (Client is new, Backend is old).

## 1. The Context: "Auth Unification" & The Regression
**Original Goal:** Achieve "Auth Unification" (Zero-Code Modification) across Dev, Staging, and Production. We wanted [main.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/main.dart) and [auth_service.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/services/auth_service.dart) to be identical for all environments, relying solely on environment variables and Firebase/GCP configuration.
*   **Reference:** [Auth Unification Plan](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/DOCS NEW 2.0/Knowledge Base/auth unification plan_zeroconfig code.md)

**The Result:** While attempting this unification, we inadvertently **broke the previously working Sign-Up functionality** on the Staging environment. We are now in a "Fix Forward" state where we must resolve the `401 Unauthorized` without rolling back to the legacy (divergent) auth code.

## 2. The Core Problem
The Staging environment (`bizpharma-staging`) is failing with `401 Unauthorized` errors when attempting to perform `@auth(level: USER)` operations in Data Connect.
*   **Works:** Local Emulators, Anonymous Firebase Sign-in.
*   **Fails:** Data Connect queries (e.g., [getUserByAuthId](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/dataconnect_generated/biz_pharma.dart#846-849), [createBusiness](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/dataconnect_generated/biz_pharma.dart#881-884)).

## 3. What We Tried (And Why It Failed)
We attempted several fixes before discovering the specific Deployment Mismatch. **Do NOT repeat these steps blindly.**

*   **Attempt 1: Client-Side Retry Logic**
    *   *Idea:* Maybe the token isn't propagated fast enough. Added complex retry loops in [auth_service.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/services/auth_service.dart).
    *   *Result:* Failed. The 401 is immediate and persistent, not transient. We reverted this code.
*   **Attempt 2: IAM & Service Agents**
    *   *Idea:* The "Firebase Data Connect Service Agent" was missing from the Staging project's IAM policy.
    *   *Action:* We manually added the role via CLI.
    *   *Result:* Necessary, but **insufficient**. The 401 persisted, implying another gatekeeper (App Check or Deployment Sync).
*   **Attempt 3: Disabling App Check (Code-Only)**
    *   *Idea:* App Check is blocking the request.
    *   *Action:* Commented out [activate()](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/services/location_service.dart#149-162) in [main.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/main.dart).
    *   *Result:* **Confusing Failure.** The deployment pipeline didn't update the service worker/backend efficiently, leading to the "He said, She said" state where logs showed App Check active despite code changes.
*   **Attempt 4: Diagnostic Logging**
    *   *Idea:* Token Audience/Issuer mismatch.
    *   *Result:* **Ruled Out.** The generated tokens are perfectly valid for `bizpharma-staging`.

## 4. Diagnostics Performed (The Breakthrough)
We went through a rigorous isolation process to rule out common culprits.

### Phase A: Token Validation (Ruled Out)
*   **Hypothesis:** The Firebase Auth Token had the wrong audience (`aud`) or issuer (`iss`).
*   **Result:** Application logs confirmed the generated token is valid for `bizpharma-staging`.

### Phase B: App Check (Investigated & Paused)
*   **Hypothesis:** App Check was blocking requests before they reached Auth.
*   **Action:** We commented out `FirebaseAppCheck.instance.activate(...)` in [lib/main.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/main.dart) and forced a deploy.
*   **Observation:** Browser logs *still* showed `Initializing Firebase firebase_app_check`, causing massive confusion about whether the deployment worked.

### Phase C: Deployment Verification (The Breakthrough)
*   **Action:** We added a visual marker `v.DIAGNOSTIC-001 - APP CHECK DISABLED` to the [LandingPage](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/pages/landing/landing_page.dart#14-20).
*   **Result:** The user **SAW** the marker. This proved the **Flutter Client Code** was successfully deployed.
*   **Action:** We implemented a "Connectivity Probe" button that executes a public [uptime](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/dataconnect_generated/biz_pharma.dart#841-844) query.
*   **Result:** The probe failed with **`404 Not Found`**.
*   **Conclusion:** The Data Connect Service (Backend) **does not have the [uptime](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/dataconnect_generated/biz_pharma.dart#841-844) query deployed**.

**VERDICT:** The Client and Backend are out of sync. The Flutter app is asking for a schema version that the Data Connect service doesn't know about yet. This mismatch usually causes `404`s, but can also trigger auth failures if the service configuration is stale.

## 3. Current State
*   **Codebase:**
    *   [lib/main.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/main.dart): App Check is currently **DISABLED** (lines commented out).
    *   `lib/pages/landing_page.dart`: Contains a debug overlay with a "Run Connectivity Probe" button.
    *   `lib/dataconnect/connector/queries/system/uptime.gql`: A public query exists in source.
*   **Environment (Staging):**
    *   **Frontend:** Updated (Has probe, has visual marker).
    *   **Backend (Data Connect):** **STALE**. Does not have the [uptime](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/dataconnect_generated/biz_pharma.dart#841-844) query.

## 4. Immediate Next Steps (For the New Agent)

You must start by fixing the backend deployment.

1.  **Force Backend Deploy:**
    Ask the user to run this immediately to sync the service:
    ```bash
    firebase deploy --only dataconnect --project bizpharma-staging
    ```

2.  **Re-Run Probe:**
    Once deployed, ask the user to click "Run Connectivity Probe" on the staging site.
    *   **If GREEN (OK):** The backend is fixed. Now retry the Sign-Up flow.
        *   If Sign-Up works -> **SUCCESS**. Re-enable App Check in [main.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/main.dart) and finish.
        *   If Sign-Up gives `401` -> The issue is **Identity Platform**. You must verify the "Firebase Data Connect Service Agent" IAM role in GCP.
    *   **If RED (401/403):** The service is blocking public access. This is likely a GCP Firewall or a deeper App Check enforcement (even if disabled in client, it might be enforcing on server).

3.  **Cleanup:**
    Once verified, you must:
    *   Remove the "Connectivity Probe" UI from [landing_page.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/pages/landing/landing_page.dart).
    *   Uncomment App Check in [main.dart](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/main.dart).
    *   Ensure the CI/CD pipeline correctly deploys *both* Hosting and Data Connect.

## 5. Artifacts to Reference
*   [task.md](file:///C:/Users/Ihtiram/.gemini/antigravity/brain/351d54f2-4ee9-46be-9a60-dbe097d9c003/task.md): Check the "Verify Staging Deployment" section.
*   [remediation_plan.md](file:///C:/Users/Ihtiram/.gemini/antigravity/brain/351d54f2-4ee9-46be-9a60-dbe097d9c003/remediation_plan.md): Detailed breakdown of the isolation strategy.
