import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/navbar.dart';
import 'widgets/hero_section.dart';
import 'widgets/value_props_section.dart';
import 'widgets/pricing_section.dart';
import 'widgets/footer.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  late final ScrollController _scrollController;
  final ValueNotifier<bool> _isScrolledNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final isScrolled = _scrollController.offset > 50;
    if (_isScrolledNotifier.value != isScrolled) {
      _isScrolledNotifier.value = isScrolled;
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _isScrolledNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allow body to be behind content
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: const [
                // Add top padding to account for fixed navbar if needed,
                // but Hero usually covers top.
                // Actually, HeroSection is full screen or close to it, so it should start at top.
                HeroSection(),
                ValuePropsSection(),
                PricingSection(),
                LandingFooter(),
              ],
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _isScrolledNotifier,
            builder: (context, isScrolled, child) {
              return LandingNavbar(isScrolled: isScrolled);
            },
          ),
        ],
      ),
    );
  }
}
