import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_followers/features/profile/profile_screen_providers.dart';
import 'package:github_followers/features/search/domain/follower.dart';
import 'package:github_followers/features/search/domain/followers_response.dart';
import 'package:github_followers/managers/network_manager.dart';
import 'package:multiple_result/multiple_result.dart';

final scrollControllerProvider = Provider<ScrollController>((ref) {
  return ScrollController();
});

final followersListProvider =
    StateProvider.autoDispose<List<Follower>>((ref) => []);

final userFollowersProvider = FutureProvider.autoDispose
    .family<Result<FollowersResponse, GFError>, String>((ref, username) async {
  final userRepository = ref.read(userRepositoryProvider);
  final pageNotifier = ref.watch(pageProvider);
  return userRepository.getFollowers(
      username: username, page: pageNotifier.currentPage);
});

final pageProvider = StateNotifierProvider.autoDispose<PageNotifier, PageState>(
    (ref) => PageNotifier());

class PageState {
  int currentPage;

  PageState(this.currentPage);
}

class PageNotifier extends StateNotifier<PageState> {
  PageNotifier() : super(PageState(1));

  void nextPage() {
    state = PageState(state.currentPage + 1);
  }

  void previousPage() {
    state = PageState(state.currentPage - 1);
  }
}
