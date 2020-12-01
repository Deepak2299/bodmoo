import 'package:bodmoo/Screens/GoogleSignIn/methods.dart';
import 'package:bodmoo/Screens/realMeat/homeScreen.dart';
import 'package:bodmoo/models/userModel.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleScreen extends StatefulWidget {
  @override
  _GoogleScreenState createState() => _GoogleScreenState();
}

class _GoogleScreenState extends State<GoogleScreen> {
  bool obscure = true, loading = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  _launchURL(int t) async {
    String url1 = 'https://support.google.com/accounts?hl=en-GB#topic=3382296';
    String url2 = 'https://accounts.google.com/TOS?loc=IN&hl=en-GB&privacy=true';
    String url3 = 'https://accounts.google.com/TOS?loc=IN&hl=en-GB';
    String url;
    switch (t) {
      case 1:
        url = url1;
        break;
      case 2:
        url = url2;
        break;
      case 3:
        url = url3;
        break;
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google',
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              ListView(
                // shrinkWrap: true,
                children: <Widget>[
                  SizedBox(height: 20),
                  Center(
                      child: Image.asset(
                    'assets/google.png',
                    // gaplessPlayback: true,
                    scale: 40,
                  )),
                  SizedBox(height: 20),
                  Center(
                      child: Text(
                    "Sign in with your Google Account",
                    style: TextStyle(fontSize: 16),
                  )),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Card(
                      color: Colors.grey[90],
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                          10,
                          10,
                          10,
                          20,
                        ),
                        child: Form(
                          key: key,
                          autovalidate: false,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Icon(
                                  Icons.account_circle,
                                  color: Colors.grey[300],
                                  size: 100,
                                ),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff4285F4)))),
                                  validator: (String str) {
                                    str = str.trim();
                                    if (str == null || str.length == 0)
                                      return '! Enter an email';
                                    else
                                      return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  controller: pwdController,
                                  obscureText: obscure,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          obscure ? MdiIcons.eyeOutline : MdiIcons.eyeOffOutline,
                                          color: Colors.black87,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            obscure = !obscure;
                                          });
                                        },
                                      ),
                                      labelText: 'Enter your Password',
                                      labelStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff4285F4)))),
                                  validator: (String str) {
                                    str = str.trim();
                                    if (str == null || str.length == 0)
                                      return '! Enter a password';
                                    else
                                      return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: RaisedButton(
                                  color: Color(0xff4285F4),
                                  child: Container(
                                    width: double.maxFinite,
                                    height: 40,
                                    child: Center(
                                        child: Text("Sign in",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ))),
                                  ),
                                  onPressed: () async {
                                    if (key.currentState.validate()) {
                                      setState(() {
                                        loading = true;
                                      });

                                      String email = emailController.text.trim();
                                      String pwd = pwdController.text.trim();
                                      bool b = await method(inputEmail: email, inputPwd: pwd);
                                      print('b' + b.toString());
                                      if (b) {
                                        Provider.of<CustomerDetailsProvider>(context, listen: false).setCustomerDetails(
                                            userModel: UserModel(
                                          token: null,
                                          customerMobile: null,
                                          customerName: email.split('@')[0],
                                        ));
                                        Navigator.pushReplacement(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) => HomeScreen(),
                                            ));
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return CupertinoAlertDialog(
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text("OK"),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  )
                                                ],
                                                title: Text("Error"),
                                                content: Column(
                                                  children: <Widget>[
                                                    SizedBox(height: 8),
                                                    Text("Try again with valid credentials. "),
                                                    SizedBox(height: 8),
                                                    Text("If still not able to login please report to developer."),
                                                  ],
                                                ),
                                              );
                                            });
                                      }

                                      setState(() {
                                        loading = false;
                                      });
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  "Need Help?",
                                  style: TextStyle(color: Color(0xff4285F4), fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text("English (United Kingdom)"),
                        GestureDetector(
                          onTap: () {
                            _launchURL(1);
                          },
                          child: Text("Help"),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURL(2);
                          },
                          child: Text("Privacy"),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURL(3);
                          },
                          child: Text("Terms"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              loading
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black12,
                      alignment: Alignment.topCenter,
                      child: LinearProgressIndicator(),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
