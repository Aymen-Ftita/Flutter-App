import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fspotify/pages/reported_message.dart';
import 'package:fspotify/pages/user_card.dart';

import 'admin_setting.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;
  List<StatefulWidget> screens = [
    const UserInformation(),
    const reportedMessages(),
    const AdminSttings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Screen'),
        backgroundColor: const Color.fromARGB(255, 46, 85, 139),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        buttonBackgroundColor: const Color(0xFFAEE5D0),
        backgroundColor: Colors.transparent,
        color: const Color(0xFFAEE5D0),
        items: const <Widget>[
          Icon(
            Icons.account_circle,
            size: 30,
            color: Color.fromARGB(255, 46, 85, 139),
          ),
          Icon(
            Icons.report, 
            size: 30, 
            color: Color.fromARGB(255, 46, 85, 139)),
          Icon(
            Icons.app_registration,
            size: 30,
            color: Color.fromARGB(255, 46, 85, 139),
          ),
        ],
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 200),
        key: navigationKey,
        index: index,
        onTap: (index) => setState(() => this.index = index),
      ),
      body: screens[index],
    );
  }
}
