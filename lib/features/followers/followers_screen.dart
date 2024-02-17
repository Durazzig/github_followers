import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_followers/features/followers/followers_screen_providers.dart';
import 'package:github_followers/features/followers/widgets/bottom_pagination.dart';
import 'package:github_followers/features/profile/profile_screen_providers.dart';
import 'package:github_followers/features/shared/custom_consumer_widget.dart';
import 'package:github_followers/ui/gf_avatar_image.dart';

class FollowersScreen extends CustomConsumerWidget {
  const FollowersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.read(currentUserProvider);
    final userAsyncValue = ref.watch(userFollowersProvider(currentUser!.login));
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    currentUser.login,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              currentUser.followers == 0
                  ? showEmptyState(context,
                      "${currentUser.login} does not have any followers")
                  : Expanded(
                      child: Container(
                        child: userAsyncValue.whenOrNull(
                          data: (result) {
                            return result.when(
                              (followers) {
                                final followersList = followers.data;

                                WidgetsBinding.instance
                                    .addPostFrameCallback((timeStamp) {
                                  ref
                                      .watch(followersListProvider.notifier)
                                      .state = followersList;
                                });

                                return GridView.builder(
                                  controller:
                                      ref.read(scrollControllerProvider),
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 20.0,
                                    mainAxisExtent: 150,
                                  ),
                                  itemCount: followersList.length,
                                  itemBuilder: (context, index) {
                                    final follower = followersList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context, follower.login);
                                      },
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: GFAvatarImage(
                                              url: follower.avatarUrl,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            follower.login,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                const TextStyle(fontSize: 16.0),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              (error) {
                                errorAlert(context, error.msg);
                                return Center(
                                  child: Text(
                                    error.msg,
                                  ),
                                );
                              },
                            );
                          },
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    ),
              const BottomPagination(),
            ],
          ),
        ),
      ),
    );
  }
}
