import 'package:bodmoo/Screens/GoogleSignIn/googleSignInScreen.dart';
import 'package:bodmoo/Screens/login/phoneVerification.dart';
import 'package:bodmoo/Screens/realMeat/homeScreen.dart';
import 'package:bodmoo/Screens/realMeat/home_screen_all_part.dart';
import 'package:bodmoo/onBoardingScreen.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:flutter/cupertino.dart';
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

    Future.delayed(Duration(seconds: 2), () async {
      bool b = await checkPrefsForLogin(context: context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) {
                if (b) {
                  return AllPartsHomeScreen();
                } else
                  return OnboardingScreen();
                // return SignInWithPhoneNO();
              }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo.png',
            ),
            Text(
              "Welcome",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text("Now, spare parts at your door"),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    fetchPrefsForCarts(context: context);
    super.didChangeDependencies();
  }
}
