import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/theme_provider.dart';

class HeroSection extends ConsumerStatefulWidget {
  const HeroSection({super.key});

  @override
  ConsumerState<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends ConsumerState<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    // Gradient Colors based on Theme
    final gradientColors = isDark
        ? [const Color(0xFF1E1E1E), const Color(0xFF2C3500)] // Dark to Olive
        : [
            const Color(0xFFF8F9FA),
            const Color(0xFFE8F5B8),
          ]; // Off-white to Pale Lime

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: isMobile
            ? size.height * 0.8
            : size.height, // 80vh mobile, 100vh desktop
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
        ),
      ),
      child: SafeArea(
        // Ensure content isn't under status bar initially, though navbar is fixed
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 48,
            vertical: isMobile ? 80 : 120, // Add top padding for fixed navbar
          ),
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: isMobile
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _TextContent(isMobile: true, isDark: isDark),
                          const SizedBox(height: 48),
                          // _HeroImage(isMobile: true), // Optional on mobile if space is tight
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 6,
                            child: _TextContent(
                              isMobile: false,
                              isDark: isDark,
                            ),
                          ),
                          const SizedBox(width: 48),
                          Expanded(flex: 6, child: _HeroImage(isMobile: false)),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TextContent extends ConsumerWidget {
  final bool isMobile;
  final bool isDark;

  const _TextContent({required this.isMobile, required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Typography Colors
    final headlineColor = isDark
        ? const Color(0xFFC5E64D)
        : const Color(0xFF0F4C4C); // Lime or Deep Teal
    final subheadlineColor = isDark
        ? const Color(0xFFC7C7C7)
        : const Color(0xFF44474E); // Light Gray or Medium Gray

    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'The Future of Pharmacy Management is Here.',
          style: GoogleFonts.inter(
            fontSize: isMobile
                ? 32
                : 56, // 32px Mobile, 56px Desktop (close to 48px/57px in spec)
            fontWeight: FontWeight.w600,
            height: 1.1,
            color: headlineColor,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 24),
        Text(
          'Run your entire pharmacy business from your smartphone. Intelligent inventory, seamless POS, and powerful analytics—all in one unified cloud platform.',
          style: GoogleFonts.inter(
            fontSize: isMobile ? 16 : 20,
            height: 1.5,
            color: subheadlineColor,
            fontWeight: FontWeight.w400,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 40),

        // CTA Buttons
        isMobile
            ? Column(
                children: [
                  _PrimaryCTA(isMobile: isMobile, isDark: isDark),
                  const SizedBox(height: 16),
                  _DemoButton(isDark: isDark),
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _PrimaryCTA(isMobile: isMobile, isDark: isDark),
                  const SizedBox(width: 24),
                  _DemoButton(isDark: isDark),
                ],
              ),

        const SizedBox(height: 32),

        // Trust Badges
        _TrustBadges(isMobile: isMobile, isDark: isDark),
      ],
    );
  }
}

class _DemoButton extends StatelessWidget {
  final bool isDark;

  const _DemoButton({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final color = isDark
        ? const Color(0xFFC5E64D) // Lime
        : const Color(0xFF0F4C4C); // Deep Teal

    return TextButton.icon(
      onPressed: () {},
      icon: Icon(Icons.play_circle_outline, size: 24),
      label: Text(
        'Watch Demo',
        style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      style: TextButton.styleFrom(
        foregroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      ),
    );
  }
}

class _PrimaryCTA extends ConsumerStatefulWidget {
  final bool isMobile;
  final bool isDark;

  const _PrimaryCTA({required this.isMobile, required this.isDark});

  @override
  ConsumerState<_PrimaryCTA> createState() => _PrimaryCTAState();
}

class _PrimaryCTAState extends ConsumerState<_PrimaryCTA> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // Spec Colors
    // Light: Bg #CDDC39 (Lime), Text #2C3E00 (Dark Green)
    // Dark: Bg #C5E64D (Lime), Text #2C3500 (Very Dark Green)

    final defaultBg = widget.isDark
        ? const Color(0xFFC5E64D)
        : const Color(0xFFCDDC39);
    final hoverBg = widget.isDark
        ? const Color(0xFFD4ED6A)
        : const Color(0xFFE8F5B8);
    final pressedBg = widget.isDark
        ? const Color(0xFF9FC230)
        : const Color(0xFFB0D340);

    final textColor = widget.isDark
        ? const Color(0xFF2C3500)
        : const Color(0xFF2C3E00);

    final currentBg = _isPressed
        ? pressedBg
        : (_isHovered ? hoverBg : defaultBg);

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        ref.read(authServiceProvider).signInAnonymously();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: Duration(milliseconds: _isPressed ? 100 : 200),
          curve: Curves.easeOut,
          width: widget.isMobile
              ? double.infinity
              : null, // Full width on mobile
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
          transform: Matrix4.translationValues(
            0,
            _isPressed ? 0 : (_isHovered ? -2 : 0),
            0,
          )..scale(_isPressed ? 0.98 : 1.0),
          decoration: BoxDecoration(
            color: currentBg,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: widget.isDark
                    ? const Color(0xFFC5E67D).withOpacity(0.3) // Lime shadow
                    : const Color(0xFFCDDC39).withOpacity(0.4),
                offset: Offset(0, _isPressed ? 1 : (_isHovered ? 4 : 2)),
                blurRadius: _isPressed ? 3 : (_isHovered ? 12 : 8),
              ),
            ],
          ),
          child: Text(
            'Start Free Trial',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _TrustBadges extends StatelessWidget {
  final bool isMobile;
  final bool isDark;

  const _TrustBadges({required this.isMobile, required this.isDark});

  @override
  Widget build(BuildContext context) {
    // Colors
    final iconColor = isDark
        ? const Color(0xFF4ADE80)
        : const Color(0xFF28A745); // Bright Green / Green
    final textColor = isDark
        ? const Color(0xFF9FC230)
        : const Color(0xFF5A7A6F); // Light Olive / Sage Green

    final badges = [
      'Free for 4 weeks',
      'No Credit Card required',
      'Full features',
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 8,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: badges
          .map(
            (text) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: iconColor, size: 16),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

class _HeroImage extends StatelessWidget {
  final bool isMobile;

  const _HeroImage({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        'assets/images/hero.png',
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          // Fallback Placeholder
          return Container(
            height: isMobile ? 250 : 400,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.dashboard_customize,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Dashboard Preview',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
