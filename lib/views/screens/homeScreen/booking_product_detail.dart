// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_major_project/models/booking_detail_model.dart';
import 'package:ecommerce_major_project/models/product_model.dart';
import 'package:ecommerce_major_project/models/user_model.dart';
import 'package:flutter/material.dart';

class BookingProductDetail extends StatefulWidget {
  BookingProductDetail({Key? key, required this.bookingProductDetail})
      : super(key: key);

  BookingDetailsModel bookingProductDetail;

  @override
  _BookingProductDetailState createState() => _BookingProductDetailState();
}

class _BookingProductDetailState extends State<BookingProductDetail> {
  UserModel? userData;
  List<ProductModelFirebase> productModel = [];

  getUserDetails() async {
    FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: widget.bookingProductDetail.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        UserModel data = UserModel(
            uid: value.docs[0]['uid'],
            email: value.docs[0]['email'],
            displayName: value.docs[0]['displayName'],
            profileImage: value.docs[0]['profileImage']);
        setState(() {
          userData = data;
        });
      }
    });
  }

  getProductsDetails() {
    for (var item in widget.bookingProductDetail.productId) {
      FirebaseFirestore.instance
          .collection('allProducts')
          .doc(item)
          .get()
          .then((value) => {
                setState(() {
                  productModel.add(ProductModelFirebase(
                      category: value['category'],
                      imageUrl: value['imageUrl'],
                      stock: value['stock'],
                      price: value['price'],
                      name: value['name'],
                      description: value['description']));
                })
              });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
    getProductsDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Booking Products')),
        body: userData == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const SizedBox(height: 20),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(userData!.profileImage),
                    ),
                    title: Text(userData!.displayName!),
                    subtitle: Text(userData!.email),
                  ),
                  const Text(
                    'Ordered List',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                      height: 200,
                      child: ListView.builder(
                          itemCount: productModel.length,
                          itemBuilder: (ctx, ind) {
                            return Card(
                              elevation: 7,
                              child: ListTile(
                                title: Text(productModel[ind].name.toString()),
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        productModel[ind].imageUrl.toString())),
                                trailing: Text(
                                  productModel[ind].price.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          }))
                ],
              ));
  }
}
