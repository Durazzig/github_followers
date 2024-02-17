import 'dart:convert';

import 'package:github_followers/features/search/domain/follower.dart';
import 'package:github_followers/features/search/domain/user_model.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class FollowersResponse {
  List<Follower> data;

  FollowersResponse({
    required this.data,
  });

  factory FollowersResponse.fromJson(Map<String, dynamic> json) =>
      FollowersResponse(
        data:
            List<Follower>.from(json["data"].map((x) => Follower.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
