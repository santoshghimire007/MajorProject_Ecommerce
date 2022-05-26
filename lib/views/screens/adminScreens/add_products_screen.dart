import 'package:ecommerce_major_project/models/product_model.dart';
import 'package:ecommerce_major_project/services/apiServices/products_services.dart';
import 'package:flutter/material.dart';

class AddProductsScreen extends StatefulWidget {
  const AddProductsScreen({Key? key}) : super(key: key);

  @override
  _AddProductsScreenState createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  List<ProductModel> allProducts = [];

  bool loader = false;

  fetchAllProducts() async {
    setState(() {
      loader = true;
    });
    List<ProductModel> data = await getProductsData();

    setState(() {
      allProducts = data;

      loader = false;
    });
  }

  @override
  void initState() {
    fetchAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Products'),
      ),
      body: loader == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: allProducts.length,
              itemBuilder: (BuildContext context, index) {
                return ListTile(
                  title: Text(allProducts[index].title),
                );
              }),
    );
  }
}
