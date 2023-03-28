


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fspotify/pages/admin.dart';
import 'package:fspotify/pages/home_page.dart';
import 'package:fspotify/pages/map_screen.dart';
import 'package:fspotify/pages/profile_screen.dart';

import 'package:fspotify/pages/signin.dart';
import 'package:fspotify/pages/test.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  

  final _auth = FirebaseAuth.instance;
  var page;

  splach(){
    if(_auth.currentUser != null){
      return const HomePage();
    }else{
      return const Signin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FollowMe',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: splach() /*_auth.currentUser != null ? const HomePage() : const Signin(),splach(),*/
    );
  }
}


