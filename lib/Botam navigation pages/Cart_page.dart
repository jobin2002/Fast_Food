import 'package:flutter/material.dart';
import 'package:untitled4/home%20widgets/Your_Order.dart';
import 'package:untitled4/home%20widgets/cart.dart';

class Addtocart extends StatelessWidget {
  const Addtocart({Key? key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Define the number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: const Text("Your Cart"),
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.white,
            indicator: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)),
            indicatorPadding: const EdgeInsets.all(5.0),
            tabs: const [
              Tab(text: 'Your Cart'),
              Tab(text: 'Your Orders'),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        body: const TabBarView(
          children: [
            // Content for Tab 1
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: CartPage(),
              ),
            ),
            // Content for Tab 2
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Yourorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
