import 'package:ecommerce_major_project/models/login_validation_model.dart';
import 'package:ecommerce_major_project/models/product_model.dart';
import 'package:ecommerce_major_project/services/apiServices/products_services.dart';
import 'package:ecommerce_major_project/views/screens/homeScreen/user_home_screen.dart';
import 'package:ecommerce_major_project/views/screens/signup_screen.dart';
import 'package:ecommerce_major_project/views/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userConroller = TextEditingController();
  TextEditingController passwordConroller = TextEditingController();

  late SharedPreferences loginCheck;
  late bool newUser;
  String? userdata;

  setAccount() async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    loginData.setString('Username', userConroller.text);
    // loginData.setString('Password', passwordConroller.text);
  }

  alreadyLoginCheck() async {
    loginCheck = await SharedPreferences.getInstance();
    userdata = (loginCheck.getString('Username'));
    if (userdata == 'admin') {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const UserHomeScreen()));
    }
  }

  validateSignInDetails(BuildContext context) {
    LoginValidationModel loginDetails = LoginValidationModel(
      username: userConroller.text,
      password: passwordConroller.text,
    );
    var validationResult = loginDetails.validateLoginDetails();
    if (validationResult == true) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logged in successfully')));
      setAccount();
      alreadyLoginCheck();
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => const UserHomeScreen()),
      //   (Route<dynamic> route) => false,
      // );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username or password does not match')));
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
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('assets/images/logoe.png'),
            ),
            const SizedBox(
              height: 30,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Login to your Account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextfieldWidget(
                controllerValue: userConroller, lblText: 'Username'),
            const SizedBox(
              height: 10,
            ),
            TextfieldWidget(
                controllerValue: passwordConroller, lblText: 'Password'),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepOrange)),
                    onPressed: () {
                      validateSignInDetails(context);
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 16),
                    ))),
            const SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              const Text("Don't have an Account?",
                  style: TextStyle(fontSize: 16)),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
                  },
                  child: const Text('Sign up',
                      style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)))
            ])
          ])),
        ),
      ),
    ));
  }
}
