import 'package:budget_app/components/app_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.width = 150,
    this.height = 50,
    this.fontSize = 15,
    this.icon,
  });

  final String title;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double fontSize;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: MaterialButton(
        splashColor: Colors.grey,
        color: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: icon != null
              ? MainAxisAlignment.spaceEvenly
              : MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            Flexible(
              child: FittedBox(
                alignment: Alignment.center,
                fit: BoxFit.scaleDown,
                child: OpenSans(
                  text: title,
                  fontSize: fontSize,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
