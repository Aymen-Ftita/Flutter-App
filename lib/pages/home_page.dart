import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Center(

           child:Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWQWe7j9kg5TF1kdp8btUiHlS0M69Ru7ufQw&usqp=CAU',width: 300,height: 150,),
            ),
        
      )
    );
  }
}