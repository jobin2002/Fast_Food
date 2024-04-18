import 'package:flutter/material.dart';
import 'package:untitled4/Botam%20navigation%20pages/explore.dart';
import 'package:untitled4/Botam%20navigation%20pages/profile.dart';
import 'package:untitled4/home%20widgets/topcontnt.dart';
import 'package:untitled4/home%20widgets/cardview.dart';
import 'package:untitled4/home%20widgets/gridview.dart';
import 'package:untitled4/home%20widgets/banner.dart';
import 'package:untitled4/home%20widgets/seealltxt.dart';



class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  @override
  Widget build(BuildContext context) {
    // int _currentindex = 0;

    return Scaffold(
      // bottomNavigationBar: Theme(
      //     data: Theme.of(context).copyWith(canvasColor: Colors.grey),
      //     child: BottomNavigationBar(
      //         unselectedItemColor: Colors.black,
      //         selectedItemColor: Colors.white,
      //         currentIndex: _currentindex,
      //         onTap: (int newindex) {
      //           setState(() {
      //             _currentindex = newindex;
      //             // if(newindex==3){
      //             //   Navigator.push(context, MaterialPageRoute(builder: (context) => Profilepage(),));
      //             // }else if(newindex==1){
      //             //   Navigator.push(context, MaterialPageRoute(builder: (context) => Explorepage(),));
      //             // }
      //             Screens[_currentindex];
      //           });
      //         },
      //         items: const [
      //           BottomNavigationBarItem(
      //               icon: Icon(Icons.home), label: "Home"),
      //           BottomNavigationBarItem(
      //               icon: Icon(Icons.explore), label: "Explore"),
      //           BottomNavigationBarItem(
      //               icon: Icon(Icons.shopping_cart), label: "Cart"),
      //           BottomNavigationBarItem(
      //               icon: Icon(Icons.person), label: "Profile"),
      //         ])),
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 45),
          child: Center(
              child: Text(
            "Tastee Meals",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
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
