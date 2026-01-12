import 'package:get/get.dart';
import 'package:news_app/presentation/coordinators/coordinators.dart';
import 'package:news_app/presentation/viewmodels/viewmodels.dart';

/// Initial bindings - global dependencies
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Coordinators
    Get.put(AppCoordinator(), permanent: true);

    // Global ViewModels
    Get.put(ThemeViewModel(), permanent: true);
    Get.put(LocaleViewModel(), permanent: true);
    Get.put(AuthViewModel(), permanent: true);
  }
}
