import 'package:bodmoo/Screens/login/phoneVerification.dart';
import 'package:bodmoo/main_screen.dart';
import 'package:bodmoo/providers/loginProvider.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 1), () async {
      bool b = await checkPrefsForLogin();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) {
                if (b)
                  return MainScreen();
                else
                  return SignInWithPhoneNO();
              }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(child: Text("Laoding")),
      ),
    );
  }
}
