import 'package:flutter/material.dart';
import 'package:italk/pages/sign_in.dart';
import 'package:italk/pages/sing_up.dart';
import 'package:italk/utils/colors.dart';
import 'package:italk/widgets/buttons.dart';

class OnBoard extends StatelessWidget {
  static final routName = "OnBoard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(children: [
          Center(
              child: Text(
            "iTalk",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MainButton(
                  title: "Sign In",
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignInScreen.routeName);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                MainButton(
                  title: "Sign Up",
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      SignUpScreen.routeName,
                    );
                  },
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
