import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return Container(
      width: double.infinity,
      color: Theme.of(
        context,
      ).colorScheme.surfaceContainerHighest.withOpacity(0.3),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 48,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        children: [
          Text(
            'Choose Your Plan',
            style: GoogleFonts.inter(
              fontSize: isMobile ? 28 : 40,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: const [
              _PricingCard(
                title: 'Trial',
                subtitle: 'Perfect for testing waters',
                price: 'Free',
                period: '4 Weeks',
                features: [
                  'Full feature access',
                  '500 inventory items',
                  '500 transactions/day',
                  '50 suppliers',
                  'No credit card required',
                ],
                isHighlighted: false,
              ),
              _PricingCard(
                title: 'Growth',
                subtitle: 'For ambitious pharmacies',
                price: 'PKR 60K',
                period: 'Upfront + PKR 400/mo',
                features: [
                  'Unlimited items & transactions',
                  '3 base users',
                  'All core features',
                  'Email support',
                  '6-month installments',
                ],
                isHighlighted: true,
              ),
              _PricingCard(
                title: 'Enterprise',
                subtitle: 'For large chains',
                price: 'Custom',
                period: 'Contact Sales',
                features: [
                  'Unlimited users & roles',
                  'Custom integrations',
                  'Dedicated support',
                  'Custom SLA',
                  'White-glove onboarding',
                ],
                isHighlighted: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PricingCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String price;
  final String period;
  final List<String> features;
  final bool isHighlighted;

  const _PricingCard({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.period,
    required this.features,
    required this.isHighlighted,
  });

  @override
  State<_PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<_PricingCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
        width: 320,
        child: Card(
          elevation: widget.isHighlighted || _isHovered ? 8 : 2,
          shadowColor: theme.colorScheme.primary.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: widget.isHighlighted
                ? BorderSide(color: theme.colorScheme.primary, width: 2)
                : BorderSide.none,
          ),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.isHighlighted)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'RECOMMENDED',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                if (widget.isHighlighted) const SizedBox(height: 16),
                Text(
                  widget.title,
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.price,
                      style: GoogleFonts.inter(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.period,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                ...widget.features.map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 20,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            feature,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              height: 1.4,
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.8,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: widget.isHighlighted
                          ? theme.colorScheme.primary
                          : null,
                    ),
                    child: Text(
                      widget.title == 'Enterprise'
                          ? 'Contact Sales'
                          : 'Get Started',
                      style: GoogleFonts.inter(
                        fontSize: 16,
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
    );
  }
}
