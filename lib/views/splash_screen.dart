import 'dart:async';

import 'package:ecommerce_major_project/views/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 200,
              width: 100,
              child: Image.asset('assets/splash/splash.png'),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 100,
              child: LoadingIndicator(
                  indicatorType: Indicator.ballClipRotateMultiple,

                  /// Required, The loading type of the widget
                  colors: [
                    // Colors.green,
                    // Colors.blue,
                    // Colors.yellow,
                    Colors.white
                  ],

                  /// Optional, The color collections
                  strokeWidth: 2,

                  /// Optional, The stroke of the line, only applicable to widget which contains line
                  // backgroundColor: Colors.black,      /// Optional, Background of the widget
                  pathBackgroundColor: Colors.black

                  /// Optional, the stroke backgroundColor
                  ),
            )
            // const CircularProgressIndicator(
            //   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            // )
          ],
        ),
      ),
    );
  }
}
