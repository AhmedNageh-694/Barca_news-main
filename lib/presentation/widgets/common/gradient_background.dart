import 'package:flutter/material.dart';
import 'package:news_app/core/constants/constants.dart';

/// Gradient background container used across the app
class GradientBackground extends StatelessWidget {
  final Widget? child;
  final List<Color>? colors;

  const GradientBackground({super.key, this.child, this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors ?? AppColors.primaryGradient,
        ),
      ),
      child: child,
    );
  }
}
