import 'package:flutter/material.dart';
import 'package:untitled4/Admin%20Page/Bugreports.dart';
import 'package:untitled4/Admin%20Page/OrderDetailAdmin.dart';

import 'package:untitled4/Admin%20Page/category.dart';
import 'package:untitled4/Admin%20Page/upload_file.dart';
import 'package:untitled4/Admin%20Page/userdetails.dart';

List title = [
  "User Details",
  "Add Offers",
  "Button",
  "Order Details",
  "Bug Reports"
];

class Addcontent extends StatelessWidget {
  const Addcontent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: const Text("Admin Panel"), backgroundColor: Colors.black),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: MaterialButton(
                onPressed: () {
                  switch (index) {
                    case 0:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Userdetails()),
                      );
                      break;
                    case 1:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UploadImageAndMore()),
                      );
                      break;
                    case 2:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Categorybtn()),
                      );
                    case 3:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OrderDetailAdmin()),
                      );
                      break;
                    case 4:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Bugreports()),
                      );
                  }
                },
                child: Text(title[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
