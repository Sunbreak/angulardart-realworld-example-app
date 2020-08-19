class User {
  String email;
  String token;
  String username;
  String bio;
  String image;

  User({
    this.email,
    this.token,
    this.username,
    this.bio,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      token: json['token'],
      username: json['username'],
      bio: json['bio'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'token': token,
      'username': username,
      'bio': bio,
      'image': image,
    };
  }
}
