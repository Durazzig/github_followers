import 'package:flutter/material.dart';
import 'package:github_followers/features/home/home_screen.dart';
import 'package:github_followers/ui/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: ThemeMode.system,
      // initialRoute: '/',
      // routes: {
      //   '/home': (context) => const HomeScreen(),
      //   '/profile': (context) => const ProfileScreen(),
      // },
      home: const HomeScreen(),
    );
  }
}
