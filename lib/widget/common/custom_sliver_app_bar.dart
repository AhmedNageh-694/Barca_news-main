import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/core/constants/app_constants.dart';
import 'package:news_app/widget/common/gradient_background.dart';

/// Custom sliver app bar used across the app
class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final String? secondaryTitle;
  final Color? secondaryTitleColor;
  final double expandedHeight;
  final IconData? backgroundIcon;
  final Widget? leading;
  final List<Widget>? actions;

  const CustomSliverAppBar({
    super.key,
    required this.title,
    this.secondaryTitle,
    this.secondaryTitleColor,
    this.expandedHeight = 120.0,
    this.backgroundIcon,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: expandedHeight,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 0,
      leading: leading,
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.only(bottom: AppDimensions.paddingM),
        title:
            secondaryTitle != null
                ? Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.brandTitleSmall.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      secondaryTitle!,
                      style: AppTextStyles.brandTitleSmall.copyWith(
                        color: secondaryTitleColor ?? AppColors.accent,
                      ),
                    ),
                  ],
                )
                : Text(
                  title,
                  style: AppTextStyles.brandTitleSmall.copyWith(
                    color: AppColors.white,
                  ),
                ),
        background: GradientBackground(
          child: Center(
            child: Opacity(
              opacity: 0.1,
              child: FaIcon(
                backgroundIcon ?? FontAwesomeIcons.futbol,
                size: AppDimensions.iconXXL,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
