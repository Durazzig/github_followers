import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'follower.g.dart';

@HiveType(typeId: 0)
class Follower {
  @HiveField(0)
  String login;

  @HiveField(1)
  String avatarUrl;

  Follower({
    required this.login,
    required this.avatarUrl,
  });

  factory Follower.fromJson(Map<String, dynamic> json) => Follower(
        login: json["login"],
        avatarUrl: json["avatar_url"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "avatar_url": avatarUrl,
      };
}
