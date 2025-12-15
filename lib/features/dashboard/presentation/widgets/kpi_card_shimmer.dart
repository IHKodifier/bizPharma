import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class KpiCardShimmer extends StatelessWidget {
  const KpiCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // Basic Shimmer card matching KpiCard dimensions
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
