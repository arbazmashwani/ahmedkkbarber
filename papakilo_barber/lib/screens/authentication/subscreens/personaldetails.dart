// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:papakilo_barber/constants/loadingwidget.dart';
import 'package:papakilo_barber/screens/authentication/widgets.dart';

import '../../../constants/colors.dart';

class PersonalProfile extends StatefulWidget {
  const PersonalProfile({super.key, required this.onChange});
  final VoidCallback onChange;

  @override
  State<PersonalProfile> createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  @override
  void initState() {
    super.initState();
  }

  bool passwordconfirmed() {
    if (passwordcontroller.text == confirmpasswordcontroller.text) {
      return true;
    } else {
      return false;
    }
  }

  Future signup() async {
    if (passwordconfirmed() == true) {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: LoadingWidget(),
            );
          });

      try {
        final UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailcontroller.text, password: passwordcontroller.text);
        await addusersdetails();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        widget.onChange();
        // ignore: use_build_context_synchronously
        _showToast(context, "Successfully created");
      } on FirebaseException catch (error) {
        Navigator.pop(context);
        _showToast(context, error.toString());
      }
    } else {
      Navigator.pop(context);
      _showToast(context, "Password Mismatched");
    }
  }

  Future addusersdetails() async {
    FirebaseDatabase.instance
        .ref()
        .child('branches')
        .child(FirebaseAuth.instance.currentUser!.uid.toString())
        .set({
      'name': barbernamecontroller.text,
      'email': emailcontroller.text,
      "password": passwordcontroller.text,
      "phone": barbernamecontroller.text,
      "date": DateTime.now().toString(),
      "uid": FirebaseAuth.instance.currentUser!.uid.toString(),
    });
  }

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController barbernamecontroller = TextEditingController();
  TextEditingController barberphonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        screenIndexText("01 - Barber Personal Information"),
        sizedBoxwidget(20, 0),
        mainheading('Register Barber'),
        submainheading(
            "Please Provide your Valid Information and Email to verify"),
        texttilewidget("Email", "Enter Email", 15, emailcontroller),
        texttilewidget(
            "Barber name", "Enter Barber Name", 0, barbernamecontroller),
        texttilewidget(
            "Barber Phone", "Enter Barber Phone", 0, barberphonecontroller),
        texttilewidget("Password", "Enter Password", 0, passwordcontroller),
        texttilewidget("Confirm Password", "Enter Confirm Password", 0,
            confirmpasswordcontroller),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MaterialButton(
              onPressed: () {
                if (emailcontroller.text.isEmpty) {
                  _showToast(context, "Enter Email");
                } else if (barbernamecontroller.text.isEmpty) {
                  _showToast(context, "Enter barber Name");
                } else if (barberphonecontroller.text.isEmpty) {
                  _showToast(context, "Enter barber Phone");
                } else if (passwordcontroller.text.isEmpty) {
                  _showToast(context, "Enter Password");
                } else {
                  signup();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: themecolorDarkBlue,
                    borderRadius: BorderRadius.circular(10)),
                width: 120,
                height: 52,
                child: const Center(
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
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
