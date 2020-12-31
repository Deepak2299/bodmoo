import 'package:bodmoo/Screens/login/phoneVerification.dart';
import 'package:bodmoo/Screens/login/signUpScreen.dart';
import 'package:bodmoo/Screens/realMeat/PartDetailsScreen.dart';
import 'package:bodmoo/Screens/realMeat/PartScreen.dart';
//import 'file:///D:/FLUTTERAPPS/bodmoo/lib/Screens/drawer/myAddresses/addAddressScreen.dart';
import 'package:bodmoo/Screens/realMeat/cartItemsScreen.dart';
import 'package:bodmoo/Screens/realMeat/homeScreen.dart';
import 'package:bodmoo/Screens/splashScreen.dart';
import 'package:bodmoo/providers/ScreenProvider.dart';
import 'package:bodmoo/providers/cartProvider.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ScreenProvider>(
          create: (_) => ScreenProvider(),
        ),
        ChangeNotifierProvider<CustomerDetailsProvider>(
          create: (_) => CustomerDetailsProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
      ],
      // create: (context) => ScreenProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spare Parts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:
          // AddAddressScreen(),
          SplashScreen(),
      // initialRoute: '/home',
      routes: {
        // "/home": (context) => HomeScreen(),
        // '/parts': (context) => PartScreen(),
        // "partDetail": (context) => PartDetailsScren(),
        // "cartScreen": (context) => CartItemsScreen(),
        // "phoneSignUp": (context) => SignInWithPhoneNO(),
        // "userSignUp": (context) => SignUpScreen(),
      },
      onGenerateRoute: (route) {
        if (route.name == '/parts')
          return CupertinoPageRoute(builder: (context) => PartScreen(), maintainState: true);
        else
          return null;
      },
    );
  }
}
