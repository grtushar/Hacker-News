import 'package:hackernews/model/Article.dart';
import 'package:hackernews/network/HackerNewsApi.dart';

Future<List<Article>> getArticles() async {
	final articles = List<Article>();
	fetchArticles().then((articleIds) {
//		for(int articleId in articleIds) {
		for(int i = 0; i < 50; i++) {
			int articleId = articleIds[i];
			fetchArticle(articleId).then((article) {
				articles.add(article);
			});
		}
	});
	
	return articles;
}