import 'package:hackernews/model/Article.dart';
import 'package:rxdart/rxdart.dart';

class HackerNewsBloc {
	Stream<List<Article>> get articles => _articleSubject.stream;
	
	final _articleSubject = BehaviorSubject<List<Article>>();
	
	HackerNewsBloc() {
	
	}
}