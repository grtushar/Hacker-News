import 'dart:convert';

import 'package:hackernews/model/Article.dart';
import 'package:http/http.dart' as http;

Future<List<int>> fetchArticles() async {
	final url = "https://hacker-news.firebaseio.com/v0/topstories.json";
	final response = await http.get(url);
	
	if(response.statusCode != 200) throw Exception('Failed to load article!');
	
	final result = (jsonDecode(response.body) as List<dynamic>).cast<int>();
	return result;
}

Future<Article> fetchArticle(int id) async {
	final url = "https://hacker-news.firebaseio.com/v0/item/$id.json";
	final response = await http.get(url);
	
	if(response.statusCode != 200) throw Exception('Failed to load article!');
	
	return Article.fromJson(jsonDecode(response.body));
}