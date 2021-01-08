import 'dart:io';

import 'package:bodmoo/Screens/GoogleSignIn/googleSignInScreen.dart';
import 'package:bodmoo/Screens/login/phoneVerification.dart';
import 'package:bodmoo/Screens/realMeat/homeScreen.dart';
import 'package:bodmoo/Screens/realMeat/home_screen_all_part.dart';
import 'package:bodmoo/methods/recents/loadRecents.dart';
import 'package:bodmoo/onBoardingScreen.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String APP_URL = 'https://drive.google.com/drive/folders/1js1AN0rJppQMv8jQWmfSVmTltroMlD7f';
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  double currentVersion = 0.0;
  String currentVersionName = ' ';
  currentVersionCheck() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    currentVersionName = info.version;
    currentVersion = double.parse(info.version.trim().replaceAll(".", ""));
    print('currentVersion' + currentVersion.toString());
  }

  newVersionCheck(BuildContext context) async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));

    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 5));
      await remoteConfig.activateFetched();
      double newVersion =
          double.parse(remoteConfig.getString('force_update_current_version').trim().replaceAll(".", ""));
      print('newVersion' + newVersion.toString());
      if (newVersion > currentVersion) {
        _showVersionDialog(context);
      } else {
        Future.delayed(Duration(seconds: 2), () async {
          bool b = await checkPrefsForLogin(context: context);
//      Navigator.pushReplacementNamed(
//          context,
//          MaterialPageRoute(
//              fullscreenDialog: true,
//              builder: (context) {
//                if (b) {
//                  return AllPartsHomeScreen();
//                } else
//                  return OnboardingScreen();
//                // return SignInWithPhoneNO();
//              }));
          b ? Navigator.pushReplacementNamed(context, '/home') : Navigator.pushReplacementNamed(context, '/onboard');
        });
      }
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
  }

  _showVersionDialog(context) async {
    print("showDialog()");
    await showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        String title = "New Update Available";
        String message = "There is a newer version of app available please update it now.";
        String btnLabel = "Update Now";
        String btnLabelCancel = "Later";
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: Text(btnLabel),
                    onPressed: () => _launchURL(APP_URL),
                  ),
                ],
              )
            : new CupertinoAlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: Text(btnLabel),
                    onPressed: () => _launchURL(APP_URL),
                  ),
                ],
              );
      },
    );
  } //LAUNCH URL

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      _firebaseMessaging.getToken().then((token) {
        print("token: " + token.toString());
      });
    } catch (e) {
      print(e.toString());
    }
    currentVersionCheck();
    if (mounted) setState(() {});
    try {
      newVersionCheck(context);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomSheet: Container(
          padding: EdgeInsets.only(bottom: 10),
          height: 30,
          alignment: Alignment.bottomCenter,
          // color: Colors.blue[100],
          child: Text(
            "App Version " + currentVersionName,
            style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
          ),
        ),
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
    loadRecents(context: context);
    super.didChangeDependencies();
  }
}
