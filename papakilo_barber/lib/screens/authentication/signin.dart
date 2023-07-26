import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:papakilo_barber/constants/loadingwidget.dart';
import 'package:papakilo_barber/dashboard.dart';

import 'package:papakilo_barber/screens/authentication/registration.dart';

import '../../constants/colors.dart';
import '../../constants/navigation.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  timerlistener() {
    Timer.periodic(const Duration(seconds: 4), (timer) {
      timer.cancel();
      if (FirebaseAuth.instance.currentUser == null) {
        if (mounted) {
          setState(() {
            showsplash = true;
          });
        }
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const DashboardScreen()));
      }
    });
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      // ignore: deprecated_member_use
      if (WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
        if (mounted) {
          setState(() {
            _scrollController.animateTo(1000,
                duration: const Duration(milliseconds: 100),
                curve: Curves.fastOutSlowIn);
          });
        }
        _timer!.cancel();
      } else {
        if (mounted) {
          setState(() {
            keyboardheight = 0;
          });
        }
      }
    });
  }

  @override
  void initState() {
    timerlistener();
    // TODO: implement initState
    super.initState();
  }

  bool showsplash = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffF8F3F7),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            AnimatedContainer(
                duration: const Duration(milliseconds: 1500),
                decoration: BoxDecoration(
                    color: themecolorDarkBlue,
                    borderRadius: showsplash == false
                        ? null
                        : const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12))),
                height: showsplash == false
                    ? MediaQuery.of(context).size.height
                    : 370,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    showsplash == false
                        ? Image.asset("images/rer.jpg")
                        : SizedBox(
                            height: 250,
                            width: double.infinity,
                            child: Image.asset("images/rer.jpg")),
                    showsplash == false
                        ? Container()
                        : const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                "Let's get started! Enter your Credientials",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17)),
                          ),
                  ],
                )),
            showsplash == false
                ? Container()
                : SizedBox(
                    child: SizedBox(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            onTap: () {
                              if (_timer!.isActive == false) {
                                timerlistener();
                              }
                            },
                            onChanged: (a) {
                              setState(() {});
                            },
                            controller: emailcontroller,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: "Enter Your Email",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 20),
                          child: TextField(
                            onTap: () {
                              if (_timer!.isActive == false) {
                                timerlistener();
                              }
                            },
                            onChanged: (a) {
                              setState(() {});
                            },
                            controller: passwordcontroller,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                hintText: "Enter Password",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            signin();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: emailcontroller.text.isEmpty
                                    ? themecolorDarkBlue.withOpacity(0.70)
                                    : themecolorDarkBlue,
                                borderRadius: BorderRadius.circular(10)),
                            width: double.infinity,
                            height: 52,
                            child: const Center(
                              child: Text(
                                "Sign In",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Dont have an account?"),
                            TextButton(
                                onPressed: () {
                                  navigationToNewScreen(
                                      context, const UserInformation());
                                },
                                child: const Text("Register Branch"))
                          ],
                        ),
                        SizedBox(
                          height: keyboardheight,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: const SizedBox(
                            height: 10,
                          ),
                        )
                      ],
                    ),
                  )),
          ],
        ),
      ),
    );
  }

  double keyboardheight = 0;

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();

  Future signin() async {
    bool signincomplete = false;
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: LoadingWidget(),
          );
        });

    try {
      if (emailcontroller.text.isEmpty) {
        _showToast(context, "Email is required");
      } else if (passwordcontroller.text.isEmpty) {
        _showToast(context, "Password is required");
      } else {
        final email = emailcontroller.text;
        final password = passwordcontroller.text;
        var response = await _authService.signInWithEmailAndPassword(
            email, password, context);

        if (response == true) {
          signincomplete = response;
        }
      }
    } catch (e) {
      _showToast(context, e.toString());
    } finally {
      Navigator.pop(context);
      if (signincomplete == true) {
        animatednoBackNavigation(context, const DashboardScreen());
      }
    }
  }
}

_showToast(BuildContext context, String message) {
  OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (BuildContext context) {
      return Positioned(
        top: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
        child: Material(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black87.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      );
    },
  );

  Overlay.of(context).insert(overlayEntry);

  // Remove the toast after a certain duration (e.g., 2 seconds)
  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<bool> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseException catch (error) {
      _showToast(context, error.toString());
      return false;
    }
  }
}
