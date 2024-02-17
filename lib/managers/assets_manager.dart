import 'package:flutter/material.dart';

class AssetsManager {
  final BuildContext context;

  AssetsManager(this.context);

  AssetImage getImageAsset(String imageName) {
    return AssetImage(_getImagePath(imageName));
  }

  String _getImagePath(String imageName) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? 'assets/dark/$imageName.png'
        : 'assets/light/$imageName.png';
  }
}
