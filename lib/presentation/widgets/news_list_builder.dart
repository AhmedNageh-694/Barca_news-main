import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/presentation/viewmodels/viewmodels.dart';
import 'package:news_app/presentation/widgets/common/common.dart';
import 'package:news_app/presentation/widgets/news_tile.dart';

class NewsListBuilder extends StatefulWidget {
  const NewsListBuilder({super.key, required this.category});
  final String category;

  @override
  State<NewsListBuilder> createState() => _NewsListBuilderState();
}

class _NewsListBuilderState extends State<NewsListBuilder> {
  late NewsViewModel viewModel;
  late String tag;

  @override
  void initState() {
    super.initState();
    _initializeViewModel();
  }

  void _initializeViewModel() {
    tag = widget.category;
    viewModel = Get.put(NewsViewModel(), tag: tag);
    if (viewModel.articles.isEmpty) {
      viewModel.getNews(category: widget.category);
    }
  }

  @override
  void didUpdateWidget(NewsListBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.category != widget.category) {
      _initializeViewModel();
      viewModel.getNews(category: widget.category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (viewModel.isLoading.value) {
        return const SliverLoadingIndicator();
      }

      if (viewModel.hasError) {
        return SliverErrorMessage(
          message: '${AppStrings.errorPrefix}${viewModel.errorMessage.value}',
        );
      }

      if (viewModel.isEmpty) {
        return const SliverEmptyState(message: AppStrings.noNewsAvailable);
      }

      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => NewsTile(article: viewModel.articles[index]),
          childCount: viewModel.articles.length,
        ),
      );
    });
  }
}
