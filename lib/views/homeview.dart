import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/widget/category_list_view.dart';
import 'package:news_app/widget/common/common_widgets.dart';
import 'package:news_app/widget/drawer_widget.dart';
import 'package:news_app/widget/news_list_view_builder.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  static const String _defaultCategory = AppCategories.defaultCategory;

  Future<void> _handleRefresh() async {
    final controller = Get.find<NewsController>(tag: _defaultCategory);
    await controller.getNews(category: _defaultCategory);
  }

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
            _buildCategoriesSection(),
            _buildLatestNewsHeader(),
            const Newslistviewbuilder(category: _defaultCategory),
            const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: 120.0,
      backgroundColor: Theme.of(context).colorScheme.primary,
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
            // Search functionality to be implemented
          },
        ),
        const SizedBox(width: AppDimensions.paddingS),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.only(bottom: AppDimensions.paddingM),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Barca',
              style: AppTextStyles.brandTitleSmall.copyWith(
                color: AppColors.white,
              ),
            ),
            const SizedBox(width: AppDimensions.paddingXS),
            Text(
              'News',
              style: AppTextStyles.brandTitleSmall.copyWith(
                color: AppColors.accent,
              ),
            ),
          ],
        ),
        background: const GradientBackground(
          child: Center(
            child: Opacity(
              opacity: 0.1,
              child: FaIcon(
                FontAwesomeIcons.futbol,
                size: AppDimensions.iconXXL,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: AppStrings.categories,
              actionText: AppStrings.viewAll,
              onActionTap: () {
                // View all categories
              },
            ),
            const SizedBox(height: AppDimensions.paddingM),
            const CategoriesListView(),
          ],
        ),
      ),
    );
  }

  Widget _buildLatestNewsHeader() {
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
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
