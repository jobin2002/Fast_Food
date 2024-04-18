import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled4/Loginpage/login.dart';
import 'package:untitled4/home%20widgets/Addressview.dart';
import 'package:untitled4/home%20widgets/Bug_report.dart';
import 'package:untitled4/home%20widgets/Terms&conditions.dart';
import 'package:url_launcher/url_launcher.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  final TextEditingController _name = TextEditingController();

  final TextEditingController _age = TextEditingController();

  String imageUrl = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text("Edit Profile",
                            style: TextStyle(color: Colors.black)),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              style: const TextStyle(color: Colors.black),
                              controller: _name,
                              decoration: InputDecoration(
                                  labelText: "Name",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              style: const TextStyle(color: Colors.black),
                              controller: _age,
                              decoration: InputDecoration(
                                  labelText: "Age",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: MaterialButton(
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                height: 50,
                                onPressed: () {
                                  if (_name.text.isEmpty || _age.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: 'Field is empty');
                                  } else {
                                    uploadDataToFirestore();
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text(
                                  "Submit",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ]);
                  },
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 21,
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text(
          "Profile",
          style: GoogleFonts.prozaLibre(),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('userId',
                              isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                              child: Text('Add Name and Details'));
                        }
                        final doc = snapshot.data!.docs.first;
                        return ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Profile pic",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    backgroundColor: Colors.white,
                                    actions: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: MaterialButton(
                                                  color: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  height: 50,
                                                  onPressed: () async {
                                                    final file =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery);
                                                    if (file == null) return;

                                                    String fileName = DateTime
                                                            .now()
                                                        .microsecondsSinceEpoch
                                                        .toString();

                                                    Reference referenceRoot =
                                                        FirebaseStorage.instance
                                                            .ref();
                                                    Reference
                                                        referenceDireImages =
                                                        referenceRoot
                                                            .child('images');

                                                    Reference
                                                        referenceImageaToUpload =
                                                        referenceDireImages
                                                            .child(fileName);

                                                    try {
                                                      await referenceImageaToUpload
                                                          .putFile(
                                                              File(file.path));

                                                      imageUrl =
                                                          await referenceImageaToUpload
                                                              .getDownloadURL();
                                                    } catch (error) {}
                                                  },
                                                  child: Text(
                                                    "Pick Image",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: MaterialButton(
                                              color: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              height: 50,
                                              onPressed: () {
                                                profilephoto();
                                                Navigator.pop(context);
                                              },
                                              child: Text("Upload",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                doc['imageUrl'],
                              ),
                              backgroundColor: Colors.black,
                              radius: 30,
                            ),
                          ),
                          title: Text(doc['name']),
                          subtitle: Text("Email:${doc['email']}"),
                        );
                      },
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 480,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const AddressView(),
                                            ));
                                      },
                                      child: Container(
                                          height: 200,
                                          width: 160,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: const Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.local_shipping,
                                                ),
                                                Text("Shipping Address")
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Bugreport(),
                                          ));
                                    },
                                    child: Container(
                                      height: 200,
                                      width: 160,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: const Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.bug_report,
                                            ),
                                            Text("Bug Report")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Termsandconditions(),
                                          ));
                                    },
                                    child: Container(
                                      height: 200,
                                      width: 160,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: const Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.file_copy,
                                            ),
                                            Text("Terms&Conditions")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      final Uri Launchemail = Uri(
                                          scheme: 'mailto',
                                          path: "jobinjvarghese2002@gmail.com");
                                      try {
                                        await launch(Launchemail.toString());
                                      } catch (e) {}
                                    },
                                    child: Container(
                                      height: 200,
                                      width: 160,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: const Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.help_center,
                                            ),
                                            Text("Help Center")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MaterialButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Userlogin(),
                          ));
                    },
                    color: Colors.white,
                    elevation: 20,
                    highlightColor: Colors.green,
                    height: 55,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("Sign Out",
                        style: GoogleFonts.aBeeZee(color: Colors.black)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> uploadDataToFirestore() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return;
      }
      String userId = currentUser.uid;
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        DocumentReference docRef = snapshot.docs.first.reference;
        await docRef.update({
          'name': _name.text,
          'age': _age.text,
        });
      } else {}
    } catch (error) {}
  }

  Future<void> profilephoto() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return;
      }
      String userId = currentUser.uid;
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        DocumentReference docRef = snapshot.docs.first.reference;
        await docRef.update({
          'imageUrl': imageUrl,
        });
      } else {
        await FirebaseFirestore.instance.collection('users').add({
          'imageUrl': imageUrl,
        });
      }
    } catch (error) {}
  }
}
