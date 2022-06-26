import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza100/Views/ChatForum/ChatHome.dart';
import 'package:pizza100/Views/News/news.dart';
import 'package:pizza100/Views/Report/Home.dart';
import 'package:pizza100/constants.dart';

class ReportOrChat extends StatelessWidget {
  const ReportOrChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout_outlined, color: clr1),
        backgroundColor: Colors.white,
        onPressed: () {
          FirebaseAuth.instance.signOut();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 120),
                  decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent.shade100,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35))),
                ),
                Container(
                  child: Center(
                      child: Column(
                    children: [
                      Text("Where To?",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                      SizedBox(height: 10)
                    ],
                  )),
                  padding: EdgeInsets.only(top: 70),
                  decoration: BoxDecoration(
                      color: clr1,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                ),
                Container(
                  padding: EdgeInsets.only(top: 60),
                  decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent.shade100,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35))),
                )
              ],
            ),
            SizedBox(height: 32),
            Center(
              child: SizedBox(
                  height: 15,
                  width: 30,
                  child: Image(image: AssetImage("assets/images/flag.png"))),
            ),
            SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  GestureDetector(
                    child: Container(
                      height: 200,
                      width: 180,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Image(
                          image: AssetImage("assets/images/report.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    onTap: () {
                      Get.to(() => Home());
                    },
                  ),
                  SizedBox(width: 12),
                  GestureDetector(
                    child: Container(
                      height: 200,
                      width: 180,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Image(
                          image: AssetImage("assets/images/social.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    onTap: () {
                      Get.to(() => ChatHome());
                    },
                  )
                ],
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  GestureDetector(
                    child: Container(
                      height: 200,
                      width: 180,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Image(
                          image: AssetImage("assets/images/News.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    onTap: () {
                      Get.to(() => NewsPage());
                    },
                  ),
                  SizedBox(width: 12),
                  GestureDetector(
                    child: Container(
                      height: 200,
                      width: 180,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Image(
                          image: AssetImage("assets/images/more.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    onTap: () {},
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
