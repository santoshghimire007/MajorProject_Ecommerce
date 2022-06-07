import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_major_project/views/screens/cart_screen_firebase.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.detailProduct}) : super(key: key);

  final QueryDocumentSnapshot<Object?> detailProduct;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool loader = false;

  void _saveCart() {
    FirebaseFirestore.instance.collection("cart").add({
      "imageUrl": widget.detailProduct['imageUrl'],
      "name": widget.detailProduct['name'],
      "price": widget.detailProduct['price'],
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
            Text(
              'Rs: ' + widget.detailProduct['price'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
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
                  _saveCart();
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
