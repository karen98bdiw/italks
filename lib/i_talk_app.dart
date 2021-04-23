import 'package:flutter/material.dart';
import 'package:italk/pages/home.dart';
import 'package:italk/pages/onBoard.dart';
import 'package:italk/pages/sign_in.dart';
import 'package:italk/pages/sing_up.dart';

class ITalkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: OnBoard.routName,
      routes: {
        OnBoard.routName: (c) => OnBoard(),
        SignUpScreen.routeName: (c) => SignUpScreen(),
        SignInScreen.routeName: (c) => SignInScreen(),
        HomePage.routeName: (c) => HomePage(),
      },
    );
  }
}
