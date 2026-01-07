import 'package:dio/dio.dart';
import 'package:news_app/models/articlemodel.dart';

class NewsServices {
  final Dio dio;
  NewsServices(this.dio);
  static const String _apitoken = 'Ifs7pZkzT280ihBA4XKeRqf0vnvjiRo0MIq3cbcQDzlCEk2AF088bKJ1rahl';

  Future<List<ArticleModel>> getSportsNews({required String query}) async {
    try {
      var url = await dio.get(
        'https://api.sportmonks.com/v3/football/squads/teams/83?api_token=$_apitoken',
      );
      Map<String, dynamic> jsonData = url.data;
      List<dynamic> artcles = jsonData['data'];
      List<ArticleModel> articlesList = [];
      for (var article in artcles) {
        ArticleModel articleModel = ArticleModel(
          image: article['urlToImage'],
          titel: article['player_id'],
          suptitel: article['detailed_position_id'],
        );
        articlesList.add(articleModel);
      }
      return articlesList;
    } catch (e) {
      return [];
    }
  }
}
