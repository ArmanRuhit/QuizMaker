import 'package:flutter/material.dart';
import 'package:flutterapp3/helper/functions.dart';
import 'package:flutterapp3/services/auth.dart';
import 'package:flutterapp3/views/signin.dart';
import 'package:flutterapp3/widgets/widgets.dart';

import 'home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name, email, password;
  final _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  bool isLoading = false;
  signUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      await authService.signUpEmailAndPass(email, password).then((value) {
        if (value != null) {
          setState(() {
            isLoading = false;
          });
          HelperFunctions.saveUserLoggedInDetails(isLoggedIn: true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: appBar(),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          brightness: Brightness.light,
        ),
        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: <Widget>[
                Spacer(),
                TextFormField(
                  validator: (val) {
                    return val.isEmpty ? 'Enter name' : null;
                  },
                  decoration: InputDecoration(hintText: 'Name'),
                  onChanged: (val) {
                    name = val;
                  },
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  validator: (val) {
                    return val.isEmpty ? 'Enter email' : null;
                  },
                  decoration: InputDecoration(hintText: 'Email'),
                  onChanged: (val) {
                    email = val;
                  },
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  obscureText: true,
                  validator: (val) {
                    return val.isEmpty ? 'Enter Password' : null;
                  },
                  decoration: InputDecoration(hintText: 'Password'),
                  onChanged: (val) {
                    password = val;
                  },
                ),
                SizedBox(
                  height: 14,
                ),
                GestureDetector(
                    onTap: () {
                      signUp();
                    },
                    child: blueButton(context: context, label: "Sign Up")),
                SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 15.5,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
                      },
                      child: Text("Sign In",
                          style: TextStyle(
                            fontSize: 15.5,
                            decoration: TextDecoration.underline,
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 80,
                )
              ],
            ),
          ),
        ));
  }
}
