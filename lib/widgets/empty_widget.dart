import 'package:flutter/material.dart';
import 'package:pokemon_app_bloc/resources/app_theme.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "./assets/empty.png",
            width: 40,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(height: 6),
          Text(
            "No favourite added yet",
            style: TextStyle(
              fontSize: 18,
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
