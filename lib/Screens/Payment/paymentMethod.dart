import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

pay({@required double amount, @required Razorpay razorpay}) async {
  String url = 'https://api.razorpay.com/v1/orders';
  String username = 'rzp_test_Cmt4oHRCGuf0BP',
      password = 'leyN2nOTlVdGfof2tc8g0WG5';
  var rq = await http.post(
    url,
    body: jsonEncode(
        {"amount": amount, "currency": "INR", "receipt": "rcptid_11"}),
    headers: {
      'content-type': 'application/json',
      HttpHeaders.authorizationHeader:
          'Basic ' + base64Encode(utf8.encode('$username:$password')),
    },
  );
  print(rq.body);
  checkout(
      orderId: jsonDecode(rq.body)['id'], amount: amount, razorpay: razorpay);
}

checkout(
    {@required String orderId,
    @required double amount,
    @required Razorpay razorpay}) {
  Razorpay _razorpay = Razorpay();
  var options = {
    'key': 'rzp_test_Cmt4oHRCGuf0BP',
    'amount': amount, //in the smallest currency sub-unit.
    'name': 'Acme Corp.',
    'order_id': orderId, // Generate order_id using Orders API
    'description': 'Fine T-Shirt',
    'timeout': 60, // in seconds
    // 'prefill': {'contact': '9123456789', 'email': 'gaurav.kumar@example.com'}
  };
  try {
    razorpay.open(options);
  } catch (e) {
    debugPrint(e);
  }
}
