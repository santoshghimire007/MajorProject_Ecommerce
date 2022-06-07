// import 'package:ecommerce_major_project/views/screens/login_screen.dart';
import 'package:ecommerce_major_project/views/screens/adminScreens/admin_home_screen.dart';
import 'package:ecommerce_major_project/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        //  useMaterial3: true
      ),
      home: const SplashScreen(),
    );
  }
}
