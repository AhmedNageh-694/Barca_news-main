import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/presentation/viewmodels/viewmodels.dart';
import 'package:news_app/presentation/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const String _defaultCategory = AppCategories.defaultCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: Theme.of(context).colorScheme.primary,
        edgeOffset: 120,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            _buildAppBar(context),
            _buildCategoriesSection(context),
            _buildLatestNewsHeader(context),
            const NewsListBuilder(category: _defaultCategory),
            const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    final viewModel = Get.find<NewsViewModel>(tag: _defaultCategory);
    await viewModel.refreshNews(category: _defaultCategory);
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: 140.0,
      backgroundColor: AppColors.primary,
      elevation: 0,
      leading: Builder(
        builder:
            (context) => IconButton(
              icon: const Icon(Icons.menu_rounded, color: AppColors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
      ),
      actions: [
        IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.magnifyingGlass,
            size: AppDimensions.iconS,
            color: AppColors.white,
          ),
          onPressed: () {
            // Search functionality
          },
        ),
        const SizedBox(width: AppDimensions.paddingS),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.only(bottom: AppDimensions.paddingM),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Barca',
              style: AppTextStyles.brandTitleSmall.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w900,
              ),
            ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2, end: 0),
            const SizedBox(width: 4),
            Text(
                  'News',
                  style: AppTextStyles.brandTitleSmall.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w900,
                  ),
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 200.ms)
                .slideX(begin: 0.2, end: 0),
          ],
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            const GradientBackground(),
            Center(
              child: const FaIcon(
                    FontAwesomeIcons.futbol,
                    size: 100,
                    color: Color(
                      0x1AFFFFFF,
                    ), // White with 0.1 opacity. Corrected from 0x1AGGD9E6 to ensure valid hex color.
                  )
                  .animate(onPlay: (controller) => controller.repeat())
                  .rotate(duration: const Duration(seconds: 10)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: AppStrings.categories,
              actionText: AppStrings.viewAll,
              onActionTap: () {},
            ).animate().fadeIn().slideX(),
            const SizedBox(height: AppDimensions.paddingM),
            const CategoriesListView().animate().fadeIn(delay: 200.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildLatestNewsHeader(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.paddingM,
        0,
        AppDimensions.paddingM,
        AppDimensions.paddingM,
      ),
      sliver: SliverToBoxAdapter(
        child: Text(
          AppStrings.latestNews,
          style: AppTextStyles.headlineLarge.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),
      ),
    );
  }
}
