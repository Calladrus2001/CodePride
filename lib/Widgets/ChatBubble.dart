import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ChatBubble {
  Future<void> _copyToClipboard(String message) async {
    await Clipboard.setData(ClipboardData(text: message));
    Get.snackbar("Code:Pride", "Copied!");
  }

  Widget buildBubble(String email, String message, int category) {
    Color clr;
    Color txtclr;
    if (category == 1) {
      clr = Color(0xffF2F4F6);
      txtclr = Colors.black;
    } else if (category == 2) {
      clr = Colors.red;
      txtclr = Colors.white;
    } else {
      clr = Colors.lightGreen;
      txtclr = Colors.white;
    }

    return Align(
        alignment: email == FirebaseAuth.instance.currentUser!.email
            ? Alignment.topRight
            : Alignment.topLeft,
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                constraints: BoxConstraints(maxWidth: 220),
                decoration: BoxDecoration(
                    color: clr,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  crossAxisAlignment:
                      email == FirebaseAuth.instance.currentUser!.email
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                  children: [
                    email == FirebaseAuth.instance.currentUser!.email
                        ? Text("You",
                            style: TextStyle(
                                fontSize: 12, color: Colors.deepOrangeAccent))
                        : Text("${email}",
                            style: TextStyle(
                                fontSize: 12, color: Colors.deepOrangeAccent)),
                    Text(message,
                        style: TextStyle(color: txtclr, fontSize: 18)),
                  ],
                ),
              ),
              onLongPress: () {
                _copyToClipboard(message);
              },
            ),
            SizedBox(height: 4)
          ],
        ));
  }
}
