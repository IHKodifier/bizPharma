import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 1200;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary.withOpacity(0.05),
            theme.colorScheme.surface,
            theme.colorScheme.primaryContainer.withOpacity(0.1),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : (isTablet ? 48 : 80),
          vertical: isMobile ? 40 : 80,
        ),
        child: isMobile || isTablet
            ? Column(
                children: [
                  _TextContent(isMobile: isMobile),
                  const SizedBox(height: 48),
                  _HeroImage(isMobile: isMobile),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 5, child: _TextContent(isMobile: false)),
                  const SizedBox(width: 80),
                  Expanded(flex: 5, child: _HeroImage(isMobile: false)),
                ],
              ),
      ),
    );
  }
}

class _TextContent extends StatelessWidget {
  final bool isMobile;

  const _TextContent({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          'The Future of Pharmacy Management is Here.',
          style: GoogleFonts.inter(
            fontSize: isMobile ? 32 : 56,
            fontWeight: FontWeight.bold,
            height: 1.1,
            color: theme.colorScheme.onSurface,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 24),
        Text(
          'Run your entire pharmacy business from your smartphone. Intelligent inventory, seamless POS, and powerful analytics—all in one unified cloud platform.',
          style: GoogleFonts.inter(
            fontSize: isMobile ? 16 : 18,
            height: 1.6,
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _PrimaryButton(
              label: 'Start Your 4-Week Free Trial',
              onPressed: () {},
            ),
            _SecondaryButton(label: 'Watch Demo', onPressed: () {}),
          ],
        ),
      ],
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
          return Container(
            height: isMobile ? 250 : 400,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Icon(
                Icons.image,
                size: 64,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const _PrimaryButton({required this.label, required this.onPressed});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _isHovered ? -2 : 0, 0),
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            elevation: _isHovered ? 8 : 2,
            shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const _SecondaryButton({required this.label, required this.onPressed});

  @override
  State<_SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<_SecondaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _isHovered ? -2 : 0, 0),
        child: OutlinedButton(
          onPressed: widget.onPressed,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            side: BorderSide(
              color: _isHovered
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.play_circle_outline,
                size: 20,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
