import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fspotify/pages/signin.dart';
import 'package:fspotify/pages/signup.dart';
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFAEE5D0),
      body: Center(
        child:Stack(
          children: [
            Image.asset("assets/images/bg.png"),
            
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 3),
              child: Column(children: [
                
                  const SizedBox(height: 90),
                  
                  Image.asset('assets/images/logo.png',width: 180 ,),
                  const Text('FollowMe',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900),),
                  
                        
                Image.asset("assets/images/welcomeBoy.gif"),
                
                
                        
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Signin()
                                  )
                                );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFAEE5D0),
                    minimumSize: const Size(200, 60),
                    elevation: 50
                    ), 
                  child: const Text('SIGN IN',style: TextStyle(fontSize: 25, ),),
                ),
                        
                const SizedBox(height: 40,),
                        
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const signup()
                                  )
                                );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 53, 99, 164),
                    minimumSize: const Size(200, 60),
                    elevation: 50
                    ), 
                  child: const Text('SIGN UP',style: TextStyle(fontSize: 25, ),),
                ),
                
              ],),
            )
          ],
        ) )
        )
          
        
      ;
    
  }
}