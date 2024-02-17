import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_followers/features/followers/followers_screen_providers.dart';
import 'package:github_followers/features/profile/profile_screen_providers.dart';

class BottomPagination extends ConsumerWidget {
  const BottomPagination({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.read(currentUserProvider);

    return Visibility(
      visible: currentUser!.followers != 0 && currentUser.followers > 100,
      child: Builder(
        builder: (context) {
          final totalPages = (currentUser.followers / 100).round();
          final currentPage = ref.read(pageProvider).currentPage;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: currentPage != 1,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: TextButton(
                  onPressed: () {
                    ref.read(pageProvider.notifier).previousPage();
                  },
                  child: const Text("Previous"),
                ),
              ),
              Text("Page $currentPage of $totalPages"),
              Visibility(
                visible: currentPage != totalPages,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: TextButton(
                  onPressed: () {
                    ref.read(pageProvider.notifier).nextPage();
                  },
                  child: const Text("Next"),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
