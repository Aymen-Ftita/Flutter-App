import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fspotify/pages/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: camel_case_types
class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

// ignore: camel_case_types
class _signupState extends State<signup> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String pass;
  late String email;
  bool show = true;
  // ignore: non_constant_identifier_names
  bool Not_match = false;
  // ignore: non_constant_identifier_names
  bool Vemail = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass1 = TextEditingController();
  final TextEditingController _pass2 = TextEditingController();

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
                          padding: const EdgeInsets.only(
                              top: 40, left: 12, right: 12),
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
                                  'assets/icons/signup.gif',
                                  width: 90,
                                  height: 80,
                                ),

                                // ignore: prefer_const_constructors
                                Text(
                                  "Registration",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 46, 85, 139),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),

                                const SizedBox(
                                  height: 40,
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (value) => {email = value},
                                    controller: _email,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.email, size: 24),
                                        hintText: '  Email',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.0)),
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    onChanged: (value) => {pass = value},
                                    controller: _pass1,
                                    obscureText: show,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(7.0),
                                        prefixIcon:
                                            const Icon(Icons.lock, size: 24),
                                        suffix: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                show = !show;
                                              });
                                            },
                                            icon: Icon(show
                                                ? Icons.visibility_rounded
                                                : Icons
                                                    .visibility_off_rounded)),
                                        hintText: '  Password',
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.0)),
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _pass2,
                                    obscureText: show,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(7.0),
                                        prefixIcon:
                                            const Icon(Icons.lock, size: 24),
                                        suffix: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                show = !show;
                                              });
                                            },
                                            icon: Icon(show
                                                ? Icons.visibility_rounded
                                                : Icons
                                                    .visibility_off_rounded)),
                                        hintText: ' Confirm Password',
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.0)),
                                        )),
                                  ),
                                ),

                                Visibility(
                                    visible: Not_match,
                                    child: Row(children: const [
                                      Icon(
                                        Icons.warning,
                                      ),
                                      Text(
                                        "password fields deosn't match",
                                      ),
                                    ])),

                                Visibility(
                                    visible: Vemail,
                                    child: Row(children: const [
                                      Icon(
                                        Icons.warning,
                                      ),
                                      Text(
                                        "Email field is empty",
                                      ),
                                    ])),
                                const SizedBox(
                                  height: 40,
                                ),
                                Container(
                                    width: 170,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 46, 85, 139),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextButton(
                                      onPressed: () async {
                                        if (_email.text != '') {
                                          setState(() {
                                            Vemail = false;
                                          });
                                          if (_pass1.text == _pass2.text) {
                                            setState(() {
                                              Not_match = false;
                                            });
                                            try {
                                              await _auth
                                                  .createUserWithEmailAndPassword(
                                                      email: email,
                                                      password: pass);

                                              final firestore =
                                                  FirebaseFirestore.instance;

                                              /*await firestore.collection('users').add({
                                                  'Uid': _auth.currentUser?.uid,
                                                  'admin':false,
                                                  'email':email,
                                                  'nom':'inconnue',
                                                  'prenom':'inconnue',
                                                  'qrcode': "",
                                                  'token':""                   
                                                });*/

                                              await firestore
                                                  .collection('users')
                                                  .doc(_auth.currentUser?.uid)
                                                  .set({
                                                'Uid': _auth.currentUser?.uid,
                                                'admin': false,
                                                'email': email,
                                                'nom': 'inconnue',
                                                'prenom': 'inconnue',
                                                'profile_img': '',
                                                'qrcode': "",
                                                'token': ""
                                              });

                                              // ignore: use_build_context_synchronously
                                              AwesomeDialog(
                                                dialogBackgroundColor:
                                                    const Color.fromARGB(
                                                        255, 255, 255, 255),
                                                context: context,
                                                dialogType: DialogType.success,
                                                headerAnimationLoop: false,
                                                animType: AnimType.topSlide,
                                                title: 'Regestration succes',
                                                desc:
                                                    'Please try to SignIn to verify your email',
                                                buttonsTextStyle:
                                                    const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 46, 85, 139),
                                                        fontSize: 20),
                                                showCloseIcon: true,
                                                btnOkColor:
                                                    const Color(0xFFAEE5D0),
                                                btnOkOnPress: () {
                                                  Navigator.pop(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Signin()));
                                                },
                                              ).show();
                                              // ignore: use_build_context_synchronously
                                              /*Navigator.pop(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                            const Signin()));*/
                                              // ignore: avoid_print
                                            } on FirebaseAuthException catch (e) {
                                              if (e.code ==
                                                  'email-already-in-use') {
                                                AwesomeDialog(
                                                  dialogBackgroundColor:
                                                      const Color.fromARGB(
                                                          255, 255, 255, 255),
                                                  context: context,
                                                  dialogType: DialogType.info,
                                                  headerAnimationLoop: false,
                                                  animType: AnimType.topSlide,
                                                  title: 'Email Already In Use',
                                                  desc:
                                                      'Try to Reset Your Password',
                                                  buttonsTextStyle:
                                                      const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 46, 85, 139),
                                                          fontSize: 20),
                                                  showCloseIcon: true,
                                                  btnOkColor:
                                                      const Color(0xFFAEE5D0),
                                                  btnOkOnPress: () {
                                                    Navigator.pop(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const Signin()));
                                                  },
                                                ).show();
                                              }
                                              // ignore: avoid_print
                                              print(e.code);
                                            }
                                            // ignore: avoid_print
                                            print(email);
                                            // ignore: avoid_print
                                            print(pass);
                                          } else {
                                            setState(() {
                                              Not_match = true;
                                            });
                                          }
                                        } else {
                                          setState(() {
                                            Vemail = true;
                                          });
                                        }
                                      },
                                      child: const Text("SignUp",
                                          style: TextStyle(
                                            color: Color(0xFFf7ece1),
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
                                  "you have an account ?",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Signin()));
                                    },
                                    child: const Text(
                                      "SignIn",
                                      style: TextStyle(
                                          color: Color(0xFFAEE5D0),
                                          fontSize: 20),
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
