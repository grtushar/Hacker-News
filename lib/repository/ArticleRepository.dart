import 'package:flutter/cupertino.dart';
import 'package:hackernews/model/Article.dart';
import 'package:hackernews/network/ArticleApiClient.dart';

class ArticleRepository {
	final ArticleApiClient articleApiClient;

  ArticleRepository({@required this.articleApiClient})
    : assert(articleApiClient != null);
	
	Future<List<Article>> getArticles(int type) async {
		final ids = await articleApiClient.fetchArticles(type);
		return Future.wait(ids.sublist(0, 14).map((id) => articleApiClient.fetchArticle(id)));
		
//	final articles = List<Article>();
//	fetchArticles().then((articleIds) {
////		for(int articleId in articleIds) {
//		for(int i = 0; i < 50; i++) {
//			int articleId = articleIds[i];
//			fetchArticle(articleId).then((article) {
//				yield article;
////				articles.add(article);
//			});
//		}
//	});

//		for(int i = 0; i < 16; i++) {
//			yield await articleApiClient.fetchArticle(ids[i]);
//		}
	}
}