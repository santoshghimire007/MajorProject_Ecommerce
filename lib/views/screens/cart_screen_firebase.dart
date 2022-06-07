import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';

class CartScreenFirebase extends StatefulWidget {
  CartScreenFirebase({
    Key? key,
  }) : super(key: key);

  @override
  _CartScreenFirebaseState createState() => _CartScreenFirebaseState();
}

class _CartScreenFirebaseState extends State<CartScreenFirebase> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference cart = FirebaseFirestore.instance.collection('cart');
  double sum = 0;

  Future getTotal() async {
    FirebaseFirestore.instance.collection('cart').get().then(
      (querySnapshot) {
        for (var result in querySnapshot.docs) {
          setState(() {
            sum = sum + result['price'];
          });
        }
        // print(sum);
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total: $sum'),
            TextButton(onPressed: () {}, child: const Text('Checkout'))
          ],
        ),
        appBar: AppBar(title: const Text('Your Cart')),
        body: StreamBuilder<QuerySnapshot>(
            stream: cart.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Error');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        // leading: Text((index + 1).toString())
                        leading: CircleAvatar(
                            radius: 30.5,
                            backgroundImage: NetworkImage(
                                snapshot.data!.docs[index]['imageUrl'])),

                        title: Text(
                          snapshot.data!.docs[index]['name'],
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        subtitle:
                            Text("Rs: ${snapshot.data!.docs[index]['price']}"),
                      ),
                    );
                  });
            }));
  }
}
