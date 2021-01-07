import 'package:bodmoo/Screens/login/signUpScreen.dart';
import 'package:bodmoo/Screens/realMeat/homeScreen.dart';
import 'package:bodmoo/methods/firebaseMethds/firebaseMethods.dart';
import 'package:bodmoo/methods/login/getUserDetails.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  String verificationId, phoneNumber, code;
  bool stored;
  OTPScreen(
      {@required this.verificationId,
      this.phoneNumber,
      this.code,
      this.stored = false});
//  FocusNode Node = FocusNode();
  TextEditingController otpController = TextEditingController();
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController otpController = TextEditingController();
  bool loading = false, isEnable = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("OTP Verification")),
        body: Stack(
          children: <Widget>[
            Padding(
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
                      onChanged: (str) {
                        str = str.trim();
                        if (str.length > 0)
                          isEnable = true;
                        else
                          isEnable = false;
                        setState(() {});
                      },
                      cursorColor: flipkartBlue,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                      },

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
            loading ? LoadingWidget(msg: 'Verifying') : Container()
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: GestureDetector(
              onTap: () async {
                setState(() {
                  loading = true;
                });
                bool verified = await authFunction(
                    verificationId: widget.verificationId,
                    phoneNumber: widget.code + widget.phoneNumber,
                    sms: otpController.text);
                setState(() {
                  loading = false;
                });
                if (verified) {
                  bool userexist = await getUserDetailsOrLogin(
                      PhNo: widget.phoneNumber, context: context);
                  if (userexist) {
                    if (widget.stored) {
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
//                      var nav = Navigator.of(context);
//                      nav.pop();
//                      nav.pop();
                    } else
                      // Navigator.push(context, CupertinoPageRoute(builder: (context) => HomeScreen()));
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/home", (route) => false);
                  } else {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => SignUpScreen(
                                  phoneNumber: widget.phoneNumber,
                                  stored: widget.stored,
                                )));
                  }
                }
              },
              child: Container(
                color: isEnable ? Colors.deepOrangeAccent : Colors.grey,
                height: MediaQuery.of(context).size.height * 0.06,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Verify",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
