import 'package:flutter/material.dart';
import 'package:news_app/core/constants/constants.dart';

/// Auth header with icon, title, and subtitle
class AuthHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Icon(icon, size: AppDimensions.iconXL, color: Colors.indigo),
        const SizedBox(height: AppDimensions.paddingM),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.brandTitle.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingS),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }
}
