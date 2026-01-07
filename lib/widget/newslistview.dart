import 'package:flutter/material.dart';
import 'package:news_app/models/articlemodel.dart';
import 'package:news_app/widget/newstile.dart';

class NewsListView extends StatelessWidget {
  final List<ArticleModel> article;
  const NewsListView({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Newstile(articleModel: article[index]);
        },
        childCount: article.length,
      ),
    );
  }
}
