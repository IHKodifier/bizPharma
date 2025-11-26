import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ik_pharma/firebase_options.dart';
import 'package:ik_pharma/dataconnect_generated/ik_pharma.dart';

void main() {
  test('Verify Business Creation', () async {
    // Initialize Firebase
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Connect to Emulators
    // Assuming Auth emulator is on 9099, if not, this might fail or hit prod
    // But for Data Connect verification, we need to hit the Data Connect emulator

    // Configure Data Connect Emulator
    IkPharmaConnector.instance.dataConnect.useDataConnectEmulator(
      '127.0.0.1',
      9399,
    );

    // We need to be authenticated to query businesses
    final auth = FirebaseAuth.instance;
    // Uncomment if Auth emulator is running
    // auth.useAuthEmulator('127.0.0.1', 9099);

    // Sign in anonymously to get a token
    // Note: If RLS restricts access to only own business, this might return empty
    // unless ListAllBusinesses is open to all users.
    await auth.signInAnonymously();
    print('Signed in as: ${auth.currentUser?.uid}');

    // Query Businesses
    final result = await IkPharmaConnector.instance
        .listAllBusinesses()
        .execute();

    print('Found ${result.data.businesses.length} businesses');
    for (var business in result.data.businesses) {
      print('Business: ${business.name} (Tier: ${business.tier})');
    }
  });
}
