import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Hero(
              tag: "logo",
              child: Image.asset(
                "./assets/logo.png",
                width: MediaQuery.of(context).size.width * 0.3,
                fit: BoxFit.contain,
              ))),
    );
  }
}
