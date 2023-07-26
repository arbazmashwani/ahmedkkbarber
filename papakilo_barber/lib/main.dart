import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:papakilo_barber/screens/authentication/signin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // storemenu();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // ignore: deprecated_member_use
          androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
          textTheme: GoogleFonts.openSansTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SignInPage());
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

// storemenu() {
//   String uuids = const Uuid().v4().toString();

//   Map menumap = {
//     "uuids": uuids,
//     "name": "Papakilo Haircut without Hair-spa",
//     "name_trans": "(Potongan Rambut Papakilo tanpa Hair-spa)",
//     "desc":
//         "The ultimate grooming experience. Sit back and relax as our expert barbers tailor your haircut with precision, creating a style that soars above the rest.",
//     "desc_trans":
//         "(Pengalaman perawatan terbaik. Duduk dan bersantailah saat tukang cukur ahli kami menyesuaikan potongan rambut anda dengan presisi, menciptakan gaya yang menonjol di atas yang lain.)",
//     "premium_price": 70,
//     "eco_price": 100
//   };

//   FirebaseDatabase.instance.ref().child('menu').child(uuids).set(menumap);
// }
