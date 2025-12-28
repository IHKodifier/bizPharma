import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../providers/location_provider.dart';
import '../../../../../dataconnect_generated/biz_pharma.dart';

/// Modal dialog for creating or editing a location
class LocationFormModal extends ConsumerStatefulWidget {
  final String businessId;
  final ListLocationsByBusinessLocations? existingLocation;
  final VoidCallback onSaved;

  const LocationFormModal({
    super.key,
    required this.businessId,
    required this.onSaved,
    this.existingLocation,
  });

  @override
  ConsumerState<LocationFormModal> createState() => _LocationFormModalState();
}

class _LocationFormModalState extends ConsumerState<LocationFormModal> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Form fields
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _operatingHoursController;
  late final TextEditingController _licenseNumberController;

  // Address fields
  late final TextEditingController _addressLine1Controller;
  late final TextEditingController _addressLine2Controller;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  late final TextEditingController _postalCodeController;
  late final TextEditingController _countryController;

  String _selectedType = 'RETAIL_STORE';

  bool get isEditing => widget.existingLocation != null;

  @override
  void initState() {
    super.initState();
    final location = widget.existingLocation;

    _nameController = TextEditingController(text: location?.name ?? '');
    _phoneController = TextEditingController(text: location?.phone ?? '');
    _emailController = TextEditingController(text: location?.email ?? '');
    _operatingHoursController = TextEditingController();
    _licenseNumberController = TextEditingController();

    // Address controllers
    _addressLine1Controller = TextEditingController();
    _addressLine2Controller = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _postalCodeController = TextEditingController();
    _countryController = TextEditingController(text: 'Pakistan');

    if (location != null) {
      _selectedType = location.type.stringValue;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _operatingHoursController.dispose();
    _licenseNumberController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 600,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withOpacity(
                  0.3,
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isEditing
                        ? Icons.edit_location_alt
                        : Icons.add_location_alt,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    isEditing ? 'Edit Location' : 'Add New Location',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // Form Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Basic Information Section
                      _buildSectionHeader('Basic Information'),
                      const SizedBox(height: 16),

                      // Name
                      TextFormField(
                        controller: _nameController,
                        decoration: _inputDecoration(
                          'Location Name',
                          hintText: 'e.g., Main Store, Warehouse A',
                          icon: Icons.store,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Location name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Type
                      DropdownButtonFormField<String>(
                        value: _selectedType,
                        decoration: _inputDecoration(
                          'Location Type',
                          icon: Icons.category,
                        ),
                        items: locationTypeOptions.map((option) {
                          return DropdownMenuItem(
                            value: option['value'] as String,
                            child: Text(option['label'] as String),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _selectedType = value);
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // Phone and Email in a row
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _phoneController,
                              decoration: _inputDecoration(
                                'Phone',
                                hintText: '+92 XXX XXXXXXX',
                                icon: Icons.phone,
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _emailController,
                              decoration: _inputDecoration(
                                'Email',
                                hintText: 'location@business.com',
                                icon: Icons.email,
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Address Section
                      _buildSectionHeader('Address'),
                      const SizedBox(height: 16),

                      // Address Line 1
                      TextFormField(
                        controller: _addressLine1Controller,
                        decoration: _inputDecoration(
                          'Address Line 1',
                          hintText: 'Street address',
                          icon: Icons.location_on,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Address Line 2
                      TextFormField(
                        controller: _addressLine2Controller,
                        decoration: _inputDecoration(
                          'Address Line 2',
                          hintText: 'Apartment, suite, unit, etc. (optional)',
                          icon: Icons.location_on_outlined,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // City and State in a row
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _cityController,
                              decoration: _inputDecoration(
                                'City',
                                hintText: 'Lahore',
                                icon: Icons.location_city,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _stateController,
                              decoration: _inputDecoration(
                                'State/Province',
                                hintText: 'Punjab',
                                icon: Icons.map,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Postal Code and Country in a row
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _postalCodeController,
                              decoration: _inputDecoration(
                                'Postal Code',
                                hintText: '54000',
                                icon: Icons.markunread_mailbox,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _countryController,
                              decoration: _inputDecoration(
                                'Country',
                                hintText: 'Pakistan',
                                icon: Icons.flag,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Additional Information Section
                      _buildSectionHeader('Additional Information'),
                      const SizedBox(height: 16),

                      // Operating Hours
                      TextFormField(
                        controller: _operatingHoursController,
                        decoration: _inputDecoration(
                          'Operating Hours',
                          hintText: 'Mon-Sat: 9 AM - 9 PM',
                          icon: Icons.access_time,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // License Number
                      TextFormField(
                        controller: _licenseNumberController,
                        decoration: _inputDecoration(
                          'License Number',
                          hintText: 'Pharmacy license (optional)',
                          icon: Icons.badge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Footer with actions
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: theme.colorScheme.outline.withOpacity(0.2),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: _isLoading
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  FilledButton.icon(
                    onPressed: _isLoading ? null : _saveLocation,
                    icon: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save),
                    label: Text(isEditing ? 'Save Changes' : 'Add Location'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  InputDecoration _inputDecoration(
    String label, {
    String? hintText,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hintText,
      prefixIcon: icon != null ? Icon(icon, size: 20) : null,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  Future<void> _saveLocation() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final locationService = ref.read(locationServiceProvider);

      if (isEditing) {
        await locationService.updateLocation(
          id: widget.existingLocation!.id,
          name: _nameController.text.trim(),
          type: LocationType.values.byName(_selectedType),
          phone: _phoneController.text.trim().isEmpty
              ? null
              : _phoneController.text.trim(),
          email: _emailController.text.trim().isEmpty
              ? null
              : _emailController.text.trim(),
          operatingHours: _operatingHoursController.text.trim().isEmpty
              ? null
              : _operatingHoursController.text.trim(),
          licenseNumber: _licenseNumberController.text.trim().isEmpty
              ? null
              : _licenseNumberController.text.trim(),
        );
      } else {
        await locationService.createLocation(
          businessId: widget.businessId,
          name: _nameController.text.trim(),
          type: LocationType.values.byName(_selectedType),
          phone: _phoneController.text.trim().isEmpty
              ? null
              : _phoneController.text.trim(),
          email: _emailController.text.trim().isEmpty
              ? null
              : _emailController.text.trim(),
          operatingHours: _operatingHoursController.text.trim().isEmpty
              ? null
              : _operatingHoursController.text.trim(),
          licenseNumber: _licenseNumberController.text.trim().isEmpty
              ? null
              : _licenseNumberController.text.trim(),
        );
      }

      if (mounted) {
        widget.onSaved();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEditing
                  ? 'Location updated successfully'
                  : 'Location added successfully',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
