import 'package:flutter/material.dart';
import 'package:news_app/models/categorymodel.dart';
import 'package:news_app/views/categoty_view.dart';
import 'package:news_app/widget/categorycard.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key});

  static const List<CategoryModel> _categories = [
    CategoryModel(
      image: "assets/images/player_news.jpg",
      categoryName: "player",
    ),
    CategoryModel(
      image: "assets/images/camp_no.jpeg",
      categoryName: "General",
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
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CategotyView(),
                ),
              );
            },
            child: Categorycard(categoryModel: _categories[index]),
          );
        },
      ),
    );
  }
}
