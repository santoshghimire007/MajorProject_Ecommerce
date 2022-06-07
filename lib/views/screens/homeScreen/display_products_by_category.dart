import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_major_project/views/screens/cart_screen_firebase.dart';
import 'package:flutter/material.dart';

class UserProductsScreen extends StatefulWidget {
  const UserProductsScreen({Key? key, required this.ctgryValue})
      : super(key: key);
  final String ctgryValue;

  @override
  _AdminProductsScreenState createState() => _AdminProductsScreenState();
}

class _AdminProductsScreenState extends State<UserProductsScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference allProducts =
      FirebaseFirestore.instance.collection('allProducts');

  _deleteProduct(id) {
    firestore.collection('allProducts').doc(id).delete().then((doc) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Item Deleted !')));
    }, onError: (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.ctgryValue)),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("allProducts")
                .where("category", isEqualTo: widget.ctgryValue)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No Data'));
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var stockData = snapshot.data!.docs[index]['stock'];
                    return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 450,
                            width: double.infinity,
                            child: Column(children: <Widget>[
                              SizedBox(
                                  height: 200,
                                  width: double.infinity,
                                  child: Image.network(
                                      snapshot.data!.docs[index]['imageUrl'] ??
                                          'https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg',
                                      fit: BoxFit.contain)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 170,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Text(
                                              "Name: ${snapshot.data!.docs[index]['name']}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              "Price: ${snapshot.data!.docs[index]['price']}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          stockData == true
                                              ? const Text("Stock: Available",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold))
                                              : const Text(
                                                  "Stock: Not Available",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                          Text(
                                              "Description: ${snapshot.data!.docs[index]['description']}",
                                              maxLines: 2,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                          const SizedBox(height: 5),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "Category: ${snapshot.data!.docs[index]['category']}",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (ctx) =>
                                                                  CartScreenFirebase()));
                                                    },
                                                    icon: const Icon(
                                                        Icons.favorite),
                                                    iconSize: 35),
                                              ])
                                        ]),
                                  ),
                                ),
                              ),
                            ])));
                  });
            }));
  }
}
