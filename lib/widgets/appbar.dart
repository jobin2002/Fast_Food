import 'package:flutter/material.dart';

class appbar extends StatelessWidget {
  const appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12)),
            child: OutlinedButton(
                onPressed: () {},
                style: ButtonStyle(
                    minimumSize:
                    MaterialStatePropertyAll(Size(50, 60))),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ))),
        Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12)),
            child: OutlinedButton(
                onPressed: () {},
                style: ButtonStyle(
                    minimumSize:
                    MaterialStatePropertyAll(Size(50, 60))),
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ))),
      ],
    );
  }
}
