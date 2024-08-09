import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsflash/model/news_infoModel.dart';


Future<NewsResponse> fetchNews() async {
  final String apiKey = '2217dd4f898a403aaaf8459b3d84c4b9';
  final String url = 'https://newsapi.org/v2/everything?q=tesla&from=2024-07-09&sortBy=publishedAt&apiKey=$apiKey';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return NewsResponse.fromJson(data);
    } else {
      throw Exception('Failed to load news');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
