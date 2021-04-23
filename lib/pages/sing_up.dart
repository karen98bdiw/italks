import 'package:flutter/material.dart';
import 'package:italk/models/user.dart';
import 'package:italk/services/i_talk_base.dart';
import 'package:italk/utils/helperWidgets.dart';
import 'package:italk/utils/helpers.dart';
import 'package:italk/widgets/buttons.dart';
import 'package:italk/widgets/inputs.dart';

class SignUpScreen extends StatefulWidget {
  static final routeName = "SignUp";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool obscurePassword = true;
  bool obscurePasswordInRepeat = true;

  User userModel = User();
  String password;

  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void _onSingUp() async {
    if (!_formState.currentState.validate()) return;
    _formState.currentState.save();
    passwordController.clear();
    setState(() {
      isLoading = true;
    });
    var res = await ITalkBase().profileService.signUp(
          user: userModel,
          password: password,
        );
    setState(() {
      isLoading = false;
    });
    if (res) {
      print("user is registred-----------------");
    } else {
      print("something went wrong----------------------");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign Up"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formState,
                  child: Column(
                    children: [
                      MainInput(
                        validator: (v) => v.isEmpty ? "Name is required" : null,
                        prefix: userPrefix,
                        hint: "Name",
                        onSaved: (v) => userModel.name = v,
                      ),
                      MainInput(
                        onSaved: (v) => userModel.surname = v,
                        validator: (v) =>
                            v.isEmpty ? "Surname is required" : null,
                        prefix: userPrefix,
                        hint: "Surname",
                      ),
                      MainInput(
                        onSaved: (v) => userModel.email = v,
                        prefix: emailPrefix,
                        hint: "E-Mail",
                        validator: (v) => v.isEmpty
                            ? "Email is required"
                            : isValidEmail(v)
                                ? null
                                : "E-Mail is invalid",
                      ),
                      MainInput(
                        controller: passwordController,
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
                      MainInput(
                        onSaved: (v) => password = v,
                        obscureText: obscurePasswordInRepeat,
                        prefix: passwordPrefix,
                        validator: (v) => v != passwordController.text
                            ? "Password does't match"
                            : null,
                        hint: "Repeat Password",
                        suffix: GestureDetector(
                          child: passwordSuffix,
                          onTap: () {
                            setState(() {
                              obscurePasswordInRepeat =
                                  !obscurePasswordInRepeat;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MainButton(
                        onPressed: _onSingUp,
                        title: "Sign Up",
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
