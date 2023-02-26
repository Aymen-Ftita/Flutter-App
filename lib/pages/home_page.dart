import 'package:flutter/material.dart';
import 'package:fspotify/pages/signin.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFf7ece1),
          bottomNavigationBar: CurvedNavigationBar(
    backgroundColor: const Color(0xFFf7ece1),
    items: const <Widget>[
      Icon(Icons.home, size: 30),
      Icon(Icons.map, size: 30),
      Icon(Icons.person, size: 30)

    ],
    animationDuration: const Duration(milliseconds: 200),
    onTap: (index) {
      
    },
  ),
      body: Center(
        child: Column(
          children: [
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWQWe7j9kg5TF1kdp8btUiHlS0M69Ru7ufQw&usqp=CAU',
              width: 300,
              height: 150,
            ),
            TextButton(
                onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>  Signin()))
                    },
                child: const Text(
                  "SignOut",
                ))
          ],
        ),
      ),
    ));
  }
}
