import 'package:bodmoo/Screens/login/phoneVerification.dart';
import 'package:bodmoo/Screens/login/signUpScreen.dart';
import 'package:bodmoo/main_screen.dart';
import 'package:bodmoo/providers/ScreenProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ScreenProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignUpScreen(),
    );
  }
}
