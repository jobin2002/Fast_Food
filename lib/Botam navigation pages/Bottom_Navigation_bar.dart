import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/Botam%20navigation%20pages/Cart_page.dart';
import 'package:untitled4/Botam%20navigation%20pages/profile.dart';
import 'package:untitled4/Botam%20navigation%20pages/home.dart';
import 'package:untitled4/home%20widgets/Searchpage.dart';

final Screens = [
  const home(),
  const Searchpage(),
  const Addtocart(),
  const Profilepage(),
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _homeState();
}

class _homeState extends State<Home> {
  int _currentindex = 0;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
            height: 57,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: Colors.white,
            color: Colors.white,
            animationDuration: const Duration(milliseconds: 300),
            index: _currentindex,
            onTap: (index) => setState(() {
                  _currentindex = index;
                }),
            items: const [
              Icon(Icons.home),
              Icon(Icons.percent),
              Icon(Icons.shopping_cart),
              Icon(Icons.person),
            ]),
        backgroundColor: Colors.black,
        body: IndexedStack(
          index: _currentindex,
          children: Screens,
        ));
  }
}
