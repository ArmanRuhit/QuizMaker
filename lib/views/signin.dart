import 'package:flutter/material.dart';
import 'package:flutterapp3/helper/functions.dart';
import 'package:flutterapp3/services/auth.dart';
import 'package:flutterapp3/views/home.dart';
import 'package:flutterapp3/views/signup.dart';
import 'package:flutterapp3/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email, password;
  final _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  bool isLoading = false;
  signIn() async {
    setState(() {
      isLoading = true;
    });

    if (_formKey.currentState.validate()) {
      await authService.signInEmailAndPass(email, password).then((value) {
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
        body: isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
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
                            signIn();
                          },
                          child:
                              blueButton(context: context, label: "Sign In")),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Don't Have an account? ",
                            style: TextStyle(
                              fontSize: 15.5,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Text("Sign Up",
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
