import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_followers/core/utils/helpers.dart';
import 'package:github_followers/features/followers/followers_screen.dart';
import 'package:github_followers/features/profile/profile_screen_providers.dart';
import 'package:github_followers/features/profile/widgets/user_followers.dart';
import 'package:github_followers/features/profile/widgets/user_header.dart';
import 'package:github_followers/features/profile/widgets/user_repos.dart';
import 'package:github_followers/features/search/domain/follower.dart';
import 'package:github_followers/features/search/presentation/widgets/gf_item_info.dart';
import 'package:github_followers/features/shared/custom_consumer_stateful_widget.dart';
import 'package:github_followers/managers/followers_manager.dart';

class ProfileScreen extends CustomConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   Future.microtask(
  //     () => ref.read(currentUsernameProvider.notifier).state =
  //         ref.read(usernameControllerProvider).text,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final currentUsername = ref.watch(currentUsernameProvider);
    final userAsyncValue = ref.watch(userProvider(currentUsername));
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, "refresh");
          },
        ),
        actions: [
          Visibility(
            visible: ref.watch(errorProvider) == null,
            child: IconButton(
              onPressed: addFollowerToFavorites,
              icon: const Icon(Icons.star),
            ),
          )
        ],
      ),
      body: userAsyncValue.whenOrNull(
        data: (userEither) {
          return userEither.when(
            (user) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                ref.read(currentUserProvider.notifier).state = user;
              });
              return Column(
                children: [
                  UserHeader(user: user),
                  UserRepos(
                    buttonTitle: "Github Profile",
                    buttonColor: Colors.purple,
                    type1: ItemInfoType.repos,
                    type2: ItemInfoType.gists,
                    type1Count: user.publicRepos,
                    type2Count: user.publicGists,
                    onButtonTapped: () => Helpers.openUrl(user.htmlUrl),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  UserFollowers(
                    buttonTitle: "Get followers",
                    buttonColor: Colors.green,
                    type1: ItemInfoType.followers,
                    type2: ItemInfoType.following,
                    type1Count: user.followers,
                    type2Count: user.following,
                    onButtonTapped: () async {
                      ref.read(currentUserProvider.notifier).state = user;
                      ref.read(currentUsernameProvider.notifier).state =
                          user.login;
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FollowersScreen(),
                        ),
                      );

                      if (result != null) {
                        ref.read(currentUsernameProvider.notifier).state =
                            result;
                        return await ref.refresh(userProvider(result));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("GitHub since: ${Helpers.formatDate(user.createdAt)}"),
                ],
              );
            },
            (error) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                ref.read(errorProvider.notifier).state = error;
              });
              return Column(
                children: [
                  widget.showEmptyState(context, "User not found"),
                ],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void addFollowerToFavorites() {
    final user = ref.read(currentUserProvider);
    if (user != null) {
      if (followersBox.containsKey(user.login)) {
        widget.presentGFAlert(
          context,
          title: "Oops",
          body: "It seems you already added this user to your favorites",
          buttonTitle: "OK",
        );
      } else {
        widget.presentGFAlert(
          context,
          title: "Congratulations",
          body: "You successfully added this user to your favorites",
          buttonTitle: "OK",
        );
        final follower = Follower(
          login: user.login,
          avatarUrl: user.avatarUrl,
        );
        followersBox.put(user.login, follower);
      }
    }
  }
}
