import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import '../pages/landing/landing_page.dart';
import '../app_home_page.dart';
import '../pages/onboarding/onboarding_stepper.dart';
import '../dataconnect_generated/ik_pharma.dart';

// Provider to fetch the user from Data Connect
final currentUserProvider = FutureProvider.family<GetUserByAuthIdUser?, String>(
  (ref, uid) async {
    final authService = ref.watch(authServiceProvider);
    return authService.getUser(uid);
  },
);

// Provider to fetch business by ID
final businessByIdProvider =
    FutureProvider.family<GetBusinessByIdBusiness?, String>((
      ref,
      businessId,
    ) async {
      final result = await IkPharmaConnector.instance
          .getBusinessById(id: businessId)
          .execute();
      return result.data.business;
    });

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (firebaseUser) {
        if (firebaseUser != null) {
          // User is authenticated with Firebase Auth
          // Now fetch their Data Connect profile
          final userAsync = ref.watch(currentUserProvider(firebaseUser.uid));

          return userAsync.when(
            data: (dcUser) {
              if (dcUser != null) {
                // User exists in Data Connect
                // Hydrate global user provider
                Future.microtask(() {
                  ref.read(userProvider.notifier).setUser(dcUser);
                });

                // Fetch and hydrate business
                final businessAsync = ref.watch(
                  businessByIdProvider(dcUser.businessId),
                );

                return businessAsync.when(
                  data: (business) {
                    if (business != null) {
                      Future.microtask(() {
                        ref
                            .read(businessProvider.notifier)
                            .setBusiness(business);
                      });
                      return const AppHomePage(title: 'ik-Pharma Dashboard');
                    }
                    return const Scaffold(
                      body: Center(child: Text('Business not found')),
                    );
                  },
                  loading: () => const Scaffold(
                    body: Center(child: Text('Loading business details...')),
                  ),
                  error: (e, s) => Scaffold(
                    body: Center(child: Text('Error loading business: $e')),
                  ),
                );
              } else {
                // New user, route to onboarding
                return const OnboardingStepper();
              }
            },
            loading: () => const Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Verifying account...'),
                  ],
                ),
              ),
            ),
            error: (error, stack) =>
                Scaffold(body: Center(child: Text('Error: $error'))),
          );
        }
        return const LandingPage();
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) => const LandingPage(),
    );
  }
}
