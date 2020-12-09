import 'package:flutter/material.dart';


class OrderPlaceErrorScreen extends StatefulWidget {
  String transactionId;
  OrderPlaceErrorScreen({@required this.transactionId});
  @override
  _OrderPlaceErrorScreenState createState() => _OrderPlaceErrorScreenState();
}

class _OrderPlaceErrorScreenState extends State<OrderPlaceErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text("Sorry, can't place Order. Don't worry your money "
              "is safe and will get refund. "
              "Your Transaction Id: ${widget.transactionId}."
              "Contact seller"
              "+914554584"),

        ),
      ),
    );
  }
}
