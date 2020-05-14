import 'package:hackernews/model/Article.dart';
import 'package:hackernews/network/HackerNewsApi.dart';

Stream<Article> getArticles() async* {
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
	final ids = await fetchArticles();
	for(int i = 0; i < 16; i++) {
		yield await fetchArticle(ids[i]);
	}
}