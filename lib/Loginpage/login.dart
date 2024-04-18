import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled4/Admin%20Page/Admin.dart';
import 'package:untitled4/Botam%20navigation%20pages/Bottom_Navigation_bar.dart';
import 'package:untitled4/Loginpage/signup.dart';

class Userlogin extends StatefulWidget {
  const Userlogin({super.key});

  @override
  State<Userlogin> createState() => _UserloginState();
}

class _UserloginState extends State<Userlogin> {
  bool _issecurepassword = true;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Login"),
            backgroundColor: Colors.black,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Adminlogin(),
                        ));
                  },
                  icon: const Icon(Icons.admin_panel_settings))
            ]),
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
                                  left: 20, right: 20, top: 10, bottom: 4),
                              child: TextField(
                                  controller: _email,
                                  decoration: InputDecoration(
                                      labelText: "Email",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)))),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 4),
                              child: TextField(
                                  obscureText: _issecurepassword,
                                  controller: _password,
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
                              padding: const EdgeInsets.only(
                                top: 8,
                              ),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  width: 260,
                                  child: MaterialButton(
                                    onPressed: () {
                                      _signIn(
                                          email: _email.text,
                                          password: _password.text);
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
                            Padding(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account",
                                    style:
                                        GoogleFonts.bitter(color: Colors.black),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const Signupscrn(),
                                            ));
                                      },
                                      child: Text(
                                        "Sign Up",
                                        style: GoogleFonts.bitter(
                                            color: Colors.blue),
                                      ))
                                ],
                              ),
                            )
                          ]),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ));
  }

  _signIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text("No user found for that email")));
      } else if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Invalid Username or Password")));
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Username Cannot Be Empty")));
      } else if (e.code == 'missing-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Password Cannot Be Empty")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red, content: Text(e.code.toString())));
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
}
