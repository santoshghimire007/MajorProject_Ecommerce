import 'package:ecommerce_major_project/models/login_validation_model.dart';
import 'package:ecommerce_major_project/views/screens/adminScreens/admin_home_screen.dart';
import 'package:ecommerce_major_project/views/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController userConroller = TextEditingController();
  TextEditingController passwordConroller = TextEditingController();

  validateSignInDetails(BuildContext context) {
    LoginValidationModel loginDetails = LoginValidationModel(
      username: userConroller.text,
      password: passwordConroller.text,
    );
    var validationResult = loginDetails.validateLoginDetails();
    if (validationResult == true) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logged in successfully')));

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AdminHomeScreen()),
        (Route<dynamic> route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username or password does not match')));
    }
  }

  bool _obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Admin Login'),
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                    child: Center(
                        child: Column(children: [
                  const SizedBox(height: 70),
                  SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset('assets/images/logoe.png')),
                  const SizedBox(height: 30),
                  const Align(
                      alignment: Alignment.center,
                      child: Text('Login Here',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 25))),
                  const SizedBox(height: 20),
                  TextfieldWidget(
                      controllerValue: userConroller, lblText: 'Username'),
                  const SizedBox(height: 10),
                  TextField(
                      controller: passwordConroller,
                      obscureText: _obsecureText,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obsecureText = !_obsecureText;
                                });
                              },
                              icon: Icon(_obsecureText
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          hintText: 'Enter password',
                          hintStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)))),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            validateSignInDetails(context);
                          },
                          child: const Text('Login',
                              style: TextStyle(fontSize: 16))))
                ]))))));
  }
}
