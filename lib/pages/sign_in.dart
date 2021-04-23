import 'package:flutter/material.dart';
import 'package:italk/pages/home.dart';
import 'package:italk/services/i_talk_base.dart';
import 'package:italk/utils/helperWidgets.dart';
import 'package:italk/utils/helpers.dart';
import 'package:italk/widgets/buttons.dart';
import 'package:italk/widgets/inputs.dart';

class SignInScreen extends StatefulWidget {
  static final routeName = "SignIn";
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool obscurePassword = true;

  String password;
  String email;

  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void _onSingIn() async {
    if (!_formState.currentState.validate()) return;
    _formState.currentState.save();
    setState(() {
      isLoading = true;
    });

    var res = await ITalkBase().profileService.singIn(
          email: email,
          password: password,
        );

    setState(() {
      isLoading = false;
    });
    if (res) {
      Navigator.of(context).pushNamed(HomePage.routeName);
    } else {
      await showError(errorText: "Something went wrong...", context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign In"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formState,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MainInput(
                        onSaved: (v) => email = v,
                        prefix: emailPrefix,
                        hint: "E-Mail",
                        validator: (v) => v.isEmpty
                            ? "Email is required"
                            : isValidEmail(v)
                                ? null
                                : "E-Mail is invalid",
                      ),
                      MainInput(
                        onSaved: (v) => password = v,
                        prefix: passwordPrefix,
                        hint: "Password",
                        obscureText: obscurePassword,
                        validator: (v) => v.length < 6
                            ? "Password must have at last 6 characters"
                            : null,
                        suffix: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          child: passwordSuffix,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MainButton(
                        onPressed: _onSingIn,
                        title: "Sign In",
                        fill: false,
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
