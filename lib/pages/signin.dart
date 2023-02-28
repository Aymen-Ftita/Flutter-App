import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fspotify/pages/reset_password.dart';
import 'package:fspotify/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool show = true;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 46, 85, 139),
      body: Stack(
        children: [
          Image.asset('assets/images/bg.png'),
          Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(
                  color: Color(0xFFAEE5D0),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 2),
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                          padding:
                              const EdgeInsets.only(top: 40, left: 12, right: 12),
                          child: Container(
                            width: MediaQuery.of(context).size.height * 0.4,
                            height: MediaQuery.of(context).size.height * 0.7,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 40,
                                ),
                                Image.asset(
                                  'assets/icons/login2.gif',
                                  width: 90,
                                  height: 60,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 46, 85, 139),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 60,
                                ),
                                  TextField(
                                  onChanged: (v) => email = v,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.email, size: 24),
                                    hintText: '  Email',
                                  ),
                                ),
                                const SizedBox(
                                  height: 35,
                                ),
                                TextField(
                                  onChanged: (value) => password=value,
                                  obscureText: show,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock, size: 24),
                                    suffix: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            show = !show;
                                          });
                                        },
                                        icon: Icon(show
                                            ? Icons.visibility_rounded
                                            : Icons.visibility_off_rounded)),
                                    hintText: '  Password',
                                  ),
                                ),
                                TextButton(
                                    onPressed: (()  {
                                      
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const ResetPass()));
                                      
                                      
                                    }),
                                    child: const Text("Forget your password ?",
                                        style:
                                            TextStyle(color: Color.fromARGB(255, 46, 85, 139)))),
                                const SizedBox(
                                  height: 40,
                                ),
                                Container(
                                    width: 170,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 46, 85, 139),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextButton(
                                      onPressed: () async {
                                          try{
                                            final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                                            // ignore: unnecessary_null_comparison
                                            if(user!=null){
                                              // ignore: use_build_context_synchronously, avoid_print
                                              print(email + password);
                                              // ignore: use_build_context_synchronously
                                              Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomePage()));
                                            }else{
                                              
                                            }
                                          }catch(e){print(e);}
                                          
                                        
                                    },
                                      child: const Text("SignIn",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                          )),
                                    )),
                              ],
                            ),
                          )),
            
                      // ignore: prefer_const_constructors
                      Padding(
                          padding: const EdgeInsets.only(
                            top: 60,
                            left: 12,
                            right: 12,
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Don't have an account ?",
                                  style: TextStyle(color: Color(0xFFf7ece1)),
                                ),
                                TextButton(
                                    onPressed: () {
                                      
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const signup()));
                                    },
                                    child: const Text(
                                      "Signup",
                                      style: TextStyle(
                                          color: Color(0xFFAEE5D0), fontSize: 20),
                                    ))
                              ])),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
