import 'package:flutter/material.dart';

class AppRouter {
  late NavigatorState navigator;

  AppRouter(BuildContext context) {
    navigator = Navigator.of(context);
  }

  static AppRouter of(BuildContext context) => AppRouter(context);

  Future<Object?> goToScreen(Widget screen) async {
    return await navigator.push(MaterialPageRoute(builder: (_) => screen));
    // await navigator.pushNamed(route, arguments: arguments);
  }

  Future<void> goToScreenAndReplace(Widget screen) async {
    navigator.popUntil((route) => route.isFirst);
    await navigator.pushReplacement(MaterialPageRoute(builder: (_) => screen));
  }

  Future<void> goToScreenAndClear(Widget screen) async {
    await navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => screen),
      (route) => false,
    );
  }

  void popUntilSpecificScreen(BuildContext context, String targetRouteName) {
    Navigator.of(context).popUntil((route) {
      return route.settings.name == targetRouteName;
    });
  }

  void pop() => navigator.pop();

  void popTwice() {
    navigator.pop();
    navigator.pop();
  }

  void popUntil(int count) {
    var temp = 0;
    while (navigator.canPop() && temp < count) {
      navigator.pop();
      temp++;
    }
  }
}
