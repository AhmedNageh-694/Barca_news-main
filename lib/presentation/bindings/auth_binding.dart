import 'package:get/get.dart';
import 'package:news_app/presentation/coordinators/coordinators.dart';

/// Auth screens binding
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthCoordinator());
  }
}
