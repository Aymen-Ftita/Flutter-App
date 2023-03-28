import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class reportedMessages extends StatefulWidget {
  const reportedMessages({super.key});

  @override
  State<reportedMessages> createState() => _reportedMessagesState();
}

// ignore: camel_case_types
class _reportedMessagesState extends State<reportedMessages> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('messages').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                child: data['reported'] == true
                    ? Column(
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: Icon(
                                  Icons.message_outlined,
                                  size: 50,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Text('sender : ${data['sender']}'),
                                  Scrollbar(
                                      child: Text('message : ${data['text']}'))
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    // ignore: no_leading_underscores_for_local_identifiers
                                    final _firestore =
                                        FirebaseFirestore.instance;
                                    AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.info,
                                            headerAnimationLoop: false,
                                            animType: AnimType.bottomSlide,
                                            title:
                                                'Are you sure you want to delete this user',
                                            desc: "Email : ${data['sender']}",
                                            buttonsTextStyle: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 46, 85, 139),
                                                fontSize: 20),
                                            showCloseIcon: true,
                                            btnOkColor: const Color(0xFFAEE5D0),
                                            btnOkOnPress: () {
                                              _firestore
                                                  .collection('messages')
                                                  .doc(data['sender'])
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
                      )
                    : const SizedBox(),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
