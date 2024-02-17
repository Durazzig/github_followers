import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_followers/features/search/domain/follower.dart';
import 'package:github_followers/managers/followers_manager.dart';

final followersProvider = Provider.autoDispose<List<Follower>>((ref) {
  List<Follower> followers = followersBox.values.toList();
  return followers;
});
