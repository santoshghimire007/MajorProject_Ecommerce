import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_major_project/views/screens/cart_screen_firebase.dart';
import 'package:ecommerce_major_project/views/screens/firebase_category.dart';
import 'package:ecommerce_major_project/views/screens/hot_products_firebase.dart';
import 'package:ecommerce_major_project/views/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartScreenFirebase()));
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
                    children: const [
                      BannerCarousel(),
                      // Image.network(
                      //     'https://static.vecteezy.com/system/resources/thumbnails/002/216/694/small/shopping-trendy-banner-vector.jpg'),
                      SizedBox(height: 0),
                      Text("Category",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            //color: Colors.deepOrangeAccent,
                            fontSize: 20,
                          )),
                      SizedBox(height: 10),

                      FirebaseCategory(),

                      SizedBox(height: 25),

                      Text("Recently Viewed",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),

                      SizedBox(height: 25),
                      Text("All Products",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      HotProductsFirebase(),
                      // HotProducts(allProducts: _hotProducts),
                      SizedBox(height: 25),
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
