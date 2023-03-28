import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fspotify/pages/signin.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;

  String? messageText;
  final messageT = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        // ignore: avoid_print
        print(signedInUser.email);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void messageStreams() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        // ignore: avoid_print
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 46, 85, 139),
        title: Row(
          children: const [
            //Image.asset('images/logo.png', height: 25),
            SizedBox(width: 10),
            Text('MessageBox')
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Signin()));
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MessageStreamBuilder(),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFAEE5D0),
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageT,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': signedInUser.email,
                        'reported': false,
                        'time': FieldValue.serverTimestamp(),
                      });
                      setState(() {
                        messageT.clear();
                      });
                    },
                    // ignore: prefer_const_constructors
                    child: Text(
                      'send',
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        color: const Color.fromARGB(255, 46, 85, 139),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<MessageLine> messageWidgets = [];

        if (!snapshot.hasData) {
          return const Center(
              child: CircularProgressIndicator(
            color: Color.fromARGB(255, 46, 85, 139),
            backgroundColor: Color(0xFFAEE5D0),
          ));
        }

        final messages = snapshot.data!.docs.reversed;

        for (var message in messages) {
          final messageText = message.get('text');
          final messgaeSender = message.get('sender');
          final rep = message.get('reported');

          final currentUser = signedInUser.email;

          if (currentUser == messgaeSender) {}

          final messageWidget = MessageLine(
              sender: messgaeSender,
              text: messageText,
              isMe: currentUser == messgaeSender,
              rep: rep);
          messageWidgets.add(messageWidget);
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine(
      {required this.rep,
      this.text,
      this.sender,
      required this.isMe,
      super.key});

  final String? text;
  final String? sender;
  final bool isMe;
  final bool rep;

  void report() {
    _firestore.collection('messages').doc(sender).set({
      'text': text,
      'sender': sender,
      'reported': true,
      'time': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style: const TextStyle(fontSize: 12, color: Colors.black45),
          ),
          GestureDetector(
            onLongPress: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                headerAnimationLoop: false,
                animType: AnimType.bottomSlide,
                title: 'Do you want to report this Message?',
                desc: 'Pleaze Make Sure Your Request! ',
                buttonsTextStyle: const TextStyle(
                    color: Color.fromARGB(255, 46, 85, 139), fontSize: 20),
                showCloseIcon: true,
                btnOkColor: const Color(0xFFAEE5D0),
                btnOkOnPress: report,
                btnCancelOnPress: () {},
              ).show();
            },
            child: Material(
                elevation: 5,
                borderRadius: isMe
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )
                    : const BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                color: isMe
                    ? const Color.fromARGB(255, 46, 85, 139)
                    : const Color.fromARGB(255, 255, 255, 255),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: rep
                      ? Text(
                          '$text (This message was reported )',
                          style:
                              const TextStyle(color: Colors.red, fontSize: 15),
                        )
                      : Text(
                          '$text',
                          style: TextStyle(
                              color: isMe ? Colors.white : Colors.black87,
                              fontSize: 15),
                        ),
                )),
          ),
        ],
      ),
    );
  }
}
