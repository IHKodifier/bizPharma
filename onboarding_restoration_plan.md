# Onboarding Stepper Restoration Plan

## Current System Analysis

### 1. Existing Components
- **Onboarding Stepper Widget**: `lib/pages/onboarding/onboarding_stepper.dart` - Complete 3-step form (Business Name, Admin Details, Review)
- **Authentication Wrapper**: `lib/widgets/auth_wrapper.dart` - Handles routing logic
- **Backend API**: `backend/modules/setup/router.py` - `/initialize` endpoint
- **Data Connect Mutation**: `dataconnect/connector/mutations/admin/onboarding.gql` - Saves to Cloud SQL
- **Initialization Service**: `backend/modules/setup/initialization.py` - Sets Firebase custom claims

### 2. Current Flow
```mermaid
graph TD
    A[User Authenticates] --> B[AuthWrapper checks Data Connect]
    B -->|User exists in DB| C[Redirect to Dashboard]
    B -->|New user (no DB record)| D[Show Onboarding Stepper]
    D -->|Submit form| E[Call /api/v1/setup/initialize]
    E -->|Success| F[Set Firebase custom claims]
    F -->|Token refresh| G[Redirect to Dashboard]
```

### 3. Current Issue
The onboarding stepper is currently disabled/suspended and users are being routed directly to the dashboard without completing onboarding.

## Restoration Plan

### Phase 1: Verify Current State
1. **Check if onboarding stepper is being bypassed** in `auth_wrapper.dart`
2. **Verify the `/initialize` endpoint** is working correctly
3. **Test Data Connect mutation** for business/user creation

### Phase 2: Restore Onboarding Flow
1. **Ensure `auth_wrapper.dart` routes new users to onboarding**:
   ```dart
   // Line 79-82 in auth_wrapper.dart
   } else {
     // New user, route to onboarding
     return const OnboardingStepper();
   }
   ```

2. **Verify onboarding stepper submission**:
   - Form validation works correctly
   - API call to `/api/v1/setup/initialize` is successful
   - Firebase token refresh happens after custom claims are set

3. **Update backend initialization**:
   - Ensure `initialize_business()` creates proper Cloud SQL records
   - Verify Data Connect mutation executes successfully
   - Confirm custom claims are set correctly

### Phase 3: Testing & Validation
1. **Test anonymous user flow**:
   - New anonymous user → Onboarding → Dashboard

2. **Test authenticated user flow**:
   - New authenticated user → Onboarding → Dashboard
   - Existing user → Direct to Dashboard

3. **Verify data persistence**:
   - Business record created in Cloud SQL
   - User record linked to business
   - Custom claims properly set

### Phase 4: Deployment
1. **Enable onboarding in production**
2. **Monitor for errors**
3. **Collect user feedback**

## Technical Implementation Details

### Frontend Changes Required
1. **`auth_wrapper.dart`** - Ensure new users are routed to onboarding
2. **`onboarding_stepper.dart`** - Verify form submission and API calls work

### Backend Changes Required
1. **`initialization.py`** - Ensure Data Connect integration works
2. **`router.py`** - Verify `/initialize` endpoint handles requests correctly

### Database Changes
1. **Cloud SQL** - Verify `CreateBusinessAndAdmin` mutation works
2. **Firebase Auth** - Confirm custom claims are set properly

## Success Criteria
- ✅ New users (authenticated or anonymous) see onboarding stepper on first login
- ✅ Onboarding data is successfully saved to Cloud SQL
- ✅ Users are redirected to dashboard after successful onboarding
- ✅ Existing users bypass onboarding and go directly to dashboard
- ✅ All data is properly linked (business_id custom claims, user records, etc.)