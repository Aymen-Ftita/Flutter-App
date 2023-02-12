import 'package:flutter/material.dart';
import 'package:fspotify/pages/reset_password.dart';
import 'package:fspotify/pages/signup.dart';

import 'home_page.dart';


class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool show = true;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      
      
      backgroundColor: Color(0xFF8d86c9),
      body:Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.6,
            decoration: const BoxDecoration(
              color: Color(0xFFcac4ce),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight:  Radius.circular(20),
              )
            )
            
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child:Column(
              children: [
                Column(
                    
                  children: [
                    
                    Padding(
                      padding: const EdgeInsets.only(top: 40,left: 12,right: 12),
                      child: Container(
                        width: MediaQuery.of(context).size.height * 0.4,
                        height: MediaQuery.of(context).size.height * 0.7,
                        decoration: BoxDecoration(
                          color: Color(0xFFf7ece1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          
                          children:  [
                            SizedBox(height: 40,),
                            
                              Image.network('http://cdn.onlinewebfonts.com/svg/img_515258.png',width: 90,height: 60,),
                              SizedBox(height: 10,),
                              Text("Login",
                                style: TextStyle(
                                  color: Color(0xFF8d86c9),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              
                            SizedBox(height: 60,),


                            TextField(
                              decoration: InputDecoration(
                                
                                prefixIcon: Icon(Icons.email, size: 24),
                                
                                hintText: '  Email',
                              ),
                            ),

                            SizedBox(height: 35,),

                            
                              
                                
                                    
                            TextField(
                                    
                              obscureText: show,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock, size: 24),
                                suffix: IconButton(onPressed: (){ 
                                          setState(() { 
                                              show = !show;
                                          });
                                  }, icon: Icon(show ?Icons.visibility_rounded:Icons.visibility_off_rounded)),
                                hintText: '  Password',
                              ),
                            ),
                                  
                              
                            TextButton(onPressed: (() {
                              Navigator.push(context,MaterialPageRoute(builder: (context) => ResetPass()));
                            }), child: Text("Forget your password ?",style: TextStyle(color:Color(0xFF242038 )))),
                            
                            SizedBox(height: 40,),

                            Container(
                              
                              width: 170,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Color(0xFF8d86c9),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()));
                                } ,
                                child: 
                                  Text("SignIn",
                                    style: 
                                      TextStyle(
                                        color: Color(0xFFf7ece1),
                                        fontSize: 25,
                                        )
                                ),
                              )
                            ),
                            
                          ],
                        ),
                      )
                    ),

                    // ignore: prefer_const_constructors
                    Padding(
                      padding:const EdgeInsets.only(top: 60,left: 12,right: 12,),
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                        children:[
                          
                          Text(
                            "Don't have an account ?",
                            style: TextStyle(color:Color(0xFFf7ece1)),
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context) => signup()));
                            } , 
                            child: const Text("Signup",style: TextStyle(color: Color(0xFF242038),fontSize: 20),)
                          )
                       ]
                      )  
                    ),
                  ],
                ),
              ],
            ),
          
      )],
      ) ,
    );
  }
}
  
