import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_major_project/models/product_model.dart';
import 'package:http/http.dart' as http;

Future<List<ProductModel>> getProductsData() async {
  final response =
      await http.get(Uri.parse('https://fakestoreapi.com/products'));
  if (response.statusCode == HttpStatus.ok) {
    var result = jsonDecode(response.body);
    List<ProductModel> allProducts = [];
    for (var product in result) {
      allProducts.add(ProductModel.fromJson(product));
    }
    return allProducts;
  } else {
    return [];
  }
}

Future<List<String>> getCategories() async {
  final response =
      await http.get(Uri.parse("https://fakestoreapi.com/products/categories"));
  if (response.statusCode == HttpStatus.ok) {
    var result = jsonDecode(response.body);
    List<String> categories = [];
    for (var product in result) {
      categories.add(product);
    }
    return categories;
  } else {
    return [];
  }
}

Future<List<ProductModel>> getRecentlyViewed() async {
  final response =
      await http.get(Uri.parse("https://fakestoreapi.com/products?limit=5"));
  if (response.statusCode == HttpStatus.ok) {
    var result = jsonDecode(response.body);
    List<ProductModel> allProducts = [];
    for (var product in result) {
      allProducts.add(ProductModel.fromJson(product));
    }
    return allProducts;
  } else {
    return [];
  }
}

Future<List<ProductModel>> getSingleCategory({required String cate}) async {
  final response = await http
      .get(Uri.parse("https://fakestoreapi.com/products/category/$cate"));
  if (response.statusCode == HttpStatus.ok) {
    var result = jsonDecode(response.body);
    List<ProductModel> singleCat = [];
    for (var product in result) {
      singleCat.add(ProductModel.fromJson(product));
    }
    return singleCat;
  } else {
    return [];
  }
}
