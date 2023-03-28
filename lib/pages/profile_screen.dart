import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io' as io;

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String dowloadUrl = '';
  XFile myImg = XFile('');
  final storage = FirebaseStorage.instance;

  void pickImage() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          myImg = XFile(image.path);
          uploadImage();
        });
      }
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('image picker err $e');
    }
  }

  void uploadImage() async {
    // ignore: unnecessary_null_comparison
    if (myImg == null) return;
    final filemane = DateTime.now().toString();
    final destination = 'Avatars/$filemane';

    try {
      final ref = FirebaseStorage.instance
          .ref(destination)
          .child('Avatar-${_auth.currentUser?.email}');
      await ref.putFile(io.File(myImg.path));
      setState(() async {
        dowloadUrl = (await ref.getDownloadURL()).toString();
        updateProfileImage();
      });

      print(dowloadUrl);
    } catch (e) {
      // ignore: avoid_print
      print('upload Image err $e');
    }
  }

  void updateProfileImage() async {
    _firestore.collection('users').doc(_auth.currentUser?.uid).update({
      'profile_img': dowloadUrl,
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc('${_auth.currentUser?.uid}').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
              backgroundColor: const Color.fromARGB(255, 46, 85, 139),
              body: Padding(
                padding: const EdgeInsets.only(left: 20, top: 60),
                child: Container(
                  width: MediaQuery.of(context).size.height * 0.4,
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 46, 85, 139),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        GestureDetector(
                            onTap: pickImage,
                            child: data['profile_img'] == '' ? const Icon(Icons.account_circle,size: 150,color:Color(0xFFAEE5D0) ,) : CircleAvatar(
                              backgroundImage:  NetworkImage('${data['profile_img']}'),
                              radius: 80,
                            )  ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${data['nom']} ${data['prenom']}",
                          style: const TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.email_rounded,
                              color: Color(0xFFAEE5D0),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${data['email']}',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                            width: 160,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFFAEE5D0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: const Text("Edit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                  )),
                            )),
                      ],
                    ),
                  ),
                ),
              ));
          ;
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
