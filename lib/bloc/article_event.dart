import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();
}

class LoadingArticle extends ArticleEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;

  @override
  String toString() {
    return 'Loading Article';
  }
}
