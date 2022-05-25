import 'package:ecommerce_major_project/views/screens/cart_screen.dart';
import 'package:ecommerce_major_project/views/screens/provider.dart';
import 'package:flutter/material.dart';

import '../../models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    Key? key,
    required this.heroId,
    required ProductModel hotProducts,
  })  : _details = hotProducts,
        super(key: key);

  // final ProductModel _hotProducts;
  final ProductModel _details;
  final int heroId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_details.title),
          backgroundColor: Colors.deepOrange,
        ),
        bottomNavigationBar: SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepOrange)),
                onPressed: () {
                  ProductCart.cartItems.add(_details);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
                child: const Text(
                  'Add to Card',
                  style: TextStyle(fontSize: 16),
                )),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Hero(
                    tag: _details.id,
                    child: Image.network(
                      _details.image,
                      height: 250,
                    )),
                Text(_details.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
                const SizedBox(height: 10),
                Text(_details.description),
                const SizedBox(height: 10),
                Text('Price: ${_details.price.toString()}'),
              ],
            )));
  }
}
