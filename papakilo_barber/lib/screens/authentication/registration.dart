import 'package:flutter/material.dart';
import 'package:papakilo_barber/dashboard.dart';
import 'package:papakilo_barber/screens/authentication/subscreens/details.dart';
import 'package:papakilo_barber/screens/authentication/subscreens/menulist.dart';
import 'package:papakilo_barber/screens/authentication/subscreens/personaldetails.dart';

import '../../constants/colors.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  List<bool> boollist = List.generate(3, (index) => false).toList();
  int indexnumber = 0;

  void _toggleWidget() {
    setState(() {
      indexnumber++;
      boollist[indexnumber] = true;
      _scrollController.animateTo(0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn);
    });
  }

  String page1 = "started";
  String page2 = "";
  String page3 = "";
  String page4 = "";
  String page5 = "";

  @override
  void initState() {
    boollist[0] = true;

    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: SizedBox(
                height: 10,
                child: ListView.builder(
                    itemCount: boollist.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          color: boollist[index]
                              ? themecolorDarkBlue
                              : const Color(0xffA3CBD9).withOpacity(0.5),
                          height: 10,
                          width: MediaQuery.of(context).size.width / 3 - 20,
                        ),
                      );
                    }),
              ),
            ),
            Container(
              child: screenlist[indexnumber],
            ),
            indexnumber == 2
                ? MaterialButton(
                    onPressed: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const DashboardScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: themecolorDarkBlue,
                          borderRadius: BorderRadius.circular(10)),
                      width: double.infinity,
                      height: 52,
                      child: const Center(
                        child: Text(
                          "Get Started",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                : Container(),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  late List<Widget> screenlist = [
    PersonalProfile(
      onChange: _toggleWidget,
    ),
    ShopsDetails(
      onChange: _toggleWidget,
    ),
    const Menulist()
  ];
}
