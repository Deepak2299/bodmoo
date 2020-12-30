import 'package:bodmoo/Screens/Payment/paymentMethod.dart';
import 'package:bodmoo/Screens/drawer/myOrders/1ordersListScreen.dart';
import 'package:bodmoo/Screens/drawer/myOrders/orderError.dart';
import 'package:bodmoo/Screens/realMeat/cartItemsScreen.dart';
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
//  Widget build(BuildContext context) {
//    return SafeArea(
//      child: Scaffold(
//        body: Stack(
//          children: <Widget>[
//            Text(widget.items[0].partName),
//            // ListView.builder(
//            //     shrinkWrap: true,
//            //     itemCount: widget.items.length,
//            //     itemBuilder: (context, index) {
//            //       return Card(
//            //         child: Container(
//            //           child: Column(
//            //             children: <Widget>[
//            //               Text(widget.items[index].partName),
//            //             ],
//            //           ),
//            //         ),
//            //       );
//            //     }),
//            Provider.of<ScreenProvider>(context, listen: true).orderLoader
//                ? LoadingWidget(
//                    msg: 'Ordering...',
//                  )
//                : Container()
//          ],
//        ),
//        bottomNavigationBar: RaisedButton(
//          child: Text("Proceed to pay"),
//          onPressed: () {
//            pay(
//              amount: widget.amount,
//              razorpay: _razorpay,
//              PhoneNumber: widget.addressModel.customerMobile,
//            );
//          },
//        ),
//      ),
//    );
//  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
//    showToast(msg: 'Error in Order');
    print("pay");
    Provider.of<ScreenProvider>(context, listen: false).setOrderLoader(true);

    bool b = await prepareOrder(
      address: widget.addressModel,
      context: context,
      orderId: response.orderId,
      transactionId: response.paymentId,
    );
//    bool b = false;
    Provider.of<ScreenProvider>(context, listen: false).setOrderLoader(false);
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
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => OrderPlaceErrorScreen(
              transactionId: response.paymentId,
            ),
          ));
      // showDialog(
      //   context: context,
      //   child: CupertinoAlertDialog(
      //     title: Text("Error"),
      //     content: Text("Some error occurred while placing the order. Contact dealer for refund."),
      //   ),
      // );
      //
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

  double getOrderTotal() {
    double sum = 0;
    widget.items.forEach((element) {
      sum += double.parse(element.partPrice) * element.orderQty;
    });
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Order Details"),
        ),
        body: Stack(
          children: <Widget>[
            ListView(
//          shrinkWrap: true,
              physics: ScrollPhysics(),
              children: [
                cardWidget(
                  children: [
//                Container(
//                  width: double.maxFinite,
//                  child: Padding(
//                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
//                    child: Text(
//                      "Order ID - " + widget.orderModel.orderNumber.toString(),
//                      style: TextStyle(color: Colors.black54),
//                    ),
//                  ),
//                ),
//                Divider(
//                  height: 2,
//                  thickness: 1.2,
//                ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      itemBuilder: (context, orderItemIndex) {
                        List<OrderItemModel> orderItem = widget.items;
                        return ListTile(
                          onTap: () {
//                        Navigator.push(
//                            context,
//                            CupertinoPageRoute(
//                              builder: (context) => OrderItemDetailsScreen(
//                                orderItem: orderItem[orderItemIndex],
//                              ),
//                            ));
                          },
                          leading: Image.asset(
                            IMAGE,
                            fit: BoxFit.fill,
                          ),
                          title: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                orderItem[orderItemIndex].partName,
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Flexible(
                                child: Row(
                                  children: <Widget>[
                                    tagStyle(
                                        str: orderItem[orderItemIndex]
                                            .brandName),
                                    tagStyle(
                                        str: orderItem[orderItemIndex]
                                            .vehicleName),
                                    tagStyle(
                                        str: orderItem[orderItemIndex]
                                                .vehicleModel +
                                            " " +
                                            orderItem[orderItemIndex]
                                                .vehicleYear),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                  "Price: Rs. " +
                                      orderItem[orderItemIndex].partPrice,
                                  style: TextStyle(fontSize: 14)),
                              SizedBox(height: 2),
                              Text(
                                "Qty: " +
                                    orderItem[orderItemIndex]
                                        .orderQty
                                        .toString(),
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, i) => Divider(),
                      itemCount: widget.items.length,
                    )
                  ],
                ),
                cardWidget(
                  children: [
                    Container(
                      width: double.maxFinite,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Text(
                          "Shipping Details",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                    Divider(
                      height: 2,
                      thickness: 1.2,
                    ),
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: addressWidget(addressModel: widget.addressModel),
                    ),
                  ],
                ),
                cardWidget(
                  children: [
                    Container(
                      width: double.maxFinite,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Text(
                          "Price Details",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                    Divider(
                      height: 2,
                      thickness: 1.2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 8.0),
                      child: Row(
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Text(
                            "Rs. " + widget.amount.toString(),
                            // getOrderTotal().toString(),
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 2,
                      thickness: 1.2,
                    ),
                  ],
                ),
              ],
            ),
            Provider.of<ScreenProvider>(context, listen: true).orderLoader
                ? LoadingWidget(
                    msg: 'Ordering...',
                  )
                : Container()
          ],
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            pay(
              amount: widget.amount,
              razorpay: _razorpay,
              PhoneNumber: widget.addressModel.customerMobile,
            );
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.06,
            color: Colors.deepOrange,
            child: Center(
              child: Text(
                "Proceed to pay",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
