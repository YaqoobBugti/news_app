import 'package:news/modle/article_modle.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class News {
  List<ArticleModle> news = [];

  Future<void> getNews() async {
    String api ='http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=a86606a48d954ee5b5a4aaec923c859e';
    var reponse = await http.get(api);
    var jsonData = jsonDecode(reponse.body);
    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach(
        (element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            ArticleModle articleModle = ArticleModle(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content'],
              publishedAt: element['publishedAt'],
            );
            news.add(articleModle);
          }
        },
      );
    }
  }
}
