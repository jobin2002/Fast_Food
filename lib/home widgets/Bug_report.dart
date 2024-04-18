import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Bugreport extends StatefulWidget {
  const Bugreport({super.key});

  @override
  State<Bugreport> createState() => _BugreportState();
}

class _BugreportState extends State<Bugreport> {
  final TextEditingController _title = TextEditingController();

  final TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:
          AppBar(title: const Text("Report"), backgroundColor: Colors.black),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  controller: _title,
                  decoration: InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  controller: description,
                  decoration: InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: MaterialButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                height: 50,
                onPressed: () {
                  if (_title.text.isEmpty) {
                    Fluttertoast.showToast(msg: 'Required Field Title');
                  } else {
                    UploadReport();
                    Fluttertoast.showToast(msg: 'Report Send Successfully');
                    Navigator.pop(context);
                    _title.dispose();
                    description.dispose();
                  }
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  UploadReport() {
    User? user = FirebaseAuth.instance.currentUser;
    String? userid = user?.email;
    String? userId = user?.uid;
    if (user != null) {
      FirebaseFirestore.instance.collection('reports').add({
        'User': userid,
        'UserId': userId,
        'Title': _title.text,
        'Description': description.text,
      });
    }
  }
}
