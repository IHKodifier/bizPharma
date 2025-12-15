# Debugging Guide for Onboarding Routing Issues

## Step 1: Clear All App Data
Since hot restart didn't work, we need to clear all app data:

### For Web Apps:
1. Clear browser cache completely
2. Use Incognito/Private mode for testing
3. Clear IndexedDB storage (Chrome DevTools → Application → Clear storage)

### For Mobile Apps:
1. Uninstall and reinstall the app
2. Clear app data from device settings
3. Use `flutter clean` and rebuild

## Step 2: Add Debug Logging
Let me add some debug logging to understand what's happening:

## Step 3: Check Current User Status
We need to verify:
1. Is there an existing Firebase user?
2. What does the Data Connect query return?
3. What's the value of `dcUser` and `dcUser.businessId`?

## Step 4: Potential Issues Found

### Issue 1: User Already Exists in Firebase
If you've tested this before, there might be an existing anonymous Firebase user that already completed onboarding.

### Issue 2: Data Connect Query Might Be Succeeding
The Data Connect query might actually be finding a user record when we expect it to fail.

### Issue 3: Cached State in Providers
Riverpod providers might be caching the user state incorrectly.

## Step 5: Recommended Debugging Steps

1. **Clear all Firebase Auth state**:
   ```dart
   await FirebaseAuth.instance.signOut();
   // Then sign in again as anonymous
   ```

2. **Add debug prints to auth wrapper**:
   ```dart
   print('Firebase user: ${firebaseUser?.uid}');
   print('Data Connect user: ${dcUser?.id}, businessId: ${dcUser?.businessId}');
   ```

3. **Check if user exists in Data Connect manually**:
   - Use the Data Connect console to check if your test user ID exists

4. **Try with a completely new device/browser**:
   - This ensures no cached data interferes

## Step 6: Alternative Testing Approach
If clearing data doesn't work, let's try a different approach:

1. **Temporarily force all users to onboarding** (for testing):
   ```dart
   // In auth_wrapper.dart, temporarily change:
   if (false) {  // Force all users to onboarding for testing
     // Existing business logic
   } else {
     return const OnboardingStepper();  // Force onboarding
   }
   ```

2. **Test with this forced onboarding** to verify the onboarding widget works
3. **Then revert the change** and test normal flow

This will help us isolate whether the issue is in the routing logic or the authentication state detection.