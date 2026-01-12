import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:news_app/models/articlemodel.dart';
import 'package:news_app/services/news_services.dart';

class NewsController extends GetxController {
  final NewsServices _newsServices = NewsServices(Dio());

  RxList<ArticleModel> articles = <ArticleModel>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  Future<void> getNews({required String category}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final fetchedArticles = await _newsServices.getSportsNews(
        query: category,
      );

      if (fetchedArticles.isEmpty) {
        errorMessage.value = 'No articles found or network error.';
      } else {
        articles.value = fetchedArticles;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
