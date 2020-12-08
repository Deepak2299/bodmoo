import 'package:bodmoo/Screens/Payment/paymentMethod.dart';
import 'package:bodmoo/Screens/drawer/myOrders/1ordersListScreen.dart';
import 'package:bodmoo/Screens/realMeat/chooseAddressScreen.dart';
import 'package:bodmoo/methods/prepareOrder.dart';
import 'package:bodmoo/models/addressModel.dart';
import 'package:bodmoo/models/orderItemModel.dart';
import 'package:bodmoo/providers/ScreenProvider.dart';
import 'package:bodmoo/providers/cartProvider.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ConfirmPaymentScreen extends StatefulWidget {
  AddressModel addressModel;
  bool cartOrder;
  double amount;
  List<OrderItemModel> items = [];

  ConfirmPaymentScreen({
    @required this.addressModel,
    @required this.cartOrder,
    @required this.amount,
    @required this.items,
    // @required this.addressModel,
  });

  @override
  _ConfirmPaymentScreenState createState() => _ConfirmPaymentScreenState();
}

class _ConfirmPaymentScreenState extends State<ConfirmPaymentScreen> {
  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            ListView.builder(
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Text(widget.items[index].partName),
                        ],
                      ),
                    ),
                  );
                }),
            Provider.of<ScreenProvider>(context, listen: true).orderLoader
                ? LoadingWidget(
                    msg: 'Ordering...',
                  )
                : Container()
          ],
        ),
        bottomNavigationBar: RaisedButton(
          child: Text("Proceed to pay"),
          onPressed: () {
            pay(
              amount: widget.amount,
              razorpay: _razorpay,
              PhoneNumber: widget.addressModel.customerMobile,
            );
          },
        ),
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
//    showToast(msg: 'Error in Order');
    Provider.of<ScreenProvider>(context, listen: false).setOrderLoader(true);

    bool b = await prepareOrder(
      address: widget.addressModel,
      context: context,
      orderId: response.orderId,
      transactionId: response.paymentId,
    );
//    bool b = true;
    Provider.of<ScreenProvider>(context, listen: false).setOrderLoader(false);
    if (b) {
      // TODO:SHOW ORDER PLACED SUCCEFULLY
      widget.cartOrder ? Provider.of<CartProvider>(context, listen: false).clearCart() : null;
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => OrderListScreen()),
        // ModalRoute.withName('/parts'),
      );
    } else {
      showDialog(
        context: context,
        child: CupertinoAlertDialog(
          title: Text("Error"),
          content: Text("Some error occurred while placing the order. Contact dealer for refund."),
        ),
      );
    }
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
        msg: response.message,
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
