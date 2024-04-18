import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Userdetails extends StatefulWidget {
  const Userdetails({Key? key}) : super(key: key);

  @override
  _UserdetailsState createState() => _UserdetailsState();
}

class _UserdetailsState extends State<Userdetails> {
  final TextEditingController _updatename = TextEditingController();
  final TextEditingController _updateage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("User Details"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _readData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No Data Yet"));
          }
          final users = snapshot.data!.docs;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: users.map((doc) {
                  final user = doc.data() as Map<String, dynamic>;
                  return ListTile(
                    leading: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Update"),
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    controller: _updatename,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    controller: _updateage,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton(
                                      onPressed: () {
                                        if (_updatename.text.isEmpty ||
                                            _updateage.text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            backgroundColor: Colors.red,
                                            content:
                                                Text("Enter Details To Update"),
                                          ));
                                        } else {
                                          _updatedata(
                                            doc.id,
                                            _updatename.text,
                                            _updateage.text,
                                          );
                                          _updatename.clear();
                                          _updateage.clear();
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: const Text("Update"),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      user['name'],
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Email: ${user['email']}",
                              maxLines: 2,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Age: ${user['age']}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        _deletedata(doc.id);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Stream<QuerySnapshot> _readData() {
    final userCollection = FirebaseFirestore.instance.collection("users");
    return userCollection.snapshots();
  }

  void _updatedata(String id, String name, String age) {
    final userCollection = FirebaseFirestore.instance.collection("users");
    userCollection.doc(id).update({'name': name, 'age': age});
  }

  void _deletedata(String id) {
    final userCollection = FirebaseFirestore.instance.collection("users");
    userCollection.doc(id).delete();
  }

  @override
  void dispose() {
    _updatename.dispose();
    _updateage.dispose();
    super.dispose();
  }
}
