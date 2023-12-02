import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:untitled4/home.dart';

void main() {
  runApp(MaterialApp(home: Myapp(), debugShowCheckedModeBanner: false));
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              Padding(
                padding: const EdgeInsets.only(top: 50),
                  child: SlideAction(
                      onSubmit: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => home()));
                      },
                      innerColor: Colors.black,
                      outerColor: Colors.white,
                      child:
                      Text("Get Started", style: TextStyle(fontSize: 23)),
                      sliderButtonIcon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
