import 'package:hackernews/network/ArticleApiClient.dart';
import 'package:test/test.dart';

void main() {
	test("Fetching article ids", () async {
		final ArticleApiClient articleApiClient = ArticleApiClient();
		int firstArticleId = (await articleApiClient.fetchArticles()).first;
		expect(firstArticleId, isNotNull);
		
		String firstArticleAuthor = (await articleApiClient.fetchArticle(firstArticleId)).by;
		expect(firstArticleAuthor, isNotNull);
	});
}