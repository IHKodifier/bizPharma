# Data Connect Authentication & Security Guide

**Last Updated**: 2026-01-16  
**Author**: Development Team  
**Purpose**: Guide for Data Connect authentication configuration, troubleshooting, and production security

---

## Table of Contents

1. [Authentication Levels Overview](#authentication-levels-overview)
2. [Current Staging Configuration](#current-staging-configuration)
3. [Security Implications](#security-implications)
4. [Production Deployment Strategy](#production-deployment-strategy)
5. [Troubleshooting Guide](#troubleshooting-guide)
6. [Migration Checklist](#migration-checklist)

---

## Authentication Levels Overview

### Available Auth Levels

Data Connect supports three authentication levels via the `@auth` directive:

```graphql
@auth(level: PUBLIC)   # No authentication required
@auth(level: USER)     # Requires authenticated Firebase user
@auth(level: USER_ANON) # Allows anonymous users (not recommended)
```

### When to Use Each Level

| Level | Use Case | Security Risk |
|-------|----------|---------------|
| `PUBLIC` | Public data, session restoration queries | ⚠️ HIGH - Anyone can call |
| `USER` | Protected user/business data | ✅ LOW - Requires valid auth token |
| `USER_ANON` | Trial features for anonymous users | ⚠️ MEDIUM - Limited validation |

---

## Current Staging Configuration

### Queries with PUBLIC Auth

**⚠️ TEMPORARY CONFIGURATION FOR DEVELOPMENT**

The following queries are currently set to `PUBLIC` to support session restoration:

#### 1. `GetUserByAuthId`
```graphql
query GetUserByAuthId($id: String!) 
  @auth(level: PUBLIC, insecureReason: "Required for session restoration") {
  user(id: $id) { ... }
}
```

**Why PUBLIC?**
- Called by `AuthWrapper` to check if user exists during page load
- Prevents circular dependency: "need auth to check if authenticated"
- User ID comes from Firebase Auth UID (already validated)

**Security Concern**: Anyone can query user data by UID if they know it

#### 2. `GetBusinessById`
```graphql
query GetBusinessById($id: UUID!) 
  @auth(level: PUBLIC, insecureReason: "Required for session restoration") {
  business(id: $id) { ... }
}
```

**Why PUBLIC?**
- Called after `GetUserByAuthId` to load business data
- Part of session restoration flow
- Business ID comes from authenticated user's `businessId` field

**Security Concern**: Anyone can query business data by UUID if they know it

### Mutations with PUBLIC Auth

#### `CreateBusinessAndAdmin`
```graphql
mutation CreateBusinessAndAdmin(...) 
  @auth(level: PUBLIC, insecureReason: "Initial onboarding for new users") {
  ...
}
```

**Why PUBLIC?**
- Called during initial user signup/onboarding
- User has Firebase Auth session but token may not be propagated yet
- Creates business + user + default location atomically

**Security Concern**: Anyone can create businesses (mitigated by Firebase Auth requirement in frontend)

---

## Security Implications

### Current Risks in Staging/Development

1. **Data Exposure**: PUBLIC queries can be called by anyone with the endpoint URL
2. **No Row-Level Security**: Queries don't validate user ownership of data
3. **Potential Abuse**: Malicious actors could enumerate users/businesses

### Why This Is Acceptable for Staging

- ✅ Staging uses test data only
- ✅ Not exposed to public internet (Firebase App Check required)
- ✅ Enables rapid development and debugging
- ✅ Allows session persistence testing

### Why This Is NOT Acceptable for Production

- ❌ Real customer data at risk
- ❌ Compliance violations (GDPR, HIPAA, etc.)
- ❌ Business data could be stolen
- ❌ Reputation damage from security breach

---

## Production Deployment Strategy

### Option 1: Server-Side Session Management (RECOMMENDED)

**Architecture**:
```
Frontend → Backend API → Data Connect
         ↑ (with auth token)
```

**Implementation**:
1. Keep all Data Connect queries at `@auth(level: USER)`
2. Frontend calls backend API endpoints (FastAPI)
3. Backend validates Firebase token
4. Backend calls Data Connect with service account credentials
5. Backend implements row-level security checks

**Benefits**:
- ✅ Full control over authorization logic
- ✅ Can implement complex business rules
- ✅ Audit logging at API layer
- ✅ Rate limiting and abuse prevention

**Example**:
```python
# backend/routes/user.py
@router.get("/user/profile")
async def get_user_profile(current_user: User = Depends(get_current_user)):
    # Backend calls Data Connect with service account
    result = await dataconnect_client.get_user_by_auth_id(
        id=current_user.uid
    )
    # Additional authorization checks
    if not result.data.user:
        raise HTTPException(status_code=404)
    return result.data.user
```

### Option 2: Client-Side with Custom Claims (ALTERNATIVE)

**Architecture**:
```
Frontend → Data Connect
         ↑ (with custom claims in token)
```

**Implementation**:
1. Set Firebase custom claims after user creation
2. Use custom claims in Data Connect auth rules
3. Keep queries at `@auth(level: USER)`
4. Add `@where` clauses for row-level security

**Example**:
```graphql
query GetUserByAuthId($id: String!) @auth(level: USER) {
  user(id: $id) @where(expr: "this.id == auth.uid") {
    id
    businessId
    ...
  }
}
```

**Benefits**:
- ✅ Simpler architecture (no backend API layer)
- ✅ Lower latency (direct to Data Connect)
- ✅ Leverages Firebase Auth infrastructure

**Drawbacks**:
- ⚠️ Limited to Firebase Auth claims (max 1000 bytes)
- ⚠️ Less flexible for complex authorization
- ⚠️ Harder to audit and debug

### Option 3: Hybrid Approach (BALANCED)

**Use Server-Side for**:
- Sensitive operations (payments, admin actions)
- Complex business logic
- Operations requiring multiple Data Connect calls

**Use Client-Side for**:
- Read-only queries with simple auth rules
- Real-time updates (with proper `@where` clauses)
- High-frequency, low-risk operations

---

## Troubleshooting Guide

### Issue: 401 Unauthorized on Page Refresh

**Symptoms**:
- User completes onboarding successfully
- Refreshing page redirects to onboarding screen
- Console shows `401 Unauthenticated` errors

**Root Cause**:
Query used for session restoration has `@auth(level: USER)` but is called before auth token is available.

**Solution**:
1. Identify which query is failing (check console logs)
2. Temporarily change to `@auth(level: PUBLIC)` for development
3. Add `insecureReason` explaining why
4. Document in this guide
5. Plan production migration strategy

**Example Fix**:
```graphql
# BEFORE (causes 401)
query GetUserByAuthId($id: String!) @auth(level: USER) { ... }

# AFTER (allows session restoration)
query GetUserByAuthId($id: String!) 
  @auth(level: PUBLIC, insecureReason: "Session restoration - STAGING ONLY") { 
  ... 
}
```

### Issue: Infinite Loading Spinner on Mutations

**Symptoms**:
- Click "Save" button
- Spinner appears and never stops
- Console shows `401` or `403` errors

**Root Cause**:
Mutation requires `@auth(level: USER)` but user token is not being sent or is invalid.

**Debugging Steps**:
1. Check browser console for exact error
2. Verify Firebase Auth state: `firebase.auth().currentUser`
3. Check if token is being sent in Data Connect request headers
4. Verify mutation has correct auth level
5. Check if user has required custom claims (if using Option 2)

**Common Fixes**:
- Ensure `FirebaseAuth.instance.currentUser` is not null
- Verify Data Connect SDK is using auth token
- Check App Check is configured correctly
- Verify service account has Data Connect permissions

### Issue: App Check Failures

**Symptoms**:
- All Data Connect requests fail with `403`
- Error mentions "App Check"

**Solution**:
1. Verify App Check is enabled in Firebase Console
2. Check reCAPTCHA Enterprise key is correct for environment
3. Ensure domain is whitelisted in App Check settings
4. For staging: Verify debug token is set correctly

**Staging Debug Token**:
```dart
// lib/main.dart
if (kDebugMode) {
  js.context['FIREBASE_APPCHECK_DEBUG_TOKEN'] = 
    'af5e46d4-e084-4cc4-9b16-10312aa29084';
}
```

---

## Migration Checklist

### Deploying New Features to Staging

- [ ] Review all new queries/mutations for auth levels
- [ ] Test with App Check enabled
- [ ] Verify no 401 errors in console
- [ ] Test session persistence (refresh page)
- [ ] Document any PUBLIC queries added
- [ ] Plan production migration if PUBLIC auth used

### Migrating Staging to Production

**Pre-Deployment**:
- [ ] Audit all queries/mutations with `@auth(level: PUBLIC)`
- [ ] Choose production strategy (Option 1, 2, or 3)
- [ ] Implement row-level security (`@where` clauses or backend checks)
- [ ] Update all PUBLIC queries to USER level
- [ ] Test thoroughly in staging with USER auth
- [ ] Document any exceptions and their justification

**Deployment**:
- [ ] Deploy backend API if using Option 1
- [ ] Set up custom claims if using Option 2
- [ ] Deploy Data Connect schema changes
- [ ] Deploy frontend with updated SDK
- [ ] Monitor error rates and auth failures
- [ ] Have rollback plan ready

**Post-Deployment**:
- [ ] Verify no 401/403 errors in production logs
- [ ] Test session persistence in production
- [ ] Audit access logs for suspicious activity
- [ ] Update this document with any new learnings

---

## Best Practices

### Development (Staging)
1. ✅ Use PUBLIC auth for session restoration queries
2. ✅ Document all PUBLIC queries with `insecureReason`
3. ✅ Keep track of PUBLIC queries for production migration
4. ✅ Test with real auth flows regularly
5. ✅ Use App Check even in staging

### Production
1. ✅ Default to `@auth(level: USER)` for all queries/mutations
2. ✅ Implement row-level security with `@where` clauses
3. ✅ Use backend API layer for sensitive operations
4. ✅ Enable audit logging for all Data Connect operations
5. ✅ Monitor for unusual access patterns
6. ✅ Regular security audits of auth configurations

### Code Review Checklist
- [ ] No new PUBLIC queries without justification
- [ ] All mutations have appropriate auth level
- [ ] Row-level security implemented where needed
- [ ] Custom claims used correctly (if applicable)
- [ ] Error handling for auth failures
- [ ] Logging for security events

---

## References

- [Firebase Data Connect Auth Documentation](https://firebase.google.com/docs/data-connect/authentication)
- [Firebase Custom Claims](https://firebase.google.com/docs/auth/admin/custom-claims)
- [App Check Documentation](https://firebase.google.com/docs/app-check)
- Project: `staging_deployment_guide_2025.md`
- Project: `production_rollout_checklist.md`

---

## Incident Log

### 2026-01-15: Session Persistence Issue
**Problem**: Page refresh redirected to onboarding  
**Root Cause**: `GetUserByAuthId` and `GetBusinessById` had `@auth(level: USER)`  
**Solution**: Changed to PUBLIC for staging  
**Production Plan**: Implement Option 1 (Server-Side Session Management)  
**Status**: ✅ Resolved in staging, production migration pending
