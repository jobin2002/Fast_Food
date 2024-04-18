import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          "UPI Payments",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
