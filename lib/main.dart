import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_followers/features/search/domain/follower.dart';
import 'package:github_followers/managers/followers_manager.dart';
import 'package:github_followers/managers/persistence_manager.dart';
import 'package:github_followers/my_app.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(FollowerAdapter());
  followersBox = await Hive.openBox<Follower>('followersBox');
  PersistenceManager();
  runApp(const ProviderScope(child: MyApp()));
}
