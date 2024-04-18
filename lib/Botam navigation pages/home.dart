import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
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
  void initState() {
    Future.delayed(
      const Duration(seconds: 9),
      () {
        requestNotificationPermissions();
      },
    );
    super.initState();
  }

  void requestNotificationPermissions() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
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
