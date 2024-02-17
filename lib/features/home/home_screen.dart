import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_followers/features/favorites/favorites_screen.dart';
import 'package:github_followers/features/home/home_screen_providers.dart';
import 'package:github_followers/features/search/presentation/search_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: ref.watch(pageControllerProvider),
          children: const [
            SearchScreen(),
            FavoritesScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: ref.watch(bottomBarProvider),
        onTap: (page) => changePage(page),
        items: const [
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: "Favorites",
            icon: Icon(Icons.favorite),
          )
        ],
      ),
    );
  }

  void changePage(int page) {
    ref.read(bottomBarProvider.notifier).update((state) => page);
    ref.read(pageControllerProvider).jumpToPage(page);
  }
}
