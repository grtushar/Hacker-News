import 'package:equatable/equatable.dart';
import 'package:hackernews/model/Article.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticlesEmpty extends ArticleState {}

class ArticlesLoading extends ArticleState {}

class ArticlesLoaded extends ArticleState {
  final List<Article> articles;

  ArticlesLoaded(this.articles) : assert(articles != null);

  @override
  List<Object> get props => [articles];
}

class ArticlesError extends ArticleState {}
