import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled4/Botam%20navigation%20pages/Bottom_Navigation_bar.dart';

class Signupscrn extends StatefulWidget {
  const Signupscrn({super.key});

  @override
  State<Signupscrn> createState() => _SignupscrnState();
}

class _SignupscrnState extends State<Signupscrn> {
  bool _issecurepassword = true;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  String imageUrl = "";

  @override
  void dispose() {
    _username.dispose();
    _age.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: const Text("Sign Up"), backgroundColor: Colors.black),
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Stack(
                children: [
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(right: 320, top: 230),
                      child: Image(
                        image: AssetImage("assets/images/kfcchickenfry.png"),
                        height: 250,
                        width: 150,
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(left: 330, top: 100),
                      child: Image(
                        image: AssetImage("assets/images/juice.png"),
                        height: 200,
                        width: 100,
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(right: 25, left: 30),
                      child: Image(
                        image: AssetImage("assets/images/bgcolor4.png"),
                        height: 390,
                        width: 300,
                      ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "Sign Up",
                                  style: GoogleFonts.inknutAntiqua(
                                      fontSize: 20,
                                      color: Colors.black54,
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 3, top: 3, left: 20, right: 20),
                              child: TextField(
                                  controller: _username,
                                  decoration: InputDecoration(
                                      labelText: "Name",
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)))),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 3, top: 3, left: 20, right: 20),
                              child: TextField(
                                  controller: _age,
                                  decoration: InputDecoration(
                                      labelText: "Age",
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)))),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 3, top: 3, left: 20, right: 20),
                              child: TextField(
                                  controller: _email,
                                  decoration: InputDecoration(
                                      labelText: "Email",
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)))),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 3, top: 3, left: 20, right: 20),
                              child: TextField(
                                  controller: _password,
                                  obscureText: _issecurepassword,
                                  decoration: InputDecoration(
                                      labelText: "Password",
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.blue),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      suffixIcon: togglepassword())),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: SizedBox(
                                width: 260,
                                child: MaterialButton(
                                  onPressed: () {
                                    if (_username.text.isEmpty ||
                                        _age.text.isEmpty ||
                                        _email.text.isEmpty ||
                                        _password.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                  "Field Cannot Be Empty")));
                                    } else {
                                      _signUp(
                                          email: _email.text,
                                          password: _password.text);
                                      Future.delayed(
                                        Duration(seconds: 5),
                                        () {
                                          addUserdetails();
                                        },
                                      );
                                    }
                                  },
                                  color: Colors.black26,
                                  elevation: 20,
                                  highlightColor: Colors.green,
                                  height: 55,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text("Sign Up",
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.white)),
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

  _signUp({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text("The password is too weak")));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text("The email is already in use")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red, content: Text(e.message.toString())));
      }
    }
  }

  Widget togglepassword() {
    return IconButton(
        onPressed: () {
          setState(() {
            _issecurepassword = !_issecurepassword;
          });
        },
        icon: _issecurepassword
            ? const Icon(Icons.visibility_off)
            : const Icon(Icons.visibility));
  }

  Future<void> addUserdetails() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return;
      }
      String? email = currentUser.email;
      String userId = currentUser.uid;
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').get();

      if (snapshot.docs.isNotEmpty) {
        await FirebaseFirestore.instance.collection('users').add({
          'userId': userId,
          'email': email,
          'name': _username.text,
          'age': _age.text,
          'imageUrl': imageUrl,
        });
      } else {}
    } catch (error) {}
  }
}
