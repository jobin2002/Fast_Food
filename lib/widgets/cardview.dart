import 'package:flutter/material.dart';

List imagge = [
  "https://thumbs.dreamstime.com/b/burger-juicy-beef-melty-cheese-crisp-lettuce-side-crispy-golden-fries-burger-juicy-beef-melty-cheese-crisp-278189063.jpg",
  "https://insanelygoodrecipes.com/wp-content/uploads/2020/02/Burger-and-Fries.jpg",
  "https://t3.ftcdn.net/jpg/01/24/04/36/360_F_124043666_qGhOvVF9VvhiEfw76er3HX1Q1JEwMDc3.jpg",
  "https://thumbs.dreamstime.com/b/beef-hamburger-expertly-barbecued-grill-ready-to-be-savored-generative-ai-281548262.jpg",
  "https://thumbs.dreamstime.com/b/double-hamburger-two-patties-pickles-tomatoes-onion-greens-appetizing-double-hamburger-two-juicy-veal-patties-pickles-240278026.jpg",
  "https://insanelygoodrecipes.com/wp-content/uploads/2020/02/Burger-and-Fries.jpg",
];
List Texte = [
  "Sandwitch Fast-Food",
  "Double Cheese",
  "Double patty",
  "Classic Burger",
  "Burger Frenchfries",
  "Onian Burger",
];
List mid = [
  "12-13km,2:00-6:00",
  "12-13km,2:00-6:00",
  "12-13km,2:00-6:00",
  "12-13km,2:00-6:00",
  "12-13km,2:00-6:00",
  "12-13km,2:00-6:00",
];

class seeall extends StatelessWidget {
  const seeall({super.key});

  @override
  Widget build(BuildContext context) {
    Widget pad = Padding(padding: EdgeInsets.all(10.00));
    Widget al = Align(
      alignment: Alignment.topLeft,
    );
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 250,
          child: GridView.builder(
            itemCount: imagge.length,
            scrollDirection: Axis.horizontal,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey,
                                image: DecorationImage(
                                    image: NetworkImage(imagge[index]),
                                    fit: BoxFit.cover))),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Texte[index],
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                mid[index],
                                style:
                                    TextStyle(color: Colors.white, fontSize: 15),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
