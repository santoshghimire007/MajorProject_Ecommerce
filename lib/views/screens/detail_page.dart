import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_major_project/models/user_model.dart';
import 'package:ecommerce_major_project/services/sessionService/session_service.dart';
import 'package:ecommerce_major_project/views/screens/cart_screen_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.detailProduct}) : super(key: key);

  final QueryDocumentSnapshot<Object?> detailProduct;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool loader = false;
  late Map<String, dynamic> userInfo;
  getUserData() async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    var userInfoString = loginData.getString('uid');
    userInfo = jsonDecode(userInfoString!);
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  void _saveCart() {
    FirebaseFirestore.instance.collection("cart").add({
      "uid": userInfo['uid'],
      "productId": widget.detailProduct.id,
      "imageUrl": widget.detailProduct['imageUrl'],
      "name": widget.detailProduct['name'],
      "price": double.parse(widget.detailProduct['price'].toString()),
      "description": widget.detailProduct['description'],
      "stock": widget.detailProduct['stock'],
      "category": widget.detailProduct['category'],
    }).whenComplete(() {
      setState(() {
        loader = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Added to cart successfully'),
        duration: Duration(seconds: 1),
      ));
      _goHome();
    }).catchError((err) {
      setState(() {
        loader = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    });
  }

  _goHome() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.detailProduct['price']);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.detailProduct['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(
                widget.detailProduct['imageUrl'],
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Name: ' + widget.detailProduct['name'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            // Text(
            //   'Rs: ${widget.detailProduct['price']} ',
            //   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            // ),
            const SizedBox(
              height: 10,
            ),
            widget.detailProduct['stock'] == true
                ? const Text("Stock: Available",
                    style: TextStyle(fontWeight: FontWeight.bold))
                : const Text("Stock: Not Available",
                    style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Description: ' + widget.detailProduct['description'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Category: ' + widget.detailProduct['category'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("cart")
                      .where("productId", isEqualTo: widget.detailProduct.id)
                      .where("uid", isEqualTo: SessionService.userData!.uid)
                      .get()
                      .then((value) {
                    if (value.docs.isEmpty) {
                      _saveCart();
                    } else {
                      // print('Product Already Exists');
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Product Already Exist')));
                    }
                  });
                },
                child: const Text('Add to cart'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
