import 'package:flutter/material.dart';
import 'feature/settings/settings_page.dart';
import 'feature/history/history_page.dart';
import 'feature/home/home_page.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({super.key});

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int _selectedIndex = 0;

  // الصفحات التي سنعرضها
  final List<Widget> _pages = [
    const HomePage(),
    const HistoryPage(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        child: SizedBox(
          height: 60,
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xff7373d7),
            unselectedItemColor: Colors.grey,

            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),

              BottomNavigationBarItem(
                icon: Icon(Icons.history, size: 22),
                label: "",
              ),

              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
            ],
            showSelectedLabels: false,
            showUnselectedLabels: false,
          ),
        ),
      ),
    );
  }
}
