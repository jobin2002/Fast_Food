import 'package:flutter/material.dart';

class twobtn extends StatefulWidget {
  const twobtn({super.key});

  @override
  State<twobtn> createState() => _twobtnState();
}

class _twobtnState extends State<twobtn> {
  @override
  Widget build(BuildContext context) {
    int num = 0;
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.white)),
              child: OutlinedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.remove,
                    size: 50,
                    color: Colors.white,
                  ))),
          Stack(alignment: Alignment.bottomCenter, children: [
            Container(
              height: 40,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28), color: Colors.white),
              child: Center(
                  child: Text(
                "&15.50",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              )),
            ),
            SizedBox(
                height: 80,
                child: Text(
                  "01",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ))
          ]),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.white)),
              child: OutlinedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.remove,
                    size: 50,
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }
}
