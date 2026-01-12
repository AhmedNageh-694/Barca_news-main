import 'package:dio/dio.dart';
import 'package:news_app/core/config/api_config.dart';
import 'package:news_app/models/models.dart';

/// Service class for fetching news from the API
class NewsServices {
  final Dio _dio;

  NewsServices(this._dio);

  /// Fetch sports news based on a search query
  /// Throws [DioException] for network errors or [FormatException] for parsing errors
  Future<List<ArticleModel>> getSportsNews({required String query}) async {
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
