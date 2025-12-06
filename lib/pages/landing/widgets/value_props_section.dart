import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ValuePropsSection extends StatelessWidget {
  const ValuePropsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 900;
    final theme = Theme.of(context);

    // Feature Data
    final features = [
      _FeatureData(
        icon: Icons.smartphone,
        title: 'Mobile POS',
        description:
            'Turn any smartphone into a powerful POS terminal. Scan barcodes with your camera—no expensive hardware needed.',
      ),
      _FeatureData(
        icon: Icons.calendar_today_outlined,
        title: 'Batch & Expiry',
        description:
            'Never sell expired medicine again. FEFO (First-Expired-First-Out) tracking ensures inventory freshness.',
      ),
      _FeatureData(
        icon: Icons.store_mall_directory_outlined,
        title: 'Multi-Location',
        description:
            'Manage all your stores from one dashboard. Transfer stock instantly and track performance across locations.',
      ),
      _FeatureData(
        icon: Icons.shopping_cart_outlined,
        title: 'Smart Reordering',
        description:
            'AI-powered suggestions tell you exactly what to buy and when, preventing stockouts and overstocking.',
      ),
      _FeatureData(
        icon: Icons.pie_chart_outline,
        title: 'Financial Reporting',
        description:
            'Real-time P&L, tax reports, and sales insights. Know your exact profit margins instantly.',
      ),
      _FeatureData(
        icon: Icons.people_outline,
        title: 'Customer Management',
        description:
            'Track purchase history, offer loyalty rewards, and manage credit profiles for your customers.',
      ),
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 48,
        vertical: isMobile ? 48 : 80,
      ),
      child: Column(
        children: [
          // Section Header
          Text(
            'Everything you need to manage your pharmacy',
            style: GoogleFonts.inter(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Powerful features designed for modern pharmacy operations',
            style: GoogleFonts.inter(
              fontSize: isMobile ? 16 : 18,
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),

          // Feature Grid
          LayoutBuilder(
            builder: (context, constraints) {
              // Grid Configuration
              int columns = isMobile ? 1 : (isTablet ? 2 : 3);
              double gap = 24.0;
              // Calculate item width based on available width and gaps
              // availableWidth = totalWidth - ((columns - 1) * gap)
              double totalGap = (columns - 1) * gap;
              double itemWidth = (constraints.maxWidth - totalGap) / columns;

              return Wrap(
                spacing: gap,
                runSpacing: isMobile ? 16 : 32,
                children: features.map((feature) {
                  return _FeatureCard(
                    data: feature,
                    width: itemWidth,
                    isMobile: isMobile,
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FeatureData {
  final IconData icon;
  final String title;
  final String description;

  _FeatureData({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class _FeatureCard extends StatefulWidget {
  final _FeatureData data;
  final double width;
  final bool isMobile;

  const _FeatureCard({
    required this.data,
    required this.width,
    required this.isMobile,
  });

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Determine colors based on hover state and theme
    // We want a subtle primary border on hover
    final primaryColor = theme.colorScheme.primary;
    final borderColor = _isHovered
        ? primaryColor
        : theme.colorScheme.outline.withOpacity(0.2);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        transform: Matrix4.translationValues(
          0,
          _isHovered && !widget.isMobile ? -4 : 0,
          0,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: _isHovered ? 1.5 : 1.0),
          boxShadow: _isHovered && !widget.isMobile
              ? [
                  BoxShadow(
                    color: theme.shadowColor.withOpacity(0.1),
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                  ),
                ]
              : [],
        ),
        padding: EdgeInsets.all(widget.isMobile ? 24 : 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Container
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: widget.isMobile ? 64 : 80,
              height: widget.isMobile ? 64 : 80,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withOpacity(
                  _isHovered ? 0.3 : 0.15,
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 200),
                  scale: _isHovered ? 1.05 : 1.0,
                  child: Icon(
                    widget.data.icon,
                    size: widget.isMobile ? 32 : 40,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              widget.data.title,
              style: GoogleFonts.inter(
                fontSize: widget.isMobile ? 20 : 22,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              widget.data.description,
              style: GoogleFonts.inter(
                fontSize: 16,
                height: 1.6,
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 16),

            // Learn More Link
            if (!widget.isMobile)
              Row(
                children: [
                  Text(
                    'Learn more',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                      decoration: _isHovered
                          ? TextDecoration.underline
                          : TextDecoration.none,
                      decorationColor: primaryColor,
                    ),
                  ),
                  const SizedBox(width: 4),
                  AnimatedPadding(
                    duration: const Duration(milliseconds: 150),
                    padding: EdgeInsets.only(left: _isHovered ? 4 : 0),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
