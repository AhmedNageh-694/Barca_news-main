import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/presentation/widgets/widgets.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    // Get category from arguments if passed through navigation
    final String displayCategory =
        category.isNotEmpty
            ? category
            : (Get.arguments?['category'] ?? AppCategories.defaultCategory);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          displayCategory,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.only(top: AppDimensions.paddingM),
          ),
          NewsListBuilder(category: displayCategory),
          const SliverPadding(
            padding: EdgeInsets.only(bottom: AppDimensions.paddingL),
          ),
        ],
      ),
    );
  }
}
