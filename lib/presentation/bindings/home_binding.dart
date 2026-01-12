import 'package:get/get.dart';
import 'package:news_app/presentation/viewmodels/viewmodels.dart';

/// Home screen binding
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeViewModel());
  }
}
