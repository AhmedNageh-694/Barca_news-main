import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/auth_controller.dart';
import 'package:news_app/controllers/locale_controller.dart';
import 'package:news_app/controllers/theme_controller.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final theme = Theme.of(context);

    // Using Obx to reactively update the user details if they change
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: theme.colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                isRtl ? 'الإعدادات' : 'Settings',
                style: const TextStyle(
                  fontFamily: 'CaveatBrush',
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF1A237E),
                      theme.colorScheme.primary,
                    ],
                  ),
                ),
                child: Center(
                  child: Opacity(
                    opacity: 0.1,
                    child: const Icon(
                      Icons.settings_outlined,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(
                    context,
                    isRtl ? 'الحساب' : 'Account',
                    isRtl,
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => _buildUserTile(
                      context,
                      authController.user.value,
                      isRtl,
                      authController,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionHeader(
                    context,
                    isRtl ? 'التفضيلات' : 'Preferences',
                    isRtl,
                  ),
                  const SizedBox(height: 8),
                  _buildPreferencesList(context, isRtl),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, bool isRtl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildUserTile(
    BuildContext context,
    User? user,
    bool isRtl,
    AuthController authController,
  ) {
    final email = user?.email ?? (isRtl ? 'غير مسجل الدخول' : 'Guest user');
    final uid = user?.uid ?? (isRtl ? 'لا يوجد معرف' : 'No ID available');

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(
            context,
          ).colorScheme.primary.withOpacity(0.1),
          child: Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.primary,
            size: 32,
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
            const SizedBox(height: 4),
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
                  onPressed: () {
                    authController.signOut();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isRtl ? 'تم تسجيل الخروج' : 'Logged out'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  tooltip: isRtl ? 'خروج' : 'Logout',
                )
                : null,
      ),
    );
  }

  Widget _buildPreferencesList(BuildContext context, bool isRtl) {
    final themeController = Get.find<ThemeController>();
    final localeController = Get.find<LocaleController>();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Obx(() {
            final isDark = themeController.themeMode.value == ThemeMode.dark;
            return SwitchListTile(
              value: isDark,
              onChanged: (_) => themeController.toggleTheme(),
              secondary: Icon(
                isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(isRtl ? 'المظهر' : 'Appearance'),
              subtitle: Text(
                isDark
                    ? (isRtl ? 'الوضع الداكن' : 'Dark theme')
                    : (isRtl ? 'الوضع الفاتح' : 'Light theme'),
              ),
            );
          }),
          Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
            color: Colors.grey.withOpacity(0.2),
          ),
          Obx(() {
            final locale = localeController.locale.value;
            return ListTile(
              leading: Icon(
                Icons.language,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(isRtl ? 'اللغة' : 'Language'),
              subtitle: Text(
                locale.languageCode == 'en' ? 'English' : 'العربية',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _LanguageButton(
                    label: 'En',
                    isSelected: locale.languageCode == 'en',
                    onTap: () => localeController.setLocale(const Locale('en')),
                  ),
                  const SizedBox(width: 8),
                  _LanguageButton(
                    label: 'ع',
                    isSelected: locale.languageCode == 'ar',
                    onTap: () => localeController.setLocale(const Locale('ar')),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey.shade400,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade600,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
