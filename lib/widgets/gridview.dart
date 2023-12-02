import 'package:flutter/material.dart';
import 'package:untitled4/cart.dart';

List imagee = [
  "assets/images/burger1.png",
  "assets/images/pizza.png",
  "assets/images/coffee.png",
  "assets/images/ricebowl.png",
  "assets/images/chickenleg.png",
  "assets/images/salad.png",
  "assets/images/bubbletea.png",
  "assets/images/vegetable.png",
];
List labele = [
  "Burger",
  "Pizza",
  "Coffee",
  "Rice Bowl",
  "Chicken",
  "Salad",
  "Bubble Tea",
  "Vegetable"
];

class gridview extends StatelessWidget {
  const gridview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: imagee.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => cart()));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white),
                color: Colors.black,
              ),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  height: 58,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey,
                      image: DecorationImage(
                        image: AssetImage(imagee[index]),
                        fit: BoxFit.fitHeight,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    labele[index],
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ]),
            ),
          );
        },
      ),
    );
  }
}
