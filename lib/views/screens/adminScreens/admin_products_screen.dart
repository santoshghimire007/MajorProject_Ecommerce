import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_major_project/models/product_model.dart';
import 'package:ecommerce_major_project/services/apiServices/products_services.dart';
import 'package:ecommerce_major_project/views/screens/adminScreens/add_products_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AdminProductsScreen extends StatefulWidget {
  const AdminProductsScreen({Key? key, required this.ctgryValue})
      : super(key: key);
  final String ctgryValue;

  @override
  _AdminProductsScreenState createState() => _AdminProductsScreenState();
}

class _AdminProductsScreenState extends State<AdminProductsScreen> {
  // List<ProductModel> allProducts = [];

  // bool loader = false;

  // fetchAllProducts() async {
  //   setState(() {
  //     loader = true;
  //   });
  //   List<ProductModel> data = await getProductsData();

  //   setState(() {
  //     allProducts = data;

  //     loader = false;
  //   });
  // }

  // @override
  // void initState() {
  //   fetchAllProducts();
  //   super.initState();
  // }

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

  // var ctgry = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddProductsScreen()));
              },
              icon: const Icon(Icons.add))
        ],
        title: const Text('All Products'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: allProducts.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            // print(
            //   snapshot.data!.docs.length,
            // );

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var ctgry = snapshot.data!.docs[index]['category'];
                  var stockData = snapshot.data!.docs[index]['stock'];

                  return widget.ctgryValue == ctgry
                      ? Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                                // color: Colors.black45,
                                ),
                            padding: const EdgeInsets.all(10),
                            height: 450,
                            width: double.infinity,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 200,
                                  width: double.infinity,
                                  child: Image.network(
                                    snapshot.data!.docs[index]['imageUrl'] ??
                                        'https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 170,
                                    // decoration: BoxDecoration(
                                    //     border: Border.all(color: Colors.deepOrange)),
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
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  overflow:
                                                      TextOverflow.ellipsis)),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "Category: ${snapshot.data!.docs[index]['category']}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              IconButton(
                                                onPressed: () {
                                                  _deleteProduct(snapshot
                                                      .data!.docs[index].id);
                                                },
                                                icon: const Icon(
                                                    Icons.delete_forever),
                                                iconSize: 35,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Container();
                });
          }),
    );
  }
}
