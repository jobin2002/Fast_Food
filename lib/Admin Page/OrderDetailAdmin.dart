import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderDetailAdmin extends StatelessWidget {
  const OrderDetailAdmin({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black, title: const Text("Order Details")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = documents[index];
              Map item = document.data() as Map;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 230,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 2, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 0, left: 10, right: 10),
                              child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(item['image']),
                                          fit: BoxFit.fill),
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                            Column(
                              children: [
                                Text(item['name']),
                                Text("Quantity:${item['quantity']}"),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      deletedata(document.id);
                                    },
                                    icon: const Icon(Icons.delete)),
                                Text("Total Price:₹${item['totalPrice']}"),
                              ],
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 18, right: 8, top: 2, bottom: 2),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text("UserDetails:")),
                          ),
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                    right: 19, left: 8, top: 2, bottom: 0),
                                child: Text("Payment Method:"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 18, top: 0, bottom: 2),
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text("${item['Payment Method']}")),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, left: 15, right: 15),
                        child: Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Name:${item['fullname']}",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "Location:${item['location']}",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "PhoneNumber:${item['phoneNumber']}",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "Pincode:${item['pincode']}",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void deletedata(String documentId) async {
    try {
      final CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('products');
      await collectionReference.doc(documentId).delete();
      Fluttertoast.showToast(msg: 'Order cancelled');
    } catch (e) {}
  }
}
