import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:github_followers/core/router/app_router.dart';
import 'package:github_followers/features/favorites/favorites_screen_providers.dart';
import 'package:github_followers/features/profile/profile_screen.dart';
import 'package:github_followers/features/profile/profile_screen_providers.dart';
import 'package:github_followers/features/search/domain/follower.dart';
import 'package:github_followers/features/shared/custom_consumer_stateful_widget.dart';
import 'package:github_followers/managers/followers_manager.dart';
import 'package:github_followers/ui/gf_avatar_image.dart';

class FavoritesScreen extends CustomConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  "Favorites",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ref.watch(followersProvider).isEmpty
                ? widget.showEmptyState(context,
                    'You dont have any followers added to your favorites')
                : showFavorites(ref.read(followersProvider))
          ],
        ),
      ),
    );
  }

  Widget showFavorites(List<Follower> followers) {
    return Expanded(
      child: ListView.separated(
        itemCount: followers.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemBuilder: (context, index) {
          final follower = followers[index];
          return Slidable(
            key: Key(follower.login),
            startActionPane: ActionPane(
              dragDismissible: false,
              motion: const ScrollMotion(),
              extentRatio: 0.25,
              children: [
                CustomSlidableAction(
                  autoClose: true,
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  onPressed: (context) {
                    followersBox.delete(follower.login);
                    return ref.refresh(followersProvider);
                  },
                  backgroundColor: Theme.of(context).colorScheme.background,
                  foregroundColor: Colors.white,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      ),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.delete),
                        SizedBox(height: 3),
                        Text("Delete")
                      ],
                    ),
                  ),
                )
              ],
            ),
            child: InkWell(
              onTap: () async {
                //Assign username usernameProvider so that ProfileScreen can retrieve the username
                ref.read(currentUsernameProvider.notifier).state =
                    follower.login;
                final router = AppRouter.of(context);
                final result = await router.goToScreen(
                  const ProfileScreen(),
                );

                if (result != null) {
                  return await ref.refresh(followersProvider);
                }
              },
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: GFAvatarImage(
                        url: follower.avatarUrl,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            follower.login,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: double.infinity,
                      child: Icon(
                        Icons.chevron_right,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
