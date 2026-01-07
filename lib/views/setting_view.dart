import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/auth/auth_bloc.dart';
import 'package:news_app/bloc/locale_cubit.dart';
import 'package:news_app/bloc/theme_cubit.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      appBar: AppBar(
        title: Text(isRtl ? 'الإعدادات' : 'Settings'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.08),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildUserCard(context, user, isRtl),
            const SizedBox(height: 16),
            _buildThemeCard(context, isRtl),
            const SizedBox(height: 16),
            _buildLanguageCard(context, isRtl),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(
    BuildContext context,
    User? user,
    bool isRtl,
  ) {
    final email = user?.email ?? (isRtl ? 'غير مسجل الدخول' : 'Guest user');
    final uid = user?.uid ?? (isRtl ? 'لا يوجد معرف' : 'No ID available');

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.primary,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    email,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'UID: $uid',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (user != null)
              TextButton.icon(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthLogoutRequested());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isRtl ? 'تم تسجيل الخروج' : 'Logged out',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.logout, size: 18),
                label: Text(isRtl ? 'خروج' : 'Logout'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeCard(BuildContext context, bool isRtl) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, mode) {
            final isDark = mode == ThemeMode.dark;
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                isRtl ? 'المظهر' : 'Appearance',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                isDark
                    ? (isRtl ? 'الوضع الداكن' : 'Dark theme')
                    : (isRtl ? 'الوضع الفاتح' : 'Light theme'),
              ),
              trailing: Switch.adaptive(
                value: isDark,
                onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLanguageCard(BuildContext context, bool isRtl) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isRtl ? 'اللغة' : 'Language',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            BlocBuilder<LocaleCubit, Locale>(
              builder: (context, locale) {
                final isEnglish = locale.languageCode == 'en';
                return Row(
                  children: [
                    _LanguageChip(
                      label: 'English',
                      selected: isEnglish,
                      onTap: () =>
                          context.read<LocaleCubit>().setLocale(
                                const Locale('en'),
                              ),
                    ),
                    const SizedBox(width: 12),
                    _LanguageChip(
                      label: 'العربية',
                      selected: !isEnglish,
                      onTap: () =>
                          context.read<LocaleCubit>().setLocale(
                                const Locale('ar'),
                              ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : null,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}