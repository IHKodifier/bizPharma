import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

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
}
