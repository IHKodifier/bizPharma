import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../dataconnect_generated/ik_pharma.dart';

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
      final result = await IkPharmaConnector.instance
          .getUserByAuthId(id: uid)
          .execute();
      return result.data.user;
    } catch (e) {
      log('Error checking user existence: $e');
      rethrow;
    }
  }

  // Create Business and Admin User atomically
  Future<void> createBusinessAndUser({
    required String businessName,
    required String email,
    required String firstName,
    required String lastName,
    String? phone,
    required String uid,
  }) async {
    try {
      const uuid = Uuid();
      final businessId = uuid.v4();

      await IkPharmaConnector.instance
          .createBusinessAndAdmin(
            businessId: businessId,
            businessName: businessName,
            userEmail: email,
            userFirstName: firstName,
            userLastName: lastName,
            authUid: uid,
            today: DateTime.now(),
          )
          // .userPhone(phone)
          .execute();
      log('Business and User created successfully');
    } catch (e) {
      log('Error creating business and user: $e');
      rethrow;
    }
  }
}
