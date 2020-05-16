import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();
}

class FetchArticles extends ArticleEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;

  @override
  String toString() {
    return 'Fetching Article';
  }
}

class RefreshArticles extends ArticleEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;

  @override
  String toString() {
    return 'Rereshing Article';
  }
}
