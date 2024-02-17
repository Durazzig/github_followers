import 'package:flutter/material.dart';
import 'package:github_followers/core/router/app_router.dart';
import 'package:github_followers/ui/gf_button.dart';

class GFAlert extends StatelessWidget {
  const GFAlert({
    super.key,
    required this.title,
    required this.body,
    required this.buttonTitle,
  });

  final String title;
  final String body;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.white, // Set your desired border color here
          width: 2.0, // Set the border width
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: Text(
        body,
        textAlign: TextAlign.center,
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      actions: [
        Row(
          children: [
            Expanded(
              child: GFButton(
                title: buttonTitle,
                color: Colors.pink,
                height: 36,
                onPressed: () => AppRouter.of(context).pop(),
              ),
            )
          ],
        )
      ],
    );
  }
}
