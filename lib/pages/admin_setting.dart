import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AdminSttings extends StatefulWidget {
  const AdminSttings({super.key});

  @override
  State<AdminSttings> createState() => _AdminSttingsState();
}

class _AdminSttingsState extends State<AdminSttings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: const [
          Icon(Icons.app_registration)
        ]),
      )  
    );
  }
}