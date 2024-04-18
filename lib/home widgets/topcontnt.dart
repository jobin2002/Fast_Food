import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:untitled4/Botam%20navigation%20pages/explore.dart';
import 'package:untitled4/home%20widgets/Searchpage.dart';

class appbar extends StatefulWidget {
  const appbar({super.key});

  @override
  State<appbar> createState() => _appbarState();
}

class _appbarState extends State<appbar> {
  String currentAddress = 'Tap to Locate';

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'please enable location');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'location permission is denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg: 'Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    try {
      List<Placemark> placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemark[0];
      setState(() {
        currentAddress = "${place.locality}" "/" "${place.administrativeArea}";
      });
    } catch (e) {}
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    _determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12)),
            child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(PageAnimationTransition(
                      page: const Searchpage(),
                      pageAnimationType: BottomToTopTransition()));
                },
                style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(50, 60))),
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                ))),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 30),
          child: GestureDetector(
            onTap: () {
              _determinePosition();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                    )),
                Text(
                  currentAddress,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      letterSpacing: 2),
                ),
              ],
            ),
          ),
        ),
        Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12)),
            child: OutlinedButton(
                onPressed: () {},
                style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(50, 60))),
                child: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                ))),
      ],
    );
  }
}
