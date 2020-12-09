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
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: ListView(
                  physics: ScrollPhysics(),
//                    mainAxisSize: MainAxisSize.min,
//                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, orderIndex) {
                        OrderModel orderModel = ordersList[orderIndex];

                        return ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                ),Text(
                                  "Transaction Id: " + orderModel.paymentTransactionId,
                                  style: TextStyle(fontSize: 12),
                                ),
//                        Text(orderModel.paymentTransactionId),
                              ],
                            ),
                          ),
                          trailing: Container(
                            padding: EdgeInsets.only(top: 12),
                            child: Icon(Icons.keyboard_arrow_right),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => OrderDetailsScreen(
                                      orderModel: orderModel),
                                ));
                          },
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                        thickness: 1,
                        height: 2,
                      ),
                      itemCount: ordersList.length,
                    ),
                    Divider(
                      height: 2,
                      thickness: 1,
                    ),
                    Center(
                        heightFactor: 3,
                        child: Text(
                          "No more orders",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
              );
            } else
              return LoadingWidget(msg: 'Loading Orders');
          },
        ),
      ),
    );
  }
}
