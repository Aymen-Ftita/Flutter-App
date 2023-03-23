import 'package:flutter/material.dart';
import 'package:fspotify/pages/settings_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'chat_lobby_screen.dart';

import 'map_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;
  List<StatefulWidget> screens = [
    const MapScreen(),
    const ChatScreen(),
    const Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_literals_to_create_immutables
    return Scaffold(
    
    bottomNavigationBar: CurvedNavigationBar(
    
    height: 50,
    buttonBackgroundColor:const Color(0xFFAEE5D0) ,
    backgroundColor:  Colors.transparent,
    color: const Color(0xFFAEE5D0),
    items: const <Widget>[
      
      Icon(Icons.map, size: 30,color: Color.fromARGB(255, 46, 85, 139),),
      Icon(Icons.chat, size: 30,color: Color.fromARGB(255, 46, 85, 139)),
      Icon(Icons.settings, size: 30,color: Color.fromARGB(255, 46, 85, 139)),
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
