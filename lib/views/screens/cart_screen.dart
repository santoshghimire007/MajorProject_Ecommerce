import 'dart:developer';

import 'package:ecommerce_major_project/models/product_model.dart';
import 'package:ecommerce_major_project/views/screens/provider.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  // final List<ProductModel> _cartProduct;
  // List<ProductModel> _cartProduct = [];

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<ProductModel> _cartProducts = [];
  double _cartAmount = 0.0;

  getTotalAmount() {
    double amount = 0.0;
    for (var item in _cartProducts) {
      amount = amount + item.price;
    }
    setState(() {
      _cartAmount = amount;
    });
  }

  @override
  void initState() {
    _cartProducts = ProductCart.cartItems;
    getTotalAmount();

    super.initState();
  }

  removeFromCart(int id) {
    setState(() {
      ProductCart.cartItems.removeAt(id);
    });
    getTotalAmount();
  }

  @override
  Widget build(BuildContext context) {
    // print(_cartAmount);
    return Scaffold(
      bottomNavigationBar: SizedBox(
          height: 50,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrange)),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => Container(
                              height: 450,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50.0),
                                      topRight: Radius.circular(50.0))),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),

                                  const Text(
                                    'Do you want to checkout?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    'Total Price: ${_cartAmount.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // const Spacer(),
                                  Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: _cartProducts.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Card(
                                            elevation: 5,
                                            shadowColor: Colors.deepOrange,
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                  child: Text(
                                                      _cartProducts[index]
                                                          .id
                                                          .toString())),
                                              title: Image.network(
                                                _cartProducts[index].image,
                                                height: 55,
                                              ),
                                              trailing: Text(
                                                'Price: ${_cartProducts[index].price.toString()}',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.deepOrange)),
                                    onPressed: () {},
                                    child: const Text(
                                      'Checkout',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ));
                  },
                  child: const Text('Proceed to Checkout',
                      style: TextStyle(fontSize: 16))))),
      appBar: AppBar(title: const Text('Cart')),
      body: _cartProducts.isEmpty
          ? const Center(
              child: Text(
                'No Products Added !',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Raleway'),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: _cartProducts.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        Expanded(
                            flex: 3,
                            child: Image.network(_cartProducts[index].image,
                                height: 120)),
                        Expanded(
                          flex: 7,
                          child: ListTile(
                            title: Text(_cartProducts[index].title),
                            subtitle: Text(
                                'Rs ' + _cartProducts[index].price.toString()),
                            trailing: IconButton(
                                onPressed: () {
                                  removeFromCart(index);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Deleted !!'),
                                      duration: Duration(seconds: 1),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete_forever,
                                  size: 40,
                                  color: Colors.red,
                                )),
                          ),
                        ),
                      ]),
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.deepOrange,
                    ),
                  ],
                );
              }),
    );
  }
}
