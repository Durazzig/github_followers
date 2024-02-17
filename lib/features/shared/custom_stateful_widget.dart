import 'package:flutter/material.dart';
import 'package:github_followers/managers/assets_manager.dart';

abstract class CustomStatefulWidget extends StatefulWidget {
  const CustomStatefulWidget({super.key});

  void showLoadingView() {}

  void dismissLoadingView() {}

  Widget showEmptyState(BuildContext context, String title) {
    final assetsProvider = AssetsManager(context);
    return Expanded(
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: -MediaQuery.of(context).size.width * 0.25,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              height: MediaQuery.of(context).size.height * 0.40,
              child: Image(
                image: assetsProvider.getImageAsset("empty-state-logo"),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
