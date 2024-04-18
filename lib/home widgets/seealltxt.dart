import 'package:flutter/material.dart';
import 'package:untitled4/home%20widgets/Category_Navigation/Burger.dart';

class txtbtn extends StatelessWidget {
  const txtbtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Burger",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Burgerpage(),));

              },
              child: const Text("See All")),
        )
      ],
    );
  }
}
