import 'package:bodmoo/Screens/login/signUpScreen.dart';
import 'package:bodmoo/main_screen.dart';
import 'package:bodmoo/methods/firebaseMethds/firebaseMethods.dart';
import 'package:bodmoo/methods/post/getUserDetails.dart';
import 'package:bodmoo/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  String verificationId, phoneNumber;
  OTPScreen({@required this.verificationId, this.phoneNumber});
//  FocusNode Node = FocusNode();
  TextEditingController otpController = TextEditingController();
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("OTP Verifications")),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _key,
            child: ListView(
              shrinkWrap: true,
//                crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Verify your phone number here",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      wordSpacing: 1.5),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Paste OTP here",
                  style: TextStyle(
                      color: Color(0xff888888),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      wordSpacing: 1.5),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autofocus: true,
                  controller: otpController,
//                  focusNode: codeNode,
                  validator: (String code) {
                    if (code.isEmpty) return "Enter SMS Code";
                    return null;
                  },
                  cursorColor: flipkartBlue,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,

//                    style: labelStyle,
                  decoration: InputDecoration(
//                    hintText: "91",
                    labelText: "OTP Code",
                    focusColor: flipkartBlue,
                    focusedBorder: fieldBorder,
                    border: fieldBorder,
                    enabledBorder: fieldBorder,
                    errorBorder: errorBorder,
                    errorStyle: TextStyle(color: Colors.redAccent),
                    filled: true,
                    fillColor: Colors.transparent,
//                        fillColor: Colors.white12
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: GestureDetector(
              onTap: () async {
                bool verified = await function(
                    verificationId: widget.verificationId,
                    phoneNumber: widget.phoneNumber,
                    sms: otpController.text);
                print(verified.toString());
                if (verified) {
                  bool userexist =
                      await getUserDetailsOrLogin(PhNo: widget.phoneNumber);
                  if (userexist)
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => MainScreen()));
                  else
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => SignUpScreen()));
                }
              },
              child: Container(
                color: Colors.deepOrangeAccent,
                height: 43,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Verify",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
