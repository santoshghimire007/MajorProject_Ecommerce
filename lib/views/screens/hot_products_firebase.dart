import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_major_project/views/screens/detail_page.dart';
import 'package:flutter/material.dart';

class HotProductsFirebase extends StatefulWidget {
  const HotProductsFirebase({Key? key}) : super(key: key);

  @override
  State<HotProductsFirebase> createState() => _HotProductsFirebaseState();
}

class _HotProductsFirebaseState extends State<HotProductsFirebase> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference allProducts =
      FirebaseFirestore.instance.collection('allProducts');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: allProducts.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return SizedBox(
            height: 300,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 4,
                      margin: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: 168,
                                  child: Image.network(
                                      snapshot.data!.docs[index]['imageUrl'] ??
                                          'https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg',
                                      fit: BoxFit.contain)),
                              Text(
                                snapshot.data!.docs[index]['name'],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "Rs: ${snapshot.data!.docs[index]['price']}"),
                              Row(
                                children: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailPage(
                                                      detailProduct: snapshot
                                                          .data!.docs[index],
                                                    )));
                                      },
                                      child: const Text('See more..')),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.favorite_outline_rounded))
                                ],
                              )
                            ]),
                      ));
                }),
          );
        });
  }
}
