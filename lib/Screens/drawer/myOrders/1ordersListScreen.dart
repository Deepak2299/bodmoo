import 'file:///D:/FLUTTERAPPS/bodmoo/lib/Screens/drawer/myOrders/2orderDetailsScreen.dart';
import 'package:bodmoo/methods/get/getOrdersList.dart';
import 'package:bodmoo/models/cartModel.dart';
import 'package:bodmoo/models/orderModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          future: getOrdersList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<OrderModel> ordersList = snapshot.data;
              return ListView.separated(
                itemBuilder: (context, orderIndex) {
                  OrderModel orderModel = ordersList[orderIndex];
                  return ListTile(
                    title: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(orderModel.id),
                        Text(orderModel.orderDate.toIso8601String()),
                        Text(orderModel.orderNumber),
                        Text(orderModel.orderStatus),
                        Text(orderModel.paymentType),
                        Text(orderModel.paymentTransactionId),
                        Text(orderModel.pinCode),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => OrderDetailsScreen(orderModel: orderModel),
                          ));
                    },
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: ordersList.length,
              );
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
