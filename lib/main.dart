import 'package:flutter/material.dart';
import 'package:hackernews/model/Article.dart';
import 'package:hackernews/repository/ArticleRepository.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

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
  final _articles = List<Article>();

  @override
  void initState() {
    super.initState();

    articles = getArticles();
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
    return StreamBuilder<Article>(
      stream: articles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final article = _articles[index];
                    return _buildListItem(article);
//                      ListTile(
////                      key: Key(index.toString()),
//                      title: Text('${article.title}'),
//                      subtitle: Text('${article.by}'),
//                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    height: 1,
                  ),
                  itemCount: _articles.length,
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }

        if(snapshot.data != null) _articles.add(snapshot.data);
        // By default, show a loading spinner.
        return Center(
            child: CircularProgressIndicator()); //CircularProgressIndicator());
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
