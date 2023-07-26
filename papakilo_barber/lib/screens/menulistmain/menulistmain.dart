import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:papakilo_barber/constants/colors.dart';
import 'package:papakilo_barber/screens/authentication/widgets.dart';

class Menulistmainscreen extends StatefulWidget {
  const Menulistmainscreen({super.key});

  @override
  State<Menulistmainscreen> createState() => _MenulistmainscreenState();
}

class _MenulistmainscreenState extends State<Menulistmainscreen> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themecolorDarkBlue,
        title: const Text(
          "Manage Service List",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: themecolorDarkBlue.withOpacity(0.90),
        child: Column(
          children: [
            FirebaseAnimatedList(
                shrinkWrap: true,
                query: FirebaseDatabase.instance.ref().child('menu'),
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  int newindex = index + 1;
                  returnsnapshotval(String text) {
                    return snapshot.child(text).value.toString();
                  }

                  return ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    subtitle: Text(
                      returnsnapshotval("name_trans"),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      returnsnapshotval("name"),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}

void showMyDialog(BuildContext context, String title, name, uid) {
  TextEditingController textFieldController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        backgroundColor: Colors.white,
        content: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              mainheading(name),
              submainheading("Update the $title  as custom & affordable"),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: textFieldController,
                  decoration: const InputDecoration(
                    labelText: 'Enter New Price',
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () async {
              String enteredText = textFieldController.text;
              await FirebaseDatabase.instance
                  .ref()
                  .child('menu')
                  .child(uid)
                  .child("branches")
                  .child(FirebaseAuth.instance.currentUser!.uid.toString())
                  .child(title)
                  .set(enteredText);

              Navigator.of(context).pop(enteredText);
            },
          ),
        ],
      );
    },
  );
}
