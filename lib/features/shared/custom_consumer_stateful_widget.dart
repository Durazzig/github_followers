import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_followers/managers/assets_manager.dart';
import 'package:github_followers/ui/gf_alert.dart';

abstract class CustomConsumerStatefulWidget extends ConsumerStatefulWidget {
  const CustomConsumerStatefulWidget({super.key});

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

  void errorAlert(BuildContext context, String error) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      presentGFAlert(
        context,
        title: "Error",
        body: error,
        buttonTitle: "Ok",
      );
    });
  }

  void presentGFAlert(
    BuildContext context, {
    required String title,
    required String body,
    required String buttonTitle,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return GFAlert(title: title, body: body, buttonTitle: buttonTitle);
      },
    );
  }
}
