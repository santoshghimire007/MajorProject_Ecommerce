import 'package:flutter/material.dart';

import '../../models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    Key? key,
    required ProductModel hotProducts,
  })  : _hotProducts = hotProducts,
        super(key: key);

  final ProductModel _hotProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_hotProducts.title),
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
                onPressed: () {},
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
                    tag: _hotProducts.id,
                    child: Image.network(
                      _hotProducts.image,
                      height: 250,
                    )),
                Text(_hotProducts.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
                const SizedBox(height: 10),
                Text(_hotProducts.description),
                const SizedBox(height: 10),
                Text(_hotProducts.price.toString()),
              ],
            )));
  }
}
