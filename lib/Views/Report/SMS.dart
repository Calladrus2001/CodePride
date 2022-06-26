import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:pizza100/Services/Geolocation.dart';
import 'package:pizza100/Services/SendSMS.dart';
import 'package:pizza100/constants.dart';
import '../../Services/DecodingSpeech.dart';

class SMS extends StatefulWidget {
  const SMS({Key? key}) : super(key: key);

  @override
  State<SMS> createState() => _SMSState();
}

class _SMSState extends State<SMS> {
  String args = Get.arguments;
  final box = GetStorage();
  late Map<String, String> decoded;
  var abuser;
  var armed;
  var med;
  var kid;
  var close;
  bool haveLocation = false;
  var location;
  late Position _pos;

  CollectionReference entries = FirebaseFirestore.instance.collection('Chat');

  void addAlertEntry() {
    entries
        .add({
          "Message":
              "~~ALERT!~~\nNumber of Aggressors: $abuser\nArmed?: $armed\nNeed Medical Aid: $med\nIn Pursuit?: $kid\nIn close proximity? : $close",
          "User": FirebaseAuth.instance.currentUser!.email,
          "Category": 2,
          "Timestamp": Timestamp.now(),
        })
        .then((value) => print("Entry Added"))
        .catchError((error) => print("Failed to add entry: $error"));
    entries
        .add({
          "Message": "$location",
          "User": FirebaseAuth.instance.currentUser!.email,
          "Category": 2,
          "Timestamp": Timestamp.now(),
        })
        .then((value) => print("Entry Added"))
        .catchError((error) => print("Failed to add entry: $error"));
  }

  @override
  void initState() {
    decoded = Decoding().decode(args);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 60, 16, 20),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Chip(
                      label: Text("speech-to-text",
                          style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.deepOrangeAccent,
                    ),
                  ),
                  const SizedBox(height: 8),

                  /// Text from previous screen
                  Card(
                    elevation: 2.0,
                    child: Scrollbar(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 150,
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: TextHighlight(
                            text: args.toLowerCase(),
                            words: highlights,
                            textStyle: const TextStyle(
                              fontSize: 26.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Chip(
                      label: Text("SMS", style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.deepOrangeAccent,
                    ),
                  ),
                  const SizedBox(height: 8),

                  /// SMS Preview and editing
                  Card(
                    elevation: 2.0,
                    child: Scrollbar(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 150,
                        width: double.infinity,
                        child: SingleChildScrollView(
                            child: Column(
                          children: [
                            const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "~~ Code:Pride ALERT! ~~\n",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                )),
                            Decoding().getAbuser(decoded, abuser),
                            Decoding().getArmedStatus(decoded, armed),
                            Decoding().getMedical(decoded, med),
                            Decoding().getMinors(decoded, kid),
                            Decoding().getProximity(decoded, close),
                            haveLocation
                                ? Row(
                                    children: const [
                                      Text("Location: ",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 22)),
                                      SizedBox(width: 8),
                                      Icon(Icons.check, color: Colors.green)
                                    ],
                                  )
                                : Row(
                                    children: [
                                      const Text("Location: ",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 20)),
                                      TextButton(
                                        child: const Chip(
                                            backgroundColor:
                                                Colors.deepOrangeAccent,
                                            label: Text(
                                              "Get Location",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            )),
                                        onPressed: () async {
                                          Position pos = await Location()
                                              .determinePosition();
                                          if (pos.latitude != null) {
                                            location =
                                                "https://www.google.com/maps/dir/?api=1&destination=" +
                                                    Uri.encodeComponent(
                                                        "${pos.latitude}, ${pos.longitude}");
                                            setState(() {
                                              _pos = pos;
                                              haveLocation = true;
                                            });
                                          }
                                        },
                                      )
                                    ],
                                  ),
                          ],
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  /// Send SMS Button
                  GestureDetector(
                    child: const Chip(
                      label: Text("Send SMS",
                          style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.deepOrangeAccent,
                      elevation: 2.0,
                    ),
                    onTap: () {
                      abuser = box.read("abuser");
                      armed = box.read("armed");
                      med = box.read("medical");
                      kid = box.read("minors");
                      close = box.read("proximity");
                      String body =
                          "\n~~Code:Pride ALERT!~~\nNumber of Aggressors: $abuser\nArmed?: $armed\nNeed Medical Aid: $med\nIn Pusruit?: $kid\nMinors Present? : $close\nlocation: $location";
                      // TwilioSMS().sendSMS(body);
                      addAlertEntry();
                      box.erase();
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
