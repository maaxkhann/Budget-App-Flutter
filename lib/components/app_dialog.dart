import 'package:budget_app/components/app_text.dart';
import 'package:flutter/material.dart';

appDialog(BuildContext context, String title) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        title: OpenSans(text: title, fontSize: 20),
        contentPadding: EdgeInsets.all(32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 2, color: Colors.black),
        ),

        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: const OpenSans(
              text: 'OK',
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      );
    },
  );
}
