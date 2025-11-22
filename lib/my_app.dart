import 'package:flutter/material.dart';
import 'widgets/auth_wrapper.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/theme_provider.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'ik-Pharma',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF004040)),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF004040),
          brightness: Brightness.dark,
        ),
      ),
      home: const AuthWrapper(),
    );
  }
}
