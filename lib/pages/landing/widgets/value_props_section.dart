import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ValuePropsSection extends StatelessWidget {
  const ValuePropsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 900;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 48,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        children: [
          Text(
            'Why ikPharma?',
            style: GoogleFonts.inter(
              fontSize: isMobile ? 28 : 40,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              int columns = isMobile ? 1 : (isTablet ? 2 : 4);
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: [
                  _ValuePropCard(
                    icon: Icons.phone_android,
                    title: 'Mobile-First POS',
                    description:
                        'Turn any smartphone into a powerful POS terminal. Scan barcodes with your camera—no expensive hardware needed.',
                    width: (constraints.maxWidth / columns) - 24,
                  ),
                  _ValuePropCard(
                    icon: Icons.inventory_2_outlined,
                    title: 'Smart Inventory',
                    description:
                        'Never lose money to expired stock again. FEFO tracking and AI-powered reorder suggestions keep your shelves optimized.',
                    width: (constraints.maxWidth / columns) - 24,
                  ),
                  _ValuePropCard(
                    icon: Icons.dashboard_outlined,
                    title: 'Unified Operations',
                    description:
                        'Procurement, Warehouse, Accounting, and HR. Stop juggling multiple systems. ikPharma does it all.',
                    width: (constraints.maxWidth / columns) - 24,
                  ),
                  _ValuePropCard(
                    icon: Icons.trending_up,
                    title: 'Scalable Growth',
                    description:
                        'From a single store to a nationwide chain. Our modular architecture grows with your business.',
                    width: (constraints.maxWidth / columns) - 24,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ValuePropCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final double width;

  const _ValuePropCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.width,
  });

  @override
  State<_ValuePropCard> createState() => _ValuePropCardState();
}

class _ValuePropCardState extends State<_ValuePropCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
        child: Card(
          elevation: _isHovered ? 8 : 2,
          shadowColor: theme.colorScheme.primary.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    widget.icon,
                    size: 28,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.title,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    height: 1.5,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
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
