import 'package:flutter/material.dart';
import 'package:pokemon_app_bloc/widgets/logo_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1e81b0),
      body: Center(child: Hero(tag: "logo", child: LogoWidget())),
    );
  }
}
