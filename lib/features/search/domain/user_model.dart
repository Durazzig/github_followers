import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String login;
  int id;
  String avatarUrl;
  String htmlUrl;
  String? name;
  String? location;
  String? bio;
  int publicRepos;
  int publicGists;
  int followers;
  int following;
  DateTime createdAt;

  User({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.htmlUrl,
    this.name,
    this.location,
    this.bio,
    required this.publicRepos,
    required this.publicGists,
    required this.followers,
    required this.following,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        login: json["login"],
        id: json["id"],
        avatarUrl: json["avatar_url"],
        htmlUrl: json["html_url"],
        name: json["name"],
        location: json["location"],
        bio: json["bio"],
        publicRepos: json["public_repos"],
        publicGists: json["public_gists"],
        followers: json["followers"],
        following: json["following"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "id": id,
        "avatar_url": avatarUrl,
        "html_url": htmlUrl,
        "name": name,
        "location": location,
        "bio": bio,
        "public_repos": publicRepos,
        "public_gists": publicGists,
        "followers": followers,
        "following": following,
        "created_at": createdAt.toIso8601String(),
      };
}
