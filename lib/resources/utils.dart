import 'package:flutter/material.dart';
import 'package:pokemon_app_bloc/resources/app_theme.dart';
import 'package:pokemon_app_bloc/widgets/custom_button_widget.dart';

class Utils {
  static snackbar(String message, BuildContext context, Color? color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(message,
          style: TextStyle(color: AppTheme.colorWhite, fontSize: 17)),
      backgroundColor: color,
    ));
  }

  static dialog(BuildContext context, VoidCallback onTap) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          'Are you sure you want to log out?',
          style: TextStyle(color: AppTheme.primaryColor),
        ),
        actions: <Widget>[
          CustomButton(
            width: MediaQuery.of(context).size.width * 0.26,
            height: MediaQuery.of(context).size.height * 0.045,
            title: "YES",
            onTap: () {
              Navigator.of(context).pop();
              onTap();
            },
          ),
          CustomButton(
            width: MediaQuery.of(context).size.width * 0.26,
            height: MediaQuery.of(context).size.height * 0.045,
            inverse: true,
            title: "NO",
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
