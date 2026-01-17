# AI Agent Coding Rules: Firebase Data Connect Authentication

**Purpose**: Prevent authentication-related bugs when developing with Firebase Data Connect  
**Target Audience**: AI Coding Agents (Claude, GPT, etc.)  
**Last Updated**: 2026-01-16

---

## 🚨 CRITICAL RULES - ALWAYS FOLLOW

### Rule 1: Default to `@auth(level: USER)` for All Queries/Mutations

**DO THIS**:
```graphql
query GetUserProfile($id: String!) @auth(level: USER) {
  user(id: $id) { ... }
}

mutation UpdateUserProfile(...) @auth(level: USER) {
  user_update(...) { ... }
}
```

**DON'T DO THIS** (unless explicitly justified):
```graphql
query GetUserProfile($id: String!) @auth(level: PUBLIC) {
  user(id: $id) { ... }
}
```

**Why**: PUBLIC auth exposes data to unauthenticated users. Always require authentication by default.

---

### Rule 2: Understand the Session Restoration Circular Dependency

**THE PROBLEM**:
```
1. User refreshes page
2. App needs to check if user exists → calls GetUserByAuthId
3. GetUserByAuthId has @auth(level: USER)
4. But user isn't authenticated yet (token not loaded)
5. Query fails with 401 → app thinks user doesn't exist
6. App redirects to onboarding (wrong!)
```

**THE SOLUTION** (for development/staging):
```graphql
# Queries used ONLY for session restoration can be PUBLIC
query GetUserByAuthId($id: String!) 
  @auth(level: PUBLIC, insecureReason: "Session restoration - STAGING ONLY. Production uses server-side session.") {
  user(id: $id) { ... }
}

query GetBusinessById($id: UUID!) 
  @auth(level: PUBLIC, insecureReason: "Session restoration - STAGING ONLY. Production uses server-side session.") {
  business(id: $id) { ... }
}
```

**PRODUCTION SOLUTION**:
- Move session restoration to backend API
- Backend validates Firebase token
- Backend calls Data Connect with service account
- Keep queries at `@auth(level: USER)`

**WHY THIS WORKS IN PRODUCTION BUT NOT STAGING**:

The "magic" is **WHO makes the Data Connect call**:

**Staging (Frontend → Data Connect)**:
```
User Browser → Data Connect
     ↓ (Firebase Token)
   
Problem: Token is for checking if user exists, but query requires USER auth
Result: Circular dependency → 401 error
```

**Production (Frontend → Backend → Data Connect)**:
```
User Browser → Backend API → Data Connect
     ↓              ↓
Firebase Token  Service Account
                (Always Authenticated)
```

