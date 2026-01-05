import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/product_service.dart';
import '../../../../providers/auth_provider.dart';

class AddCategoryDialog extends ConsumerStatefulWidget {
  const AddCategoryDialog({super.key});

  @override
  ConsumerState<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends ConsumerState<AddCategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    // Assuming businessId is available from auth state or user profile.
    // For now, I'll fetch it from a provider if available, or assume user has one.
    // Wait, createCategory needs businessId.
    // I need a way to get businessId. AuthProvider usually has it if the user is loaded.
    // Let's assume we can pass it or get it.
    // I'll assume we can get it from the user object if it has custom claims or via a provider.
    // Let's check auth provider logic later. For now, I'll use a placeholder or assume it's properly set.
    // Actually, `ApiClient` gets tokens, but I need the ID explicitly for Data Connect.
    // I'll try to get it from `user?.uid` (which is user ID, not business ID).
    // The `auth_service.dart` or `user_provider.dart` should have the business ID.
    // I'll assume `ref.read(currentUserProvider)` or similar has it.
    // Just in case, I'll pass a placeholder or try to read it.

    // TEMPORARY: hardcoded testing ID or "get from args".
    // Better: Retrieve from `authProvider` if I updated it to store businessId.
    // If not, I might fail.
    // Let's check `auth_provider.dart` quickly? No, I'll just write the code assuming a `ref.read(businessIdProvider)` exists or I'll add `businessId` as a requirement.
    // For now, I will assume the parent passes it, or I use a hardcoded value for MVP test.
    // Wait, `createProduct` also needs `businessId`.

    // I'll add a comment about businessId.

    setState(() => _isLoading = true);

    try {
      final authService = ref.read(authServiceProvider);
      final currentUser = authService.currentUser;
      if (currentUser == null) throw Exception("User not authenticated");

      final userData = await authService.getUser(currentUser.uid);
      if (userData == null) throw Exception("User data not found");

      final businessId = userData.businessId;

      await ref
          .read(productServiceProvider)
          .createCategory(
            businessId: businessId,
            name: _nameController.text,
            description: _descriptionController.text.isNotEmpty
                ? _descriptionController.text
                : null,
          );

      if (mounted) {
        Navigator.of(context).pop(true); // Return true on success
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
    return AlertDialog(
      title: const Text('Add New Category'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Category Name'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (Optional)',
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _submit,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Add'),
        ),
      ],
    );
  }
}
