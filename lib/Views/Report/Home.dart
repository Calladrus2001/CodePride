import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza100/Services/DecodingSpeech.dart';
import 'package:pizza100/Views/Report/SMS.dart';
import 'package:pizza100/Views/Video%20call/index.dart';
import 'package:pizza100/constants.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:highlight_text/highlight_text.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isListening = false;
  bool isComplete = false;
  Color clr1 = Colors.grey;
  double rad = 100;
  String _text = " ";
  late stt.SpeechToText _speech;
  List<String> codewords = Decoding().getCodewords(codebase);
  @override
  void initState() {
    box.write("codewords", codewords);
    _speech = stt.SpeechToText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isComplete
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                    heroTag: "btn1",
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.refresh_rounded,
                        color: Colors.deepOrangeAccent),
                    onPressed: () {
                      setState(() {
                        _text = " ";
                        isComplete = false;
                      });
                    }),
                const SizedBox(width: 12),
                const Text("or", style: TextStyle(color: Colors.grey)),
                const SizedBox(width: 12),
                FloatingActionButton(
                    heroTag: "btn2",
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.deepOrangeAccent),
                    onPressed: () {
                      Get.to(() => const SMS(), arguments: _text);
                    }),
              ],
            )
          : AvatarGlow(
              animate: isListening,
              glowColor: Colors.deepOrangeAccent,
              endRadius: 70.0,
              duration: const Duration(milliseconds: 2000),
              repeatPauseDuration: const Duration(milliseconds: 100),
              repeat: true,
              child: isListening
                  ? FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          isListening = false;
                          isComplete = true;
                        });
                      },
                      child: const Icon(
                        Icons.mic,
                        color: Colors.deepOrangeAccent,
                      ),
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton(
                                heroTag: "btn1",
                                backgroundColor: Colors.white,
                                child: const Icon(
                                  Icons.mic_none_rounded,
                                  color: Colors.deepOrangeAccent,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _listen();
                                    isListening = true;
                                  });
                                }),
                            const SizedBox(width: 7.5),
                            const Text("or",
                                style: TextStyle(color: Colors.grey)),
                            const SizedBox(width: 7.5),
                            FloatingActionButton(
                                heroTag: "btn2",
                                backgroundColor: Colors.white,
                                child: const Icon(
                                  Icons.videocam_outlined,
                                  color: Colors.deepOrangeAccent,
                                ),
                                onPressed: () {
                                  Get.to(() => const IndexPage());
                                }),
                          ],
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          child: const Chip(
                            elevation: 4.0,
                            backgroundColor: Colors.white,
                            label: Text("Glossary",
                                style:
                                    TextStyle(color: Colors.deepOrangeAccent)),
                          ),
                          onTap: () {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20))),
                                context: context,
                                builder: (context) {
                                  return buildSheet();
                                });
                          },
                        )
                      ],
                    )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                    height: 15,
                    width: 30,
                    child: Image(image: AssetImage("assets/images/flag.png"))),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  reverse: true,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(4, 20, 16, 30),
                    child: TextHighlight(
                      text: _text.toLowerCase(),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSheet() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Your randomised codewords:",
                style: const TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            const Divider(
              indent: 40,
              endIndent: 40,
              thickness: 0.5,
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 100,
                        child: Chip(
                            elevation: 2.0,
                            backgroundColor: Colors.white,
                            label: Text(codewords[0],
                                style: const TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontWeight: FontWeight.w700))),
                      ),
                    ),
                    const SizedBox(width: 64),
                    const Text(
                      "Number of Aggressors",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, letterSpacing: 0.5),
                    )
                  ],
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 100,
                        child: Chip(
                            elevation: 2.0,
                            backgroundColor: Colors.white,
                            label: Text(codewords[1],
                                style: const TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontWeight: FontWeight.w700))),
                      ),
                    ),
                    const SizedBox(width: 64),
                    const Text(
                      "Aggressors are armed",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, letterSpacing: 0.5),
                    )
                  ],
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 100,
                        child: Chip(
                            elevation: 2.0,
                            backgroundColor: Colors.white,
                            label: Text(codewords[2],
                                style: const TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontWeight: FontWeight.w700))),
                      ),
                    ),
                    const SizedBox(width: 64),
                    const Text(
                      "Need Medical aid",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, letterSpacing: 0.5),
                    )
                  ],
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 100,
                        child: Chip(
                            elevation: 2.0,
                            backgroundColor: Colors.white,
                            label: Text(codewords[3],
                                style: const TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontWeight: FontWeight.w700))),
                      ),
                    ),
                    const SizedBox(width: 64),
                    const Text(
                      "In pursuit",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, letterSpacing: 0.5),
                    )
                  ],
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 100,
                        child: Chip(
                            elevation: 2.0,
                            backgroundColor: Colors.white,
                            label: Text(codewords[4],
                                style: const TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontWeight: FontWeight.w700))),
                      ),
                    ),
                    const SizedBox(width: 64),
                    const Text(
                      "In close proximity",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, letterSpacing: 0.5),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _listen() async {
    if (!isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          print('onStatus: $val');
          if (val == "done") {
            setState(() {
              isComplete = true;
              isListening = false;
            });
          }
        },
        onError: (val) {},
      );
      if (available) {
        setState(() => isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => isListening = false);
      _speech.stop();
    }
  }
}
