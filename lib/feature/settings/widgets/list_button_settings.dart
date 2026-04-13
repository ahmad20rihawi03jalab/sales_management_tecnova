// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ListButtonSettings extends StatelessWidget {
  Color color = const Color(0xFF121212);

  ListButtonSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      color: color,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            child: Row(
              children: [
                Icon(Icons.edit, color: Color(0xff7373d7)),
                SizedBox(width: 10),
                Text(
                  "Edit Profile",
                  style: TextStyle(
                    color: Color(0xff7373d7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            child: Row(
              children: [
                Icon(Icons.credit_card, color: Color(0xff7373d7)),
                SizedBox(width: 10),
                Text(
                  "Payment History",
                  style: TextStyle(
                    color: Color(0xff7373d7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            child: Row(
              children: [
                Icon(Icons.key, color: Color(0xff7373d7)),
                SizedBox(width: 10),
                Text(
                  "Security",
                  style: TextStyle(
                    color: Color(0xff7373d7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            child: Row(
              children: [
                Icon(Icons.settings, color: Color(0xff7373d7)),
                SizedBox(width: 10),
                Text(
                  "Settings",
                  style: TextStyle(
                    color: Color(0xff7373d7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Color(0xff7373d7)),
                SizedBox(width: 10),
                Text(
                  "Help Center",
                  style: TextStyle(
                    color: Color(0xff7373d7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            child: Row(
              children: [
                Icon(Icons.logout, color: Colors.red),
                SizedBox(width: 10),
                Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
