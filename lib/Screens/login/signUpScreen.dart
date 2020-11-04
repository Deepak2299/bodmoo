import 'package:bodmoo/main_screen.dart';
import 'package:bodmoo/utils/utils.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = new TextEditingController();
  bool isEnabled = false;

  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController addController = TextEditingController();
  FocusNode nameNode = FocusNode();
  FocusNode addNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: flipkartBlue,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Welcome to new user",
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
                MaterialPageRoute(builder: (context) => MainScreen()),
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
//                  Text(
//                    "Log in to get started",
//                    style: TextStyle(
//                        color: Colors.black,
//                        fontSize: 15,
//                        fontWeight: FontWeight.w500,
//                        wordSpacing: 1.5),
//                  ),
//                  SizedBox(
//                    height: 15,
//                  ),
//                  Text(
//                    "Experience the all new Bodmoo!",
//                    style: TextStyle(
//                        color: Color(0xff888888),
//                        fontSize: 12,
//                        fontWeight: FontWeight.w500,
//                        wordSpacing: 1.5),
//                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    autofocus: true,
                    controller: nameController,
                    focusNode: nameNode,
                    validator: (String code) {
                      code = code.trim();
                      if (code == "") return "Enter your name";
                      return null;
                    },
                    cursorColor: flipkartBlue,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(addNode);
                    },
//                    style: labelStyle,
                    decoration: InputDecoration(
                      hintText: "prayant",
                      labelText: "Name",
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
                    controller: addController,
                    onChanged: (String val) {
                      val = val.trim();
                      if (val == "")
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
                      if (val == "") return "Enter address";
                    },
                    showCursor: true,
                    keyboardAppearance: Brightness.light,
                    cursorColor: flipkartBlue,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                    },
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      hintText: "Abc, India",
                      labelText: "Address",
                      focusColor: flipkartBlue,
                      focusedBorder: fieldBorder,
                      border: fieldBorder,
                      enabledBorder: fieldBorder,
                      errorBorder: errorBorder,
                      errorStyle: TextStyle(color: Colors.redAccent),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                    focusNode: addNode,
                  ),
                  SizedBox(
                    height: 15,
                  ),
//                  InkWell(
//                    onTap: () {
////                      Navigator.pushAndRemoveUntil(
////                          context,
////                          MaterialPageRoute(
////                              builder: (context) => SignInWithEmail()),
////                          ModalRoute.withName(""));
//                    },
//                    child: Align(
//                      alignment: Alignment.centerRight,
//                      child: Text(
//                        "Use Email ID",
//                        style: TextStyle(
//                            color: flipkartBlue,
//                            fontSize: 12,
//                            fontWeight: FontWeight.w500),
//                      ),
//                    ),
//                  )
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
//              sendCodeToPhoneNumber(
//                  phonenumber: "+" + codeController.text + phoneController.text, context: context);
//            }
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
