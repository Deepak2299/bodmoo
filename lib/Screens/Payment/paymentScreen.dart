import 'package:bodmoo/Screens/Payment/paymentMethod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  double paymentAmount;
  PaymentScreen({@required this.paymentAmount});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Razorpay _razorpay = Razorpay();
  bool check = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Razorpay _razorpay = Razorpay();
    pay(amount: widget.paymentAmount);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      check = true;
    });

    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear(); // Removes all listeners

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(check);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(!check ? "Payment" : "order"),
        ),
      ),
    );
  }
}
