import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:news_app/data/models/models.dart';
import 'package:news_app/data/repositories/news_repository.dart';

/// NewsViewModel - handles news data fetching and state
class NewsViewModel extends GetxController {
  final NewsRepository _repository;

  NewsViewModel({NewsRepository? repository})
    : _repository = repository ?? NewsRepository(Dio());

  // Observable state
  final RxList<ArticleModel> articles = <ArticleModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Getters
  bool get hasError => errorMessage.isNotEmpty;
  bool get isEmpty => articles.isEmpty && !isLoading.value && !hasError;

  /// Fetch news for a specific category
  Future<void> getNews({required String category}) async {
    try {
      _setLoading(true);
      _clearError();

      final fetchedArticles = await _repository.getNews(query: category);

      if (fetchedArticles.isEmpty) {
        _setError('No articles found.');
      } else {
        articles.value = fetchedArticles;
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Refresh news
  Future<void> refreshNews({required String category}) async {
    await getNews(category: category);
  }

  // Private helpers
  void _setLoading(bool value) => isLoading.value = value;
  void _setError(String message) => errorMessage.value = message;
  void _clearError() => errorMessage.value = '';
}
