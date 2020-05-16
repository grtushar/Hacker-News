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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  Stream<Article> articles;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ArticleBloc>(context)
      .add(FetchArticles());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildArticleListView(context),
    );
  }

  Widget _buildArticleListView(BuildContext context) {
    return BlocConsumer<ArticleBloc, ArticleState> (
      listener: (BuildContext context, ArticleState state) {
      },
      builder: (BuildContext context, ArticleState state) {
        if(state is ArticlesLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if(state is ArticlesLoaded) {
          final articles = state.articles;
          return Column(
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
          );
        }
        if (state is ArticlesError) {
          return Text(
            'Something went wrong!',
            style: TextStyle(color: Colors.red),
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
