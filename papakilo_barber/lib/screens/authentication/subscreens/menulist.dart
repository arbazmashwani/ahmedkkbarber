import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:papakilo_barber/constants/colors.dart';
import 'package:papakilo_barber/screens/authentication/widgets.dart';

class Menulist extends StatefulWidget {
  const Menulist({super.key});

  @override
  State<Menulist> createState() => _MenulistState();
}

class _MenulistState extends State<Menulist> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        screenIndexText("03 - MenuList Management"),
        sizedBoxwidget(20, 0),
        mainheading('Manage MenuList'),
        submainheading(
            "set up the price amount of menu list as affordable for all customers"),
        FirebaseAnimatedList(
            shrinkWrap: true,
            query: FirebaseDatabase.instance.ref().child('menu'),
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              int newindex = index + 1;
              returnsnapshotval(String text) {
                return snapshot.child(text).value.toString();
              }

              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: themecolorDarkBlue,
                          child: Text(
                            newindex.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(    
                          returnsnapshotval("name"),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                        subtitle: Text(
                          returnsnapshotval("name_trans"),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          returnsnapshotval("desc"),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                        subtitle: Text(
                          returnsnapshotval("desc"),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      ListTile(
                          trailing: IconButton(
                            onPressed: () {
                              showMyDialog(
                                  context,
                                  "premium_price",
                                  returnsnapshotval("name"),
                                  returnsnapshotval("uuids"));
                            },
                            icon: const Icon(
                              Iconsax.edit,
                              color: Colors.green,
                            ),
                          ),
                          title: const Text(
                            "Premium Price",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                returnsnapshotval("branches") == "null"
                                    ? returnsnapshotval("premium_price")
                                    : snapshot
                                                .child("branches")
                                                .child(FirebaseAuth
                                                    .instance.currentUser!.uid
                                                    .toString())
                                                .value
                                                .toString() ==
                                            "null"
                                        ? returnsnapshotval("premium_price")
                                        : snapshot
                                                    .child("branches")
                                                    .child(FirebaseAuth.instance
                                                        .currentUser!.uid
                                                        .toString())
                                                    .child("premium_price")
                                                    .value
                                                    .toString() ==
                                                "null"
                                            ? returnsnapshotval("premium_price")
                                            : snapshot
                                                .child("branches")
                                                .child(FirebaseAuth
                                                    .instance.currentUser!.uid
                                                    .toString())
                                                .child("premium_price")
                                                .value
                                                .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                              const Text(
                                "k",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                            ],
                          )),
                      ListTile(
                          trailing: IconButton(
                            onPressed: () {
                              showMyDialog(
                                  context,
                                  "eco_price",
                                  returnsnapshotval("name"),
                                  returnsnapshotval("uuids"));
                            },
                            icon: const Icon(
                              Iconsax.edit,
                              color: Colors.green,
                            ),
                          ),
                          title: const Text(
                            "Eco Price",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                returnsnapshotval("branches") == "null"
                                    ? returnsnapshotval("eco_price")
                                    : snapshot
                                                .child("branches")
                                                .child(FirebaseAuth
                                                    .instance.currentUser!.uid
                                                    .toString())
                                                .value
                                                .toString() ==
                                            "null"
                                        ? returnsnapshotval("eco_price")
                                        : snapshot
                                                    .child("branches")
                                                    .child(FirebaseAuth.instance
                                                        .currentUser!.uid
                                                        .toString())
                                                    .child("eco_price")
                                                    .value
                                                    .toString() ==
                                                "null"
                                            ? returnsnapshotval("eco_price")
                                            : snapshot
                                                .child("branches")
                                                .child(FirebaseAuth
                                                    .instance.currentUser!.uid
                                                    .toString())
                                                .child("eco_price")
                                                .value
                                                .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                              const Text(
                                "k",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              );
            })
      ],
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
