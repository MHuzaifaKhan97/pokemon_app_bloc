import 'package:flutter/material.dart';
import 'package:pokemon_app_bloc/resources/app_theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.onTap,
    this.isLoading = false,
    this.title,
    this.width,
    this.height,
    this.icon,
    this.inverse = false,
  }) : super(key: key);
  final Function()? onTap;
  final String? title;
  final double? width;
  final double? height;
  final bool isLoading;
  final bool? inverse;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * 0.90,
      height: height ?? 45,
      decoration: BoxDecoration(
          color: inverse! ? AppTheme.colorWhite : AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2, color: AppTheme.primaryColor)),
      child: MaterialButton(
        onPressed: onTap,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: inverse! ? AppTheme.primaryColor : Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: inverse! ? AppTheme.primaryColor : Colors.white),
                  ),
                  icon != null
                      ? const SizedBox(width: 8)
                      : const SizedBox.shrink(),
                  icon ?? const SizedBox.shrink()
                ],
              ),
      ),
    );
  }
}
