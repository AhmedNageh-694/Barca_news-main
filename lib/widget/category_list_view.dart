import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/models/models.dart';
import 'package:news_app/views/categoty_view.dart';
import 'package:news_app/widget/categorycard.dart';

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
                () =>
                    Get.to(() => CategoryView(category: category.categoryName)),
            child: CategoryCard(categoryModel: category),
          );
        },
      ),
    );
  }
}
