import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_followers/core/router/app_router.dart';
import 'package:github_followers/features/profile/profile_screen.dart';
import 'package:github_followers/features/profile/profile_screen_providers.dart';
import 'package:github_followers/features/search/presentation/search_screen_providers.dart';
import 'package:github_followers/features/shared/custom_consumer_stateful_widget.dart';
import 'package:github_followers/managers/assets_manager.dart';
import 'package:github_followers/ui/gf_button.dart';

class SearchScreen extends CustomConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late AssetsManager assetsProvider;

  @override
  void initState() {
    super.initState();
    assetsProvider = AssetsManager(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              kBottomNavigationBarHeight -
              41,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: Image(
                    image: assetsProvider.getImageAsset("gh-logo"),
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.75,
                  ),
                ),
                TextField(
                  controller: ref.read(usernameControllerProvider),
                  keyboardType: TextInputType.text,
                  onEditingComplete: () => search(),
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GFButton(
                        title: "Search user",
                        onPressed: search,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void search() {
    final username = ref.read(usernameControllerProvider).text;
    //Assign username usernameProvider so that ProfileScreen can retrieve the username
    ref.read(currentUsernameProvider.notifier).state = username;
    if (username.isEmpty) {
      widget.presentGFAlert(
        context,
        title: "Invalid Username",
        body: "Please enter a valid username",
        buttonTitle: "Ok",
      );
    } else {
      FocusScope.of(context).unfocus();
      AppRouter.of(context).goToScreen(
        const ProfileScreen(),
      );
    }
  }
}
