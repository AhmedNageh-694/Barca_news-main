import 'package:dio/dio.dart';
import 'package:news_app/core/config/api_config.dart';
import 'package:news_app/data/models/models.dart';

/// News API Service - handles network requests
class NewsService {
  final Dio _dio;

  NewsService(this._dio);

  /// Fetch news from API
  /// Throws [DioException] for network errors or [FormatException] for parsing errors
  Future<List<ArticleModel>> fetchNews({required String query}) async {
    try {
      final uri = Uri.parse('${ApiConfig.newsApiBaseUrl}/everything').replace(
        queryParameters: {
          'q': query,
          'apiKey': ApiConfig.newsApiKey,
          'language': ApiConfig.newsApiLanguage,
        },
      );

      final response = await _dio.getUri(uri);

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to fetch news: ${response.statusCode} ${response.statusMessage}',
        );
      }

      final Map<String, dynamic> jsonData = response.data;

      if (jsonData['status'] == 'error') {
        throw Exception(jsonData['message'] ?? 'API returned an error');
      }

      final List<dynamic> articles = jsonData['articles'] ?? [];

      if (articles.isEmpty) {
        return [];
      }

      return articles.map((article) => ArticleModel.fromJson(article)).toList();
    } on DioException catch (e) {
      // Re-throw DioException with more context
      throw Exception(
        'Network error: ${e.message ?? 'Unable to connect to the server'}',
      );
    } catch (e) {
      // Re-throw other exceptions with context
      throw Exception('Failed to fetch news: ${e.toString()}');
    }
  }
}
