import 'package:flutter/material.dart';


class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {


  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Text('data')
      ),
    );
  }
}

