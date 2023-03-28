import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  final _firestore = FirebaseFirestore.instance;
  bool visible = false;
  late String email;
  late String name;
  late String lastname;
  late bool admin;
  // ignore: non_constant_identifier_names
  late String Uid;
  late String nameA = '';
  late String lastnameA = '';
  late String emailA = '';
  late bool adminA = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: data['profile_img'] == ''
                                ? const Icon(
                                    Icons.account_circle,
                                    size: 73,
                                    color: Color(0xFFAEE5D0),
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        NetworkImage('${data['profile_img']}'),
                                    radius: 32,
                                  ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                'Email : ${data['email']}',
                                style: const TextStyle(
                                    color: Colors.blueGrey, fontSize: 10),
                              ),
                              Text(
                                'Uid : ${data['Uid']}',
                                style: const TextStyle(fontSize: 10),
                              )
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  nameA = data['nom'];
                                  lastnameA = data['prenom'];
                                  adminA = data['admin'];
                                  emailA = data['email'];
                                  Uid = data['Uid'];
                                  visible = !visible;
                                });
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Color(0xFFAEE5D0),
                              )),
                          IconButton(
                              onPressed: () {
                                // ignore: no_leading_underscores_for_local_identifiers

                                AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.warning,
                                        headerAnimationLoop: false,
                                        animType: AnimType.bottomSlide,
                                        title:
                                            'Are you sure you want to delete this user',
                                        desc: "Email : ${data['email']}",
                                        buttonsTextStyle: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 46, 85, 139),
                                            fontSize: 20),
                                        showCloseIcon: true,
                                        btnOkColor: const Color(0xFFAEE5D0),
                                        btnOkOnPress: () {
                                          _firestore
                                              .collection('users')
                                              .doc(data['Uid'])
                                              .delete();
                                        },
                                        btnCancelOnPress: () {})
                                    .show();
                                /*_firestore.collection('users').doc(data['Uid']).delete();*/
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        ],
                      ),

                      /*Text("Email : ${data['email']}"),
                        Text("Name : ${data['name']}"),*/
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
        Center(
          child: Visibility(
              visible: visible,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 196, 196, 196),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              visible = !visible;
                            });
                          },
                        )
                      ]),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Email : $emailA'),
                      Text('Name : $nameA'),
                      Text('LastName : $lastnameA'),
                      Text('Admin : $adminA'),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        onChanged: (value) => email = value,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email, size: 24),
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                            )),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextField(
                        onChanged: (value) => name = value,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.account_box, size: 24),
                            hintText: 'Name',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                            )),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextField(
                        onChanged: (value) => lastname = value,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.account_box, size: 24),
                            hintText: 'LastName',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                            )),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextField(
                        onChanged: (value) =>
                            value == 'true' ? admin = true : admin = false,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.admin_panel_settings_rounded,
                                size: 24),
                            hintText: 'Admin (true or False)',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                            )),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextButton(
                          onPressed: () {
                            _firestore.collection('users').doc(Uid).update({
                              'email': email,
                              'nom': name,
                              'prenom': lastname,
                              'admin': admin,
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 46, 85, 139),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  'Save Data',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 196, 196, 196)),
                                ),
                              )))
                    ],
                  ),
                ),
              )),
        )
      ]),
    );
  }
}
