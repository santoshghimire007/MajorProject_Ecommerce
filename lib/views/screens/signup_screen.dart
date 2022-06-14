import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_major_project/views/screens/homeScreen/user_home_screen.dart';
import 'package:ecommerce_major_project/views/widgets/textfield_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // TextEditingController userController = TextEditingController();
  // TextEditingController passController = TextEditingController();
  // TextEditingController conformEmailController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.orange,
              size: 35,
            )),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset('assets/images/logoe.png'),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Create your Account',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // TextfieldWidget(
                  //     controllerValue: userController, lblText: 'Email'),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // TextfieldWidget(
                  //     controllerValue: passController, lblText: 'Password'),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // TextfieldWidget(
                  //     controllerValue: conformEmailController,
                  //     lblText: 'Confirm Password'),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
          
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
