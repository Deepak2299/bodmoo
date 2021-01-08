import 'package:bodmoo/Screens/realMeat/homeScreen.dart';
import 'package:bodmoo/Screens/realMeat/home_screen_all_part.dart';
import 'package:bodmoo/methods/login/addUser.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/utils.dart';
import 'package:bodmoo/widgets/toastWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  String phoneNumber;
  bool stored;
  SignUpScreen({@required this.phoneNumber, this.stored = false});
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = new TextEditingController();
  bool isEnabled = false;
  bool loading = false;

  GlobalKey<FormState> _key = GlobalKey();
  FocusNode nameNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: flipkartBlue,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Welcome to new user, ${widget.phoneNumber}",
          style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          padding: EdgeInsets.only(bottom: 15),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.pushReplacementNamed(context, "/home");
//                context, MaterialPageRoute(builder: (context) => HomeScreen()), ModalRoute.withName(""));
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _key,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
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
                        cursorColor: flipkartBlue,
                        // keyboardType: TextInputType,
                        textInputAction: TextInputAction.next,

//                    style: labelStyle,
                        decoration: InputDecoration(
                          // hintText: "prayant",
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
          loading ? LoadingWidget(msg: 'Signing Up') : Container()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onTap: !isEnabled
              ? () {}
              : () async {
                  FocusScope.of(context).unfocus();
                  if (_key.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    bool addUserStatus = await addUser(
                      Name: nameController.text,
                      PhNo: widget.phoneNumber,
                      context: context,
                    );
                    await Future.delayed(Duration(seconds: 1), () {});
                    setState(() {
                      loading = false;
                    });
                    if (addUserStatus) {
                      if (widget.stored) {
                        int count = 0;
                        Navigator.pop(context);
                        // Navigator.of(context).popUntil((_) => count++ >= 2);
                      } else
                        Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => AllPartsHomeScreen(),
                            ),
                            (route) => route != '/');
                      // Navigator.push(
                      // context,
                      // CupertinoPageRoute(
                      //     builder: (context) => HomeScreen()));
                    } else
                      showToast(msg: "Already exists");
                  }
                },
          child: Container(
            color: isEnabled ? Colors.deepOrangeAccent : Colors.grey,
            height: MediaQuery.of(context).size.height * 0.06,
            width: double.infinity,
            child: Center(
              child: Text(
                "Sign Up",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
