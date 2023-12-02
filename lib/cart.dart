import 'package:flutter/material.dart';
import 'package:untitled4/widgets/2btn.dart';
import 'package:untitled4/widgets/ad2cart.dart';
import 'package:untitled4/widgets/backbtn.dart';
import 'package:untitled4/widgets/container2.dart';
import 'package:untitled4/widgets/image2.dart';
import 'package:untitled4/widgets/text3.dart';

void main() {
  runApp(MaterialApp(
    home: cart(),
    debugShowCheckedModeBanner: false,
  ));
}

class cart extends StatelessWidget {
  const cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              backbtn(),
              text3(),
              Stack(
                children: [
                  image2(),
                  Positioned(right: 110, bottom: 1, child: detail())
                ],
              ),
              twobtn(),
              SizedBox(height: 20),
              slider2()
            ],
          ),
        ),
      ),
    );
  }
}
