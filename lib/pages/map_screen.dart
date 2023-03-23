import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int index = 1;
  final firestore = FirebaseFirestore.instance; 
  String email = 'aymenftita1@gmail.com';
  @override
  Widget build(BuildContext context) {
    return  const Center(
      child: Text('dara'));
  }
}