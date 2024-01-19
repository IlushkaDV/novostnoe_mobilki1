import 'dart:convert';
import 'package:http/http.dart' as http;

class News {
  String title;
  String description;
  String url;

  News({required this.title, required this.description, required this.url});
}

class NewsService {
  final String apiKey = 'b5e41fddb74847a2b88b24f229c75462'; // Замените YOUR_API_KEY на ваш ключ API

  Future<List<News>> getNews() async {
    final response = await http.get(
      Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<News> newsList = [];

      for (var item in jsonData['articles']) {
        News news = News(
          title: item['title'] ?? '',
          description: item['description'] ?? '',
          url: item['url'] ?? '',
        );
        newsList.add(news);
      }

      return newsList;
    } else {
      throw Exception('Failed to load news');
    }
  }
}