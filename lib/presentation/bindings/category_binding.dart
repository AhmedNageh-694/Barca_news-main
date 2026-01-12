import 'package:get/get.dart';
import 'package:news_app/presentation/viewmodels/viewmodels.dart';

/// Category screen binding
class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewsViewModel());
  }
}
