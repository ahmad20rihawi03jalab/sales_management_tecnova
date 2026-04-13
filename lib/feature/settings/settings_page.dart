import 'package:flutter/material.dart';
import 'widgets/profile_header.dart';
import 'widgets/list_button_settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ProfileHeader(fName: "fName", lName: "lName"),
          SizedBox(height: 10),
          ListButtonSettings(),
        ],
      ),
    );
  }
}
