import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Addressdetail extends StatefulWidget {
  const Addressdetail({super.key});

  @override
  State<Addressdetail> createState() => _AddressdetailState();
}

class _AddressdetailState extends State<Addressdetail> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _Houseeno = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _pincode = TextEditingController();
  final TextEditingController _Landmark = TextEditingController();

  String currentAddress = '';

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
        currentAddress = "${place.administrativeArea}" "," "${place.locality}";
      });
    } catch (e) {}
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: const Text("Add Address"), backgroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Form(
                key: _formkey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                            controller: _fullname,
                            decoration: InputDecoration(
                                labelText: "Fullname",
                                border: UnderlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(15)))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _number,
                            maxLength: 10,
                            validator: (value) {
                              if (_number.text.length <= 9) {
                                return "";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _formkey.currentState?.validate();
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                counterText: "",
                                labelText: "PhoneNumber",
                                border: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                            controller: _Houseeno,
                            decoration: InputDecoration(
                                labelText:
                                    "Flat,House no,Building,Company,Apartment",
                                border: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                            controller: _city,
                            decoration: InputDecoration(
                                labelText: "Town",
                                border: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _pincode,
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                counterText: "",
                                labelText: "Pincode",
                                border: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                            controller: _Landmark,
                            decoration: InputDecoration(
                                labelText: "PlaceName And Its Landmark",
                                border: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)))),
                      ),
                      MaterialButton(
                        color: Colors.black,
                        onPressed: () {
                          _determinePosition();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: const Text(
                          "Use Current Location",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: MaterialButton(
                              color: Colors.black,
                              onPressed: () {
                                if (_fullname.text.isEmpty ||
                                    _Houseeno.text.isEmpty ||
                                    _city.text.isEmpty ||
                                    _Landmark.text.isEmpty) {
                                  Fluttertoast.showToast(msg: 'Field is Empty');
                                } else if (_number.text.length != 10) {
                                  Fluttertoast.showToast(
                                      msg: 'Enter a valid phone number');
                                } else if (_pincode.text.length != 6) {
                                  Fluttertoast.showToast(
                                      msg: 'Enter a valid pincode');
                                } else {
                                  uploadAddress();
                                  Navigator.pop(context);
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> uploadAddress() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return;
      }
      String userId = currentUser.uid;
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Address')
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        DocumentReference docRef = snapshot.docs.first.reference;
        await docRef.update({
          'Fullname': _fullname.text,
          'Phonenumber': _number.text,
          'House Address': _Houseeno.text,
          'City': _city.text,
          'Pincode': _pincode.text,
          'Landmark': _Landmark.text,
          'Location': currentAddress,
        });
      } else {
        await FirebaseFirestore.instance.collection('Address').add({
          'userId': userId,
          'Fullname': _fullname.text,
          'Phonenumber': _number.text,
          'House Address': _Houseeno.text,
          'City': _city.text,
          'Pincode': _pincode.text,
          'Landmark': _Landmark.text,
          'Location': currentAddress,
        });
      }
    } catch (error) {}
  }
}
