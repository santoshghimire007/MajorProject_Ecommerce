import 'package:ecommerce_major_project/models/login_validation_model.dart';
import 'package:ecommerce_major_project/views/screens/adminScreens/admin_home_screen.dart';
import 'package:ecommerce_major_project/views/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
        body: Container(
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/login_bg.jpg",
              ),
              fit: BoxFit.cover)),
      child: Container(
        color: Colors.black87.withOpacity(0.5),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
                child: Center(
                    child: Column(children: [
              const SizedBox(height: 20),
              SizedBox(
                  height: 200,
                  width: 250,
                  child: Lottie.asset('assets/images/login1.json')),
              const SizedBox(height: 30),
              const Align(
                  alignment: Alignment.center,
                  child: Text('Admin Login',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 28,
                          color: Colors.white))),
              const SizedBox(height: 20),
              Card(
                color: Colors.white24,
                child: TextfieldWidget(
                    controllerValue: userConroller, lblText: 'Username'),
              ),
              const SizedBox(height: 10),
              TextField(
                  controller: passwordConroller,
                  obscureText: _obsecureText,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white24,
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
                      hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)))),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                      onPressed: () {
                        validateSignInDetails(context);
                      },
                      child:
                          const Text('Login', style: TextStyle(fontSize: 16))))
            ])))),
      ),
    ));
  }
}
