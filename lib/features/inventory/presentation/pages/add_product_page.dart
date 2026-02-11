import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:biz_pharma/dataconnect_generated/biz_pharma.dart';
import '../../data/product_service.dart';
import '../widgets/add_category_dialog.dart';
import '../../../../providers/auth_provider.dart';

class AddProductPage extends ConsumerStatefulWidget {
  const AddProductPage({super.key});

  @override
  ConsumerState<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends ConsumerState<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Controllers
  final _nameController = TextEditingController(); // Generic Name
  final _brandNameController = TextEditingController();
  final _skuController = TextEditingController();
  final _barcodeController = TextEditingController();
  // final _priceController = TextEditingController(); // Not used in createProduct directly
  // Wait, price is usually in `createProductPricing` or separate.
  // `createProduct` has basic attributes.
  // The mutation `createProduct` DOES NOT take price?
  // Let's check `ProductService.createProduct`.
  // It takes keys like `reorderPoint`, `packageSize`. No price.
  // Pricing is a separate table `ProductPricing` linked to `Product`.
  // Phase 2 Plan says "Add Product (Manual Entry)".
  // Users expect to set price.
  // I should probably execute `createProduct` AND THEN `createProductPricing` if needed?
  // Or just create product for now.
  // I'll add "Base Price" field visually but might not save it yet if the service doesn't support it, or I'll add a `createProductPricing` call in the service later.
  // For now, let's focus on the fields `createProduct` supports.

  // Fields supported by createProduct:
  // genericName, internalSKU, brandName, manufacturerId (dropdown/text), nationalDrugCode, barcode
  // dosageForm (Enum), strength, unit
  // packageSize, packageUnit (Enum)
  // reorderPoint, etc.

  // Enums selections
  DosageForm _dosageForm = DosageForm.TABLET;
  PackageUnit _packageUnit = PackageUnit.BOX;

  String? _selectedCategoryId;
  List<ListCategoriesByBusinessCategories> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final authService = ref.read(authServiceProvider);
      final currentUser = authService.currentUser;
      if (currentUser == null) return;

      final userData = await authService.getUser(currentUser.uid);
      if (userData == null) return;

      final businessId = userData.businessId;

      final cats = await ref
          .read(productServiceProvider)
          .listCategories(businessId);
      if (mounted) {
        setState(() {
          _categories = cats;
        });
      }
    } catch (e) {
      print("Error loading categories: $e");
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authService = ref.read(authServiceProvider);
      final currentUser = authService.currentUser;
      if (currentUser == null) throw Exception("User not authenticated");

      final userData = await authService.getUser(currentUser.uid);
      if (userData == null) throw Exception("User data not found");

      final createById = currentUser.uid;
      final businessId = userData.businessId;

      await ref
          .read(productServiceProvider)
          .createProduct(
            businessId: businessId,
            genericName: _nameController.text,
            internalSKU: _skuController.text,
            createdById: createById,
            brandName: _brandNameController.text.isNotEmpty
                ? _brandNameController.text
                : null,
            barcode: _barcodeController.text.isNotEmpty
                ? _barcodeController.text
                : null,
            categoryId: _selectedCategoryId,
            dosageForm: _dosageForm,
            packageUnit: _packageUnit,
            unit: "mg",
            strength: "500",
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added successfully')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Basic Info
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Generic Name *'),
              validator: (v) => v?.isEmpty == true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _brandNameController,
              decoration: const InputDecoration(labelText: 'Brand Name'),
            ),
            const SizedBox(height: 16),

            // Category
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedCategoryId,
                    decoration: const InputDecoration(labelText: 'Category'),
                    items: _categories
                        .map(
                          (c) => DropdownMenuItem(
                            value: c.id,
                            child: Text(c.name),
                          ),
                        )
                        .toList(),
                    onChanged: (val) =>
                        setState(() => _selectedCategoryId = val),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () async {
                    final result = await showDialog<bool>(
                      context: context,
                      builder: (_) => const AddCategoryDialog(),
                    );
                    if (result == true) {
                      _loadCategories();
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Identification
            TextFormField(
              controller: _skuController,
              decoration: const InputDecoration(labelText: 'SKU *'),
              validator: (v) => v?.isEmpty == true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _barcodeController,
              decoration: const InputDecoration(
                labelText: 'Barcode',
                suffixIcon: Icon(Icons.qr_code_scanner),
              ),
            ),
            const SizedBox(height: 16),

            // Enums
            DropdownButtonFormField<DosageForm>(
              value: _dosageForm,
              decoration: const InputDecoration(labelText: 'Dosage Form'),
              items: DosageForm.values
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _dosageForm = v);
              },
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<PackageUnit>(
              value: _packageUnit,
              decoration: const InputDecoration(labelText: 'Package Unit'),
              items: PackageUnit.values
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _packageUnit = v);
              },
            ),

            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _submit,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Save Product'),
            ),
          ],
        ),
      ),
    );
  }
}
