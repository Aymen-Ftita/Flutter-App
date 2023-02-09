import 'package:flutter/material.dart';
import 'package:fspotify/pages/reset_password.dart';
import 'package:fspotify/pages/signin.dart';

import 'home_page.dart';

// ignore: camel_case_types
class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

// ignore: camel_case_types
class _signupState extends State<signup> {
  bool show = true;
  bool Not_match = false;
  bool Vemail = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _pass1 = TextEditingController();
  TextEditingController _pass2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
      appBar: AppBar(backgroundColor:Color(0xFF8d86c9)),
      drawer: Drawer(),
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
                      padding: const EdgeInsets.only(top: 20,left: 12,right: 12),
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
                            
                              Image.network('https://cdn2.iconfinder.com/data/icons/user-interface-outlined-2020/48/create_new_account-512.png',width: 90,height: 80,),
                              Text("Registration",
                                style: TextStyle(
                                  color: Color(0xFF8d86c9),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              
                            SizedBox(height: 20,),


                            TextField(
                              controller: _email,
                              decoration: InputDecoration(
                                
                                prefixIcon: Icon(Icons.email, size: 24),
                                
                                hintText: '  Email',
                              ),
                            ),

                            SizedBox(height: 20,),

                            
                              
                                
                                    
                            TextField(
                              controller: _pass1,      
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

                            TextField(
                              controller: _pass2,      
                              obscureText: show,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock, size: 24),
                                suffix: IconButton(onPressed: (){ 
                                          setState(() { 
                                              show = !show;
                                          });
                                  }, icon: Icon(show ?Icons.visibility_rounded:Icons.visibility_off_rounded)),
                                hintText: ' Confirm Password',
                              ),
                            ),
                            Visibility(visible: Not_match,child: Row(
                              children: [Icon(Icons.warning,),Text("password fields deosn't match",),]
                            )),
                            Visibility(visible: Vemail,child: Row(
                              children: [Icon(Icons.warning,),Text("Email field is empty",),]
                            )),
                            

                                 
                              
                            
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

                                  setState(() {


                                    if(_email.text!=''){
                                      Vemail=false;
                                      if(_pass1.text==_pass2.text){
                                        
                                        Not_match=false;
                                        Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()));
                                      }else{
                                        Not_match=true;
                                      }
                                    }else{
                                      Vemail=true;
                                    }

                                  });
                                  
                                } ,
                                child: 
                                  Text("SignUp",
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
                      padding:const EdgeInsets.only(top: 30,left: 12,right: 12,),
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                        children:[
                          
                          Text(
                            "you have an account ?",
                            style: TextStyle(color:Color.fromARGB(255, 255, 255, 255)),
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context) => Signin()));
                            } , 
                            child: const Text("SignIn",style: TextStyle(color: Color(0xFF242038),fontSize: 20),)
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
    ));
  }
}