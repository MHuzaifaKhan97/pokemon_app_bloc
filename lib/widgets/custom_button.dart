import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.onTap,
    this.isLoading = false,
    this.title,
    // this.inverseStyle = false,
    this.width,
    this.height,
    // this.buttonColor,
    this.icon,
    // this.titleColor,
    // this.titleFontSize,
    // this.gradient,
    // this.borderColor,
  }) : super(key: key);
  final Function()? onTap;
  final String? title;
  final double? width;
  final double? height;
  // final Color? buttonColor;
  // final Gradient? gradient;
  // final Color? titleColor;
  // final bool inverseStyle;
  final bool isLoading;
  // final titleFontSize;
  // final borderColor;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * 0.90,
      height: height ?? 45,
      decoration: BoxDecoration(
          // gradient: gradient,
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2, color: Colors.blue)),
      child: MaterialButton(
        onPressed: onTap,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
