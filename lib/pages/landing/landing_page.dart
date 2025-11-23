import 'package:flutter/material.dart';
import 'widgets/navbar.dart';
import 'widgets/hero_section.dart';
import 'widgets/value_props_section.dart';
import 'widgets/pricing_section.dart';
import 'widgets/footer.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            LandingNavbar(),
            HeroSection(),
            ValuePropsSection(),
            PricingSection(),
            LandingFooter(),
          ],
        ),
      ),
    );
  }
}
