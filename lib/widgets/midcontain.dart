import 'package:flutter/material.dart';

class midcontainer extends StatelessWidget {
  const midcontainer({super.key});

  @override
  Widget build(BuildContext context) {
    Widget pad = SizedBox(height: 40);
    return Column(children: [
      pad,
      Container(
        height: 170,
        width: 370,
        decoration: BoxDecoration(color: Colors.white,
            // color: Color.fromARGB(255, 138,99,255),
            shape: BoxShape.rectangle,
            image: DecorationImage(
                image: AssetImage('assets/images/delivery3.png'),
                alignment: Alignment.centerRight),
            borderRadius: BorderRadius.circular(30)),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 23, bottom: 3),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("Fast Deliveries",
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Choose a Meal to Add",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "to the Plan",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 25),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  height: 36,
                  width: 110,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25)),
                    child: OutlinedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(25)))),
                        child: Text(
                          "Order now",
                          style: TextStyle(
                              color: Colors.white, fontSize: 16),
                        )),
                  ),
                )),
          )
        ]),
      ),
    ],);
  }
}
