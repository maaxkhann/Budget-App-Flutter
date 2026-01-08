import 'package:budget_app/components/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? title;
  final TextEditingController? controller;
  final double width;
  final bool isNumber;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    this.hintText,
    this.title,
    this.controller,
    this.width = 130,
    this.isNumber = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        OpenSans(text: title ?? '', fontSize: 13),
        SizedBox(
          width: width,
          child: TextFormField(
            controller: controller,
            validator: validator,
            inputFormatters: isNumber
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],
            decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.red),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.teal),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.teal, width: 2),
              ),
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }
}
