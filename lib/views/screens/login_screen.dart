import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_major_project/models/user_model.dart';
import 'package:ecommerce_major_project/services/sessionService/session_service.dart';
import 'package:ecommerce_major_project/views/screens/adminScreens/admin_login.dart';
import 'package:ecommerce_major_project/views/screens/homeScreen/user_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      print(error);
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
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Center(
              child: Column(children: [
            const SizedBox(height: 70),
            GestureDetector(
              onLongPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminLogin()));
              },
              child: SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/images/logoe.png'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Login Here',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // TextfieldWidget(
            //     controllerValue: userConroller, lblText: 'Username'),
            // const SizedBox(
            //   height: 10,
            // ),
            // TextfieldWidget(
            //     controllerValue: passwordConroller, lblText: 'Password'),
            // const SizedBox(
            //   height: 10,
            // ),
            // SizedBox(
            //     width: double.infinity,
            //     child: ElevatedButton(
            //         style: ButtonStyle(
            //             backgroundColor:
            //                 MaterialStateProperty.all(Colors.deepOrange)),
            //         onPressed: () {
            //           validateSignInDetails(context);
            //         },
            //         child: const Text(
            //           'Sign in',
            //           style: TextStyle(fontSize: 16),
            //         ))),
            // const SizedBox(height: 15),
            // const Text("Don't have an Account?",
            //     style: TextStyle(fontSize: 16)),
            ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepOrange)),
              onPressed: () {
                googleLogin();
              },
              label: const Text('Sign in as..'),
              icon: const FaIcon(
                FontAwesomeIcons.google,
              ),
            )
          ])),
        ),
      ),
    ));
  }
}
