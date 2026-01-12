import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_constants.dart';

/// Gradient background container used across the app
class GradientBackground extends StatelessWidget {
  final Widget? child;
  final double? opacity;

  const GradientBackground({super.key, this.child, this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryDark,
            Theme.of(context).colorScheme.primary,
          ],
        ),
      ),
      child: child,
    );
  }
}
