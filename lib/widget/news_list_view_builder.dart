import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/widget/common/common_widgets.dart';
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
    _initializeController();
  }

  void _initializeController() {
    tag = widget.category;
    controller = Get.put(NewsController(), tag: tag);
    if (controller.articles.isEmpty) {
      controller.getNews(category: widget.category);
    }
  }

  @override
  void didUpdateWidget(Newslistviewbuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.category != widget.category) {
      _initializeController();
      controller.getNews(category: widget.category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const SliverLoadingIndicator();
      }

      if (controller.errorMessage.isNotEmpty) {
        return SliverErrorMessage(
          message: '${AppStrings.errorPrefix}${controller.errorMessage.value}',
        );
      }

      if (controller.articles.isEmpty) {
        return const SliverEmptyState(message: AppStrings.noNewsAvailable);
      }

      return NewsListView(articles: controller.articles);
    });
  }
}
