import 'package:equatable/equatable.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();
}

class InitialArticleState extends ArticleState {
  @override
  List<Object> get props => [];
}
