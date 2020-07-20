import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackernews/blocs/article_bloc/bloc.dart';
import 'package:hackernews/model/Article.dart';
import 'package:hackernews/repository/ArticleRepository.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:hackernews/network/ArticleApiClient.dart';

void main() {
  final ArticleRepository articleRepository = ArticleRepository(
    articleApiClient: ArticleApiClient()
  );
  runApp(
    MultiBlocProvider (
      providers: [
        BlocProvider<ArticleBloc>(
          create: (context) => ArticleBloc(articleRepository),
        )
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
//      theme: ThemeData.dark(),
//        primarySwatch: Colors.blue,
//      ),
      home: MyHomePage(title: 'Hacker News Articles'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Completer<void> _refreshCompleter;
  int _selectedIndex = 0;
  
  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    BlocProvider.of<ArticleBloc>(context)
      .add(FetchArticles(_selectedIndex));
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.update), title: Text("Top Stories")),
          BottomNavigationBarItem(icon: Icon(Icons.new_releases), title: Text("New Stories")),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: _buildArticleListView(context, _selectedIndex),
    );
  }

  Widget _buildArticleListView(BuildContext context, int _selectedIndex) {
    BlocProvider.of<ArticleBloc>(context)
      .add(FetchArticles(_selectedIndex));
    
    return BlocConsumer<ArticleBloc, ArticleState> (
      listener: (BuildContext context, ArticleState state) {
        if(state is ArticlesLoaded) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
        }
      },
      builder: (BuildContext context, ArticleState state) {
        if(state is ArticlesLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if(state is ArticlesLoaded) {
          final articles = state.articles;
          return RefreshIndicator(
            onRefresh: () {
              BlocProvider.of<ArticleBloc>(context)
                .add(RefreshArticles(_selectedIndex));
              return _refreshCompleter.future;
            },
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return _buildListItem(article);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                        height: 1,
                      ),
                    itemCount: articles.length,
                  ),
                ),
              ],
            ),
          );
        }
        if (state is ArticlesError) {
          return Center(
            child: Text(
              'Something went wrong!',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildListItem(Article article) {
    return Padding(
      key: Key(article.title.toString()),
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: ListTile(
          title: Text(
            '${article.title}',
            style: TextStyle(fontSize: 20),
          ),
          subtitle: Text('By ${article.by}'),
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Type: ${article.type}'),
              IconButton(
                icon: Icon(Icons.launch),
                onPressed: () async {
                  if(await canLaunch(article.url)) {
                    launch(article.url);
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
