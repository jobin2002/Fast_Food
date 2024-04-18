import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';



class seeall extends StatefulWidget {
  const seeall({super.key});

  @override
  State<seeall> createState() => _seeallState();
}

class _seeallState extends State<seeall> {
  List Image=[];
  getData()async{
    var data = await FirebaseFirestore.instance.collection('Burger').orderBy('name').get();
    setState(() {
      Image= data.docs;
    });
  }
  @override
  void initState() {
   getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 250,
          child: GridView.builder(
            itemCount: Image.length,
            scrollDirection: Axis.horizontal,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey,
                                image: DecorationImage(
                                    image: NetworkImage(Image[index]['image']),
                                    fit: BoxFit.cover))),
                        SingleChildScrollView(scrollDirection: Axis.horizontal,
                            child: SizedBox(width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                      child: Align(alignment: Alignment.bottomLeft,
                                        child: Text(
                                          Image[index]['name'],maxLines: 2,overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),

                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Align(alignment: Alignment.bottomLeft,
                                      child: Text("₹${Image[index]['number']}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                 ]) ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
