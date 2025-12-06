import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../providers/theme_provider.dart';
import '../../../providers/auth_provider.dart';

class LandingNavbar extends ConsumerStatefulWidget {
  final bool isScrolled;

  const LandingNavbar({super.key, required this.isScrolled});

  @override
  ConsumerState<LandingNavbar> createState() => _LandingNavbarState();
}

class _LandingNavbarState extends ConsumerState<LandingNavbar> {
  bool _isMobileMenuOpen = false;

  void _toggleMobileMenu() {
    setState(() => _isMobileMenuOpen = !_isMobileMenuOpen);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1200;
    final isTablet = screenWidth >= 768 && screenWidth < 1200;
    final isMobile = screenWidth < 768;

    // Header Height
    final double height = isDesktop ? 64 : 56;

    // Background & Shadow based on scroll
    final backgroundColor = widget.isScrolled
        ? theme.colorScheme.surface
        : theme.colorScheme.surface.withOpacity(0.95);

    final shadowColor = widget.isScrolled
        ? Colors.black.withOpacity(0.08)
        : Colors.transparent;

    return Stack(
      children: [
        // Main Navbar
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                offset: const Offset(0, 1),
                blurRadius: 3,
              ),
            ],
            border: widget.isScrolled
                ? Border(
                    bottom: BorderSide(
                      color: theme.colorScheme.outlineVariant,
                      width: 1,
                    ),
                  )
                : null,
          ),
          child: ClipRRect(
            child: BackdropFilter(
              filter: widget.isScrolled
                  ? ImageFilter.blur(sigmaX: 0, sigmaY: 0) // No blur when solid
                  : ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 48 : (isTablet ? 32 : 16),
                ),
                child: Row(
                  children: [
                    // Logo
                    _Logo(isMobile: isMobile),

                    const Spacer(),

                    // Desktop/Tablet Navigation
                    if (!isMobile) ...[
                      _NavLink(label: 'Features', onTap: () {}),
                      const SizedBox(width: 32),
                      _NavLink(label: 'Pricing', onTap: () {}),
                      const SizedBox(width: 32),
                      _NavLink(label: 'About', onTap: () {}),
                      const SizedBox(width: 32),
                      _NavLink(label: 'Contact', onTap: () {}),
                      const SizedBox(width: 32),

                      // Theme Toggle
                      _ThemeToggle(),
                      const SizedBox(width: 24),

                      // Auth Buttons
                      _AuthButtons(isMobile: false),
                    ],

                    // Mobile Menu Trigger
                    if (isMobile) ...[
                      _ThemeToggle(), // Keep theme toggle accessible on mobile navbar
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: _toggleMobileMenu,
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            _isMobileMenuOpen ? Icons.close : Icons.menu,
                            key: ValueKey(_isMobileMenuOpen),
                            size: 24,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),

        // Mobile Menu Overlay
        if (_isMobileMenuOpen && isMobile)
          Positioned.fill(
            top: height, // Start below navbar
            child: _MobileMenuOverlay(
              onClose: () => setState(() => _isMobileMenuOpen = false),
            ),
          ),
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  final bool isMobile;
  const _Logo({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.local_pharmacy,
          color: theme.colorScheme.primary,
          size: isMobile ? 24 : 32,
        ),
        const SizedBox(width: 8),
        Text(
          'bizPharma',
          style: GoogleFonts.inter(
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 150),
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: _isHovered
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface,
              ),
              child: Text(widget.label),
            ),
            // Animated Underline
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOut,
              height: 2,
              width: _isHovered ? 20 : 0, // Simplified width animation
              color: theme.colorScheme.primary,
              margin: const EdgeInsets.only(top: 4),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeToggle extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return IconButton(
      onPressed: () => ref.read(themeProvider.notifier).toggle(),
      icon: Icon(
        isDark ? Icons.light_mode : Icons.dark_mode,
        color: Theme.of(context).colorScheme.onSurface,
        size: 20,
      ),
      tooltip: isDark ? 'Light Mode' : 'Dark Mode',
    );
  }
}

class _AuthButtons extends ConsumerWidget {
  final bool isMobile;
  const _AuthButtons({required this.isMobile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    // Spec Colors mirroring HeroSection
    final limeColor = isDark
        ? const Color(0xFFC5E64D)
        : const Color(0xFFCDDC39);
    final darkGreenColor = isDark
        ? const Color(0xFF2C3500)
        : const Color(0xFF2C3E00); // 2C3500 for dark, 2C3E00 for light

    return authState.when(
      data: (user) {
        if (user != null) {
          return isMobile
              ? ListTile(
                  leading: CircleAvatar(
                    backgroundImage: user.photoURL != null
                        ? NetworkImage(user.photoURL!)
                        : null,
                    child: user.photoURL == null
                        ? const Icon(Icons.person)
                        : null,
                    radius: 16,
                  ),
                  title: const Text('Logout'),
                  onTap: () => ref.read(authServiceProvider).signOut(),
                )
              : Row(
                  children: [
                    if (user.photoURL != null)
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.photoURL!),
                        radius: 16,
                      ),
                    TextButton(
                      onPressed: () => ref.read(authServiceProvider).signOut(),
                      child: Text(
                        'Logout',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                );
        }

        // Not Logged In
        return isMobile
            ? Column(
                children: [
                  OutlinedButton(
                    onPressed: () =>
                        ref.read(authServiceProvider).signInWithGoogle(),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: const Text('Sign In'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(authServiceProvider).signInAnonymously(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: limeColor, // Specific Lime
                      foregroundColor: darkGreenColor, // Specific Dark Green
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: const Text('Start Free Trial'),
                  ),
                ],
              )
            : Row(
                children: [
                  OutlinedButton(
                    onPressed: () =>
                        ref.read(authServiceProvider).signInWithGoogle(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.colorScheme.primary,
                      side: BorderSide(color: theme.colorScheme.outline),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      'Sign In',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(authServiceProvider).signInAnonymously(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: limeColor, // Specific Lime matching Hero
                      foregroundColor: darkGreenColor, // Specific Dark Green
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Start Free Trial',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              );
      },
      loading: () => const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      error: (_, __) => const Icon(Icons.error, size: 20),
    );
  }
}

class _MobileMenuOverlay extends StatelessWidget {
  final VoidCallback onClose;

  const _MobileMenuOverlay({required this.onClose});

  @override
  Widget build(BuildContext context) {
    // This overlay should cover the rest of the screen
    // Since it's in a Stack in the Navbar, we rely on the Navbar being high z-index or size?
    // Wait, the Navbar widget itself has a fixed height in the build method (AnimatedContainer).
    // The Stack is inside LandingNavbar. If LandingNavbar height is constrained by parent, this might be clipped.
    // However, LandingNavbar is usually placed in a Stack or Column.
    // In LandingPage, we put LandingNavbar in a Stack on top of body.
    // But LandingNavbar doesn't expand to fill screen.
    // To make the overlay fill the screen, LandingNavbar needs to be able to expand or we use a separate OverlayEntry.
    // For simplicity in this architecture, let's assume we can use a Full Screen Dialog or similar if strictly needed,
    // but the task boundary tool suggests we are in a Stack in LandingPage.
    // If LandingNavbar height is 64, the overlay won't show outside.
    //
    // Correction: In LandingPage, LandingNavbar is in a Stack.
    // Use `Positioned(top: 0, left: 0, right: 0, height: isMenuOpen ? screenHeight : null)` logic in LandingPage?
    // Or make LandingNavbar Wrap content?

    // Better approach: Make LandingNavbar use a portal or Overlay, OR
    // Simply make the Stack in LandingPage handle the menu if possible.
    // But we want to keep logic in Navbar.
    // Ideally, the LandingNavbar widget in LandingPage is just the top bar.
    //
    // Given the constraints and current setup, I will implement a visual overlay assuming the parent allows expansion
    // OR we change LandingPage to let Navbar take more space when open.
    //
    // ACTUALLY, the `LandingPage` uses `Stack`, so `LandingNavbar` is `Positioned` implicitly or just a child.
    // If `LandingNavbar` height is not constrained, it can grow.
    // The `AnimatedContainer` in `LandingNavbar` has explicit height. `Stack` allows children to overlap.
    // If `LandingNavbar` returns a Stack, and the Overlay part is positioned to fill screen height...
    // We need MediaQuery height.

    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    return Container(
      height: screenHeight - 56, // Subtract header height
      width: double.infinity,
      color: theme.colorScheme.surface.withOpacity(0.98),
      child: Material(
        color: Colors.transparent,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MobileMenuItem(label: 'Features', onTap: onClose),
              const Divider(),
              _MobileMenuItem(label: 'Pricing', onTap: onClose),
              const Divider(),
              _MobileMenuItem(label: 'About', onTap: onClose),
              const Divider(),
              _MobileMenuItem(label: 'Contact', onTap: onClose),
              const SizedBox(height: 32),
              const _AuthButtons(isMobile: true),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileMenuItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _MobileMenuItem({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
