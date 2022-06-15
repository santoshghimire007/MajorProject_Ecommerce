import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_major_project/models/user_model.dart';
import 'package:ecommerce_major_project/services/sessionService/session_service.dart';
import 'package:ecommerce_major_project/views/screens/adminScreens/admin_login.dart';
import 'package:ecommerce_major_project/views/screens/homeScreen/user_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  googleLogin() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      var reslut = await _googleSignIn.signIn();
      if (reslut == null) {
        return;
      } else {
        var userData = await reslut.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: userData.accessToken, idToken: userData.idToken);
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) {
          FirebaseFirestore.instance
              .collection('users')
              .where('uid', isEqualTo: value.user!.uid)
              .get()
              .then((alreadyUser) {
            UserModel userData = UserModel(
                uid: value.user!.uid,
                email: value.user!.email!,
                profileImage: value.user!.photoURL!,
                displayName: value.user!.displayName);
            if (alreadyUser.docs.isEmpty) {
              FirebaseFirestore.instance
                  .collection('users')
                  .add(userData.toJson());
            }
            SessionService.setUserData(userData);
            setAccount(uid: jsonEncode(userData.toJson()));
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => UserHomeScreen(userData: userData)));
          });
        });
      }
    } catch (error) {
      log(error.toString());
    }
  }

  String? userdata;

  setAccount({required String uid}) async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    loginData.setString('uid', uid);
  }

  alreadyLoginCheck() async {
    SharedPreferences loginCheck = await SharedPreferences.getInstance();
    String? uid = loginCheck.getString('uid');
    if (uid != null) {
      UserModel data = UserModel.fromJson(jsonDecode(uid));
      SessionService.setUserData(data);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => UserHomeScreen(userData: data)));
    } else {
      print(uid);
    }
  }

  @override
  void initState() {
    alreadyLoginCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/login_bg.jpg'),
              fit: BoxFit.cover)),
      child: Container(
        color: Colors.black87.withOpacity(0.6),
        child: Column(children: [
          const Spacer(),
          const Align(
              alignment: Alignment.center,
              child: Text('Login to E-Cart',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.white))),
          const SizedBox(height: 30),
          GestureDetector(
              onLongPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminLogin()));
              },
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70)),
                  child: Lottie.asset("assets/images/login1.json",
                      height: 240.0, width: 450))),
          const SizedBox(height: 30),
          SizedBox(
              width: 230,
              height: 50,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  onPressed: () {
                    googleLogin();
                  },
                  label: const Text('Continue with Google',
                      style: TextStyle(color: Colors.deepOrange)),
                  icon: const FaIcon(FontAwesomeIcons.google,
                      color: Colors.deepOrange))),
          const Spacer(),
        ]),
      ),
    ));
  }
}
