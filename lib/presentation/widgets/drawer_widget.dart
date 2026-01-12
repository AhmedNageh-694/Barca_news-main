import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/app/routes/routes.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/presentation/viewmodels/viewmodels.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authViewModel = Get.find<AuthViewModel>();

    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          _DrawerHeader(theme: theme),
          _DrawerBody(authViewModel: authViewModel),
          const _DrawerFooter(),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  final ThemeData theme;

  const _DrawerHeader({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 64, 24, 24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColors.primaryGradient,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingXS),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white.withValues(alpha: 0.2),
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

class _DrawerBody extends StatelessWidget {
  final AuthViewModel authViewModel;

  const _DrawerBody({required this.authViewModel});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        final isLoggedIn = authViewModel.isAuthenticated;
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
                onTap: () {
                  Navigator.of(context).pop();
                  Get.toNamed(AppRoutes.login);
                },
              ),
              const SizedBox(height: AppDimensions.paddingS),
              _DrawerItem(
                title: AppStrings.joinUs,
                icon: Icons.person_add_alt_1_rounded,
                onTap: () {
                  Navigator.of(context).pop();
                  Get.toNamed(AppRoutes.signUp);
                },
              ),
            ] else
              _DrawerItem(
                title: AppStrings.logout,
                icon: Icons.logout_rounded,
                onTap: () {
                  Navigator.of(context).pop();
                  authViewModel.signOut();
                },
              ),
            const Divider(height: 32, indent: 16, endIndent: 16),
            _DrawerItem(
              title: AppStrings.settings,
              icon: Icons.settings_rounded,
              onTap: () {
                Navigator.of(context).pop();
                Get.toNamed(AppRoutes.settings);
              },
            ),
          ],
        );
      }),
    );
  }
}

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
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
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
      hoverColor: theme.colorScheme.primary.withValues(alpha: 0.05),
    );
  }
}
