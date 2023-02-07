import 'package:flutter/material.dart';
import 'package:pokemon_app_bloc/resources/app_theme.dart';

class Utils {
  static snackbar(String message, BuildContext context, Color? color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, style: TextStyle(color: color, fontSize: 17)),
      backgroundColor: AppTheme.colorBlack,
    ));
  }
}
