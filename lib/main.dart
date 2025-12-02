import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'my_app.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/foundation.dart';
import 'dataconnect_generated/biz_pharma.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode) {
    // Connect to Data Connect Emulator
    String host = '127.0.0.1';
    if (defaultTargetPlatform == TargetPlatform.android) {
      host = '10.0.2.2';
    }
    BizPharmaConnector.instance.dataConnect.useDataConnectEmulator(host, 9399);
    print('🔌 Connected to Data Connect Emulator on $host:9399');
  }

  runApp(const ProviderScope(child: MyApp()));
}
