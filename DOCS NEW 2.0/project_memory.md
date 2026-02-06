# Project Memory - bizPharma

## Critical Gotchas and Lessons Learned

### Firebase Data Connect Auth Levels (2026-02-05)

**Issue:** `401 Unauthorized` errors when using `@auth(level: USER)` with anonymous Firebase Auth users.

**Root Cause:** Firebase Data Connect has three distinct auth levels with different behaviors:

| Auth Level | Authenticated Users | Anonymous Users | Unauthenticated Users |
|------------|-------------------|-----------------|---------------------|
| `USER` | ✅ Allowed | ❌ **DENIED** | ❌ Denied |
| `USER_ANON` | ✅ Allowed | ✅ **Allowed** | ❌ Denied |
| `PUBLIC` | ✅ Allowed | ✅ Allowed | ✅ Allowed |

**Key Insight:** `@auth(level: USER)` **explicitly excludes** anonymous Firebase Auth users, even though they have valid Firebase Auth tokens.

**Solution:** For queries/mutations that need to support anonymous trial flows (e.g., onboarding), use `@auth(level: USER_ANON)`.

**When to Use Each Level:**
- **`USER_ANON`** → Onboarding queries/mutations (checking if user exists, creating business/user records)
- **`USER`** → Business operations after onboarding, operations requiring permanent credentials
- **`PUBLIC`** → Avoid in production; only for truly public data (health checks, uptime queries)

**Auth Unification Strategy:**
1. Onboarding operations → `USER_ANON`
2. All other operations → `USER`
3. Public health checks → `PUBLIC` (minimal use)

**Files Affected:**
- `dataconnect/connector/queries/core/get_user_by_auth_id.gql`
- `dataconnect/connector/mutations/admin/onboarding.gql`

**References:**
- [Firebase Data Connect Auth Documentation](https://firebase.google.com/docs/data-connect/authorization)
- Detailed documentation: `DOCS NEW 2.0/Knowledge Base/firebase_dataconnect_auth_levels_gotcha.md`

---

## Architecture Decisions

### Anonymous User Trial Flow
- Users can sign up anonymously to start a free trial
- Anonymous users can create business and user records
- Full access requires linking to permanent credentials (Google Sign-In)
- After linking, anonymous UID is preserved, maintaining all trial data

---

## Common Pitfalls

1. **Don't assume Production = Dev** - Production may use different auth levels (e.g., PUBLIC) that mask issues
2. **Always test with anonymous users** when implementing auth unification
3. **IAM roles are not always the issue** - Check auth level directives first
4. **GCP quota limits** - Cloud Billing API has rate limits; wait 1-2 minutes between deployment attempts

---

## Environment-Specific Notes

### Staging (`bizpharma-staging`)
- Project Number: 563584335869
- Region: asia-south1
- Data Connect Service: bizpharma-service
- Connector: biz-pharma

### Production (`bizpharma-4e73a`)
- Project Number: 381385750800
- Region: asia-south1
- Currently uses `@auth(level: PUBLIC)` for onboarding (to be migrated to `USER_ANON`)
