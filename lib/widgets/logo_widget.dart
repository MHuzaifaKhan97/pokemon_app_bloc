import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  LogoWidget({Key? key, this.iconSize, this.textSize}) : super(key: key);
  double? textSize;
  double? iconSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "./assets/logo.png",
          width: iconSize ?? MediaQuery.of(context).size.width * 0.16,
          fit: BoxFit.contain,
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        Text(
          "Pokemon App",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: textSize ?? 32),
        )
      ],
    );
  }
}
