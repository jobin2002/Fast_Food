import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slider_action/slider_action.dart';
import 'package:untitled4/Botam%20navigation%20pages/Bottom_Navigation_bar.dart';
import 'package:untitled4/Loginpage/login.dart';

class frontscrn extends StatefulWidget {
  const frontscrn({super.key});

  @override
  State<frontscrn> createState() => _frontscrnState();
}

class _frontscrnState extends State<frontscrn> {
  final slideActionKey = GlobalKey<SlideActionState>();
  var auth = FirebaseAuth.instance;
  var isLogin = false;

  checkIflogin() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const SizedBox(
          height: 40,
        ),
        const Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(
                      'assets/images/png1.png',
                    ),
                    height: 450,
                    fit: BoxFit.fill,
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Cooking ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            height: 1,
                            wordSpacing: 2),
                      )),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text("Delicious like a",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 40,
                              height: 1.5,
                              wordSpacing: 1))),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text("Chef",
                        style: TextStyle(
                            color: Colors.white60,
                            fontSize: 30,
                            wordSpacing: 1,
                            height: 1.3)),
                  ),
                ],
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SlideAction(
                    key: slideActionKey,
                    onSubmit: () {
                      checkIflogin();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  isLogin ? const Home() : const Userlogin()));
                      Future.delayed(const Duration(seconds: 15), () {
                        slideActionKey.currentState!.reset();
                      });
                    },
                    innerColor: Colors.black,
                    outerColor: Colors.white,
                    sliderButtonIcon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    child: const Text("Get Started",
                        style: TextStyle(fontSize: 23))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        )
      ]),
    );
  }
}
