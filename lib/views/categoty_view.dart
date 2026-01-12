import 'package:flutter/material.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/widget/news_list_view_builder.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category,
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
          Newslistviewbuilder(category: category),
          const SliverPadding(
            padding: EdgeInsets.only(bottom: AppDimensions.paddingL),
          ),
        ],
      ),
    );
  }
}
