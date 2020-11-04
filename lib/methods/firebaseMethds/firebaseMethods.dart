import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

sendCodeToPhoneNumber({@required String phonenumber, BuildContext context}) {
  PHONE_NO = phonenumber;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phonenumber,
      timeout: Duration(seconds: 5),
      verificationCompleted: (AuthCredential authCredentials) {
        try {
          _firebaseAuth.signInWithCredential(authCredentials).then((AuthResult result) async {
            if (result.user != null) {
              showToast(msg: "Congrats, your phone number is verified");

              //sing out for phone and signin with email
              await _firebaseAuth.signOut();
              Navigator.pushAndRemoveUntil(
                  context, CupertinoPageRoute(builder: (context) => SignupScreen()), ModalRoute.withName(''));
            } else
              showToast(msg: "Phone number is not verified");
          });
        } on PlatformException catch (e) {
          showToast(msg: e.message);
        }
      },
      verificationFailed: (AuthException authException) {
        showToast(msg: authException.message);
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        TextEditingController smsController = TextEditingController();
        GlobalKey<FormState> _formKey = GlobalKey<FormState>();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.deepPurpleAccent,
                  title: Text("Enter SMS Code", style: signStyle),
                  content: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          controller: smsController,
                          validator: (String code) => smsValidator(code),
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                          },
                          style: labelStyle,
                          decoration: InputDecoration(
                            labelText: "SMS Code",
                            labelStyle: labelStyle,
                            enabledBorder: myBorder,
                            focusedBorder: myBorder,
                            errorBorder: errorBorder,
                            border: myBorder,
                            errorStyle: errorStyle,
                            filled: true,
                            fillColor: Colors.white12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color: Colors.white12,
                      child: Text(
                        "Done",
                        style: signStyle,
                      ),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState.validate()) {
                          String sms = smsController.text.trim();
                          AuthCredential _credentials;
                          _credentials = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: sms);

                          _firebaseAuth.signInWithCredential(_credentials).then((AuthResult result) async {
                            if (result.user != null) {
                              showToast(msg: "Congrats, your phone number is verified");
                              //sing out for phone and signin with email
                              await _firebaseAuth.signOut();
                              Navigator.pop(context);
                              Navigator.pushAndRemoveUntil(context,
                                  CupertinoPageRoute(builder: (context) => SignupScreen()), ModalRoute.withName(''));
                            } else {
                              showToast(msg: "Phone number is not verified");
                            }
                          }).catchError((onError) {
                            showToast(msg: onError.toString());
                          });
                        }
//                          Navigator.pop(context);
                      },
                    )
                  ],
                ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
        print(verificationId);
        print("Timeout");
      });
}
