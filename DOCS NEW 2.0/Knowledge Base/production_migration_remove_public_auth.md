# Production Migration Plan: Removing PUBLIC Auth

**Status**: 🔴 REQUIRED BEFORE PRODUCTION  
**Estimated Effort**: 2-3 days  
**Risk Level**: HIGH if not completed

---

## Current State (Staging)

### Queries with PUBLIC Auth (INSECURE)
- `GetUserByAuthId` - Anyone can query user data by UID
- `GetBusinessById` - Anyone can query business data by UUID

### Why This Works in Staging
- ✅ Enables session persistence (page refresh works)
- ✅ Test data only
- ✅ Not publicly accessible

### Why This FAILS in Production
- ❌ Exposes real customer data
- ❌ GDPR/compliance violations
- ❌ Anyone with endpoint URL can steal data
- ❌ No audit trail of who accessed what

---

## Production Architecture (REQUIRED)

### Option A: Backend API Proxy (RECOMMENDED)

**Architecture**:
```
Flutter App → FastAPI Backend → Data Connect
           ↑                   ↑
    (Firebase Token)    (Service Account)
```

**Implementation Steps**:

#### 1. Change Data Connect Queries Back to USER Auth

```graphql
# dataconnect/connector/queries/core/get_user_by_auth_id.gql
query GetUserByAuthId($id: String!) @auth(level: USER) {
  user(id: $id) @where(expr: "this.id == auth.uid") {
    id
    businessId
    role
    firstName
    lastName
    email
  }
}

# dataconnect/connector/queries/core/get_business_by_id.gql
query GetBusinessById($id: UUID!) @auth(level: USER) {
  business(id: $id) {
    id
    name
    tier
    # ... other fields
  }
}
```

#### 2. Create Backend Session Endpoints

```python
# backend/routes/session.py
from fastapi import APIRouter, Depends, HTTPException
from backend.middleware.auth import get_current_user
from backend.modules.shared.dataconnect_client import DataConnectClient

router = APIRouter(prefix="/api/session", tags=["session"])

@router.get("/user")
async def get_session_user(current_user = Depends(get_current_user)):
    """
    Get current user's profile and business data for session restoration.
    Called on app initialization and page refresh.
    """
    try:
        # Backend calls Data Connect with service account credentials
        dc_client = DataConnectClient()
        
        # Get user data
        user_result = await dc_client.execute_query(
            operation_name="GetUserByAuthId",
            variables={"id": current_user.uid}
        )
        
        if not user_result.get("user"):
            return {"user": None, "business": None}
        
        user_data = user_result["user"]
        business_id = user_data.get("businessId")
        
        # Get business data if user has one
        business_data = None
        if business_id:
            business_result = await dc_client.execute_query(
                operation_name="GetBusinessById",
                variables={"id": business_id}
            )
            business_data = business_result.get("business")
        
        return {
            "user": user_data,
            "business": business_data
        }
    except Exception as e:
        logger.error(f"Session restoration failed: {e}")
        raise HTTPException(status_code=500, detail="Failed to load session")
```

#### 3. Update Frontend to Use Backend API

```dart
// lib/services/session_service.dart
class SessionService {
  final ApiClient _apiClient;
  
  SessionService(this._apiClient);
  
  /// Get user and business data for session restoration
  /// Replaces direct Data Connect calls
  Future<SessionData?> getSessionData() async {
    try {
      final response = await _apiClient.get('/api/session/user');
      
      if (response.data['user'] == null) {
        return null; // New user, needs onboarding
      }
      
      return SessionData(
        user: User.fromJson(response.data['user']),
        business: response.data['business'] != null 
          ? Business.fromJson(response.data['business'])
          : null,
      );
    } catch (e) {
      logger.error('Session restoration failed: $e');
      return null;
    }
  }
}
```

```dart
// lib/widgets/auth_wrapper.dart
class AuthWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    
    return authState.when(
      data: (firebaseUser) {
        if (firebaseUser != null) {
          // NEW: Call backend API instead of Data Connect directly
          final sessionAsync = ref.watch(sessionDataProvider);
          
          return sessionAsync.when(
            data: (sessionData) {
              if (sessionData?.user != null && sessionData?.business != null) {
                // Hydrate providers
                ref.read(userProvider.notifier).setUser(sessionData.user);
                ref.read(businessProvider.notifier).setBusiness(sessionData.business);
                return AppHomePage();
              } else {
                return OnboardingStepper();
              }
            },
            loading: () => LoadingScreen(),
            error: (e, s) => ErrorScreen(e),
          );
        }
        return LandingPage();
      },
      loading: () => LoadingScreen(),
      error: (e, s) => LandingPage(),
    );
  }
}

// Provider that calls backend API
final sessionDataProvider = FutureProvider<SessionData?>((ref) async {
  final sessionService = ref.watch(sessionServiceProvider);
  return await sessionService.getSessionData();
});
```

#### 4. Update Backend Data Connect Client

