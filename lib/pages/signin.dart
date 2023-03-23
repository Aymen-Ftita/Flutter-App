import 'dart:ui';




import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  bool v=false;

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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                  
                                    onChanged: (v) => email = v,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      
                                      prefixIcon: Icon(Icons.email, size: 24),
                                      hintText: '  Email',
                                      border: OutlineInputBorder(
                                        borderRadius:BorderRadius.all(Radius.circular(6.0)) ,
                                      )
                                    ),
                                    
                                  ),
                                  ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    
                                    onChanged: (value) => password=value,
                                    obscureText: show,
                                    decoration: InputDecoration(
                                      contentPadding:const EdgeInsets.all(7.0),
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
                                      // ignore: prefer_const_constructors
                                      border: OutlineInputBorder(
                                          borderRadius:const BorderRadius.all(Radius.circular(6.0)) ,
                                        )
                                    ),
                                  ),
                                ),
                                TextButton(
                                    onPressed: (() async {
                                      
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const ResetPass()));
                                          
                                      
                                      
                                    }),
                                    child: const Text("Forget your password ?",
                                        style:
                                            TextStyle(color: Color.fromARGB(255, 46, 85, 139)))),
                                const SizedBox(
                                  height: 35,
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
                                          setState(() {
                                            v=true;
                                          });
                                          try{
                                            final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                                            // ignore: unnecessary_null_comparison
                                            if(user!=null){
                                              // ignore: use_build_context_synchronously, avoid_print
                                              print(email + password);
                                              final userr = FirebaseAuth.instance.currentUser;

                                            if(userr?.emailVerified==false){

                                              // ignore: avoid_print
                                              print(userr?.emailVerified);
                                              // ignore: use_build_context_synchronously
                                              AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.warning,
                                            headerAnimationLoop: false,
                                            animType: AnimType.bottomSlide,
                                            title: 'Email Verrification required',
                                            desc: 'We sent you an email , please verify you email adress',
                                            buttonsTextStyle: const TextStyle(color: Color.fromARGB(255, 46, 85, 139),fontSize: 20),
                                            showCloseIcon: true,
                                            btnOkColor: const Color(0xFFAEE5D0),
                                            btnOkOnPress: () {},
                                          ).show();

                                              await userr?.sendEmailVerification();

                                            }else{

                                              final firestore= FirebaseFirestore.instance;

                                              await firestore.collection('users').add({
                                                  'Uid': _auth.currentUser?.uid,
                                                  'admin':false,
                                                  'email':email,
                                                  'nom':'inconnue',
                                                  'prenom':'inconnue',
                                                  'qrcode': "",
                                                  'token':""                   
                                                });
                                              
                                              // ignore: use_build_context_synchronously
                                              Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomePage()));
                                            }
                                          
                                            
                                            setState(() {
                                              v=false;
                                            });

                                            }
                                          // ignore: avoid_print
                                          }catch(e){
                                            AwesomeDialog(
                                            dialogBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
                                            context: context,
                                            dialogType: DialogType.error,
                                            headerAnimationLoop: false,
                                            animType: AnimType.topSlide,
                                            title: "User deosn't exist",
                                            desc: 'Email or Password Incorrect',
                                            buttonsTextStyle: const TextStyle(color: Color.fromARGB(255, 46, 85, 139),fontSize: 20),
                                            showCloseIcon: true,
                                            btnOkColor: const Color(0xFFAEE5D0),
                                            btnOkOnPress: () {
                                              setState(() {
                                              v=false;
                                            });},
                                          ).show();

                                          
                                            // ignore: avoid_print
                                            print(e);}
                                          
                                        
                                    },
                                      child: const Text("SignIn",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                          )),
                                    )),

                                    const SizedBox(
                                    height: 5,
                                    ),

                                    Container(
                                    width: 170,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 46, 85, 139),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextButton(
                                      onPressed: (){},
                                      child: IconButton(icon: const Icon(Icons.social_distance), onPressed: ()  { 
                                        
                                        // ignore: avoid_print
                                        
                                      },)
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
          ),
          Center(child: Visibility(visible: v,child:   const CircularProgressIndicator(color:Color.fromARGB(255, 46, 85, 139),backgroundColor:Color(0xFFAEE5D0)  ,),)),
          
        ],
      ),
    );
  }
}
