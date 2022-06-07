import 'package:ecommerce_major_project/models/add_category_screen.dart';
import 'package:ecommerce_major_project/views/screens/adminScreens/admin_products_screen.dart';
import 'package:ecommerce_major_project/views/screens/adminScreens/booking_list_screen.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Home'), actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.logout))
      ]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminProductsScreen(
                              ctgryValue: 'Fashion',
                            )));
              },
              child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/product.jpg'),
                          fit: BoxFit.cover)),
                  child: Stack(
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(25)),
                      ),
                      const Center(
                          child: Text(
                        'Products',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      )),
                    ],
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Addcategory()));
              },
              child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/banner1.png'),
                          fit: BoxFit.cover)),
                  child: Stack(
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(25)),
                      ),
                      const Center(
                          child: Text(
                        'Add Category',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      )),
                    ],
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BookingListScreen()));
              },
              child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/booking.jpg'),
                          fit: BoxFit.cover)),
                  child: Stack(
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(25)),
                      ),
                      const Center(
                          child: Text(
                        'Bookings',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      )),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
