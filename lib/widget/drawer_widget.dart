import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/auth_controller.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/views/login_view.dart';
import 'package:news_app/views/setting_view.dart';
import 'package:news_app/views/sign_up_view.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authController = Get.find<AuthController>();

    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          _DrawerHeader(theme: theme),
          _DrawerBody(authController: authController),
          const _DrawerFooter(),
        ],
      ),
    );
  }
}

/// Drawer header with gradient and app branding
class _DrawerHeader extends StatelessWidget {
  final ThemeData theme;

  const _DrawerHeader({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 64, 24, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryDark, theme.colorScheme.primary],
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingXS),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white.withOpacity(0.2),
              border: Border.all(color: AppColors.white, width: 2),
            ),
            child: Image.asset(
              'assets/icon/barcelona.png',
              width: 56,
              height: 56,
            ),
          ),
          const SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.appName,
                  style: AppTextStyles.brandTitleMedium.copyWith(
                    color: AppColors.white,
                    height: 1,
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingXS),
                Text(
                  AppStrings.appSlogan,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Drawer body with navigation items
class _DrawerBody extends StatelessWidget {
  final AuthController authController;

  const _DrawerBody({required this.authController});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        final isLoggedIn = authController.user.value != null;
        return ListView(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.paddingM,
            horizontal: AppDimensions.radiusM,
          ),
          children: [
            if (!isLoggedIn) ...[
              _DrawerItem(
                title: AppStrings.login,
                icon: Icons.login_rounded,
                onTap: () => _navigateTo(context, const LoginView()),
              ),
              const SizedBox(height: AppDimensions.paddingS),
              _DrawerItem(
                title: AppStrings.joinUs,
                icon: Icons.person_add_alt_1_rounded,
                onTap: () => _navigateTo(context, const SignUpView()),
              ),
            ] else
              _DrawerItem(
                title: AppStrings.logout,
                icon: Icons.logout_rounded,
                onTap: () {
                  Navigator.of(context).pop();
                  authController.signOut();
                },
              ),
            const Divider(height: 32, indent: 16, endIndent: 16),
            _DrawerItem(
              title: AppStrings.settings,
              icon: Icons.settings_rounded,
              onTap: () => _navigateTo(context, const SettingView()),
            ),
          ],
        );
      }),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }
}

/// Drawer footer with version info
class _DrawerFooter extends StatelessWidget {
  const _DrawerFooter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Text(
        AppStrings.version,
        style: TextStyle(color: Colors.grey[500], fontSize: 12),
      ),
    );
  }
}

/// Individual drawer item
class _DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      leading: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingS),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        ),
        child: Icon(icon, color: theme.colorScheme.primary, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        size: 20,
        color: Colors.grey[400],
      ),
      hoverColor: theme.colorScheme.primary.withOpacity(0.05),
    );
  }
}
