import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Article.g.dart';

@JsonSerializable(explicitToJson: true)
class Article extends Equatable {
	final String by;
	final int descendants;
	final int id;
	final List<int> kids;
	final int score;
	final int time;
	final String title;
	final String type;
	final String url;
	
	
	const Article({this.by, this.descendants, this.id, this.kids, this.score, this.time,
		this.title, this.type, this.url});
	
//	factory Article.fromJson(Map<String, dynamic> json) {
//		if(json == null) return null;
//		return Article(
//			by: json["by"] ?? null,
//			descendants: json["descendants"] ?? null,
//			id: json["id"] ?? null,
//			kids: json["kids"] ?? null,
//			score: json["score"] ?? null,
//			time: json["time"] ?? null,
//			title: json["title"] ?? null,
//			type: json["type"] ?? null,
//			url: json["url"] ?? null,
//		);
//	}
	
	/// A necessary factory constructor for creating a new User instance
	/// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
	/// The constructor is named after the source class, in this case, User.
	factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
	
	/// `toJson` is the convention for a class to declare support for serialization
	/// to JSON. The implementation simply calls the private, generated
	/// helper method `_$UserToJson`.
	Map<String, dynamic> toJson() => _$ArticleToJson(this);

  @override
  List<Object> get props => [id, by, score, title, time, type, url, kids, descendants];
	
	@override
  String toString() {
    return 'Article {$id : $title}';
  }
}





//{
//"by" : "dhouston",
//"descendants" : 71,
//"id" : 8863,
//"kids" : [ 8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005, 9671, 8940, 9067, 8908, 9055, 8865, 8881, 8872, 8873, 8955, 10403, 8903, 8928, 9125, 8998, 8901, 8902, 8907, 8894, 8878, 8870, 8980, 8934, 8876 ],
//"score" : 111,
//"time" : 1175714200,
//"title" : "My YC app: Dropbox - Throw away your USB drive",
//"type" : "story",
//"url" : "http://www.getdropbox.com/u/2/screencast.html"
//}