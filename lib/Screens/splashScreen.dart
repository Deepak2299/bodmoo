import 'package:bodmoo/Screens/login/phoneVerification.dart';
import 'package:bodmoo/Screens/realMeat/homeScreen.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
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
      bool b = await checkPrefsForLogin(context: context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) {
                // if (b) {
                fetchPrefsForCarts(context: context);
                return HomeScreen();
                // } else
                //   return SignInWithPhoneNO();
              }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(child: Text("Loading")),
      ),
    );
  }
}
