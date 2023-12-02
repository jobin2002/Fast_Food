import 'package:flutter/material.dart';
import 'package:untitled4/widgets/appbar.dart';
import 'package:untitled4/widgets/cardview.dart';
import 'package:untitled4/widgets/gridview.dart';
import 'package:untitled4/widgets/midcontain.dart';
import 'package:untitled4/widgets/textbutton.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
          bottomNavigationBarTheme:
              BottomNavigationBarThemeData(backgroundColor: Colors.black)),
      home: home(),
      debugShowCheckedModeBanner: false));
}

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    int _currentindex = 0;

    return Scaffold(
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.grey),
          child: BottomNavigationBar(
              unselectedItemColor: Colors.black,
              selectedItemColor: Colors.white,
              currentIndex: _currentindex,
              onTap: (int newindex) {
                setState(() {
                  _currentindex = newindex;
                });
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.explore), label: "Explore"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), label: "Cart"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Settings"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
              ])),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 45),
          child: Center(
              child: Text(
            "Tastee Meals",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              appbar(),
              midcontainer(),
              gridview(),
              txtbtn(),
              seeall(),
            ],
          ),
        ),
      ),
    );
  }
}
