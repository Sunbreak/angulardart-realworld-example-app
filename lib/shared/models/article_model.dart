import 'profile_model.dart';

class Article {
  String slug;
  String title = '';
  String description = '';
  String body = '';
  List<String> tagList = [];
  String createdAt;
  String updatedAt;
  bool favorited;
  int favoritesCount;
  Profile author;

  Article({
    this.slug,
    this.title = '',
    this.description = '',
    this.body = '',
    List<String> tagList,
    this.createdAt,
    this.updatedAt,
    this.favorited,
    this.favoritesCount,
    this.author,
  }) : this.tagList = tagList ?? [];

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      slug: json['slug'],
      title: json['title'],
      description: json['description'],
      body: json['body'],
      tagList: (json['tagList'] as List).cast(),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      favorited: json['favorited'],
      favoritesCount: json['favoritesCount'],
      author: json['author'] != null ? Profile.fromJson(json['author']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'title': title,
      'description': description,
      'body': body,
      'tagList': tagList,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'favorited': favorited,
      'favoritesCount': favoritesCount,
      'author': author?.toJson(),
    };
  }
}
