import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/widget/newslistview.dart';

class Newslistviewbuilder extends StatefulWidget {
  const Newslistviewbuilder({super.key, required this.category});
  final String category;

  @override
  State<Newslistviewbuilder> createState() => _NewslistviewbuilderState();
}

class _NewslistviewbuilderState extends State<Newslistviewbuilder> {
  late NewsController controller;
  late String tag;

  @override
  void initState() {
    super.initState();
    tag = widget.category;
    // Create a new controller for this specific category (or find existing one)
    controller = Get.put(NewsController(), tag: tag);
    if (controller.articles.isEmpty) {
      controller.getNews(category: widget.category);
    }
  }

  // If the widget updates with a new category (unlikely given key usage, but good practice)
  @override
  void didUpdateWidget(Newslistviewbuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.category != widget.category) {
      tag = widget.category;
      controller = Get.put(NewsController(), tag: tag);
      controller.getNews(category: widget.category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 100),
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      } else if (controller.errorMessage.isNotEmpty) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text('Error: ${controller.errorMessage.value}'),
            ),
          ),
        );
      } else {
        if (controller.articles.isEmpty) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: Text('No news available.')),
            ),
          );
        }
        return NewsListView(article: controller.articles);
      }
    });
  }
}
