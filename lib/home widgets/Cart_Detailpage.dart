import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class CartDetail extends StatefulWidget {
  final String image;
  final String name;
  final int quantity;
  final double totalPrice;
  final String documentid;
  final List<Map<String, dynamic>> products;
  final int index; // Add index parameter here

  const CartDetail({
    required this.image,
    required this.name,
    required this.quantity,
    required this.totalPrice,
    required this.documentid,
    required this.products,
    required this.index, // Initialize index parameter here
  });

  @override
  State<CartDetail> createState() => _CartDetailState();
}

class _CartDetailState extends State<CartDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Order Details',
          style: GoogleFonts.inknutAntiqua(fontSize: 15, color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(18),
                          image: DecorationImage(
                            image: NetworkImage(widget.image),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.name,
                      style: GoogleFonts.inknutAntiqua(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantity: ${widget.quantity}',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        'Total Price: ₹${widget.totalPrice}',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: MaterialButton(
                      height: 60,
                      onPressed: () {
                        deleteOrderItem(FirebaseAuth.instance.currentUser!.uid,
                            widget.index);
                        Navigator.pop(context);
                        Future.delayed(
                          const Duration(seconds: 4),
                          () {
                            triggernotification();
                          },
                        );
                      },
                      child: const Text(
                        "Cancel Order",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void deleteOrderItem(String userId, int index) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('userId', isEqualTo: userId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs[index].reference;
        await docRef.delete();
        widget.products.removeAt(index);
        setState(() {});
        Fluttertoast.showToast(
          msg: "Order canceled successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } else {}
    } catch (e) {}
  }

  triggernotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_notification',
        title: "Order Cancelled",
        bigPicture: 'assets/images/logo_burger.png',
      ),
    );
  }
}
