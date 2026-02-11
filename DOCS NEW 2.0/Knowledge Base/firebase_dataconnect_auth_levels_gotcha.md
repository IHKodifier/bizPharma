# Firebase Data Connect Auth Levels - Critical Gotcha

## Issue Date
2026-02-05

## Category
Authentication / Firebase Data Connect

## Severity
🔴 **CRITICAL** - Causes complete authentication failure for anonymous users

---

## The Problem

When implementing auth unification in Firebase Data Connect, using `@auth(level: USER)` will **completely block anonymous Firebase Auth users**, causing `401 Unauthorized` errors even though they are authenticated.

---

## Root Cause

Firebase Data Connect has **three distinct auth levels** with different behaviors:

| Auth Level | Authenticated Users | Anonymous Users | Unauthenticated Users |
|------------|-------------------|-----------------|---------------------|
| `USER` | ✅ Allowed | ❌ **DENIED** | ❌ Denied |
| `USER_ANON` | ✅ Allowed | ✅ **Allowed** | ❌ Denied |
| `PUBLIC` | ✅ Allowed | ✅ Allowed | ✅ Allowed |

**Key Insight:** `@auth(level: USER)` **explicitly excludes** anonymous Firebase Auth users, even though they have valid Firebase Auth tokens.

---

## Solution

For queries/mutations that need to support **anonymous trial flows** (e.g., onboarding), use:

```gql
@auth(level: USER_ANON)
```

### Example: Onboarding Query
```gql
query GetUserByAuthId($id: String!) @auth(level: USER_ANON) {
  user(id: $id) {
    id
    businessId
    role
  }
}
```

### Example: Onboarding Mutation
```gql
mutation CreateBusinessAndAdmin(
  $businessId: UUID!
  $businessName: String!
  # ... other params
) @auth(level: USER_ANON) @transaction {
  business_insert(data: { ... })
  user_insert(data: { ... })
}
```

---

## When to Use Each Level

### Use `USER_ANON` for:
- ✅ Onboarding queries (checking if user exists)
- ✅ Onboarding mutations (creating business/user records)
- ✅ Any operation that anonymous trial users need access to

### Use `USER` for:
- ✅ Business operations after onboarding
- ✅ Operations requiring permanent credentials
- ✅ Sensitive data access

### Avoid `PUBLIC` for:
- ❌ Any production operations (no auth required at all)
- ⚠️ Only use for truly public data (e.g., health checks, uptime queries)

---

## Auth Unification Strategy

To achieve **strict auth enforcement** while supporting **anonymous trials**:

1. **Onboarding operations** → `USER_ANON`
2. **All other operations** → `USER`
3. **Public health checks** → `PUBLIC` (minimal use)

This ensures:
- ✅ No unauthenticated access
- ✅ Anonymous users can complete onboarding
- ✅ Full access requires account linking
- ✅ Strict security after trial period

---

## Related Files

- `dataconnect/connector/queries/core/get_user_by_auth_id.gql`
- `dataconnect/connector/mutations/admin/onboarding.gql`

---

## References

- [Firebase Data Connect Auth Documentation](https://firebase.google.com/docs/data-connect/authorization)
- [Firebase Anonymous Authentication](https://firebase.google.com/docs/auth/web/anonymous-auth)

---

## Lessons Learned

1. **Always test with anonymous users** when implementing auth unification
2. **Read the auth level documentation carefully** - the differences are subtle but critical
3. **Production working ≠ Dev working** - Production was using `PUBLIC`, which masked the issue
4. **IAM roles are not the issue** - The auth level itself was blocking anonymous users
