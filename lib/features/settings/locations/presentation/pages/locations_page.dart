import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../providers/user_provider.dart';
import '../../../../../providers/location_provider.dart';
import '../../../../../providers/auth_provider.dart';
import '../../../../../dataconnect_generated/biz_pharma.dart';
import '../widgets/location_form_modal.dart';

/// Locations management page displaying all business locations
class LocationsPage extends ConsumerWidget {
  const LocationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(userProvider);

    final authState = ref.watch(authStateProvider);

    if (user == null) {
      if (authState.value != null) {
        return const Center(child: CircularProgressIndicator());
      }
      return const Center(child: Text('Please log in to view locations'));
    }

    final locationsAsync = ref.watch(locationsProvider(user.businessId));

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Locations',
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Manage your business locations',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              FilledButton.icon(
                onPressed: () =>
                    _showAddLocationModal(context, ref, user.businessId),
                icon: const Icon(Icons.add, size: 20),
                label: const Text('Add Location'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Locations List
          Expanded(
            child: locationsAsync.when(
              data: (locations) {
                if (locations.isEmpty) {
                  return _buildEmptyState(context, ref, user.businessId);
                }
                return _buildLocationsTable(
                  context,
                  ref,
                  locations,
                  user.businessId,
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: theme.colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading locations',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.toString(),
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () =>
                          ref.invalidate(locationsProvider(user.businessId)),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    WidgetRef ref,
    String businessId,
  ) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_off_outlined,
            size: 80,
            color: theme.colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 24),
          Text(
            'No locations found',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first location to get started',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => _showAddLocationModal(context, ref, businessId),
            icon: const Icon(Icons.add),
            label: const Text('Add Location'),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationsTable(
    BuildContext context,
    WidgetRef ref,
    List<ListLocationsByBusinessLocations> locations,
    String businessId,
  ) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SingleChildScrollView(
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(
              theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
            ),
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Code')),
              DataColumn(label: Text('Type')),
              DataColumn(label: Text('Phone')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Actions')),
            ],
            rows: locations.map((location) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(
                      location.name,
                      style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                    ),
                  ),
                  DataCell(
                    Text(
                      location.code,
                      style: GoogleFonts.robotoMono(fontSize: 13),
                    ),
                  ),
                  DataCell(_buildTypeBadge(context, location.type)),
                  DataCell(Text(location.phone ?? '-')),
                  DataCell(_buildStatusBadge(context, location.isActive)),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, size: 20),
                          tooltip: 'Edit',
                          onPressed: () => _showEditLocationModal(
                            context,
                            ref,
                            location,
                            businessId,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            location.isActive
                                ? Icons.toggle_on
                                : Icons.toggle_off,
                            size: 28,
                            color: location.isActive
                                ? Colors.green
                                : Colors.grey,
                          ),
                          tooltip: location.isActive
                              ? 'Deactivate'
                              : 'Activate',
                          onPressed: () => _toggleLocationStatus(
                            context,
                            ref,
                            location,
                            businessId,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeBadge(BuildContext context, EnumValue<LocationType> type) {
    final colors = _getTypeColors(type.stringValue);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors['bg'],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        _getLocationTypeDisplayName(type.stringValue),
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: colors['text'],
        ),
      ),
    );
  }

  String _getLocationTypeDisplayName(String typeString) {
    switch (typeString) {
      case 'HEAD_OFFICE':
        return 'Head Office';
      case 'REGIONAL_OFFICE':
        return 'Regional Office';
      case 'REGIONAL_WAREHOUSE':
        return 'Regional Warehouse';
      case 'RETAIL_STORE':
        return 'Retail Store';
      case 'DISTRIBUTION_CENTER':
        return 'Distribution Center';
      default:
        return typeString;
    }
  }

  Map<String, Color> _getTypeColors(String typeString) {
    switch (typeString) {
      case 'HEAD_OFFICE':
        return {'bg': Colors.purple.shade50, 'text': Colors.purple.shade700};
      case 'REGIONAL_OFFICE':
        return {'bg': Colors.indigo.shade50, 'text': Colors.indigo.shade700};
      case 'REGIONAL_WAREHOUSE':
        return {'bg': Colors.blue.shade50, 'text': Colors.blue.shade700};
      case 'RETAIL_STORE':
        return {'bg': Colors.teal.shade50, 'text': Colors.teal.shade700};
      case 'DISTRIBUTION_CENTER':
        return {'bg': Colors.orange.shade50, 'text': Colors.orange.shade700};
      default:
        return {'bg': Colors.grey.shade50, 'text': Colors.grey.shade700};
    }
  }

  Widget _buildStatusBadge(BuildContext context, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? Colors.green.shade50 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        isActive ? 'Active' : 'Inactive',
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isActive ? Colors.green.shade700 : Colors.grey.shade600,
        ),
      ),
    );
  }

  void _showAddLocationModal(
    BuildContext context,
    WidgetRef ref,
    String businessId,
  ) {
    showDialog(
      context: context,
      builder: (context) => LocationFormModal(
        businessId: businessId,
        onSaved: () {
          ref.invalidate(locationsProvider(businessId));
        },
      ),
    );
  }

  void _showEditLocationModal(
    BuildContext context,
    WidgetRef ref,
    ListLocationsByBusinessLocations location,
    String businessId,
  ) {
    showDialog(
      context: context,
      builder: (context) => LocationFormModal(
        businessId: businessId,
        existingLocation: location,
        onSaved: () {
          ref.invalidate(locationsProvider(businessId));
        },
      ),
    );
  }

  Future<void> _toggleLocationStatus(
    BuildContext context,
    WidgetRef ref,
    ListLocationsByBusinessLocations location,
    String businessId,
  ) async {
    final locationService = ref.read(locationServiceProvider);
    final messenger = ScaffoldMessenger.of(context);

    try {
      if (location.isActive) {
        await locationService.deactivateLocation(location.id);
        messenger.showSnackBar(
          SnackBar(
            content: Text('${location.name} deactivated'),
            backgroundColor: Colors.orange,
          ),
        );
      } else {
        await locationService.reactivateLocation(location.id);
        messenger.showSnackBar(
          SnackBar(
            content: Text('${location.name} activated'),
            backgroundColor: Colors.green,
          ),
        );
      }
      ref.invalidate(locationsProvider(businessId));
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }
}
