import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_major_project/enum/booking_enum.dart';
import 'package:ecommerce_major_project/models/booking_detail_model.dart';
import 'package:ecommerce_major_project/views/screens/homeScreen/booking_product_detail.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Pending extends StatefulWidget {
  const Pending({Key? key}) : super(key: key);

  @override
  _PendingState createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference booking =
      FirebaseFirestore.instance.collection('booking');
  var docId;
  // ignore: prefer_typing_uninitialized_variables
  var documentSnapshot;

  void _updateStatus({required int updateVale}) async {
    try {
      await firestore
          .collection('booking')
          .doc(docId)
          .update({'status': updateVale});

      // await firestore.collection('products').add({'name': 'Shoe', 'price': 99});   //For auto increment id use add

    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: booking
                .where('status', isEqualTo: BookingEnum.pending.index)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('eror');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                    child: Text('No pending order !!',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)));
              }

              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, index) {
                    docId = snapshot.data!.docs[index].id;
                    documentSnapshot = FirebaseFirestore.instance
                        .collection('booking')
                        .where(docId)
                        .get();
                    String jsonResponse =
                        jsonEncode(snapshot.data!.docs[index].data());


                    BookingDetailsModel bookingDetails =
                        BookingDetailsModel.fromJson(jsonDecode(jsonResponse));


                        
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookingProductDetail(
                                      bookingProductDetail: bookingDetails,
                                    )));
                      },
                      child: Card(
                          elevation: 5,
                          child: ListTile(
                              title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: const Text("Pending",
                                            textAlign: TextAlign.justify))
                                  ]),
                              trailing: Column(children: [
                                const SizedBox(height: 20),
                                Text(
                                    'Rs: ${snapshot.data!.docs[index]['totalPrice']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold))
                              ]),
                              subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          _updateStatus(
                                              updateVale:
                                                  BookingEnum.rejected.index);
                                        },
                                        child: const Text('Reject')),
                                    TextButton(
                                        onPressed: () {
                                          _updateStatus(
                                              updateVale:
                                                  BookingEnum.accepted.index);
                                        },
                                        child: const Text('Confirm'))
                                  ]))),
                    );
                  });
            }));
  }
}
