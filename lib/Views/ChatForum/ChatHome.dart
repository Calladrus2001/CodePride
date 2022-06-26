import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizza100/Widgets/ChatBubble.dart';
import 'package:pizza100/constants.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({Key? key}) : super(key: key);

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  final messageController = new TextEditingController();
  bool isAvailable = false;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> journalStream = FirebaseFirestore.instance
      .collection('Chat')
      .orderBy("Timestamp")
      .snapshots();

  CollectionReference entries = FirebaseFirestore.instance.collection('Chat');

  @override
  void initState() {
    if (journalStream != null && entries != null) {
      setState(() {
        isAvailable = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.87,
              child: StreamBuilder(
                stream: journalStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(color: clr1));
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return ChatBubble().buildBubble(
                            data["User"], data["Message"], data["Category"]);
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 35),
            Container(
              child: ListTile(
                title: Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: Color(0xffF2F4F6),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                        hintText: "Send Message",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none),
                    cursorColor: clr1,
                  ),
                ),
                trailing: GestureDetector(
                  child: Icon(Icons.send_outlined, color: clr1),
                  onTap: () {
                    setState(() {
                      entries
                          .add({
                            "Message": messageController.text,
                            "User": FirebaseAuth.instance.currentUser!.email,
                            "Category": 1,
                            "Timestamp": Timestamp.now(),
                          })
                          .then((value) => print("Entry Added"))
                          .catchError(
                              (error) => print("Failed to add entry: $error"));
                    });
                    messageController.text = "";
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget chat(String message, int data) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? Container(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundColor: clr1,
                    child: Text("Rei", style: TextStyle(color: Colors.white)),
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Bubble(
                borderWidth: data == 0 ? 1 : 0,
                borderColor: clr1,
                radius: Radius.circular(15.0),
                color: data == 0 ? Colors.white : clr1,
                elevation: 0.0,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                          child: Container(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Text(
                          message,
                          style: data == 0
                              ? TextStyle(
                                  color: clr1, fontWeight: FontWeight.bold)
                              : TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                )),
          ),
          data == 1
              ? Container(
                  child: CircleAvatar(
                    minRadius: 30,
                    child: CircleAvatar(
                      minRadius: 29,
                      backgroundColor: Colors.white,
                      child: Text("You", style: TextStyle(color: clr1)),
                    ),
                    backgroundColor: clr1,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
