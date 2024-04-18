import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Bugreports extends StatelessWidget {
  const Bugreports({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Bug Reports"), backgroundColor: Colors.black),
      backgroundColor: Colors.black,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('reports').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> document = snapshot.data!.docs;
          return ListView.builder(
            itemCount: document.length,
            itemBuilder: (context, index) {
              DocumentSnapshot thisItem = document[index];
              Map<String, dynamic> item =
                  thisItem.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("UserEmail: ${item['User']}"),
                                        IconButton(
                                            onPressed: () {
                                              deleteid(document[index].id);
                                            },
                                            icon: const Icon(Icons.delete))
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Title: ${item['Title']}"),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              "Description:\n ${item['Description']}"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
              );
            },
          );
        },
      ),
    );
  }

  void deleteid(String documentId) {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('reports');
    collectionReference.doc(documentId).delete();
    Fluttertoast.showToast(msg: 'Deleted');
  }
}
