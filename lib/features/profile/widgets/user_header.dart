import 'package:flutter/material.dart';
import 'package:github_followers/features/profile/image_details_screen.dart';
import 'package:github_followers/features/search/domain/user_model.dart';
import 'package:github_followers/ui/gf_avatar_image.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageDetailScreen(
                          avatarUrl: user.avatarUrl,
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Hero(
                      tag: 'imageTag',
                      child: GFAvatarImage(
                        url: user.avatarUrl,
                      ),
                    ),
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
                        user.login,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(user.name ?? "",
                          style: const TextStyle(
                            fontSize: 20,
                          )),
                      Row(
                        children: [
                          const Icon(Icons.location_city),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(user.location ?? "No location available"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  user.bio ?? "No bio available",
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
