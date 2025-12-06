import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KpiCard extends StatefulWidget {
  final String title;
  final String value;
  final String? trend;
  final bool isTrendPositive;
  final String? trendText;
  final IconData? icon;
  final Color? iconColor;
  final int index;

  const KpiCard({
    super.key,
    required this.title,
    required this.value,
    this.trend,
    this.isTrendPositive = true,
    this.trendText,
    this.icon,
    this.iconColor,
    required this.index,
  });

  @override
  State<KpiCard> createState() => _KpiCardState();
}

class _KpiCardState extends State<KpiCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );

    // Lateral translation removed (dx = 0).
    // Vertical translation: Fixed Upwards (-20.0) for all cards.
    final double hoverDx = 0.0;
    const double hoverDy = -20.0;

    // First half of duration: Translate
    _offsetAnimation =
        Tween<Offset>(
          begin: Offset.zero,
          end: Offset(hoverDx, hoverDy),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(
              0.0,
              0.5,
              curve: Curves.easeInOutCubicEmphasized,
            ),
            reverseCurve: const Interval(
              0.5,
              1.0,
              curve: Curves.easeInOutCubicEmphasized,
            ),
          ),
        );

    // Second half of duration: Scale
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.16).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOutCubicEmphasized),
        reverseCurve: const Interval(
          0.0,
          0.5,
          curve: Curves.easeInOutCubicEmphasized,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isDark = theme.brightness == Brightness.dark;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..translate(
                  _offsetAnimation.value.dx,
                  _offsetAnimation.value.dy,
                )
                ..scale(_scaleAnimation.value),
              child: child,
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: isDark
                  ? colorScheme.surfaceContainer
                  : colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: isDark
                  ? Border.all(
                      color: colorScheme.outlineVariant.withOpacity(0.2),
                    )
                  : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.title,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (widget.icon != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(
                          widget.icon,
                          size: 20,
                          color:
                              widget.iconColor ??
                              colorScheme.onSurfaceVariant.withOpacity(0.5),
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.value,
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                if (widget.trend != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color:
                                (widget.isTrendPositive
                                        ? Colors.green
                                        : Colors.red)
                                    .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                widget.isTrendPositive
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                size: 12,
                                color: widget.isTrendPositive
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  widget.trend!,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: widget.isTrendPositive
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (widget.trendText != null) ...[
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            widget.trendText!,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: MouseRegion(
            onEnter: (_) => _controller.forward(),
            onExit: (_) => _controller.reverse(),
            hitTestBehavior: HitTestBehavior.translucent,
          ),
        ),
      ],
    );
  }
}
