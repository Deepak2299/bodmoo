import 'package:bodmoo/Screens/drawer/myOrders/2orderDetailsScreen.dart';
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
          future: getOrdersList(PhNo: "8800152601"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<OrderModel> ordersList = snapshot.data;
              return ListView.separated(
                itemBuilder: (context, orderIndex) {
                  OrderModel orderModel = ordersList[orderIndex];
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Order No: " + orderModel.orderNumber,
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          "Order at " + orderModel.orderDate.toIso8601String(),
                          style: TextStyle(fontSize: 15),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Status: " + orderModel.orderStatus,
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "Payment Mode: " + orderModel.paymentType,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
//                        Text(orderModel.paymentTransactionId),
                        Text(
                          "Pin Code: " + orderModel.pinCode,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) =>
                                  OrderDetailsScreen(orderModel: orderModel),
                            ));
                      },
                    ),
//                    onTap: () {
//                      Navigator.push(
//                          context,
//                          CupertinoPageRoute(
//                            builder: (context) =>
//                                OrderDetailsScreen(orderModel: orderModel),
//                          ));
//                    },
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
