import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  @override
  ArticleState get initialState => InitialArticleState();

  @override
  Stream<ArticleState> mapEventToState(
    ArticleEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
