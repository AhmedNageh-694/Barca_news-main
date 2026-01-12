import 'package:get/get.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/presentation/coordinators/coordinators.dart';

/// HomeViewModel - handles home screen state and navigation
class HomeViewModel extends GetxController {
  AppCoordinator get _coordinator => Get.find<AppCoordinator>();

  static const String defaultCategory = AppCategories.defaultCategory;

  // Navigation methods
  void navigateToLogin() => _coordinator.navigateToLogin();
  void navigateToSignUp() => _coordinator.navigateToSignUp();
  void navigateToSettings() => _coordinator.navigateToSettings();
  void navigateToCategory(String category) =>
      _coordinator.navigateToCategory(category);

  void openDrawer() {
    // Drawer is handled by Scaffold
  }
}
