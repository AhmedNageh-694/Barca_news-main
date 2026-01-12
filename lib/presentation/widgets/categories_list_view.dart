import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/app/routes/routes.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/data/models/models.dart';
import 'package:news_app/presentation/widgets/category_card.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key});

  static const List<CategoryModel> _categories = [
    CategoryModel(
      image: "assets/images/player_news.jpg",
      categoryName: "player",
    ),
    CategoryModel(image: "assets/images/camp_no.jpeg", categoryName: "General"),
    CategoryModel(
      image: "assets/images/health_barca.jpg",
      categoryName: "Health",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return GestureDetector(
            onTap:
                () => Get.toNamed(
                  AppRoutes.category,
                  arguments: {'category': category.categoryName},
                ),
            child: CategoryCard(categoryModel: category),
          );
        },
      ),
    );
  }
}
