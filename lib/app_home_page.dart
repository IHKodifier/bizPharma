import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/theme_provider.dart';
import 'providers/auth_provider.dart';

class AppHomePage extends ConsumerStatefulWidget {
  const AppHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends ConsumerState<AppHomePage> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          // User email (only for non-anonymous users)
          authState.when(
            data: (user) {
              if (user != null && !user.isAnonymous && user.email != null) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Center(
                    child: Text(
                      user.email!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          // User avatar (only for non-anonymous users)
          authState.when(
            data: (user) {
              if (user != null && !user.isAnonymous) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                    foregroundImage: user.photoURL != null
                        ? NetworkImage(user.photoURL!)
                        : null,
                    onForegroundImageError: user.photoURL != null
                        ? (exception, stackTrace) {
                            // Silently handle image load errors (rate limiting, etc.)
                          }
                        : null,
                    child: user.photoURL == null
                        ? const Icon(Icons.person)
                        : Text(
                            user.displayName?.substring(0, 1).toUpperCase() ??
                                user.email?.substring(0, 1).toUpperCase() ??
                                'U',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          // Theme toggle
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              ref.read(themeProvider.notifier).toggle();
            },
          ),
          // Conditional: Upgrade button for anonymous, Logout for authenticated
          authState.when(
            data: (user) {
              if (user != null && user.isAnonymous) {
                // Show upgrade button for anonymous users
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await ref.read(authServiceProvider).linkWithGoogle();
                    },
                    icon: const Icon(Icons.upgrade, size: 18),
                    label: const Text('Upgrade'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                );
              } else if (user != null) {
                // Show logout button for authenticated users
                return IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Sign Out',
                  onPressed: () async {
                    await ref.read(authServiceProvider).signOut();
                  },
                );
              }
              return const SizedBox.shrink();
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Upgrade prompt banner for anonymous users
          authState.when(
            data: (user) {
              if (user != null && user.isAnonymous) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(
                          context,
                        ).colorScheme.outline.withOpacity(0.2),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'You\'re using a trial account. Upgrade to secure your data and never lose access!',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                              ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      TextButton(
                        onPressed: () async {
                          await ref.read(authServiceProvider).linkWithGoogle();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.surface,
                        ),
                        child: const Text('Upgrade Now'),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          // Main content
          Expanded(child: const Center(child: Text('Welcome to ik-Pharma!'))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Welcome to ik-Pharma!'),
                content: const Text(
                  'The Premium Pharmacy management system in the cloud. \nWe are under construction. \nVisit some time later to test us out.',
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Info',
        child: const Icon(Icons.info),
      ),
    );
  }
}