```python
# backend/modules/shared/dataconnect_client.py
class DataConnectClient:
    def __init__(self):
        # Use Application Default Credentials (service account)
        # NOT user ID token
        self.credentials, _ = google.auth.default(
            scopes=['https://www.googleapis.com/auth/cloud-platform']
        )
        self.endpoint = settings.DATA_CONNECT_ENDPOINT
        self.project_id = settings.FIREBASE_PROJECT_ID
        self.location = settings.DATA_CONNECT_LOCATION
        self.service_id = "bizpharma-service"
    
    async def execute_query(self, operation_name: str, variables: dict):
        """
        Execute Data Connect query with service account credentials.
        No user token needed - backend validates user before calling.
        """
        # Service account has full access to Data Connect
        # Authorization is handled at API layer (get_current_user)
        # ... rest of implementation
```

---

## Migration Checklist

### Pre-Production (Do This Before Going Live)

- [ ] **Backend Changes**:
  - [ ] Create `/api/session/user` endpoint
  - [ ] Update `DataConnectClient` to use service account only
  - [ ] Add error handling and logging
  - [ ] Add rate limiting to prevent abuse

- [ ] **Data Connect Schema Changes**:
  - [ ] Change `GetUserByAuthId` back to `@auth(level: USER)`
  - [ ] Change `GetBusinessById` back to `@auth(level: USER)`
  - [ ] Add `@where` clauses for row-level security
  - [ ] Deploy schema to production

- [ ] **Frontend Changes**:
  - [ ] Create `SessionService` class
  - [ ] Update `AuthWrapper` to call backend API
  - [ ] Remove direct Data Connect calls for session restoration
  - [ ] Update providers to use backend API
  - [ ] Test session persistence with new flow

- [ ] **Testing**:
  - [ ] Test session restoration (page refresh)
  - [ ] Test onboarding flow for new users
  - [ ] Test with invalid/expired tokens
  - [ ] Load test session endpoint (expect high traffic)
  - [ ] Verify no 401 errors in production logs

- [ ] **Security Audit**:
  - [ ] Verify no PUBLIC queries in production
  - [ ] Verify all mutations require USER auth
  - [ ] Verify row-level security on all queries
  - [ ] Review backend authorization logic
  - [ ] Enable audit logging for session endpoint

---

## Deployment Strategy

### Phase 1: Staging Testing (1 day)
1. Implement backend session endpoint
2. Update frontend to use backend API
3. Change Data Connect queries to USER auth
4. Deploy to staging
5. Test thoroughly

### Phase 2: Production Deployment (1 day)
1. Deploy backend with session endpoint
2. Deploy Data Connect schema changes
3. Deploy frontend with new session flow
4. Monitor error rates and performance
5. Have rollback plan ready

### Phase 3: Monitoring (Ongoing)
1. Monitor session endpoint latency
2. Check for 401/403 errors
3. Review audit logs for suspicious activity
4. Optimize caching if needed

---

## Performance Considerations

### Current (Staging)
- Frontend → Data Connect (direct, fast)
- Latency: ~100-200ms

### Production (Backend Proxy)
- Frontend → Backend → Data Connect
- Latency: ~200-400ms (additional hop)

### Optimization Strategies
1. **Cache session data** in backend (Redis)
2. **Batch requests** (get user + business in one call)
3. **Use CDN** for static assets
4. **Implement connection pooling** for Data Connect

---

## Rollback Plan

If production deployment fails:

1. **Immediate**: Revert frontend to previous version
2. **Quick**: Change Data Connect queries back to PUBLIC (temporary)
3. **Monitor**: Check error rates and user complaints
4. **Fix**: Debug issues in staging
5. **Retry**: Deploy again when ready

---

## Cost Implications

### Current (Staging)
- Data Connect: Direct calls from frontend
- Cost: ~$0.01 per 1000 queries

### Production (Backend Proxy)
- Backend API: Cloud Run instance
- Data Connect: Calls from backend
- Cost: ~$0.05 per 1000 requests (includes Cloud Run)

**Estimated Monthly Cost** (10,000 users, 5 sessions/day):
- Current: ~$15/month
- Production: ~$75/month
- **Increase**: ~$60/month for better security

**Worth It?**: YES - Security is priceless compared to data breach costs.

---

## Alternative: Keep Some Queries PUBLIC (NOT RECOMMENDED)

If you absolutely cannot implement backend proxy:

### Minimal Security Approach
```graphql
query GetUserByAuthId($id: String!) 
  @auth(level: PUBLIC) {
  user(id: $id) @where(expr: "this.id == auth.uid") {
    # Only return data if queried ID matches authenticated user's ID
    id
    businessId
    # DO NOT return sensitive fields like email, phone
  }
}
```

**Problems**:
- Still exposes that a user exists
- Relies on client-side validation
- No audit trail
- Harder to implement rate limiting
- **NOT RECOMMENDED FOR PRODUCTION**

---

## Summary

**Current Setup**: ❌ NOT production-ready due to PUBLIC auth

**Required Changes**: ✅ Backend API proxy for session management

**Timeline**: 2-3 days of development + testing

**Cost**: ~$60/month additional (worth it for security)

**Recommendation**: Implement Option A (Backend API Proxy) before production deployment
