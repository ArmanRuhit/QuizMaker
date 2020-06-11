import 'package:flutter/material.dart';
import 'package:flutterapp3/helper/functions.dart';
import 'package:flutterapp3/views/home.dart';
import 'package:flutterapp3/views/signin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  @override
  void initState() {
    checkUserLoggedInStatus();
    // TODO: implement initState
    super.initState();
  }

  checkUserLoggedInStatus() async {
    HelperFunctions.getUserLoggedInDetails().then((value) {
      setState(() {
        isLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter demo',
      theme: ThemeData.light(),
      home: (isLoggedIn ?? false) ? Home() : SignIn(),
    );
  }
}
