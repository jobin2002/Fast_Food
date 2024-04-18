import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled4/Admin%20Page/contentadd.dart';

class Adminlogin extends StatelessWidget {
  Adminlogin({super.key});

  final TextEditingController _admin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Stack(
                children: [
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(right: 25),
                      child: Image(
                          image: AssetImage("assets/images/bgcolor2.png"),
                          height: 390,
                          width: 500,
                          fit: BoxFit.contain),
                    ),
                  ),
                  Center(
                    child: GlassmorphicContainer(
                      width: 300,
                      height: 400,
                      borderRadius: 18,
                      linearGradient: const LinearGradient(
                          colors: [Colors.white54, Colors.white54]),
                      border: 0,
                      blur: 10,
                      borderGradient: const LinearGradient(
                          colors: [Colors.black12, Colors.black12]),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.inknutAntiqua(
                                        fontSize: 28,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 10,
                                              offset:
                                                  Offset.fromDirection(-150, 7))
                                        ],
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 20),
                              child: TextField(
                                  obscureText: true,
                                  controller: _admin,
                                  decoration: InputDecoration(
                                      labelText: "Password",
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.blue),
                                          borderRadius:
                                              BorderRadius.circular(10)))),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 120.0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  width: 260,
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (_admin.text == "Admin1234") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const Addcontent(),
                                            ));
                                      }
                                    },
                                    color: Colors.black26,
                                    elevation: 20,
                                    highlightColor: Colors.green,
                                    height: 55,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text("Login",
                                        style: GoogleFonts.aBeeZee(
                                            color: Colors.white)),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ));
  }
}
