import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import '../../../../providers/inventory_provider.dart';

class InventoryPage extends ConsumerStatefulWidget {
  const InventoryPage({super.key});

  @override
  ConsumerState<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends ConsumerState<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Inventory Management',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 24),

          // Expiry Dashboard Section
          Text(
            'Expiry Health',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          ref
              .watch(expiryDashboardProvider)
              .when(
                data: (data) => _buildExpirySummary(context, data),
                loading: () => const CircularProgressIndicator(),
                error: (e, _) {
                  if (e is DioException) {
                    final detail = e.response?.data?['detail'] ?? e.message;
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Connection Error (${e.response?.statusCode})',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Detail: $detail',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    );
                  }
                  // Fallback for non-Dio errors
                  return Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.red.shade50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Error Type: ${e.runtimeType}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('Error Message: $e'),
                      ],
                    ),
                  );
                },
              ),
        ],
      ),
    );
  }

  Widget _buildExpirySummary(BuildContext context, Map<String, dynamic> data) {
    return Row(
      children: [
        _buildStatCard(
          context,
          'Critical (<30d)',
          '${data['critical_batches']}',
          Colors.red,
        ),
        const SizedBox(width: 16),
        _buildStatCard(
          context,
          'Warning (<90d)',
          '${data['warning_batches']}',
          Colors.orange,
        ),
        const SizedBox(width: 16),
        _buildStatCard(
          context,
          'Attention (<180d)',
          '${data['attention_batches']}',
          Colors.yellow.shade800,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
