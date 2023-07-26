import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:papakilo_barber/constants/loadingwidget.dart';
import 'package:papakilo_barber/screens/authentication/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../../../constants/colors.dart';

class ShopsDetails extends StatefulWidget {
  const ShopsDetails({super.key, required this.onChange});
  final VoidCallback onChange;

  @override
  State<ShopsDetails> createState() => _ShopsDetailsState();
}

class _ShopsDetailsState extends State<ShopsDetails> {
  Position? _currentPosition;
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchLocation() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: LoadingWidget(),
          );
        });
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      _showToast(context, "Location Service disabled");
      return;
    }

    // Request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        _showToast(context, "Location permission disabled");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      _showToast(context, "Location permission disabled forever");
      return;
    }

    // Fetch the current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      Navigator.pop(context);
      _currentPosition = position;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  //
  _pickImageofstorage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _pickedImage = pickedImage;
      });
    }
  }

  uploadPictures() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: LoadingWidget(),
          );
        });
    try {
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('images');
      Reference profilereferenceImageToUpload =
          referenceDirImages.child(const Uuid().v4().toString()).child("jj");
      await profilereferenceImageToUpload.putFile(File(_pickedImage!.path));
      profilepictureUrl = await profilereferenceImageToUpload.getDownloadURL();

      await FirebaseDatabase.instance
          .ref()
          .child('branches')
          .child(FirebaseAuth.instance.currentUser!.uid.toString())
          .child("profile_picture")
          .set(profilepictureUrl);
      await FirebaseDatabase.instance
          .ref()
          .child('branches')
          .child(FirebaseAuth.instance.currentUser!.uid.toString())
          .child("latitude")
          .set(_currentPosition!.latitude);
      await FirebaseDatabase.instance
          .ref()
          .child('branches')
          .child(FirebaseAuth.instance.currentUser!.uid.toString())
          .child("longitude")
          .set(_currentPosition!.longitude);
      Navigator.pop(context);
      widget.onChange();
      // ignore: use_build_context_synchronously
      _showToast(context, "Added Successfully");
    } catch (e) {
      Navigator.pop(context);
      _showToast(context, e.toString());
    }
  }

  TextEditingController emailcontroller = TextEditingController();
  XFile? _pickedImage;
  String profilepictureUrl = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        screenIndexText("02 - Papakilo Branch Information"),
        sizedBoxwidget(20, 0),
        mainheading('Upload Profile Photo'),
        submainheading(
            "This data will be displayed in shop account profile for security"),
        _pickedImage == null
            ? ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _pickImageofstorage(index == 0
                          ? ImageSource.gallery
                          : ImageSource.camera);
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 20),
                      child: Card(
                        elevation: 1,
                        child: Container(
                          height: 130,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    index == 0
                                        ? Iconsax.gallery
                                        : Iconsax.camera,
                                    color:
                                        index == 0 ? Colors.green : Colors.red,
                                    size: 50,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    index == 0 ? "From Gallery" : "From Camera",
                                    style: const TextStyle(
                                      color: Color(0xff2F2E2E),
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })
            : Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(
                            File(_pickedImage!.path),
                          ),
                          fit: BoxFit.contain),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
        sizedBoxwidget(20, 0),
        mainheading('Location of Papakilo Branch'),
        submainheading(
            "This data will be displayed in shop account profile for user access to shop"),
        _currentPosition == null
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  color: Colors.white,
                  child: ListTile(
                    onTap: () async {
                      await _fetchLocation();
                    },
                    title: const Text("Fetch Location of Shop"),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: SizedBox(
                  height: 200,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        _currentPosition!.latitude,
                        _currentPosition!.longitude,
                      ),
                      zoom: 14,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('currentLocation'),
                        position: LatLng(
                          _currentPosition!.latitude,
                          _currentPosition!.longitude,
                        ),
                      ),
                    },
                  ),
                ),
              ),
        sizedBoxwidget(30, 0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MaterialButton(
              onPressed: () {
                if (_pickedImage == null) {
                  _showToast(context, "Select picture");
                } else if (_currentPosition == null) {
                  _showToast(context, "Fetch Shop Location");
                } else {
                  uploadPictures();
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
