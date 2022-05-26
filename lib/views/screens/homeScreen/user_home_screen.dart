import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_major_project/models/product_model.dart';
import 'package:ecommerce_major_project/services/apiServices/products_services.dart';
import 'package:ecommerce_major_project/views/screens/cart_screen.dart';
import 'package:ecommerce_major_project/views/screens/category_details_screen.dart';
import 'package:ecommerce_major_project/views/screens/homeScreen/hot_products.dart';
import 'package:ecommerce_major_project/views/screens/homeScreen/recently_viewd.dart';
import 'package:ecommerce_major_project/views/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  late String? username;
  late SharedPreferences loginData;

  getAccount() async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    setState(() {
      username = loginData.getString('Username');
      // print(username);
    });
  }

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

  logout() async {
    SharedPreferences logoutData = await SharedPreferences.getInstance();
    logoutData.remove('Username');
    // print(username);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Logged Out')));
  }

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
    getAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
                icon: const Icon(Icons.shopping_cart),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title:
                                const Text('Are you sure you want to Logout?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                  onPressed: () {
                                    logout();
                                  },
                                  child: const Text('Yes'))
                            ],
                          ));
                },
                icon: const Icon(Icons.logout),
              )
              // Text('Logout'),
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(
              //     Icons.logout,
              //   ),
              // ),
            ],
            title: const Text('Home'),
            backgroundColor: Colors.deepOrange,
            automaticallyImplyLeading: false),
        body: _loading == true
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const BannerCarousel(),
                      // Image.network(
                      //     'https://static.vecteezy.com/system/resources/thumbnails/002/216/694/small/shopping-trendy-banner-vector.jpg'),
                      const SizedBox(height: 0),
                      const Text("Category",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            //color: Colors.deepOrangeAccent,
                            fontSize: 20,
                          )),
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
          'assets/images/banner1.png',
          'assets/images/banner2.jpg',
          'assets/images/banner3.jpg'
        ].map((i) {
          return Builder(builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(i), fit: BoxFit.contain)));
          });
        }).toList());
  }
}
