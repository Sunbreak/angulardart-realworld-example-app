class Profile {
  String username;
  String bio;
  String image;
  bool following;

  Profile({
    this.username,
    this.bio,
    this.image,
    this.following,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      username: json['username'],
      bio: json['bio'],
      image: json['image'],
      following: json['following'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'bio': bio,
      'image': image,
      'following': following,
    };
  }
}
