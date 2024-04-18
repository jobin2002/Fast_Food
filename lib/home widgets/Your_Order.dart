import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/home%20widgets/Cart_Detailpage.dart';

class Yourorder extends StatefulWidget {
  const Yourorder({Key? key});

  @override
  State<Yourorder> createState() => _YourorderState();
}

class _YourorderState extends State<Yourorder> {
  List<Map<String, dynamic>> products = [];
  @override
  void initState() {
    getCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getCartItems();
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartDetail(
                  image: products[index]['image'],
                  name: products[index]['name'],
                  quantity: products[index]['quantity'],
                  totalPrice: products[index]['totalPrice'],
                  documentid: products[index]['userId'],
                  products: products,
                  index: index,
                ),
              ),
            );
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListTile(
              leading: Container(
                height: 100,
                width: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(products[index]['image']),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              title: Text(products[index]['name']),
              subtitle: Text('Quantity: ${products[index]['quantity']}'),
              trailing: Text('₹${products[index]['totalPrice']}'),
            ),
          ),
        );
      },
    );
  }

  Future<void> getCartItems() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      CollectionReference cartItems =
          FirebaseFirestore.instance.collection('products');
      QuerySnapshot querySnapshot =
          await cartItems.where('userId', isEqualTo: user.uid).get();

      products.clear();

      querySnapshot.docs.forEach((doc) {
        products.add(doc.data() as Map<String, dynamic>);
      });

      setState(() {});
    } else {}
  }
}
