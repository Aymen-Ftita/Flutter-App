import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int index = 3;
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text('hello'),
    ));
  }
}
