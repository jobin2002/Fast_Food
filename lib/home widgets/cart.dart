import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled4/home%20widgets/Detail_page2.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> items = [];
  @override
  void initState() {
    getCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getCartItems();
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage2(
                  image: items[index]['image'],
                  name: items[index]['name'],
                  price: items[index]['price'],
                  description: items[index]['description'],
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
                    image: NetworkImage(items[index]['image']),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              title: Text(items[index]['name']),
              subtitle: Text('Quantity: ${items[index]['quantity']}'),
              trailing: IconButton(
                onPressed: () {
                  deleteCartItem(FirebaseAuth.instance.currentUser!.uid, index);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
              ),
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
          FirebaseFirestore.instance.collection('cart');
      QuerySnapshot querySnapshot =
          await cartItems.where('userId', isEqualTo: user.uid).get();
      items.clear();
      querySnapshot.docs.forEach((doc) {
        items.add(doc.data() as Map<String, dynamic>);
      });
      setState(() {});
    } else {}
  }

  void deleteCartItem(String userId, int index) async {
    try {
      await FirebaseFirestore.instance
          .collection('cart')
          .where('userId', isEqualTo: userId)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs[index].reference.delete();
      });
      items.removeAt(index);

      setState(() {});
    } catch (e) {}
  }
}
