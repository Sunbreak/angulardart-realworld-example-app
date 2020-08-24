import 'profile_model.dart';

class Comment {
  int id;
  String body;
  String createdAt;
  Profile author;

  Comment({
    this.id,
    this.body,
    this.createdAt,
    this.author,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      body: json['body'],
      createdAt: json['createdAt'],
      author: Profile.fromJson(json['author']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
      'createdAt': createdAt,
      'author': author,
    };
  }
}
