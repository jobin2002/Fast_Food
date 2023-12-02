import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class detail extends StatelessWidget {
  const detail({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlassmorphicContainer(
        width: 140,
        height: 100,
        borderRadius: 18,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Double cheese",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
              Text("burger",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              Text("420gm",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold))
            ],
          ),
        ),
        linearGradient:
            LinearGradient(colors: [Colors.white54, Colors.white54]),
        border: 0,
        blur: 20,
        borderGradient: LinearGradient(colors: [Colors.white54, Colors.white]),
      ),
    );
  }
}
