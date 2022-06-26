import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza100/Views/Auth.dart';
import 'package:pizza100/Views/Emergency.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pizza100/constants.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  var finalToken;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final introKey = GlobalKey<IntroductionScreenState>();
    return WillPopScope(
      onWillPop: () async => false,
      child: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        globalHeader: Row(
          children: [
            const Expanded(child: SizedBox(width: 1)),
            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
                child: Icon(Icons.warning_amber_rounded, color: Colors.red),
              ),
              onTap: () {
                Get.to(() => const Emergency());
              },
            )
          ],
        ),
        key: introKey,
        showSkipButton: false,
        showBackButton: false,
        dotsDecorator: DotsDecorator(
            activeColor: Colors.deepOrangeAccent.shade100,
            color: Colors.grey.shade300),
        next: const Icon(Icons.arrow_forward_ios_rounded,
            color: Colors.deepOrangeAccent),
        done: const Text("Done",
            style: TextStyle(color: Colors.deepOrangeAccent)),
        onDone: () async {
          // _prefs.setString("token", "true");
          Get.to(() => AuthScreen());
        },
        pages: [
          /// page1
          PageViewModel(
              titleWidget: const Text("Let's go!",
                  style: TextStyle(
                      letterSpacing: 2,
                      color: Colors.deepOrangeAccent,
                      fontSize: 24,
                      fontWeight: FontWeight.w700)),
              bodyWidget: Text(''),
              image: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: 36),
                    const Image(
                      image: AssetImage("assets/images/Pizza.png"),
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 8),
                    Text("Code:Pride",
                        style: TextStyle(
                            color: clr1, letterSpacing: 8, fontSize: 24))
                  ],
                ),
              ),
              decoration: const PageDecoration().copyWith(
                  imageAlignment: Alignment.center,
                  imagePadding: const EdgeInsets.fromLTRB(0, 48, 13, 0),
                  pageColor: Colors.white)),

          /// page2
          PageViewModel(
            titleWidget: const Text("We hear you!",
                style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.w700,
                    fontSize: 24)),
            image: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                  child: CircleAvatar(
                    radius: 71,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 70,
                      child: Icon(
                        Icons.mic_none_rounded,
                        color: Colors.deepOrangeAccent,
                        size: 32,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 24,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 71,
                    backgroundColor: Colors.deepOrange,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 70,
                      child: Icon(
                        Icons.mic,
                        color: Colors.deepOrangeAccent,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bodyWidget: const Text(
              "Tap the button to begin recording, tap it again to stop recording",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),

          /// page3
          PageViewModel(
              image: Container(
                  height: 300,
                  width: 300,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Image(
                      image: AssetImage("assets/images/speech.png"))),
              titleWidget: const Text("Speak in Code!",
                  style: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.w600,
                      fontSize: 24)),
              bodyWidget: Wrap(
                spacing: 8.0,
                children: [
                  Chip(
                    label: const Text("Pizza",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                    backgroundColor: Color(0xffE40303),
                  ),
                  Chip(
                    backgroundColor: Color(0xffFF8C00),
                    label: const Text("Number of Aggressors",
                        style: TextStyle(color: Colors.white)),
                  ),
                  Chip(
                    label: const Text("Pepperoni",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600)),
                    backgroundColor: Color(0xffFFED00),
                  ),
                  Chip(
                    backgroundColor: Color(0xff008026),
                    label: const Text("Aggressors are Armed",
                        style: TextStyle(color: Colors.white)),
                  ),
                  Chip(
                    label: const Text('"Large" Pizza',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                    backgroundColor: Color(0xff004DFF),
                  ),
                  Chip(
                    backgroundColor: Color(0xff750787),
                    label: const Text("Aggressors in close proximity",
                        style: TextStyle(color: Colors.white)),
                  ),
                  Chip(
                    label: const Text('Pineapple',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                    backgroundColor: Color(0xffE40303),
                  ),
                  Chip(
                    backgroundColor: Color(0xffFF8C00),
                    label: const Text("Need Medical Aid",
                        style: TextStyle(color: Colors.white)),
                  ),
                  Chip(
                    label: const Text('Garlic Bread',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600)),
                    backgroundColor: Color(0xffFFED00),
                  ),
                  Chip(
                    backgroundColor: Color(0xff008026),
                    label: const Text("In Pursuit",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
