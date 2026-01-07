import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonTextFormField extends StatelessWidget {
  // REQUIRED
  final TextEditingController controller;

  // OPTIONAL – GENERAL
  final double width;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextInputType keyboardType;
  final TextAlign textAlign;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final BorderRadius borderRadius;

  // OPTIONAL – ICONS
  final IconData? prefixIcon;
  final VoidCallback? onPrefixIconPressed;
  final Color iconColor;
  final double iconSize;

  const CommonTextFormField({
    super.key,
    required this.controller,
    this.width = 350,
    this.hintText,
    this.hintStyle,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.prefixIcon,
    this.onPrefixIconPressed,
    this.iconColor = Colors.black,
    this.iconSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        textAlign: textAlign,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(borderRadius: borderRadius),
          enabledBorder: OutlineInputBorder(borderRadius: borderRadius),
          prefixIcon: prefixIcon == null
              ? null
              : IconButton(
                  onPressed: onPrefixIconPressed,
                  icon: Icon(prefixIcon, color: iconColor, size: iconSize),
                ),
          hintText: hintText,
          hintStyle: hintStyle ?? GoogleFonts.openSans(),
        ),
      ),
    );
  }
}
