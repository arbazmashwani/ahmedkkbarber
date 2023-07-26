import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:papakilo_barber/constants/colors.dart';
import 'package:papakilo_barber/screens/homescreen/homescree.dart';
import 'package:papakilo_barber/screens/menulistmain/menulistmain.dart';
import 'package:papakilo_barber/screens/messages/messages.dart';
import 'package:papakilo_barber/screens/profile/profile.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenlist[currentindex],
      backgroundColor: themebackgroundcolor,
      persistentFooterAlignment: AlignmentDirectional.bottomEnd,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        
        
        height: 80,
        color: themecolorDarkBlue,
        child: Row(
          children: [0, 1, 2, 3]
              .map((e) => Expanded(
                      child: Center(
                          child: IconButton(
                    onPressed: () {
                      setState(() {
                        currentindex = e;
                      });
                    },
                    icon: Icon(
                      dashboardicons[e],
                      size: 25,
                      color:
                          currentindex == e ? Colors.white : Colors.grey[400],
                    ),
                  ))))
              .toList(),
        ),
      ),
    );
  }

  List<IconData> dashboardicons = [
    Icons.home,
    Iconsax.chart,
    Iconsax.message,
    Iconsax.profile_circle,
  ];

  List<Widget> screenlist = [
    const Homescreen(),
    const Menulistmainscreen(),
    const MessagesScreen(),
    const ProfilePage(),
  ];
}
