import 'package:hackernews/network/HackerNewsApi.dart';
import 'package:test/test.dart';

void main() {
	test("Fetching article ids", () async {
		const articleIdMatcher = 23155647;
		const articleAuthorMatcher = "minimaxir";
		
		int firstArticleId = (await fetchArticles()).first;
//		await fetchArticles().then((values) {
//			firstArticleId = values.first;
//		});
		expect(firstArticleId, articleIdMatcher);
		
		String firstArticleAuthor = (await fetchArticle(firstArticleId)).by;
		expect(firstArticleAuthor, articleAuthorMatcher);
	});
}