import 'package:ecommerce_major_project/views/screens/adminScreens/admin_products_screen.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Home'), actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.logout))
      ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminProductsScreen()));
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
              onTap: () {},
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
