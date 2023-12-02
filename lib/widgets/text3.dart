import 'package:flutter/material.dart';

class text3 extends StatelessWidget {
  const text3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Align(
              alignment: Alignment.topLeft,
              child: Text("Spicy",
                  style: TextStyle(color: Colors.white, fontSize: 35))),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Beast",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              )),
        ),
      ],
    );
  }
}
