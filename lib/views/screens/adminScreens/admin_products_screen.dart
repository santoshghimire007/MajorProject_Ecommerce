import 'package:ecommerce_major_project/models/product_model.dart';
import 'package:ecommerce_major_project/services/apiServices/products_services.dart';
import 'package:ecommerce_major_project/views/screens/adminScreens/add_products_screen.dart';
import 'package:flutter/material.dart';

class AdminProductsScreen extends StatefulWidget {
  const AdminProductsScreen({Key? key}) : super(key: key);

  @override
  _AdminProductsScreenState createState() => _AdminProductsScreenState();
}

class _AdminProductsScreenState extends State<AdminProductsScreen> {
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
        title: const Text('All Products'),
      ),
      body: loader == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: allProducts.length,
              itemBuilder: (BuildContext context, index) {
                return ListTile(
                  leading: SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.network(allProducts[index].image)),
                  title: Text(allProducts[index].title),
                  subtitle:
                      Text('Price : Rs ${allProducts[index].price.toString()}'),
                );
              }),
    );
  }
}
