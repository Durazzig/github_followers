import 'package:flutter/material.dart';
import 'package:github_followers/ui/gf_avatar_image.dart';

class ImageDetailScreen extends StatelessWidget {
  const ImageDetailScreen({super.key, required this.avatarUrl});

  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Hero(
              tag: 'imageTag',
              child: GFAvatarImage(
                url: avatarUrl,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
