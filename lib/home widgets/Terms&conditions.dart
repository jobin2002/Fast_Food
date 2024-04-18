import 'package:flutter/material.dart';

class Termsandconditions extends StatelessWidget {
  const Termsandconditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Terms & Conditions"),
            backgroundColor: Colors.black),
        backgroundColor: Colors.black,
        body: const SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Eligibility :"
                  "to use services Before using the services,"
                  " a user must provide every information required for"
                  " registration such as his name, address, contact details, and email."
                  " Generally, the user acknowledges and agrees that post which, the platforms will "
                  "consider your use of the services thereby approving acceptance of their terms by you.",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "Compliance of law :"
                    "All applicable laws must be followed by the user. By using the services offered, you (the user) agree to abide by all laws and regulations that are in effect in the nation in which you reside. You acknowledge that you may only use the services in accordance with the provided terms, and applicable law, and in a way that respects both the platform’s and third parties’ legal rights.",
                    style: TextStyle(color: Colors.white, fontSize: 17)),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "Terms of the services online food ordering :"
                    "The online food delivery model comes with its own set of benefits and drawbacks. They have agreements and contractual arrangements with restaurants while providing services through their platform.By creating an account in the platform, you consent to receive communications related to the same and the services it has to offer. Other customers may leave comments or follow the activity you undertake on your account, for instance. Through your account settings, you can choose not to receive or modify your preferences for non-essential communications."
                    "1. Every FDP must state in its agreement that it offers online food ordering services by entering into principal-to-principal contractual arrangements with restaurants to list their food and beverages for online ordering by users on the FDP Restaurant Partners"
                    "2. The Restaurant Partner shall comply with all applicable laws prohibiting the use of single-use plastic and shall ensure that no single-use plastic is used in the packing of any order and that no single-use plastic cutlery is provided with the order"
                    "3. Restaurant partner acknowledges and agrees that it won’t contact the customer on its own and won’t demand payments from them that are greater than what they agreed to when placing the order through the platform."
                    "4. In order to deliver the food and drinks that users have ordered through FDP, FDP must make it clear that it does not offer any delivery or logistics services and only makes it possible by connecting users with delivery partners or restaurants, as applicable."
                    "5. The FDP is not responsible for any actions or inactions by the delivery partner or restaurant partner, including but not limited to poor service, incorrect delivery of the order, delays in delivering the order, tampering with the order package, etc"
                    "6.  Food delivery app or website team has sole discretion to change terms & conditions at any time. If their team changes any content, they will notify you via site or app. You must consent to the modified terms and conditions. You may no longer use the services if you do not agree to be bound by the modified terms.",
                    style: TextStyle(color: Colors.white, fontSize: 17)),
              )
            ],
          ),
        ));
  }
}
