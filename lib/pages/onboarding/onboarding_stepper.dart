import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/auth_provider.dart';
import '../../services/api_client.dart';
import '../../app_home_page.dart';

class OnboardingStepper extends ConsumerStatefulWidget {
  const OnboardingStepper({super.key});

  @override
  ConsumerState<OnboardingStepper> createState() => _OnboardingStepperState();
}

class _OnboardingStepperState extends ConsumerState<OnboardingStepper> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Form Controllers
  final _businessNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    // Pre-fill email if available
    final user = ref.read(authServiceProvider).currentUser;
    if (user?.email != null) {
      _emailController.text = user!.email!;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _businessNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authService = ref.read(authServiceProvider);
      final user = authService.currentUser;

      if (user == null) throw Exception('No authenticated user found');

      // Call Backend API to initialize business
      // This sets custom claims (business_id) and creates records
      final apiClient = ApiClient();
      await apiClient.post(
        '/api/v1/setup/initialize',
        data: {
          'business_name': _businessNameController.text.trim(),
          'first_name': _firstNameController.text.trim(),
          'last_name': _lastNameController.text.trim(),
          'phone': _phoneController.text.trim().isEmpty
              ? ''
              : _phoneController.text.trim(),
          'email': _emailController.text.trim(),
          'profile_photo': user.photoURL,
        },
      );

      // Force token refresh to get new custom claims (business_id)
      await user.getIdToken(true);

      if (mounted) {
        // Navigate to Dashboard
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const AppHomePage()),
        );
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

  void _nextPage() {
    if (_currentStep == 0) {
      if (_businessNameController.text.isEmpty) return; // Basic validation
    } else if (_currentStep == 1) {
      if (_firstNameController.text.isEmpty ||
          _lastNameController.text.isEmpty) {
        return;
      }
      // Validate email
      final email = _emailController.text.trim();
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (email.isEmpty || !emailRegex.hasMatch(email)) {
        // Rely on form validation to show error
        // But we need to trigger it or check it here to prevent next page
        // Since we don't have a separate form key for this step, we can check manually
        if (email.isEmpty || !emailRegex.hasMatch(email)) return;
      }
    }

    if (_currentStep < 2) {
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _submit();
    }
  }

  void _previousPage() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  InputDecoration _buildInputDecoration(String label, {String? hint}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InputDecoration(
      labelText: label.isNotEmpty ? label : null,
      hintText: hint,
      hintStyle: GoogleFonts.outfit(
        fontSize: 16,
        color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
      ),
      labelStyle: GoogleFonts.outfit(
        fontSize: 16,
        color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
      ),
      filled: true,
      fillColor: isDark ? Colors.grey.shade800 : Colors.grey.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    );
  }

  TextStyle _getInputStyle() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.outfit(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: isDark ? Colors.white : Colors.black87,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? const Color(0xFF121212)
        : const Color(0xFFF0F2F5);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.blueGrey.shade900;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 8,
            shadowColor: Colors.black26,
            color: cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Header Animation for all steps
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TweenAnimationBuilder<double>(
                        key: ValueKey(
                          _currentStep,
                        ), // Rebuild animation on step change
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeOut,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 20 * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: Text(
                          _currentStep == 0
                              ? 'Tell us about your business name'
                              : _currentStep == 1
                              ? 'Tell us about yourself'
                              : 'Review your details',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // PageView for Steps
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          // Step 1: Business Name
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                key: const ValueKey('business_name_field'),
                                controller: _businessNameController,
                                style: _getInputStyle(),
                                decoration: _buildInputDecoration(
                                  '',
                                  hint: 'Enter your business name',
                                ),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                    ? 'Please enter business name'
                                    : null,
                              ),
                            ],
                          ),

                          // Step 2: Admin Details
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                key: const ValueKey('first_name_field'),
                                controller: _firstNameController,
                                style: _getInputStyle(),
                                decoration: _buildInputDecoration(
                                  'First Name',
                                  hint: 'Enter your first name',
                                ),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                    ? 'Required'
                                    : null,
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                key: const ValueKey('last_name_field'),
                                controller: _lastNameController,
                                style: _getInputStyle(),
                                decoration: _buildInputDecoration(
                                  'Last Name',
                                  hint: 'Enter your last name',
                                ),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                    ? 'Required'
                                    : null,
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                key: const ValueKey('phone_field'),
                                controller: _phoneController,
                                style: _getInputStyle(),
                                decoration: _buildInputDecoration(
                                  'Phone Number (Optional)',
                                  hint: 'Enter your phone number',
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                key: const ValueKey('email_field'),
                                controller: _emailController,
                                style: _getInputStyle(),
                                decoration: _buildInputDecoration(
                                  'Email Address',
                                  hint: 'Enter your email address',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required';
                                  }
                                  final emailRegex = RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                  );
                                  if (!emailRegex.hasMatch(value)) {
                                    return 'Invalid email address';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),

                          // Step 3: Review
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.grey.shade900
                                      : Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isDark
                                        ? Colors.grey.shade800
                                        : Colors.grey.shade200,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Review Details',
                                      style: GoogleFonts.outfit(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    _buildReviewRow(
                                      'Business',
                                      _businessNameController.text,
                                      textColor,
                                    ),
                                    const SizedBox(height: 16),
                                    _buildReviewRow(
                                      'Admin',
                                      '${_firstNameController.text} ${_lastNameController.text}',
                                      textColor,
                                    ),
                                    const SizedBox(height: 16),
                                    if (_phoneController.text.isNotEmpty)
                                      _buildReviewRow(
                                        'Phone',
                                        _phoneController.text,
                                        textColor,
                                      ),
                                    const SizedBox(height: 16),
                                    _buildReviewRow(
                                      'Email',
                                      _emailController.text,
                                      textColor,
                                    ),
                                    const SizedBox(height: 24),
                                    Text(
                                      'Click "Complete Setup" to create your organization.',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        color: isDark
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade600,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Navigation Buttons
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_currentStep > 0)
                            TextButton(
                              onPressed: _isLoading ? null : _previousPage,
                              style: TextButton.styleFrom(
                                textStyle: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                foregroundColor: isDark
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600,
                              ),
                              child: const Text('Back'),
                            )
                          else
                            const SizedBox.shrink(),

                          ElevatedButton(
                            onPressed: _isLoading ? null : _nextPage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              elevation: 4,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: _isLoading && _currentStep == 2
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    _currentStep == 2
                                        ? 'Complete Setup'
                                        : 'Continue',
                                    style: GoogleFonts.outfit(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReviewRow(String label, String value, Color valueColor) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 16,
              color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 16,
              color: valueColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
