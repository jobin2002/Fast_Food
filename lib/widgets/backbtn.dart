import 'package:flutter/material.dart';
import 'package:untitled4/home.dart';

class backbtn extends StatelessWidget {
  const backbtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: OutlinedButton(
                onPressed: () {Navigator.pop(context, MaterialPageRoute(builder:(context)=>home() ));},
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                style: ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(50,57))),
              )),
        ),
      ],
    );
  }
}
