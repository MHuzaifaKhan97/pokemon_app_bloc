import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app_bloc/resources/app_theme.dart';
import 'package:pokemon_app_bloc/screens/signup_screen.dart';

class RichTextTappableWidget extends StatelessWidget {
  RichTextTappableWidget(
      {Key? key, this.firstText, this.secondText, this.onTap})
      : super(key: key);
  String? firstText;
  String? secondText;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 22),
      child: Center(
        child: RichText(
          text: TextSpan(
              text: firstText,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              children: <TextSpan>[
                TextSpan(
                    text: secondText,
                    style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        onTap!();
                      })
              ]),
        ),
      ),
    );
  }
}
