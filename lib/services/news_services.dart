import 'package:dio/dio.dart';
import 'package:news_app/models/articlemodel.dart';

class NewsServices {
  final Dio dio;
  NewsServices(this.dio);
  static const String _apiKey = 'ae693838985d492ebc1de831211a4242';
  static const String _language = 'en';

  Future<List<ArticleModel>> getSportsNews({required String query}) async {
    try {
      var url = await dio.get(
        'https://newsapi.org/v2/everything?q=$query&apiKey=$_apiKey&language=$_language',
      );
      Map<String, dynamic> jsonData = url.data;
      List<dynamic> artcles = jsonData['articles'];
      List<ArticleModel> articlesList = [];
      for (var article in artcles) {
        ArticleModel articleModel = ArticleModel(
          image: article['urlToImage'],
          titel: article['title'],
          suptitel: article['description'],
        );
        articlesList.add(articleModel);
      }
      return articlesList;
    } catch (e) {
      return [];
    }
  }
}
