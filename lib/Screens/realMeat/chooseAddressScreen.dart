import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:bodmoo/Screens/Payment/paymentMethod.dart';
import 'package:bodmoo/Screens/Payment/paymentScreen.dart';
import 'package:bodmoo/Screens/drawer/myAddresses/addAddressScreen.dart';
import 'package:bodmoo/Screens/drawer/myAddresses/editAddressScreen.dart';
import 'package:bodmoo/Screens/drawer/myOrders/1ordersListScreen.dart';

import 'package:bodmoo/methods/get/getAddress.dart';
import 'package:bodmoo/methods/prepareOrder.dart';

import 'package:bodmoo/models/addressModel.dart';
import 'package:bodmoo/providers/ScreenProvider.dart';
import 'package:bodmoo/providers/cartProvider.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/utils.dart';

import 'package:bodmoo/widgets/toastWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ChooseAddressScreen extends StatefulWidget {
  bool cartOrder = false;
  ChooseAddressScreen({@required this.cartOrder});
  @override
  _ChooseAddressScreenState createState() => _ChooseAddressScreenState();
}

class _ChooseAddressScreenState extends State<ChooseAddressScreen> {
  List<AddressModel> addresses = [];
  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    // TODO: implement initState
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Delivery Location"),
      ),
      body: Stack(
        children: [
          FutureBuilder(
              future: getAddress(
                  PhNo: Provider.of<CustomerDetailsProvider>(context,
                          listen: false)
                      .phoneNumber,
                  token: Provider.of<CustomerDetailsProvider>(context,
                          listen: false)
                      .token),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  addresses = snapshot.data;
                  return ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Card(
                        elevation: 5,
                        child: ListTile(
                          leading: Icon(Icons.add),
                          title: Text("Add Address"),
                          onTap: () async {
                            await Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => AddAddressScreen()));
                            setState(() {});
                          },
                        ),
                      ),
                      ListView.builder(
                        // separatorBuilder: (context, i) => Divider(
                        //   height: 4,
                        //   thickness: 1.5,
                        // ),
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, i) {
                          return Card(
                            child: RadioListTile(
                              value: i,
                              // groupValue: Provider.of<CustomerDetailsProvider>(context).deliveryAddress,
                              groupValue: Provider.of<CustomerDetailsProvider>(
                                      context,
                                      listen: true)
                                  .addressIndex,
                              secondary: Provider.of<CustomerDetailsProvider>(
                                              context,
                                              listen: true)
                                          .addressIndex ==
                                      i
                                  ? EditAddressButton(
                                      i: i,
                                      addressModel: addresses[i],
                                    )
                                  : null,
                              title: Text(addresses[i].customerName),

                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 10),
                                  Text(prepareAddress(
                                      addressModel: addresses[i])),
                                  SizedBox(height: 10),
                                  Text(addresses[i].customerMobile),
                                ],
                              ),
                              onChanged: (int value) {
                                Provider.of<CustomerDetailsProvider>(context,
                                        listen: false)
                                    .setAddressINdex(value);
                                // setState(() {});
                                // addressIndex = value;
                              },
                            ),
                          );
                        },
                        itemCount: snapshot.data.length,
                      ),
                    ],
                  );
                } else
                  return LoadingWidget(
                    msg: 'Fetching saved Addresses',
                  );
              }),
          Provider.of<ScreenProvider>(context, listen: true).orderLorder
              ? LoadingWidget(
                  msg: '',
                )
              : Container()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.06,
          child: RaisedButton(
              color: Colors.green,
              child: Center(
                  child: Text('Checkout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ))),
              onPressed: () async {
//                Navigator.push(
//                    context,
//                    CupertinoPageRoute(
//                        builder: (context) => PaymentScreen(
//                              paymentAmount: 25451.0,
//                            )));
//                Razorpay _razorpay = Razorpay();
//                Provider.of<ScreenProvider>(context, listen: false)
//                    .setOrderLorder(true);
                pay(
                    amount: Provider.of<CartProvider>(context, listen: false)
                            .getTotalPriceOfCart() *
                        100,
                    razorpay: _razorpay);

              }
              // : showToast(msg: 'Choose Delivery address'),
              ),
        ),
      ),
    );
  }



  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
//    showToast(msg: 'Error in Order');
    Provider.of<ScreenProvider>(context, listen: false).setOrderLorder(true);

    bool b = await prepareOrder(
      address: addresses[
          Provider.of<CustomerDetailsProvider>(context, listen: false)
              .addressIndex],
      context: context,
    );
//    bool b = true;
    Provider.of<ScreenProvider>(context, listen: false).setOrderLorder(false);
    if (b) {
      // TODO:SHOW ORDER PLACED SUCCEFULLY
      widget.cartOrder
          ? Provider.of<CartProvider>(context, listen: false).clearCart()
          : null;
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => OrderListScreen()),
        // ModalRoute.withName('/parts'),
      );
    } else {
      showToast(msg: 'Error in Order');
    }
//    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear(); // Removes all listeners

    super.dispose();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Fluttertoast.showToast(
        msg: response.code.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
}
