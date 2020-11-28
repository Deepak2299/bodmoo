import 'package:bodmoo/Screens/login/otpScreen.dart';
import 'package:bodmoo/widgets/toastWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

Future<bool> authFunction({String verificationId, String phoneNumber, String code, String sms}) async {
  AuthCredential _credentials;

  _credentials = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: sms);
  try {
    AuthResult result = await _firebaseAuth.signInWithCredential(_credentials);
    if (result.user != null) {
      showToast(msg: "Congrats, your phone number is verified");
      return true;
    } else
      showToast(msg: "Phone number is not verified");
    return false;
  } on PlatformException catch (e) {
    showToast(msg: e.message);

    return false;
  }
}

Future<int> sendCodeToPhoneNumber({@required String phonenumber, BuildContext context, bool stored}) {
  String PHONE_NO = phonenumber;
  _firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+91" + phonenumber,
      timeout: Duration(seconds: 5),
//       verificationCompleted: (AuthCredential authCredentials) {
//         function(credential: authCredentials, PHONE_NO: PHONE_NO);
//         // try {
//         //   _firebaseAuth.signInWithCredential(authCredentials).then((AuthResult result) async {
//         //     if (result.user != null) {
//         //       showToast(msg: "Congrats, your phone number is verified");
//         //
//         //       //sing out for phone and signin with email
//         //       await _firebaseAuth.signOut();
//         //       Navigator.pushAndRemoveUntil(
//         //           context, CupertinoPageRoute(builder: (context) => MainScreen()), ModalRoute.withName(''));
//         //     } else
//         //       showToast(msg: "Phone number is not verified");
//         //   });
//         // } on PlatformException catch (e) {
//         //   showToast(msg: e.message);
//         // }
//       },
      verificationFailed: (AuthException authException) {
        showToast(msg: authException.message);
      },
      codeSent: (String verificationId, [int forceResendingToken]) async {
        await Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => OTPScreen(
                    verificationId: verificationId,
                    phoneNumber: PHONE_NO,
                    code: "+91",
                    stored: stored,
                  )),
        ); //
        // TextEditingController smsController = TextEditingController();
//         GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//         showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (context) => AlertDialog(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   backgroundColor: Colors.white,
//                   title: Text("Enter SMS Code"),
//                   content: Form(
//                     key: _formKey,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         TextFormField(
//                           controller: smsController,
//                           validator: (String code) {
//                             if (code.isEmpty) return "Enter SMS Code";
//                             return null;
//                           },
//                           cursorColor: flipkartBlue,
//                           textInputAction: TextInputAction.done,
//                           onFieldSubmitted: (value) {
//                             FocusScope.of(context).unfocus();
//                           },
//                          style: labelStyle,
//                           decoration: InputDecoration(
//                             labelText: "SMS Code",
//                             focusColor: flipkartBlue,
//                             focusedBorder: fieldBorder,
//                             border: fieldBorder,
//                             enabledBorder: fieldBorder,
//                             errorBorder: errorBorder,
//                             errorStyle: TextStyle(color: Colors.redAccent),
//                             filled: true,
//                             fillColor: Colors.transparent,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   actions: <Widget>[
//                     FlatButton(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                       color: Colors.white12,
//                       child: Text(
//                         "Done",
//                        style: signStyle,
//                       ),
//                       onPressed: () async {
//                         FocusScope.of(context).unfocus();
//                         if (_formKey.currentState.validate()) {
//                           String sms = smsController.text.trim();
//                           AuthCredential _credentials;
//                           _credentials = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: sms);
//
//                           function(credential: _credentials, PHONE_NO: PHONE_NO);
//                           _firebaseAuth.signInWithCredential(_credentials).then((AuthResult result) async {
//                             if (result.user != null) {
//                               showToast(msg: "Congrats, your phone number is verified");
//                               //sing out for phone and signin with email
//                              await _firebaseAuth.signOut();
//                               Navigator.pop(context);
//                               Navigator.pushAndRemoveUntil(context,
//                                   CupertinoPageRoute(builder: (context) => MainScreen()), ModalRoute.withName(''));
//                             } else {
//                               showToast(msg: "Phone number is not verified");
//                             }
//                           }).catchError((onError) {
//                             showToast(msg: onError.toString());
//                           });
//                         }
//                          Navigator.pop(context);
//                       },3
//                     )
//                   ],
//                 ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
        print(verificationId);
        print("Timeout");
      });
}
