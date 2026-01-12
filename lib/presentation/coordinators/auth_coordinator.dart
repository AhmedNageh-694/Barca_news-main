import 'package:get/get.dart';
import 'package:news_app/app/routes/app_routes.dart';
import 'package:news_app/presentation/coordinators/app_coordinator.dart';

/// Auth Coordinator - handles authentication flow navigation
class AuthCoordinator extends BaseCoordinator {
  @override
  void start() {
    Get.toNamed(AppRoutes.login);
  }

  void navigateToLogin() {
    Get.offAllNamed(AppRoutes.login);
  }

  void navigateToSignUp() {
    Get.toNamed(AppRoutes.signUp);
  }

  void onLoginSuccess() {
    Get.offAllNamed(AppRoutes.home);
  }

  void onSignUpSuccess() {
    Get.offAllNamed(AppRoutes.home);
  }

  void onLogout() {
    Get.back();
  }

  void goBack() {
    Get.back();
  }
}
