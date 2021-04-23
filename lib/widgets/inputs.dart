import 'package:flutter/material.dart';
import 'package:italk/utils/colors.dart';
import 'package:italk/utils/styles.dart';

class MainInput extends StatelessWidget {
  final String hint;
  final bool obscureText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final Widget prefix;
  final Widget suffix;
  final TextEditingController controller;

  MainInput({
    this.controller,
    this.prefix,
    this.suffix,
    this.hint,
    this.obscureText = false,
    this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: TextFormField(
        controller: controller,
        onSaved: onSaved,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: prefix != null
              ? Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: 14,
                    start: 14,
                    end: 14,
                    bottom: 14,
                  ),
                  child: prefix,
                )
              : null,
          suffixIcon: prefix != null
              ? Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: 14,
                    start: 14,
                    end: 14,
                    bottom: 14,
                  ),
                  child: suffix,
                )
              : null,
          isDense: true,
          contentPadding: EdgeInsetsDirectional.only(
            top: 12,
            bottom: 12,
            start: 14,
            end: 14,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: blueShape,
            fontSize: 16,
          ),
          disabledBorder: mainInputBorder,
          errorBorder: mainInputBorder,
          focusedBorder: mainInputBorder,
          enabledBorder: mainInputBorder,
          border: mainInputBorder,
        ),
      ),
    );
  }
}
