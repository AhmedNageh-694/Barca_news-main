import 'package:dio/dio.dart';
import 'package:news_app/data/models/models.dart';
import 'package:news_app/data/services/news_service.dart';

/// News Repository - abstracts data source for news
class NewsRepository {
  final NewsService _service;

  NewsRepository(Dio dio) : _service = NewsService(dio);

  /// Get news articles by query/category
  Future<List<ArticleModel>> getNews({required String query}) async {
    return await _service.fetchNews(query: query);
  }

  /// Get news by category
  Future<List<ArticleModel>> getNewsByCategory(String category) async {
    return await _service.fetchNews(query: category);
  }
}
