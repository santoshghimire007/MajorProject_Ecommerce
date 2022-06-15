import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_major_project/enum/booking_enum.dart';
import 'package:ecommerce_major_project/services/sessionService/session_service.dart';
import 'package:flutter/material.dart';

class CartScreenFirebase extends StatefulWidget {
  const CartScreenFirebase({
    Key? key,
  }) : super(key: key);

  @override
  _CartScreenFirebaseState createState() => _CartScreenFirebaseState();
}

class _CartScreenFirebaseState extends State<CartScreenFirebase> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference cart = FirebaseFirestore.instance.collection('cart');
  double sum = 0;
  bool loader = false;
  var listForBooking = [];
  bool isEmptyCart = true;

  Future getCartPriceTotal() async {
    setState(() {
      sum = 0;
    });
    FirebaseFirestore.instance.collection('cart').get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        if (SessionService.userData!.uid == result['uid']) {
          setState(() {
            sum = sum + result.data()['price'];
          });
        }
      }
    });
  }

  bookingList() {
    FirebaseFirestore.instance.collection('cart').get().then((querySnapshot) {
      FirebaseFirestore.instance.collection("booking").add({
        "uid": SessionService.userData!.uid,
        "productId": listForBooking,
        "totalPrice": sum,
        "status": BookingEnum.pending.index
      }).whenComplete(() => loader = false);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Checkout successfully'),
        duration: Duration(seconds: 1),
      ));
    }).catchError((err) {
      setState(() {
        loader = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    });
  }

  @override
  void initState() {
    super.initState();
    getCartPriceTotal();
  }

  _deleteFromCart(id) {
    firestore.collection('cart').doc(id).delete().then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Item Deleted !')));
      setState(() {
        listForBooking.remove(id);
      });
    }, onError: (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: sum == 0.0 || sum == 0
            ? null
            : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Total: $sum'),
                TextButton(
                    onPressed: () {
                      bookingList();
                    },
                    child: const Text('Checkout'))
              ]),
        appBar: AppBar(title: const Text('Your Cart')),
        body: StreamBuilder<QuerySnapshot>(
            stream: cart
                .where("uid", isEqualTo: SessionService.userData!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Error');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                    child: Text('Empty Cart !!',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)));
              }

              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.active) {
                listForBooking = [];
                for (var item in snapshot.data!.docs) {
                  listForBooking.add(item['productId']);
                }
              }

              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: ListTile(
                            leading: CircleAvatar(
                                radius: 30.5,
                                backgroundImage: NetworkImage(
                                    snapshot.data!.docs[index]['imageUrl'])),
                            title: Text(snapshot.data!.docs[index]['name'],
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                            subtitle: Text(
                                "Rs: ${snapshot.data!.docs[index]['price']}"),
                            trailing: IconButton(
                                onPressed: () {
                                  _deleteFromCart(
                                      snapshot.data!.docs[index].id);
                                  getCartPriceTotal();
                                },
                                icon: const Icon(Icons.delete_forever,
                                    size: 40, color: Colors.deepOrange))));
                  });
            }));
  }
}
