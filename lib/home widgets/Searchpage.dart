import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/home%20widgets/detailpage.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchState();
}

class _SearchState extends State<Searchpage> {
  @override
  void initState() {
    _search.addListener(onSearchChanged);
    super.initState();
  }

  @override
  void dispose() {
    _search.removeListener(onSearchChanged);
    _search.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getDataStream();
    super.didChangeDependencies();
  }

  List _allResult = [];
  List _resultlist = [];

  _searchResult() {
    var showResult = [];
    if (_search.text != "") {
      for (var uploadSnapshot in _allResult) {
        var data = uploadSnapshot.data(); // Access data using data() method
        var name = data['name'].toString().toLowerCase();
        if (name.contains(_search.text.toLowerCase())) {
          showResult.add(data); // Add data instead of snapshot
        }
      }
    } else {
      showResult = List.from(_allResult.map((snapshot) => snapshot.data()));
    }
    setState(() {
      _resultlist = showResult;
    });
  }

  getDataStream() async {
    var data1 = await FirebaseFirestore.instance
        .collection('Upload_Items')
        .orderBy('name')
        .get();

    var data2 = await FirebaseFirestore.instance
        .collection('Vegetable')
        .orderBy('name')
        .get();

    var data3 = await FirebaseFirestore.instance
        .collection('Burger')
        .orderBy('name')
        .get();
    var data4 = await FirebaseFirestore.instance
        .collection('Pizza')
        .orderBy('name')
        .get();
    var data5 = await FirebaseFirestore.instance
        .collection('Coffee')
        .orderBy('name')
        .get();

    var data6 = await FirebaseFirestore.instance
        .collection('Rice_bowl')
        .orderBy('name')
        .get();
    var data7 = await FirebaseFirestore.instance
        .collection('Chicken')
        .orderBy('name')
        .get();
    var data8 = await FirebaseFirestore.instance
        .collection('Salad')
        .orderBy('name')
        .get();
    var data9 = await FirebaseFirestore.instance
        .collection('Bubble_tea')
        .orderBy('name')
        .get();

    var allResult = [
      ...data1.docs,
      ...data2.docs,
      ...data3.docs,
      ...data4.docs,
      ...data5.docs,
      ...data6.docs,
      ...data7.docs,
      ...data8.docs,
      ...data9.docs
    ];

    setState(() {
      _allResult = allResult;
    });

    _searchResult();
  }

  final TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Find Your Meals"),
            backgroundColor: Colors.black,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: AnimSearchBar(
                    width: 300,
                    textController: _search,
                    onSuffixTap: () {},
                    onSubmitted: (p0) {},
                  ),
                ),
              )
            ]),
        backgroundColor: Colors.black,
        body: _allResult.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  itemCount: _resultlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailPage(item: _resultlist[index]),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 3,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(20)),
                                child: Image.network(
                                  "${_resultlist[index]['image']}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                                height: 8), // Added SizedBox for spacing
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "${_resultlist[index]['name']}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                                height: 4), // Added SizedBox for spacing
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "₹${_resultlist[index]['number']}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(
                                height: 8), // Added SizedBox for spacing
                          ],
                        ),
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                ),
              ));
  }

  void onSearchChanged() {
    _searchResult();
  }
}
