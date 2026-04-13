import 'package:flutter/material.dart';
import 'bottom_bar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xff121212),
        primaryColor: const Color(0xff7373d7),
      ),
      themeMode: ThemeMode.dark,
      home: const Bottombar(),
    );
  }
}
