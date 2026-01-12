import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/presentation/viewmodels/viewmodels.dart';
import 'package:news_app/presentation/widgets/widgets.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Get.find<AuthViewModel>();
    final themeViewModel = Get.find<ThemeViewModel>();
    final localeViewModel = Get.find<LocaleViewModel>();
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, isRtl),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(
                    title: isRtl ? AppStrings.accountAr : AppStrings.account,
                  ),
                  const SizedBox(height: AppDimensions.paddingS),
                  Obx(
                    () => _UserTile(
                      user: authViewModel.user.value,
                      isRtl: isRtl,
                      onLogout:
                          () => _handleLogout(context, isRtl, authViewModel),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingL),
                  _SectionTitle(
                    title:
                        isRtl
                            ? AppStrings.preferencesAr
                            : AppStrings.preferences,
                  ),
                  const SizedBox(height: AppDimensions.paddingS),
                  _PreferencesCard(
                    isRtl: isRtl,
                    themeViewModel: themeViewModel,
                    localeViewModel: localeViewModel,
                  ),
                  const SizedBox(height: AppDimensions.paddingXL),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isRtl) {
    return SliverAppBar(
      expandedHeight: 180,
      pinned: true,
      backgroundColor: AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          isRtl ? AppStrings.settingsAr : AppStrings.settings,
          style: AppTextStyles.brandTitleSmall.copyWith(color: AppColors.white),
        ),
        centerTitle: true,
        background: const GradientBackground(
          child: Center(
            child: Opacity(
              opacity: 0.1,
              child: Icon(
                Icons.settings_outlined,
                size: AppDimensions.iconXXL,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogout(
    BuildContext context,
    bool isRtl,
    AuthViewModel authViewModel,
  ) {
    authViewModel.signOut();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isRtl ? AppStrings.loggedOutAr : AppStrings.loggedOut),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingS),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _UserTile extends StatelessWidget {
  final dynamic user;
  final bool isRtl;
  final VoidCallback onLogout;

  const _UserTile({
    required this.user,
    required this.isRtl,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final email =
        user?.email ?? (isRtl ? AppStrings.guestUserAr : AppStrings.guestUser);
    final uid =
        user?.uid ??
        (isRtl ? AppStrings.noIdAvailableAr : AppStrings.noIdAvailable);

    return AppCard(
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppDimensions.paddingM),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(
            context,
          ).colorScheme.primary.withValues(alpha: 0.1),
          child: Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.primary,
            size: AppDimensions.iconL,
          ),
        ),
        title: Text(
          email,
          style: const TextStyle(fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppDimensions.paddingXS),
            Text(
              'UID: $uid',
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing:
            user != null
                ? IconButton(
                  icon: const Icon(Icons.logout_rounded),
                  onPressed: onLogout,
                  tooltip: isRtl ? AppStrings.logoutAr : AppStrings.logout,
                )
                : null,
      ),
    );
  }
}

class _PreferencesCard extends StatelessWidget {
  final bool isRtl;
  final ThemeViewModel themeViewModel;
  final LocaleViewModel localeViewModel;

  const _PreferencesCard({
    required this.isRtl,
    required this.themeViewModel,
    required this.localeViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          _ThemeSwitchTile(isRtl: isRtl, themeViewModel: themeViewModel),
          Divider(
            height: 1,
            indent: AppDimensions.paddingM,
            endIndent: AppDimensions.paddingM,
            color: Colors.grey.withValues(alpha: 0.2),
          ),
          _LanguageTile(isRtl: isRtl, localeViewModel: localeViewModel),
        ],
      ),
    );
  }
}

class _ThemeSwitchTile extends StatelessWidget {
  final bool isRtl;
  final ThemeViewModel themeViewModel;

  const _ThemeSwitchTile({required this.isRtl, required this.themeViewModel});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = themeViewModel.isDarkMode;
      return SwitchListTile(
        value: isDark,
        onChanged: (_) => themeViewModel.toggleTheme(),
        secondary: Icon(
          isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(isRtl ? AppStrings.appearanceAr : AppStrings.appearance),
        subtitle: Text(
          isDark
              ? (isRtl ? AppStrings.darkThemeAr : AppStrings.darkTheme)
              : (isRtl ? AppStrings.lightThemeAr : AppStrings.lightTheme),
        ),
      );
    });
  }
}

class _LanguageTile extends StatelessWidget {
  final bool isRtl;
  final LocaleViewModel localeViewModel;

  const _LanguageTile({required this.isRtl, required this.localeViewModel});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final locale = localeViewModel.locale.value;
      return ListTile(
        leading: Icon(
          Icons.language,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(isRtl ? AppStrings.languageAr : AppStrings.language),
        subtitle: Text(locale.languageCode == 'en' ? 'English' : 'العربية'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SelectableChip(
              label: 'En',
              isSelected: localeViewModel.isEnglish,
              onTap: () => localeViewModel.setLocale(const Locale('en')),
            ),
            const SizedBox(width: AppDimensions.paddingS),
            SelectableChip(
              label: 'ع',
              isSelected: localeViewModel.isArabic,
              onTap: () => localeViewModel.setLocale(const Locale('ar')),
            ),
          ],
        ),
      );
    });
  }
}
