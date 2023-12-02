import 'package:flutter/material.dart';

class image2 extends StatelessWidget {
  const image2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: AssetImage("assets/images/burger10.png"),width: 400,height: 400,)
      ],
    );
  }
}
