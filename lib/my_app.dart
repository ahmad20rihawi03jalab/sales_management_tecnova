import 'package:flutter/material.dart';
import 'bottom_bar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(themeMode: ThemeMode.dark, home: const Bottombar());
  }
}
