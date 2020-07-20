import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();
}

class FetchArticles extends ArticleEvent {
  final int _type;
  
  int get type => _type;
  
  FetchArticles(this._type);
  
  @override
  // TODO: implement props
  List<Object> get props => null;

  @override
  String toString() {
    return 'Fetching Article';
  }
}

class RefreshArticles extends ArticleEvent {
  final int _type;
  
  int get type => _type;

  RefreshArticles(this._type);
  
  @override
  // TODO: implement props
  List<Object> get props => null;

  @override
  String toString() {
    return 'Rereshing Article';
  }
}
