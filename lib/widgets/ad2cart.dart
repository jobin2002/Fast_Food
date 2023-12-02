import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

class slider2 extends StatelessWidget {
  const slider2({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: SlideAction(
                  onSubmit: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => home()));
                  },
                  innerColor: Colors.black,
                  outerColor: Colors.white,
                  child: Text("Add To Cart",
                      style: TextStyle(fontSize: 23)),
                  sliderButtonIcon: Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                  )),
            )
          ],
        ));
  }
}
