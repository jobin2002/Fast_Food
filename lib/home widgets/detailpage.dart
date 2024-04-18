// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slider_action/slider_action.dart';
import 'package:untitled4/home%20widgets/AddressDetail.dart';
import 'package:untitled4/home%20widgets/Paymentpage.dart';

class DetailPage extends StatefulWidget {
  final Map item;

  const DetailPage({Key? key, required this.item}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

List<String> options = ['Cash On Delivery', 'Pay Now'];

class _DetailPageState extends State<DetailPage> {
  String CurrentOption = options[0];

  bool addtocart = true;
  final slideActionKey = GlobalKey<SlideActionState>();
  int quantity = 1;
  double totalPrice = 0;

  @override
  void initState() {
    checkCart();
    super.initState();
  }

  void checkCart() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      CollectionReference cartItems =
          FirebaseFirestore.instance.collection('cart');
      QuerySnapshot querySnapshot = await cartItems
          .where('userId', isEqualTo: user.uid)
          .where('name', isEqualTo: widget.item['name'])
          .get();

      setState(() {
        addtocart = querySnapshot.docs.isNotEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    totalPrice = quantity * double.parse(widget.item['number']);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.item['name']),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(18),
                        image: DecorationImage(
                          image: NetworkImage(widget.item['image']),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.item['name'],
                      style: GoogleFonts.prozaLibre(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.item['description'],
                      style: GoogleFonts.prozaLibre(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 40,
                              width: 140,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      if (addtocart) {
                                        deleteFromCart();
                                      } else {
                                        addToCart();
                                      }
                                    });
                                  },
                                  child: Text(
                                    addtocart ? "-Remove" : "+Add To Cart",
                                    style: const TextStyle(letterSpacing: 2),
                                  ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "₹${widget.item['number']}",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 12, left: 16, right: 12, bottom: 3),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Shipping Address:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 12, left: 12, right: 16, bottom: 3),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Addressdetail(),
                                  ));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Address')
                            .where('userId',
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser?.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Center(
                                child: Text('Add The Delivery Address'));
                          }
                          final doc = snapshot.data!.docs.first;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      doc['Fullname'],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      doc['House Address'],
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 17),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        doc['Location'],
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 17),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        doc['Pincode'],
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 17),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Phone Number : +91 ${doc['Phonenumber']}",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 17),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        doc['City'],
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 17),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        doc['Landmark'],
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 17),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        top: 12, left: 16, right: 12, bottom: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Payment Method",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: ListTile(
                            title: const Text("Cash On Delivery"),
                            leading: Radio(
                                activeColor: Colors.black,
                                value: options[0],
                                groupValue: CurrentOption,
                                onChanged: (value) {
                                  setState(() {
                                    CurrentOption = value.toString();
                                  });
                                }),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: ListTile(
                            title: const Text("Pay Now With UPI"),
                            leading: Radio(
                                activeColor: Colors.black,
                                value: options[1],
                                groupValue: CurrentOption,
                                onChanged: (value) {
                                  setState(() {
                                    CurrentOption = value.toString();
                                  });
                                }),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          child: OutlinedButton(
                              onPressed: () {
                                if (quantity > 1) {
                                  setState(() {
                                    quantity--;
                                    totalPrice = quantity *
                                        double.parse(widget.item['number']);
                                  });
                                }
                              },
                              style: const ButtonStyle(
                                  minimumSize:
                                      MaterialStatePropertyAll(Size(50, 40))),
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ))),
                      Text(
                        quantity.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 19),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                  totalPrice = quantity *
                                      double.parse(widget.item['number']);
                                });
                              },
                              style: const ButtonStyle(
                                  minimumSize:
                                      MaterialStatePropertyAll(Size(50, 40))),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ))),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Total Value: ₹$totalPrice",
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SlideAction(
                  key: slideActionKey,
                  onSubmit: () async {
                    bool addressProvided = await checkAddress();
                    if (CurrentOption == options[1]) {
                      Future.delayed(const Duration(seconds: 5), () {
                        slideActionKey.currentState!.reset();
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentPage(),
                          ));
                    } else if (addressProvided) {
                      uploadToFirestore(widget.item['name'], totalPrice,
                          quantity, widget.item['image']);
                      Future.delayed(
                        const Duration(seconds: 15),
                        () {
                          triggernotification();
                        },
                      );
                      Fluttertoast.showToast(msg: 'Order Successfull');
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Add Delivery Address To Place Order');
                      Future.delayed(const Duration(seconds: 0), () {
                        slideActionKey.currentState!.reset();
                      });
                    }
                  },
                  innerColor: Colors.black,
                  outerColor: Colors.white,
                  sliderButtonIcon: const Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                  ),
                  child: const Text(
                    "Slide to Place Order",
                    style: TextStyle(fontSize: 23),
                  ),
                ),
                const SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  uploadToFirestore(
      String name, double totalPrice, int quantity, String imageUrl) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      FirebaseFirestore.instance
          .collection('Address')
          .where('userId', isEqualTo: user.uid)
          .get()
          .then((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          final doc = snapshot.docs.first;
          CollectionReference products =
              FirebaseFirestore.instance.collection('products');
          products.add({
            'userId': user.uid,
            'name': name,
            'quantity': quantity,
            'totalPrice': totalPrice,
            'image': imageUrl,
            'fullname': doc['Fullname'],
            'houseAddress': doc['House Address'],
            'phoneNumber': doc['Phonenumber'],
            'location': doc['Location'],
            'pincode': doc['Pincode'],
            'town': doc['City'],
            'landmark': doc['Landmark'],
            'Payment Method': CurrentOption,
          });
        } else {
          Fluttertoast.showToast(msg: 'Add Delivery Address To Place Order');
        }
      }).catchError((error) {});
    } else {}
  }

  void addToCart() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      CollectionReference cartItems =
          FirebaseFirestore.instance.collection('cart');
      QuerySnapshot querySnapshot = await cartItems
          .where('userId', isEqualTo: user.uid)
          .where('name', isEqualTo: widget.item['name'])
          .get();
      if (querySnapshot.docs.isEmpty) {
        cartItems.add({
          'userId': user.uid,
          'name': widget.item['name'],
          'price': widget.item['number'],
          'quantity': quantity,
          'totalPrice': totalPrice,
          'image': widget.item['image'],
          'description': widget.item['description'],
        });
        setState(() {
          addtocart = true;
        });
        Fluttertoast.showToast(msg: 'Item Added To Cart');
      } else {
        setState(() {
          addtocart = false;
        });

        Fluttertoast.showToast(msg: 'Item Already in Cart');
      }
    } else {}
  }

  void deleteFromCart() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      CollectionReference cartItems =
          FirebaseFirestore.instance.collection('cart');
      QuerySnapshot querySnapshot = await cartItems
          .where('userId', isEqualTo: user.uid)
          .where('name', isEqualTo: widget.item['name'])
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String docId = querySnapshot.docs.first.id;
        await cartItems.doc(docId).delete();
        Fluttertoast.showToast(msg: 'Item Removed From Cart');
        setState(() {
          addtocart = false;
        });
      } else {
        Fluttertoast.showToast(msg: 'Item not found in Cart');
      }
    } else {}
  }

  Future<bool> checkAddress() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('Address')
            .where('userId', isEqualTo: user.uid)
            .get();

        return snapshot.docs.isNotEmpty;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  triggernotification() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 2,
            channelKey: 'basic_notification',
            body: "Your order is on the way",
            bigPicture: 'assets/images/logo_burger.png',
            notificationLayout: NotificationLayout.BigPicture));
  }
}
