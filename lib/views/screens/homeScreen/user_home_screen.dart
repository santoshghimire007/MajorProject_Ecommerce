import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_major_project/models/user_model.dart';
import 'package:ecommerce_major_project/services/sessionService/session_service.dart';
import 'package:ecommerce_major_project/views/screens/cart_screen_firebase.dart';
import 'package:ecommerce_major_project/views/screens/firebase_category.dart';
import 'package:ecommerce_major_project/views/screens/homeScreen/user_profile_update.dart';
import 'package:ecommerce_major_project/views/screens/hot_products_firebase.dart';
import 'package:ecommerce_major_project/views/screens/login_screen.dart';
import 'package:ecommerce_major_project/views/screens/recently_viewed_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class UserHomeScreen extends StatefulWidget {
  UserHomeScreen({Key? key, this.userData}) : super(key: key);

  UserModel? userData;

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  bool _loading = false;

  // updateProfilePicture({required String profileImage, required var docId}) async {

  //   try {
  //     await firestore
  //         .collection('users')
  //         .doc(docId)
  //         .update({'profileImage': profileImage});

  //     // await firestore.collection('products').add({'name': 'Shoe', 'price': 99});   //For auto increment id use add

  //   } catch (e) {
  //     // print(e);

  //   }
  // }

  late String? username;
  late SharedPreferences loginData;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }

  getAccount() async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    setState(() {
      username = loginData.getString('uid');
      // print(username);
    });
  }

  logout() async {
    SharedPreferences logoutData = await SharedPreferences.getInstance();
    logoutData.remove('uid');
    _signOut();
    SessionService.clearUserData();
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
                            builder: (context) => const CartScreenFirebase()));
                  },
                  icon: const Icon(Icons.shopping_cart)),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                              title: const Text(
                                  'Are you sure you want to Logout?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('No')),
                                TextButton(
                                    onPressed: () {
                                      // logout();
                                      logout();
                                    },
                                    child: const Text('Yes'))
                              ]));
                },
                icon: const Icon(Icons.logout),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      context: context,
                      builder: (context) {
                        return SizedBox(
                            width: double.infinity,
                            height: 400,
                            child: Stack(children: [
                              Positioned(
                                  top: 0,
                                  right: 15,
                                  left: 15,
                                  child: ClipRect(
                                      child: Image.asset(
                                          'assets/images/wave.png',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40))),
                              SizedBox(
                                  width: double.infinity,
                                  height: 400,
                                  child: Column(children: <Widget>[
                                    const SizedBox(height: 40),
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          widget.userData!.profileImage),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      SessionService.userData!.displayName!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    SizedBox(
                                        height: 70,
                                        width: 200,
                                        child: Text(
                                            SessionService.userData!.email,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold))),
                                    const SizedBox(height: 60),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          OutlinedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            UserProfileUpdate())));
                                              },
                                              child:
                                                  const Text('Update Profile')),
                                        ],
                                      ),
                                    )
                                  ]))
                            ]));
                      });
                },
                child: CircleAvatar(
                    // backgroundColor: Colors.deepOranSge,
                    radius: 20,
                    backgroundImage:
                        NetworkImage(widget.userData!.profileImage)),
              ),
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

                      RecentlyViewedFirebase(),

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
