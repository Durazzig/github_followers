import 'package:flutter/material.dart';

class GFAvatarImage extends StatelessWidget {
  const GFAvatarImage({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(url),
    );
  }
}
