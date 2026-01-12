import 'package:flutter/material.dart';
import 'package:news_app/models/models.dart';
import 'package:news_app/widget/newstile.dart';

class NewsListView extends StatelessWidget {
  final List<ArticleModel> articles;

  const NewsListView({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => NewsTile(articleModel: articles[index]),
        childCount: articles.length,
      ),
    );
  }
}
