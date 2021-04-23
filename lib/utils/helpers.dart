import 'package:flutter/material.dart';

bool isValidEmail(String email) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}

Future<void> showError({String errorText, BuildContext context}) async {
  await showDialog(
    context: context,
    child: Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(14),
          ),
          padding: EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width * 0.7,
          child: Center(
            child: Text(
              errorText,
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ),
        ),
      ),
    ),
  );
}
