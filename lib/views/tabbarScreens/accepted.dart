import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_major_project/enum/booking_enum.dart';
import 'package:flutter/material.dart';

class Accepted extends StatefulWidget {
  const Accepted({Key? key}) : super(key: key);

  @override
  _AcceptedState createState() => _AcceptedState();
}

class _AcceptedState extends State<Accepted> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference booking =
      FirebaseFirestore.instance.collection('booking');

  totalProduct() {
    booking.get().then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: booking
                .where('status', isEqualTo: BookingEnum.accepted.index)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('eror');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, index) {
                    return Card(
                        elevation: 5,
                        child: ListTile(
                          title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: const Text("Accepted",
                                        textAlign: TextAlign.justify))
                              ]),
                          trailing: Column(children: [
                            const SizedBox(height: 20),
                            Text(
                                'Rs: ${snapshot.data!.docs[index]['totalPrice']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))
                          ]),
                        ));
                  });
            }));
  }
}
