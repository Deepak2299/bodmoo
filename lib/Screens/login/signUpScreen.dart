import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Welcome new User"),
        ),
        body: Column(
          children: <Widget>[
            Flexible(child: TextFormField(decoration: InputDecoration(labelText: 'Name'))),
            SizedBox(height: 30),
            Flexible(child: TextFormField(decoration: InputDecoration(labelText: 'Address'))),
          ],
        ),
      ),
    );
  }
}
