# Chat Knowledge Log - bizPharma

## Session Documentation

### 2026-02-05T08:25:00+05:00 - Session: Debugging Staging Auth (401 Unauthorized)

**Goal:** Resolve `401 Unauthorized` errors in Staging environment during anonymous user sign-up flow.

**Proceedings:**
1. Initially suspected backend deployment mismatch - deployed Data Connect to Staging
2. Investigated App Check enforcement - confirmed it was in "Monitoring" mode (unenforced)
3. Checked IAM permissions - added missing `Firebase Admin SDK Administrator Service Agent` role
4. Compared Production vs Dev code using GitHub CLI
5. Discovered Production uses `@auth(level: PUBLIC)` while Dev uses `@auth(level: USER)`
6. Researched Firebase Data Connect auth levels documentation
7. Identified root cause: `@auth(level: USER)` excludes anonymous users
8. Changed to `@auth(level: USER_ANON)` for onboarding operations

**What Worked:**
- ✅ Comparing Production (working) vs Dev (failing) code to identify differences
- ✅ Using GitHub CLI to view deployed schema in main branch
- ✅ Web search for Firebase Data Connect auth level documentation
- ✅ Systematic elimination of potential causes (App Check, IAM, Identity Platform)

**What Didn't:**
- ❌ Adding IAM roles didn't fix the issue (was not an IAM problem)
- ❌ Waiting for IAM propagation was unnecessary (wrong diagnosis)
- ❌ Attempting to change auth level to PUBLIC (defeats auth unification purpose)

**Gotchas:**
1. **Firebase Data Connect Auth Levels:**
   - `@auth(level: USER)` **excludes** anonymous Firebase Auth users
   - `@auth(level: USER_ANON)` **includes** anonymous Firebase Auth users
   - `@auth(level: PUBLIC)` allows unauthenticated access (no Firebase Auth required)

2. **Production ≠ Dev:** Production was using `@auth(level: PUBLIC)` which masked the issue during initial development

3. **GCP Quota Limits:** Cloud Billing API has rate limits (400 requests/minute) - wait 1-2 minutes between deployment attempts

4. **Anonymous Users ARE Authenticated:** Anonymous Firebase Auth users have valid tokens, but Data Connect treats them differently based on auth level

**Agent Directives:**
1. **Always check auth levels first** when debugging 401 errors with anonymous users
2. **Use `USER_ANON` for onboarding operations** that need to support anonymous trial flows
3. **Compare Production vs Dev** when Production works but Dev doesn't
4. **Read Firebase documentation** for subtle differences in auth behavior
5. **Don't assume IAM is always the issue** - check schema directives first

**Files Modified:**
- `dataconnect/connector/queries/core/get_user_by_auth_id.gql` → Changed to `USER_ANON`
- `dataconnect/connector/mutations/admin/onboarding.gql` → Changed to `USER_ANON`
- Created `DOCS NEW 2.0/project_memory.md` with critical gotchas
- Created `DOCS NEW 2.0/Knowledge Base/firebase_dataconnect_auth_levels_gotcha.md`

**Status:** Schema changes ready for deployment (pending GCP quota reset)

---
