import 'dart:convert';

import 'package:hackernews/model/Article.dart';
import 'package:http/http.dart' as http;

class ArticleApiClient {
	static const baseUrl = "https://hacker-news.firebaseio.com/v0/";
	
	Future<List<int>> fetchArticles(int type) async {
		final url = type == 0 ? "${baseUrl}topstories.json" : "${baseUrl}newstories.json";
		final response = await http.get(url);
		
		if(response.statusCode != 200) throw Exception('Failed to load article ids!');
		
		final result = (jsonDecode(response.body) as List<dynamic>).cast<int>();
		return result;
	}
	
	Future<Article> fetchArticle(int id) async {
		final url = "${baseUrl}item/$id.json";
		final response = await http.get(url);
		
		if(response.statusCode != 200) throw Exception('Failed to load article of id: $id!');
		
		return Article.fromJson(jsonDecode(response.body));
	}
}