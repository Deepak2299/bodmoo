import 'package:flutter/material.dart';

class PhoneVerification extends StatefulWidget {
  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Flexible(
              child: TextFormField(
                controller: phoneController,
              ),
            ),
            RaisedButton(
              child: Text("Verify"),
            )
          ],
        ),
      ),
    );
  }
}
