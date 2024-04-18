import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/home%20widgets/detailpage.dart';

class Ricepage extends StatefulWidget {
  const Ricepage({super.key});

  @override
  State<Ricepage> createState() => _UploadImageAndMoreState();
}

class _UploadImageAndMoreState extends State<Ricepage> {
  String imageUrl = '';

  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection('Rice_bowl').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Find Your Meals"),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Some error occured${snapshot.error}"),
              );
            }

            if (snapshot.hasData) {
              QuerySnapshot querySnapshot = snapshot.data;
              List<QueryDocumentSnapshot> document = querySnapshot.docs;

              // List<Map> items = document.map((e) => e.data() as Map).toList();

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  itemCount: document.length,
                  itemBuilder: (BuildContext context, int index) {
                    QueryDocumentSnapshot thisDocument = document[index];
                    Map thisItem = thisDocument.data() as Map;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(item: thisItem),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 3,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(20)),
                                child: Image.network(
                                  "${thisItem['image']}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                                height: 8), // Added SizedBox for spacing
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "${thisItem['name']}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                                height: 4), // Added SizedBox for spacing
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "₹${thisItem['number']}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(
                                height: 8), // Added SizedBox for spacing
                          ],
                        ),
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
