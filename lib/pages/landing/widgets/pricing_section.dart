import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;
    final theme = Theme.of(context);

    // Cards
    final cards = [
      _PricingData(
        title: 'Free Trial',
        subtitle: 'Perfect for testing',
        price: 'PKR 0',
        period: '/4 weeks',
        features: [
          'Full feature access',
          '500 inventory items',
          '500 transactions/day',
          '50 suppliers',
          'No credit card required',
        ],
        isHighlighted: false,
        ctaText: 'Start Free Trial',
      ),
      _PricingData(
        title: 'Growth',
        subtitle: 'Complete pharmacy solution',
        price: 'PKR 60K',
        period: 'Upfront + PKR 400/mo',
        subtext: 'License fee split in 4 installments',
        badge: 'BEST VALUE',
        features: [
          'Unlimited items & transactions',
          '3 base users',
          'All core features',
          'Email support',
          '4-month installments available',
        ],
        isHighlighted: true,
        ctaText: 'Get Started',
      ),
      _PricingData(
        title: 'Corporate',
        subtitle: 'For large organizations',
        price: 'Custom',
        period: '',
        subtext: 'Tailored to your needs',
        features: [
          'Unlimited users & roles',
          'Custom integrations',
          'Dedicated support',
          'Custom SLA',
          'White-glove onboarding',
        ],
        isHighlighted: false,
        ctaText: 'Contact Sales',
      ),
    ];

    return Container(
      width: double.infinity,
      color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 48,
        vertical: isMobile ? 48 : 80,
      ),
      child: Column(
        children: [
          Text(
            'Simple, transparent pricing',
            style: GoogleFonts.inter(
              fontSize: isMobile ? 28 : 40,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Choose the plan that fits your business',
            style: GoogleFonts.inter(
              fontSize: isMobile ? 16 : 18,
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 56),

          // Pricing Cards
          isMobile
              ? Column(
                  children: cards.map((card) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: _PricingCard(data: card),
                    );
                  }).toList(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: cards.map((card) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: _PricingCard(data: card),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}

class _PricingData {
  final String title;
  final String subtitle;
  final String price;
  final String period;
  final String? subtext;
  final String? badge;
  final List<String> features;
  final bool isHighlighted;
  final String ctaText;

  _PricingData({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.period,
    this.subtext,
    this.badge,
    required this.features,
    required this.isHighlighted,
    required this.ctaText,
  });
}

class _PricingCard extends StatefulWidget {
  final _PricingData data;

  const _PricingCard({required this.data});

  @override
  State<_PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<_PricingCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isHighlighted = widget.data.isHighlighted;

    // Spec Colors mirroring HeroSection & Navbar
    final limeColor = isDark
        ? const Color(0xFFC5E64D)
        : const Color(0xFFCDDC39);
    final darkGreenColor = isDark
        ? const Color(0xFF2C3500)
        : const Color(0xFF2C3E00);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.translationValues(
              0,
              isHighlighted || _isHovered ? -8 : 0,
              0,
            ),
            width: 340,
            child: Card(
              elevation: isHighlighted || _isHovered ? 8 : 0,
              shadowColor: limeColor.withOpacity(isHighlighted ? 0.3 : 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: isHighlighted
                      ? limeColor
                      : theme.colorScheme.outline.withOpacity(0.3),
                  width: isHighlighted || _isHovered ? 2 : 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.title,
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.data.subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          widget.data.price,
                          style: GoogleFonts.inter(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.data.period,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                    if (widget.data.subtext != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        widget.data.subtext!,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 24),
                    ...widget.data.features.map(
                      (feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 20,
                              color: isHighlighted ? limeColor : Colors.green,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                feature,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  height: 1.4,
                                  fontWeight: feature.contains('UNLIMITED')
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: limeColor,
                          foregroundColor: darkGreenColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: isHighlighted ? 2 : 0,
                        ),
                        child: Text(
                          widget.data.ctaText,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isHighlighted)
            Positioned(
              top: -20,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: limeColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: limeColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    widget.data.badge!,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: darkGreenColor,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
