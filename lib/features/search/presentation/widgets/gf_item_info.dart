import 'package:flutter/material.dart';

enum ItemInfoType { repos, gists, followers, following }

class GFItemInfo extends StatelessWidget {
  const GFItemInfo({super.key, required this.type, this.count = 0});

  final ItemInfoType type;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            getIcon(),
            const SizedBox(
              width: 5,
            ),
            Text(getTitle()),
          ],
        ),
        Text("$count")
      ],
    );
  }

  String getTitle() {
    switch (type) {
      case ItemInfoType.repos:
        return "Public Repos";
      case ItemInfoType.gists:
        return "Public Gists";
      case ItemInfoType.followers:
        return "Followers";
      case ItemInfoType.following:
        return "Following";
    }
  }

  Widget getIcon() {
    switch (type) {
      case ItemInfoType.repos:
        return const Icon(
          Icons.read_more,
          size: 30,
        );
      case ItemInfoType.gists:
        return const Icon(
          Icons.pin,
          size: 30,
        );
      case ItemInfoType.followers:
        return const Icon(
          Icons.favorite,
          size: 30,
        );
      case ItemInfoType.following:
        return const Icon(
          Icons.people,
          size: 30,
        );
    }
  }
}
