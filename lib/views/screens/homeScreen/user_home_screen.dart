import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_major_project/models/product_model.dart';
import 'package:ecommerce_major_project/services/apiServices/products_services.dart';
import 'package:ecommerce_major_project/views/screens/category_details_screen.dart';
import 'package:ecommerce_major_project/views/screens/homeScreen/hot_products.dart';
import 'package:ecommerce_major_project/views/screens/homeScreen/recently_viewd.dart';
import 'package:flutter/material.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  List<ProductModel> _hotProducts = [];
  List<ProductModel> _recentlyViewed = [];
  List<String> _categories = [];
  bool _loading = false;

  // _fetchAllProduct() async {
  //   List<ProductModel> data = await getProductsData();
  //   setState(() {
  //     data.shuffle();
  //     _hotProducts = data;
  //   });
  // }

  // _getRecentlyViewd() async {
  //   List<ProductModel> data = await getRecentlyViewed();
  //   setState(() {
  //     _recentlyViewed = data;
  //   });
  // }

  // _fetchCategories() async {
  //   List<String> data = await getCategories();
  //   setState(() {
  //     _categories = data;
  //   });
  // }

  fetchAllData() async {
    setState(() {
      _loading = true;
    });
    List data = await Future.wait([
      getCategories(),
      getProductsData(),
      getRecentlyViewed(),
    ]);
    setState(() {
      _categories = data[0];
      data[1].shuffle();
      _hotProducts = data[1];
      _recentlyViewed = data[2];
      _loading = false;
    });
  }

  @override
  void initState() {
    fetchAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Home'),
            backgroundColor: Colors.deepOrange,
            automaticallyImplyLeading: false),
        body: _loading == true
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const BannerCarousel(),
                      // Image.network(
                      //     'https://static.vecteezy.com/system/resources/thumbnails/002/216/694/small/shopping-trendy-banner-vector.jpg'),
                      const SizedBox(height: 15),
                      const Center(
                        child: Text("Select Category",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrangeAccent,
                              fontSize: 15,
                            )),
                      ),
                      const SizedBox(height: 10),

                      SizedBox(
                          height: 30,
                          child: ListView.builder(
                              itemCount: _categories.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3.0),
                                    child: ActionChip(

                                        // elevation: 0,
                                        shadowColor: Colors.deepOrange,
                                        backgroundColor: Colors.deepOrange,
                                        onPressed: () {
                                          String chipItem = _categories[index];
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CategoryDetails(
                                                        categoryItem: chipItem,
                                                      )));
                                        },
                                        label: Text(
                                          _categories[index],
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        padding: const EdgeInsets.all(8.0)));
                              })),
                      const SizedBox(height: 25),

                      const SizedBox(height: 25),
                      const Text("Recently Viewed",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),

                      RecentlyViewed(recentlyViewed: _recentlyViewed),
                      const SizedBox(height: 25),
                      const Text("Hot Products",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      HotProducts(allProducts: _hotProducts),
                      const SizedBox(height: 25),
                    ])));
  }
}

class BannerCarousel extends StatelessWidget {
  const BannerCarousel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
            height: 200.0,
            viewportFraction: 0.8,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            enlargeCenterPage: true,
            autoPlay: true),
        items: [
          "https://static.vecteezy.com/system/resources/thumbnails/000/669/988/small/Shopping_online_Hand_Banner.jpg",
          "https://static.vecteezy.com/system/resources/thumbnails/002/216/694/small/shopping-trendy-banner-vector.jpg",
          "https://static.vecteezy.com/system/resources/thumbnails/003/240/364/small/shopping-online-on-phone-paper-art-modern-pink-background-gifts-box-free-vector.jpg",
        ].map((i) {
          return Builder(builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(i), fit: BoxFit.contain)));
          });
        }).toList());
  }
}
