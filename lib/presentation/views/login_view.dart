import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/presentation/viewmodels/viewmodels.dart';
import 'package:news_app/presentation/widgets/widgets.dart';

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

  AuthViewModel get _viewModel => Get.find<AuthViewModel>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() => _isPasswordVisible = !_isPasswordVisible);
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      await _viewModel.signIn(
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
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.white),
          onPressed: () => _viewModel.goBack(),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          const GradientBackground(),
          // Pattern overlay
          Image.asset(
            'assets/icon/barcelona.png',
            repeat: ImageRepeat.repeat,
            scale: 4.0,
            opacity: const AlwaysStoppedAnimation(0.05),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimensions.paddingL),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppDimensions.maxCardWidth,
                  ),
                  child: AppCard(
                    backgroundColor: Colors.white.withValues(alpha: 0.9),
                    padding: const EdgeInsets.all(AppDimensions.paddingL),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const AuthHeader(
                            icon: Icons.sports_soccer,
                            title: AppStrings.appName,
                            subtitle: AppStrings.welcomeBack,
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
                          ).animate().fadeIn(delay: 200.ms).slideX(),
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
                              return null;
                            },
                          ).animate().fadeIn(delay: 300.ms).slideX(),
                          const SizedBox(height: AppDimensions.paddingXL),
                          Obx(
                            () => PrimaryButton(
                              text: AppStrings.login,
                              isLoading: _viewModel.isLoading.value,
                              onPressed: _handleLogin,
                            ),
                          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
                          const SizedBox(height: AppDimensions.paddingL),
                          const OrDivider(),
                          const SizedBox(height: AppDimensions.paddingL),
                          Obx(
                            () => GoogleSignInButton(
                              text: AppStrings.continueWithGoogle,
                              isLoading: _viewModel.isGoogleLoading.value,
                              onPressed: _handleGoogleSignIn,
                            ),
                          ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),
                          const SizedBox(height: AppDimensions.paddingL),
                          AuthLinkRow(
                            message: AppStrings.dontHaveAccount,
                            linkText: AppStrings.registerHere,
                            onPressed: () => _viewModel.navigateToSignUp(),
                          ),
                        ],
                      ),
                    ),
                  ).animate().scale(
                    duration: 500.ms,
                    curve: Curves.easeOutBack,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
