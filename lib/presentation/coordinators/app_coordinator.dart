import 'package:get/get.dart';
import 'package:news_app/app/routes/app_routes.dart';

/// Base Coordinator class for navigation
abstract class BaseCoordinator {
  void start();
}

/// Main App Coordinator - handles top-level navigation
class AppCoordinator extends BaseCoordinator {
  @override
  void start() {
    Get.offAllNamed(AppRoutes.home);
  }

  void navigateToHome() {
    Get.offAllNamed(AppRoutes.home);
  }

  void navigateToLogin() {
    Get.toNamed(AppRoutes.login);
  }

  void navigateToSignUp() {
    Get.toNamed(AppRoutes.signUp);
  }

  void navigateToSettings() {
    Get.toNamed(AppRoutes.settings);
  }

  void navigateToCategory(String category) {
    Get.toNamed(AppRoutes.category, arguments: {'category': category});
  }

  void goBack() {
    Get.back();
  }

  void popToRoot() {
    Get.offAllNamed(AppRoutes.home);
  }
}
