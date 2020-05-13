import 'package:flutter/material.dart';
import 'package:hackernews/model/Article.dart';
import 'package:hackernews/repository/ArticleRepository.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  Future<List<Article>> articles;
  
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
  
    return FutureBuilder<List<Article>>(
      future: articles,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              Expanded (
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final article = snapshot.data[index];
                    return ListTile (
                      title: Text(
                        '${article.title}'
                      ),
                      subtitle: Text(
                        '${article.by}'
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => Divider(
                    height: 1,
                  ),
                  itemCount: snapshot.data.length,
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }
      
        // By default, show a loading spinner.
        return Column(
          children: <Widget>[
            Expanded(child: Center(child: Text("Loading..."))),
          ],
        );//CircularProgressIndicator());
      },
    );
  }
}
