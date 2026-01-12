import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/app/routes/routes.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/presentation/bindings/bindings.dart';
import 'package:news_app/presentation/viewmodels/viewmodels.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
    // Proceed with app launch even if Firebase fails,
    // Auth features will just return errors but app will work.
  }

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const BarcaNewsApp(),
    ),
  );
}

class BarcaNewsApp extends StatelessWidget {
  const BarcaNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,

      // Initial bindings for global dependencies
      initialBinding: InitialBinding(),

      // Routes
      initialRoute: AppRoutes.home,
      getPages: AppPages.pages,

      // Theme
      themeMode: ThemeMode.system,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),

      // Localization
      locale: const Locale('en'),
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      builder: (context, child) {
        return _AppThemeWrapper(child: child!);
      },
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.offWhite,

      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: Colors.white,
        onSurface: AppColors.black,
        error: AppColors.error,
      ),

      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),

      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.black,
        titleTextStyle: AppTextStyles.brandTitleSmall.copyWith(
          color: AppColors.black,
        ),
      ),

      useMaterial3: true,
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor:
          AppColors.primary, // Dark mode background same as primary

      colorScheme: const ColorScheme.dark(
        primary: AppColors.blue, // Brighter blue for dark mode
        secondary: AppColors.secondary,
        surface: AppColors.primaryLight, // Slightly lighter for cards
        onSurface: Colors.white,
        error: AppColors.error,
      ),

      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),

      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        titleTextStyle: AppTextStyles.brandTitleSmall.copyWith(
          color: Colors.white,
        ),
      ),

      useMaterial3: true,
    );
  }
}

class _AppThemeWrapper extends StatefulWidget {
  final Widget child;

  const _AppThemeWrapper({required this.child});

  @override
  State<_AppThemeWrapper> createState() => _AppThemeWrapperState();
}

class _AppThemeWrapperState extends State<_AppThemeWrapper> {
  late final ThemeViewModel _themeViewModel;
  late final LocaleViewModel _localeViewModel;

  @override
  void initState() {
    super.initState();
    _themeViewModel = Get.find<ThemeViewModel>();
    _localeViewModel = Get.find<LocaleViewModel>();

    // Listen to theme changes and update GetX theme mode
    ever(_themeViewModel.themeMode, (ThemeMode mode) {
      Get.changeThemeMode(mode);
    });

    // Listen to locale changes and update GetX locale
    ever(_localeViewModel.locale, (Locale locale) {
      Get.updateLocale(locale);
    });

    // Set initial values
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.changeThemeMode(_themeViewModel.themeMode.value);
      Get.updateLocale(_localeViewModel.locale.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Just observe the values to trigger rebuilds when they change
      _themeViewModel.themeMode.value;
      _localeViewModel.locale.value;
      return widget.child;
    });
  }
}
