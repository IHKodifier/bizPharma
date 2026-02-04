// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:firebase_app_check/firebase_app_check.dart';
import 'dart:developer';
// import 'dart:js' as js; // Add JS interop
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../dataconnect_generated/biz_pharma.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign in with Google (web-only for now)
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Configure Google provider with profile scope
      final googleProvider = GoogleAuthProvider();
      googleProvider.addScope('profile');
      googleProvider.addScope('email');

      // Use popup-based sign-in for web
      final userCredential = await _auth.signInWithPopup(googleProvider);

      // Debug: Log user data
      log('User signed in: ${userCredential.user?.email}');
      log('Photo URL: ${userCredential.user?.photoURL}');
      log('Display Name: ${userCredential.user?.displayName}');

      return userCredential;
    } catch (e) {
      log('Error signing in with Google: $e');
      rethrow;
    }
  }

  // Sign in anonymously for trial users
  Future<UserCredential?> signInAnonymously() async {
    try {
      final userCredential = await _auth.signInAnonymously();
      log('Anonymous user signed in: ${userCredential.user?.uid}');
      return userCredential;
    } catch (e) {
      log('Error signing in anonymously: $e');
      rethrow;
    }
  }

  // Link anonymous account to Google (preserves trial data)
  Future<UserCredential?> linkWithGoogle() async {
    try {
      final googleProvider = GoogleAuthProvider();
      googleProvider.addScope('profile');
      googleProvider.addScope('email');

      // This links the anonymous account to Google, preserving all data
      final userCredential = await _auth.currentUser?.linkWithPopup(
        googleProvider,
      );
      log('Account linked successfully: ${userCredential?.user?.email}');
      return userCredential;
    } catch (e) {
      log('Error linking account: $e');
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log('Error signing out: $e');
      rethrow;
    }
  }

  // Check if user exists in Data Connect and return the user object
  Future<GetUserByAuthIdUser?> getUser(String uid) async {
    try {
      // --- DIAGNOSTIC START ---
      try {
        final user = _auth.currentUser;
        if (user != null) {
          final tokenResult = await user.getIdTokenResult(true);
          final projectId = _auth.app.options.projectId;
          final iss = tokenResult.claims?['iss'];
          final aud = tokenResult.claims?['aud'];

          print('🛑 AUTH DIAGNOSTIC (getUser) v2:');
          print('   - App Project ID: ' + projectId);
          print('   - Token Issuer (iss): ' + (iss?.toString() ?? 'null'));
          print('   - Token Audience (aud): ' + (aud?.toString() ?? 'null'));
          print('   - User UID: ' + user.uid);
        }
      } catch (e) {
        print('🛑 AUTH DIAGNOSTIC ERROR: ' + e.toString());
      }
      // --- DIAGNOSTIC END ---

      final result = await BizPharmaConnector.instance
          .getUserByAuthId(id: uid)
          .execute();
      return result.data.user;
    } catch (e) {
      print(
        'User not found in Data Connect (new user) or Auth Error: ' +
            e.toString(),
      );
      log('User not found in Data Connect (new user) or Auth Error: $e');
      if (e is DataConnectOperationError) {
        log('DataConnect Error Code: ${e.code}');
        log('DataConnect Error Message: ${e.message}');
        // Try to log details if available
      }
      // Return null for new users instead of throwing error
      // This allows the auth wrapper to route them to onboarding
      return null;
    }
  }

  // Create Business and Admin User atomically (includes default Main Store location)
  Future<void> createBusinessAndUser({
    required String businessName,
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
    required String uid,
  }) async {
    try {
      const uuid = Uuid();
      final businessId = uuid.v4();
      final defaultLocationId = uuid.v4();

      await BizPharmaConnector.instance
          .createBusinessAndAdmin(
            businessId: businessId,
            businessName: businessName,
            userEmail: email,
            userFirstName: firstName,
            userLastName: lastName,
            userMobile: phone,
            authUid: uid,
            today: DateTime.now(),
            defaultLocationId: defaultLocationId,
          )
          .execute();
      log('Business, User, and default Location created successfully');
    } catch (e) {
      log('Error creating business and user: $e');
      rethrow;
    }
  }
}
