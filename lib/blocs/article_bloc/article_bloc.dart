import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hackernews/model/Article.dart';
import 'package:hackernews/repository/ArticleRepository.dart';
import 'bloc.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository articleRepository;

  ArticleBloc(this.articleRepository);


  @override
  ArticleState get initialState => ArticlesEmpty();

  @override
  Stream<ArticleState> mapEventToState(
    ArticleEvent event,
  ) async* {
    if (event is FetchArticles) {
      yield* _mapFetchArticlesToState(event);
    } else if (event is RefreshArticles) {
      yield* _mapRefreshArticlesToState(event);
    }
  }
  
  Stream<ArticleState> _mapFetchArticlesToState(FetchArticles event) async* {
    yield ArticlesLoading();
    
    try {
      final List<Article> articles = await articleRepository.getArticles();
      yield ArticlesLoaded(articles);
    } catch (_) {
      yield ArticlesError();
    }
  }
  
  Stream<ArticleState> _mapRefreshArticlesToState(RefreshArticles event) async* {
    yield ArticlesLoading();
    
    try {
      final List<Article> articles = await articleRepository.getArticles();
      yield ArticlesLoaded(articles);
    } catch (_) {
      yield ArticlesError();
    }
  }
}
