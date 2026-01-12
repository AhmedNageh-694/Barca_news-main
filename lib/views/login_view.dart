import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/auth_controller.dart';
import 'package:news_app/views/sign_up_view.dart';
import 'package:news_app/widget/auth/auth_widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Future<void> _handleLogin(AuthController authController) async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      await authController.signIn(email, password);

      if (authController.user.value != null) {
        if (mounted) Navigator.of(context).pop();
      } else if (authController.errorMessage.isNotEmpty) {
        _showErrorSnackbar(authController.errorMessage.value);
      }
    }
  }

  Future<void> _handleGoogleSignIn(AuthController authController) async {
    await authController.signInWithGoogle();

    if (authController.user.value != null) {
      if (mounted) Navigator.of(context).pop();
    } else if (authController.errorMessage.isNotEmpty) {
      _showErrorSnackbar(authController.errorMessage.value);
    }
  }

  void _showErrorSnackbar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header Section
                    const AuthHeader(
                      icon: Icons.sports_soccer,
                      title: 'Barca News',
                      subtitle: 'Welcome back! Please login to continue.',
                    ),
                    const SizedBox(height: 48),

                    // Email Field
                    CustomTextField(
                      controller: _emailController,
                      labelText: 'Email Address',
                      hintText: 'hello@example.com',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );
                        if (!emailRegex.hasMatch(value.trim())) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Password Field
                    CustomTextField(
                      controller: _passwordController,
                      labelText: 'Password',
                      hintText: '••••••••',
                      prefixIcon: Icons.lock_outline,
                      obscureText: !_isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // Login Button
                    Obx(
                      () => PrimaryButton(
                        text: 'Login',
                        isLoading: authController.isLoading.value,
                        onPressed: () => _handleLogin(authController),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Or Divider
                    const OrDivider(),
                    const SizedBox(height: 24),

                    // Google Sign-In Button
                    Obx(
                      () => GoogleSignInButton(
                        text: 'Continue with Google',
                        isLoading: authController.isGoogleLoading.value,
                        onPressed: () => _handleGoogleSignIn(authController),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Sign Up Link
                    AuthLinkRow(
                      message: "Don't have an account?",
                      linkText: 'Register here',
                      onPressed: () => Get.to(() => const SignUpView()),
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
}
