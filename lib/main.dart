// import 'package:ecommerce_major_project/views/screens/login_screen.dart';
import 'package:ecommerce_major_project/views/screens/adminScreens/admin_home_screen.dart';
import 'package:ecommerce_major_project/views/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: const SplashScreen(),
    );
  }
}
