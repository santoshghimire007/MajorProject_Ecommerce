import 'package:ecommerce_major_project/models/product_model.dart';
import 'package:flutter/material.dart';

class HotProducts extends StatelessWidget {
  const HotProducts({
    Key? key,
    required List<ProductModel> allProducts,
  })  : _hotProducts = allProducts,
        super(key: key);

  final List<ProductModel> _hotProducts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        child: ListView.builder(
            itemCount: _hotProducts.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Hero(
                tag: _hotProducts[index].id,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ProductDetailPage(
                              hotProducts: _hotProducts[index]);
                        }));
                      },
                      child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(_hotProducts[index].image,
                                        height: 150,
                                        fit: BoxFit.contain,
                                        width: 200),
                                    const SizedBox(height: 25),
                                    SizedBox(
                                        width: 150,
                                        child: Center(
                                            child: Text(
                                                _hotProducts[index].title,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)))),
                                    Text(
                                        'Rs ' +
                                            _hotProducts[index]
                                                .price
                                                .toString(),
                                        style: const TextStyle(fontSize: 18)),
                                  ]))),
                    )),
              );
            }));
  }
}

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
        body: Hero(
            tag: _hotProducts.id, child: Image.network(_hotProducts.image)));
  }
}
