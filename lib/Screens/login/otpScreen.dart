import 'package:bodmoo/methods/firebaseMethds/firebaseMethods.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  String verificationId, phoneNumber;
  OTPScreen({@required this.verificationId, this.phoneNumber});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("OTP Verifications")),
        body: Container(
          height: 50,
          child: TextFormField(
            controller: otpController,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: GestureDetector(
            onTap: () async {
              function(verificationId: widget.verificationId, phoneNumber: widget.phoneNumber, sms: otpController.text);
            },
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Text("Verifiy"),
            ),
          ),
        ),
      ),
    );
  }
}
