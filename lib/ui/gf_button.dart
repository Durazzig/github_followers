import 'package:flutter/material.dart';

class GFButton extends StatelessWidget {
  const GFButton(
      {super.key,
      required this.title,
      this.height,
      this.color,
      this.onPressed});
  final String title;
  final double? height;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color ?? Colors.green),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }
}
