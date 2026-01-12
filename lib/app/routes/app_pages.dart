import 'package:get/get.dart';
import 'package:news_app/app/routes/app_routes.dart';
import 'package:news_app/presentation/bindings/bindings.dart';
import 'package:news_app/presentation/views/views.dart';

/// App page configurations for GetX routing
abstract class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => const SignUpView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes.category,
      page: () => const CategoryView(category: ''),
      binding: CategoryBinding(),
    ),
  ];
}
