import 'package:bodmoo/Screens/drawer/myOrders/2orderDetailsScreen.dart';
import 'package:bodmoo/methods/get/getOrdersList.dart';
import 'package:bodmoo/models/cartModel.dart';
import 'package:bodmoo/models/orderModel.dart';
import 'package:bodmoo/providers/ScreenProvider.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreen1State createState() => _OrderListScreen1State();
}

class _OrderListScreen1State extends State<OrderListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("My Orders")),
        body: FutureBuilder(
          future: getOrdersList(
              PhNo: Provider.of<CustomerDetailsProvider>(context, listen: false)
                  .phoneNumber,
              context: context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<OrderModel> ordersList = snapshot.data;
              return ListView.separated(
                itemBuilder: (context, orderIndex) {
                  OrderModel orderModel = ordersList[orderIndex];
                  return ListTile(
                    title: Card(
                      margin: EdgeInsets.zero,
//                      elevation: 10,
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,

//                          mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                "Order No: " + orderModel.orderNumber,
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                "Order at " +
                                    orderModel.orderDate.toIso8601String(),
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                "Status: " + orderModel.orderStatus,
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                "Payment Mode: " + orderModel.paymentType,
                                style: TextStyle(fontSize: 12),
                              ),
//                        Text(orderModel.paymentTransactionId),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                OrderDetailsScreen(orderModel: orderModel),
                          ));
                    },
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: ordersList.length,
              );
            } else
              return LoadingWidget(msg: 'Loading Orders');
          },
        ),
      ),
    );
  }
}
