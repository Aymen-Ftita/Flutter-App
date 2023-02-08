import 'package:flutter/material.dart';
import 'package:fspotify/pages/signin.dart';
import 'package:fspotify/pages/signup.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  bool show = true;
  bool Not_match = false;
  TextEditingController _pass1 = TextEditingController();
  TextEditingController _pass2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(),
      backgroundColor: Colors.black,
      body:Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.6,
            decoration: const BoxDecoration(
              color: Colors.blue,
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          
                          children:  [
                            SizedBox(height: 40,),
                            
                            
                              Text("Reset Pass",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              
                            SizedBox(height: 90,),


                            TextField(
                              decoration: InputDecoration(
                                
                                prefixIcon: Icon(Icons.email, size: 24),
                                
                                hintText: '  Email',
                              ),
                            ),

                            SizedBox(height: 35,),

                            
                              
                                
                                    
                            
                                  
                              
                          
                            
                            SizedBox(height: 40,),

                            Container(
                              
                              width: 170,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 1, 0, 0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => Signin()));
                                } ,
                                child: 
                                  Text("Send Email",
                                    style: 
                                      TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        )
                                ),
                              )
                            ),
                            SizedBox(height: 40,),
                            Icon(Icons.message_sharp),
                            Text("New Password will send to your mail",style: TextStyle(color:Colors.blue,fontSize: 18),)
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
                            " have an account ?",
                            style: TextStyle(color:Color.fromARGB(255, 255, 255, 255)),
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context) => Signin()));
                            } , 
                            child: const Text("SignIn"),
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