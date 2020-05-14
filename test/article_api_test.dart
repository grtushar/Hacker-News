import 'package:hackernews/network/HackerNewsApi.dart';
import 'package:test/test.dart';

void main() {
	test("Fetching article ids", () async {
		int firstArticleId = (await fetchArticles()).first;
//		await fetchArticles().then((values) {
//			firstArticleId = values.first;
//		});
		expect(firstArticleId, isNotNull);
		
		String firstArticleAuthor = (await fetchArticle(firstArticleId)).by;
		expect(firstArticleAuthor, isNotNull);
	});
}