**Key Difference**:
1. Frontend sends Firebase token to **backend** (not Data Connect)
2. Backend validates token (proves user identity)
3. Backend calls Data Connect using **service account credentials**
4. Service account is ALWAYS authenticated (no circular dependency)
5. Data Connect sees service account → allows query with USER auth
6. Backend enforces authorization (only returns user's own data)

**Code Example**:
```python
# Backend endpoint
@router.get("/api/session/user")
async def get_session_user(current_user = Depends(get_current_user)):
    # Step 1: Validate Firebase token (done in dependency)
    # Step 2: Call Data Connect with SERVICE ACCOUNT
    dc_client = DataConnectClient()  # Uses service account
    result = await dc_client.execute_query(
        operation_name="GetUserByAuthId",
        variables={"id": current_user.uid}  # Validated UID
    )
    return result  # Only user's own data
```

**Bottom Line**: USER auth works in production because backend uses service account (always authenticated), not user token (circular dependency).

---

### Rule 3: Identify Session Restoration Queries

**How to Identify**:
1. Query is called in `AuthWrapper` or similar component
2. Query is called on initial page load (before user interaction)
3. Query is used to determine if user should see onboarding vs dashboard
4. Query is called in a Riverpod/Provider that runs immediately

**Common Session Restoration Queries**:
- `GetUserByAuthId` - Check if user exists
- `GetBusinessById` - Load user's business data
- `GetUserBusinessAndDefaultLocation` - Load full user context

**Action Required**:
- Document these queries in `data_connect_auth_security_guide.md`
- Add `insecureReason` explaining why PUBLIC is needed
- Plan production migration strategy

---

### Rule 4: Never Use PUBLIC for Mutations (Except Onboarding)

**EXCEPTION - Onboarding Mutation**:
```graphql
mutation CreateBusinessAndAdmin(...) 
  @auth(level: PUBLIC, insecureReason: "Initial user signup - token not yet propagated") {
  business_insert(...) { ... }
  user_insert(...) { ... }
}
```

**Why Exception is OK**:
- Only called once during initial signup
- User has Firebase Auth session (frontend validates)
- Creates user's first business atomically

**ALL OTHER MUTATIONS - USE USER AUTH**:
```graphql
mutation CreateLocation(...) @auth(level: USER) { ... }
mutation CreateProduct(...) @auth(level: USER) { ... }
mutation UpdateBusiness(...) @auth(level: USER) { ... }
mutation DeleteUser(...) @auth(level: USER) { ... }
```

---

### Rule 5: Add Row-Level Security with `@where` Clauses

**ALWAYS add ownership checks**:
```graphql
query GetUserLocations($businessId: UUID!) @auth(level: USER) {
  locations(where: {
    businessId: { eq: $businessId }
    # Ensure user owns this business
  }) @where(expr: "this.businessId == auth.token.businessId") {
    id
    name
  }
}
```

**Why**: Even with USER auth, users could query other users' data if you don't validate ownership.

---

## 🔍 DEBUGGING CHECKLIST

### When You See: "401 Unauthorized" on Page Refresh

**Check**:
1. ✅ Is the failing query used for session restoration?
2. ✅ Does it have `@auth(level: USER)`?
3. ✅ Is it called in `AuthWrapper` or initial load?

**Fix**:
1. Change to `@auth(level: PUBLIC)` for staging
2. Add `insecureReason` with explanation
3. Document in knowledge base
4. Add TODO comment for production migration

**Example**:
```graphql
# TODO: PRODUCTION - Move to backend API for proper session management
query GetUserByAuthId($id: String!) 
  @auth(level: PUBLIC, insecureReason: "Session restoration - STAGING ONLY") {
  user(id: $id) { ... }
}
```

---

### When You See: "Infinite Loading Spinner" on Save

**Check**:
1. ✅ Is the mutation failing with 401/403?
2. ✅ Does mutation have `@auth(level: USER)`?
3. ✅ Is Firebase Auth token being sent?

**Common Causes**:
- Mutation requires USER auth but token isn't attached
- App Check is failing
- Service account lacks Data Connect permissions

**Fix**:
1. Verify `FirebaseAuth.instance.currentUser` is not null
2. Check Data Connect SDK is using auth token
3. Verify App Check configuration
4. Check mutation auth level is appropriate

---

## 📋 CODE PATTERNS

### Pattern 1: Session Restoration Flow

**Frontend (AuthWrapper)**:
```dart
final authState = ref.watch(authStateProvider);

return authState.when(
  data: (firebaseUser) {
    if (firebaseUser != null) {
      // Step 1: Check if user exists in Data Connect
      final userAsync = ref.watch(currentUserProvider(firebaseUser.uid));
      
      return userAsync.when(
        data: (dcUser) {
          if (dcUser != null && dcUser.businessId != null) {
            // Step 2: Load business data
            final businessAsync = ref.watch(businessByIdProvider(dcUser.businessId));
            
            return businessAsync.when(
              data: (business) => AppHomePage(),
              loading: () => LoadingScreen(),
              error: (e, s) => ErrorScreen(e),
            );
          } else {
            // No user in Data Connect → onboarding
            return OnboardingStepper();
          }
        },
        loading: () => LoadingScreen(),
        error: (e, s) => ErrorScreen(e),
      );
    }
    return LandingPage();
  },
);
```

**Queries Required** (both need PUBLIC for staging):
```graphql
query GetUserByAuthId($id: String!) @auth(level: PUBLIC) { ... }
query GetBusinessById($id: UUID!) @auth(level: PUBLIC) { ... }
```

---

### Pattern 2: Protected CRUD Operations

**All CRUD operations use USER auth**:
```graphql
# CREATE
mutation CreateLocation(...) @auth(level: USER) {
  location_insert(data: {...}) { ... }
}

# READ
query ListLocations($businessId: UUID!) @auth(level: USER) {
  locations(where: { businessId: { eq: $businessId } }) 
    @where(expr: "this.businessId == auth.token.businessId") {
    ...
  }
}

# UPDATE
mutation UpdateLocation(...) @auth(level: USER) {
  location_update(id: $id, data: {...}) { ... }
}

# DELETE
mutation DeleteLocation($id: UUID!) @auth(level: USER) {
  location_delete(id: $id) { ... }
}
```

---

### Pattern 3: Initial Onboarding

**Only mutation that should be PUBLIC**:
```graphql
mutation CreateBusinessAndAdmin(
  $businessId: UUID!
  $businessName: String!
  $userEmail: String!
  $userFirstName: String!
  $userLastName: String!
  $authUid: String!
) @auth(level: PUBLIC, insecureReason: "Initial signup - token not propagated yet") 
  @transaction {
  
  business_insert(data: {
    id: $businessId
    name: $businessName
  })
  
  user_insert(data: {
    id: $authUid
    businessId: $businessId
    email: $userEmail
    firstName: $userFirstName
    lastName: $userLastName
    role: BUSINESS_ADMIN
  })
  
  location_insert(data: {
    businessId: $businessId
    name: "Main Store"
    code: "MAIN"
    type: HEAD_OFFICE
    isActive: true
  })
}
```

---

## ❌ ANTI-PATTERNS - NEVER DO THIS

### Anti-Pattern 1: PUBLIC Auth for Business Logic

**DON'T**:
```graphql
query ListAllProducts() @auth(level: PUBLIC) {
  products { ... }  # ❌ Exposes all products to anyone
}

mutation DeleteProduct($id: UUID!) @auth(level: PUBLIC) {
  product_delete(id: $id)  # ❌ Anyone can delete products!
}
```

**DO**:
```graphql
query ListProductsByBusiness($businessId: UUID!) @auth(level: USER) {
  products(where: { businessId: { eq: $businessId } })
    @where(expr: "this.businessId == auth.token.businessId") {
    ...
  }
}

mutation DeleteProduct($id: UUID!) @auth(level: USER) {
  product_delete(id: $id)
}
```

---

### Anti-Pattern 2: No Ownership Validation

**DON'T**:
```graphql
query GetLocation($id: UUID!) @auth(level: USER) {
  location(id: $id) {  # ❌ User could query ANY location by ID
    ...
  }
}
```

**DO**:
```graphql
query GetLocation($id: UUID!) @auth(level: USER) {
  location(id: $id) 
    @where(expr: "this.businessId == auth.token.businessId") {
    ...
  }
}
```

---

### Anti-Pattern 3: Mixing Auth Levels Inconsistently

**DON'T**:
```graphql
query GetUser($id: String!) @auth(level: PUBLIC) { ... }
mutation UpdateUser(...) @auth(level: USER) { ... }
# ❌ Inconsistent - anyone can read but only auth users can write
```

**DO**:
```graphql
# Both at same level (unless session restoration query)
query GetUser($id: String!) @auth(level: USER) { ... }
mutation UpdateUser(...) @auth(level: USER) { ... }
```

---

## 🎯 DECISION TREE

When creating a new query/mutation, follow this decision tree:

```
Is this query/mutation used for session restoration?
├─ YES → Is this staging/development?
│  ├─ YES → Use @auth(level: PUBLIC) + insecureReason + TODO for production
│  └─ NO (Production) → Use backend API with service account
│
└─ NO → Is this the initial onboarding mutation?
   ├─ YES → Use @auth(level: PUBLIC) + insecureReason
   └─ NO → Use @auth(level: USER) + @where clause for ownership
```

---

## 📝 CHECKLIST FOR NEW FEATURES

Before deploying any new Data Connect queries/mutations:

- [ ] All queries default to `@auth(level: USER)`
- [ ] All mutations default to `@auth(level: USER)`
- [ ] Session restoration queries documented with `insecureReason`
- [ ] Row-level security (`@where`) added for multi-tenant data
- [ ] Tested with actual Firebase Auth tokens (not just emulator)
- [ ] Verified no 401 errors on page refresh
- [ ] Verified no infinite spinners on save operations
- [ ] Production migration plan documented if using PUBLIC auth
- [ ] Added to `data_connect_auth_security_guide.md` if exception

---

## 🔗 RELATED DOCUMENTS

- `DOCS NEW 2.0/Knowledge Base/data_connect_auth_security_guide.md` - Full security guide
- `DOCS NEW 2.0/Knowledge Base/staging_deployment_guide_2025.md` - Staging deployment
- `DOCS NEW 2.0/Knowledge Base/production_rollout_checklist.md` - Production checklist

---

## 📊 INCIDENT HISTORY

### 2026-01-15: Session Persistence 401 Errors

**What Happened**: Page refresh redirected users to onboarding instead of dashboard

**Root Cause**: 
- `GetUserByAuthId` had `@auth(level: USER)`
- `GetBusinessById` had `@auth(level: USER)`
- Both called during session restoration before auth token available

**Resolution**:
- Changed both to `@auth(level: PUBLIC)` for staging
- Documented in knowledge base
- Planned production migration to backend API

**Lesson Learned**: Always check if queries are used for session restoration before setting auth level

**Prevention**: Follow Rule 2 and Rule 3 in this document

---

## 🤖 AI AGENT SPECIFIC INSTRUCTIONS

When you (AI agent) are asked to:

1. **Create a new Data Connect query**:
   - Default to `@auth(level: USER)`
   - Ask: "Is this for session restoration?" If yes, follow Rule 2
   - Add `@where` clause for ownership validation

2. **Create a new Data Connect mutation**:
   - Default to `@auth(level: USER)`
   - Only exception: initial onboarding mutation
   - Validate user owns the resource being modified

3. **Debug 401 errors**:
   - Check if query is for session restoration
   - Check if mutation has correct auth level
   - Verify Firebase Auth token is being sent
   - Check App Check configuration

4. **Deploy to staging**:
   - Review all PUBLIC queries
   - Document exceptions in knowledge base
   - Test session persistence (page refresh)
   - Test all CRUD operations

5. **Prepare for production**:
   - Audit all PUBLIC queries
   - Implement backend session API endpoint (`/api/session/user`)
   - Update frontend to call backend instead of Data Connect directly
   - Change session queries back to `@auth(level: USER)`
   - Test thoroughly in staging with new architecture
   - Deploy backend → schema → frontend in that order

6. **Understand the architecture difference**:
   - **Staging**: Frontend calls Data Connect directly (requires PUBLIC for session queries)
   - **Production**: Frontend calls backend, backend calls Data Connect with service account (allows USER auth)
   - **Why it works**: Service account is always authenticated, no circular dependency

**Remember**: When in doubt, use `@auth(level: USER)` and add ownership validation. PUBLIC auth should be the exception, not the rule.

**CRITICAL**: Never deploy PUBLIC session queries to production. Always use backend API proxy pattern for production.
