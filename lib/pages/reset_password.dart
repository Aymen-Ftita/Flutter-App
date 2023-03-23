import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fspotify/pages/signin.dart';


class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 46, 85, 139),
      body:Stack(
        children: [
          Image.asset('assets/images/bg.png'),
          Container(
            height: MediaQuery.of(context).size.height*0.6,
            decoration: const BoxDecoration(
              color: Color(0xFFAEE5D0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight:  Radius.circular(20),
              )
            )
            
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 2),
              child: Column(
                children: [
                  Column(
                      
                    children: [
                      
                      Padding(
                        padding: const EdgeInsets.only(top: 40,left: 12,right: 12),
                        child: Container(
                          width: MediaQuery.of(context).size.height * 0.4,
                          height: MediaQuery.of(context).size.height * 0.7,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            
                            children:  [
                              const SizedBox(height: 40,),
                                Image.asset('assets/icons/reset.gif',width: 80,height: 80,),
                                const Text("Reset Password",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 46, 85, 139),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                
                              const SizedBox(height: 90,),
            
            
                              TextField(
                                controller: email,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(8.0),
                                  prefixIcon: Icon(Icons.email, size: 24),
                                  
                                  hintText: '  Email',
                                  border:  OutlineInputBorder(
                                          borderRadius:BorderRadius.all(Radius.circular(6.0)) ,
                                        )
                                ),
                              ),
            
                              const SizedBox(height: 35,),
            
                              
                                
                                  
                                      
                              
                                    
                                
                            
                              
                              const SizedBox(height: 40,),
            
                              Container(
                                
                                width: 170,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 46, 85, 139),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: ()async{
                                    try {
                                      FirebaseAuth.instance.sendPasswordResetEmail(email: email.text.trim()).then((value) => {
                                        // ignore: avoid_print
                                        print('Email sent'),
                                        AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.warning,
                                            headerAnimationLoop: false,
                                            animType: AnimType.bottomSlide,
                                            title: 'Email Sent',
                                            desc: 'Please check your email Box to reset paswword',
                                            buttonsTextStyle: const TextStyle(color: Color.fromARGB(255, 46, 85, 139),fontSize: 20),
                                            showCloseIcon: true,
                                            btnOkColor: const Color(0xFFAEE5D0),
                                            btnOkOnPress: () {Navigator.push(context,MaterialPageRoute(builder: (context) => const Signin()));},
                                          ).show()
                                        
                                      });
                                    } on FirebaseAuthException catch(e){
                                      // ignore: avoid_print
                                      print('$e');
                                    }
                                    
                                  } ,
                                  child: 
                                    const Text("Send Email",
                                      style: 
                                        TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          )
                                  ),
                                )
                              ),
                              const SizedBox(height: 40,),
                              const Icon(Icons.message_sharp),
                              const Text("Verification code will send to your mail",style: TextStyle(color:Color(0xFF242038 ),fontSize: 18),)
                            ],
                          ),
                        )
                      ),
            
                      // ignore: prefer_const_constructors
                      Padding(
                        padding:const EdgeInsets.only(top: 60,left: 12,right: 12,),
                        child: 
                        Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                          children:
                          [
                            
                            const Text(
                              " have an account ?",
                              style: TextStyle(color:Color(0xFFf7ece1)),
                            ),
                            TextButton(
                              onPressed: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context) => const Signin()));
                              } , 
                              child: const Text("SignIn",style: TextStyle(color: Color(0xFFAEE5D0),fontSize: 20),),
                            )
                        ]
                        )  
                      ),
                    ],
                  ),
                ],
              ),
            ),
          
      )],
      ) ,
    );  
  }
}