import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/articlemodel.dart';
import 'package:news_app/services/news_services.dart';
import 'package:news_app/widget/newslistview.dart';

class Newslistviewbuilder extends StatelessWidget {
  const Newslistviewbuilder({super.key, required this.category});
  final String category;

  Future<List<ArticleModel>> _loadNews() {
    // Single Dio + NewsServices per call; can be further abstracted if needed.
    return NewsServices(Dio()).getSportsNews(query: 'fcbarcelona');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleModel>>(
      future: _loadNews(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text('Oops, there was an error. Please try again later.'),
            ),
          );
        }
        final data = snapshot.data;
        if (data == null || data.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(child: Text('No news available.')),
          );
        }
        return NewsListView(article: data);
      },
    );
  }
}
