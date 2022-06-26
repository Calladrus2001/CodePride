import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pizza100/Views/WhereTo.dart';
import 'package:pizza100/constants.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool hasAccount = false;
  final emailController = new TextEditingController();
  final passController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    String _email = "";
    String _password = "";
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ReportOrChat();
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Center(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 65),
                              Image.asset(
                                'assets/images/videocall.png',
                                height: 250,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Form(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: 'Enter your email',
                                  hintText: 'ex: test@gmail.com',
                                ),
                                onChanged: (value) {
                                  print(value);
                                  _email = value;
                                },
                                validator: (value) {}),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: passController,
                              decoration: InputDecoration(
                                labelText: 'Enter your password',
                              ),
                              obscureText: true,
                              onChanged: (value) {
                                _password = value;
                              },
                              validator: (value) {},
                            ),
                            SizedBox(height: 48),

                            /// login/register button

                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: GestureDetector(
                                  child: Container(
                                    height: 55,
                                    width: double.infinity,
                                    child: Center(
                                        child: hasAccount
                                            ? Text(
                                                "Register",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            : Text(
                                                "Login",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                    decoration: BoxDecoration(
                                        color: clr1,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                  ),
                                  onTap: () {
                                    if (hasAccount) {
                                      SignUp(_email, _password);
                                    } else {
                                      SignIn(_email, _password);
                                    }
                                    emailController.text = "";
                                    passController.text = "";
                                  },
                                )),

                            /// login/register button ends
                            SizedBox(height: 64),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                hasAccount
                                    ? Text("Already have an account?  ",
                                        style: TextStyle(color: Colors.grey))
                                    : Text("Don't have an account?  ",
                                        style: TextStyle(color: Colors.grey)),
                                GestureDetector(
                                    child: hasAccount
                                        ? Text("Login",
                                            style: TextStyle(color: clr1))
                                        : Text("Register",
                                            style: TextStyle(color: clr1)),
                                    onTap: () {
                                      setState(() {
                                        hasAccount = !hasAccount;
                                        passController.text = "";
                                        emailController.text = "";
                                      });
                                    })
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }

  Future SignIn(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future SignUp(String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }
}
