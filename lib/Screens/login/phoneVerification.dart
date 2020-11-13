import 'package:bodmoo/Screens/login/otpScreen.dart';
import 'package:bodmoo/Screens/realMeat/homeScreen.dart';
import 'package:bodmoo/methods/firebaseMethds/firebaseMethods.dart';
import 'package:bodmoo/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInWithPhoneNO extends StatefulWidget {
  bool stored;
  SignInWithPhoneNO({this.stored = false});
  @override
  _SignInWithPhoneNOState createState() => _SignInWithPhoneNOState();
}

class _SignInWithPhoneNOState extends State<SignInWithPhoneNO> {
  TextEditingController phoneController = new TextEditingController();
  bool isEnabled = false;
  FocusNode emailNode = FocusNode();
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController codeController = TextEditingController();
  FocusNode phoneNode = FocusNode();
  FocusNode codeNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: flipkartBlue,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Bodmoo",
          style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          padding: EdgeInsets.only(bottom: 15),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                ModalRoute.withName(""));
          },
          icon: Icon(
            IconData(
              0x2715,
            ),
          ),
        ),
      ),
      body: Column(
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
                    "Log in to get started",
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
                    "Experience the all new Bodmoo!",
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
                    controller: codeController,
                    focusNode: codeNode,
                    validator: (String code) => codeValidation(code),
                    cursorColor: flipkartBlue,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(phoneNode);
                    },
//                    style: labelStyle,
                    decoration: InputDecoration(
                      hintText: "91",
                      labelText: "Country Code",
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
                  TextFormField(
//                    autofocus: true,
                    controller: phoneController,
                    onChanged: (String val) {
                      val = val.trim();
                      if (val.length > 10 || val.length < 10)
                        setState(() {
                          isEnabled = false;
                        });
                      else
                        setState(() {
                          isEnabled = true;
                        });
                    },
                    validator: (String val) {
                      val = val.trim();
                      if (val.length > 10 || val.length < 10)
                        return "Invalid mobile number";
                    },
                    showCursor: true,
                    keyboardAppearance: Brightness.light,
                    cursorColor: flipkartBlue,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      focusColor: flipkartBlue,
                      focusedBorder: fieldBorder,
                      border: fieldBorder,
                      enabledBorder: fieldBorder,
                      errorBorder: errorBorder,
                      errorStyle: TextStyle(color: Colors.redAccent),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                    focusNode: phoneNode,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onTap: !isEnabled
              ? () {}
              : () {
                  FocusScope.of(context).unfocus();
                  if (_key.currentState.validate()) {
                    sendCodeToPhoneNumber(
                        phonenumber: phoneController.text,
                        code: "+" + codeController.text,
                        context: context,
                        stored: widget.stored);
                  }
                },
          child: Container(
            color: isEnabled ? Colors.deepOrangeAccent : Colors.grey,
            height: 43,
            width: double.infinity,
            child: Center(
              child: Text(
                "Send OTP",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
