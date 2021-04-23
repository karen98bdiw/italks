import 'package:flutter/material.dart';
import 'package:italk/utils/colors.dart';

class MainButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final bool fill;

  MainButton({
    this.fill = true,
    this.onPressed,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: !fill ? MediaQuery.of(context).size.width * 0.3 : double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: onPressed,
        color: mainBtnColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
