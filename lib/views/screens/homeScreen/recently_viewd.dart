
import 'package:ecommerce_major_project/models/product_model.dart';
import 'package:flutter/material.dart';

class RecentlyViewed extends StatelessWidget {
  const RecentlyViewed({
    Key? key,
    required List<ProductModel> recentlyViewed,
  })  : _recentlyViewed = recentlyViewed,
        super(key: key);

  final List<ProductModel> _recentlyViewed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
          itemCount: _recentlyViewed.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(_recentlyViewed[index].image,
                                  height: 150, fit: BoxFit.contain, width: 200),
                              const SizedBox(height: 25),
                              SizedBox(
                                  width: 150,
                                  child: Center(
                                      child: Text(_recentlyViewed[index].title,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)))),
                              Text(
                                  'Rs ' +
                                      _recentlyViewed[index].price.toString(),
                                  style: const TextStyle(fontSize: 18)),
                            ]))));
          }),
    );
  }
}
