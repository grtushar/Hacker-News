import 'package:hackernews/model/Article.dart';
import 'package:hackernews/network/HackerNewsApi.dart';

Future<List<Article>> getArticles() async {
	final articles = List<Article>();
	fetchArticles().then((articleIds) {
		for(int articleId in articleIds) {
			fetchArticle(articleId).then((article) {
				articles.add(article);
			});
		}
	});
	
	return articles;
}