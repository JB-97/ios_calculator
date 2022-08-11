import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.textSize,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final double textSize;
  final Color backgroundColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            color: backgroundColor,
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: textColor, fontSize: textSize),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
