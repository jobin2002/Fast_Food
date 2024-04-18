import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Categorysalad extends StatefulWidget {
  const Categorysalad({super.key});

  @override
  State<Categorysalad> createState() => _UploadImageAndMoreState();
}

class _UploadImageAndMoreState extends State<Categorysalad> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final CollectionReference _items =
      FirebaseFirestore.instance.collection("Salad");

  String imageUrl = '';

  Future<void> _create() async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text("Create your Items"),
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                TextField(
                  controller: _numberController,
                  decoration: const InputDecoration(
                    labelText: 'price',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child: IconButton(
                        onPressed: () async {
                          final file = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (file == null) return;

                          String fileName =
                              DateTime.now().microsecondsSinceEpoch.toString();

                          Reference referenceRoot =
                              FirebaseStorage.instance.ref();
                          Reference referenceDireImages =
                              referenceRoot.child('images');

                          Reference referenceImageaToUpload =
                              referenceDireImages.child(fileName);

                          try {
                            await referenceImageaToUpload
                                .putFile(File(file.path));

                            imageUrl =
                                await referenceImageaToUpload.getDownloadURL();
                          } catch (error) {}
                        },
                        icon: const Icon(Icons.camera_alt))),
                Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          if (imageUrl.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Please select and upload image")));
                            return;
                          }
                          final String name = _nameController.text;
                          final String number = _numberController.text;
                          final String description =
                              _descriptionController.text;
                          await _items.add({
                            "name": name,
                            "number": number,
                            "description": description,
                            "image": imageUrl,
                          });
                          _nameController.text = '';
                          _numberController.text = '';
                          _descriptionController.text = '';
                          Navigator.of(context).pop();
                        },
                        child: const Text('Create')))
              ],
            ),
          );
        });
  }

  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection('Salad').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Upload and display Items"),
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

              return GridView.builder(
                itemCount: document.length,
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot thisDocument = document[index];
                  Map thisItem = thisDocument.data() as Map;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: NetworkImage("${thisItem['image']}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 130,
                                    child: Column(
                                      children: [
                                        SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "${thisItem['name']}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${thisItem['number']}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _deletedata(thisDocument.id);
                                    },
                                    icon: const Icon(Icons.delete),
                                    iconSize: 25,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _create();
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }

  void _deletedata(documentId) async {
    try {
      final CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("Salad");
      await collectionReference.doc(documentId).delete();
    } catch (e) {
      return;
    }
  }
}
