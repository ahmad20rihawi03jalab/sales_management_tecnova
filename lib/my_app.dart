import 'package:flutter/material.dart';
import 'bottom_bar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),

      // 2. إعدادات الثيم الداكن (Dark Mode)
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.blueAccent,
      ),

      // 3. تحديد أي ثيم يتم استخدامه
      themeMode: ThemeMode.dark,
      home: const Bottombar(),
    );
  }
}
