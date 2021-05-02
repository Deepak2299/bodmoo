import 'package:bodmoo/Screens/login/otpScreen.dart';
import 'package:bodmoo/widgets/toastWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

Future<bool> authFunction(
    {String verificationId,
    String phoneNumber,
    String code,
    String sms}) async {
  AuthCredential _credentials;

  _credentials = PhoneAuthProvider.getCredential(
      verificationId: verificationId, smsCode: sms);
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

Future<int> sendCodeToPhoneNumber(
    {@required String phonenumber, BuildContext context, bool stored}) {
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
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
        print(verificationId);
        print("Timeout");
      });
}
