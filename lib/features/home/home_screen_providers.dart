import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomBarProvider = StateProvider<int>((ref) => 0);

final pageControllerProvider = Provider<PageController>((ref) {
  return PageController();
});
