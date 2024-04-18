import 'package:flutter/material.dart';
import 'package:untitled4/home%20widgets/Category_Navigation/Burger.dart';
import 'package:untitled4/home%20widgets/Category_Navigation/bubletea.dart';
import 'package:untitled4/home%20widgets/Category_Navigation/chicken.dart';
import 'package:untitled4/home%20widgets/Category_Navigation/coffee.dart';
import 'package:untitled4/home%20widgets/Category_Navigation/pizza.dart';
import 'package:untitled4/home%20widgets/Category_Navigation/ricebowl.dart';
import 'package:untitled4/home%20widgets/Category_Navigation/salad.dart';
import 'package:untitled4/home%20widgets/Category_Navigation/vegetable.dart';

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
        physics: const NeverScrollableScrollPhysics(),
        itemCount: imagee.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
            switch(index){
              case 0:Navigator.push(context, MaterialPageRoute(builder: (context) => Burgerpage(),));
              break;
              case 1:Navigator.push(context, MaterialPageRoute(builder: (context) => Pizzapage(),));
              break;
              case 2:Navigator.push(context, MaterialPageRoute(builder: (context) => Coffeepage(),));
              break;
              case 3:Navigator.push(context, MaterialPageRoute(builder: (context) => Ricepage(),));
              break;
              case 4:Navigator.push(context, MaterialPageRoute(builder: (context) => Chickenpage(),));
              break;
              case 5:Navigator.push(context, MaterialPageRoute(builder: (context) => Saladpage(),));
              break;
              case 6:Navigator.push(context, MaterialPageRoute(builder: (context) => Bubblepage(),));
              break;
              case 7:Navigator.push(context, MaterialPageRoute(builder: (context) => Vegpage(),));
              break;

            }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white),
                color: Colors.black,
              ),
              child: SingleChildScrollView(
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
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
