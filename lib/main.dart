

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fspotify/pages/home_page.dart';

import 'package:fspotify/pages/signin.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FollowMe',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home:  _auth.currentUser != null ? const HomePage() : const Signin(),
    );
  }
}


