import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/presentation/viewmodels/viewmodels.dart';
import 'package:news_app/presentation/widgets/widgets.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  AuthViewModel get _viewModel => Get.find<AuthViewModel>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() => _isPasswordVisible = !_isPasswordVisible);
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible);
  }

  Future<void> _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      await _viewModel.signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (_viewModel.errorMessage.isNotEmpty && mounted) {
        _showErrorSnackbar(_viewModel.errorMessage.value);
      }
    }
  }

  Future<void> _handleGoogleSignIn() async {
    await _viewModel.signInWithGoogle();

    if (_viewModel.errorMessage.isNotEmpty && mounted) {
      _showErrorSnackbar(_viewModel.errorMessage.value);
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: () => _viewModel.goBack(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppDimensions.maxCardWidth,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AuthHeader(
                      icon: Icons.person_add_outlined,
                      title: 'Join ${AppStrings.appName}',
                      subtitle: AppStrings.createAccountSubtitle,
                    ),
                    const SizedBox(height: AppDimensions.paddingXXL),
                    CustomTextField(
                      controller: _emailController,
                      labelText: AppStrings.emailAddress,
                      hintText: AppStrings.emailHint,
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.pleaseEnterEmail;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppDimensions.paddingL),
                    CustomTextField(
                      controller: _passwordController,
                      labelText: AppStrings.password,
                      hintText: AppStrings.passwordHint,
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
                          return AppStrings.pleaseEnterPassword;
                        }
                        if (value.length < 6) {
                          return AppStrings.passwordMinLength;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppDimensions.paddingL),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      labelText: AppStrings.confirmPassword,
                      hintText: AppStrings.passwordHint,
                      prefixIcon: Icons.lock_outline,
                      obscureText: !_isConfirmPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: _toggleConfirmPasswordVisibility,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.pleaseConfirmPassword;
                        }
                        if (value != _passwordController.text) {
                          return AppStrings.passwordsDoNotMatch;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppDimensions.paddingXL),
                    Obx(
                      () => PrimaryButton(
                        text: AppStrings.signUp,
                        isLoading: _viewModel.isLoading.value,
                        onPressed: _handleSignUp,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingL),
                    const OrDivider(),
                    const SizedBox(height: AppDimensions.paddingL),
                    Obx(
                      () => GoogleSignInButton(
                        text: AppStrings.signUpWithGoogle,
                        isLoading: _viewModel.isGoogleLoading.value,
                        onPressed: _handleGoogleSignIn,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingL),
                    AuthLinkRow(
                      message: AppStrings.alreadyHaveAccount,
                      linkText: AppStrings.loginHere,
                      onPressed: () => _viewModel.navigateToLogin(),
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
