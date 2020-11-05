import 'package:bodmoo/Screens/drawer/myOrders/3orderItemDetailsScreen.dart';
import 'package:bodmoo/Screens/realMeat/cartItemsScreen.dart';
import 'package:bodmoo/models/orderItemModel.dart';
import 'package:bodmoo/models/orderModel.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatefulWidget {
  OrderModel orderModel = OrderModel();
  OrderDetailsScreen({@required this.orderModel});
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
//            Text(widget.orderModel.id),
//            Text(widget.orderModel.orderDate.toIso8601String()),
//            Text(widget.orderModel.orderNumber),
//            Text(widget.orderModel.orderStatus),
//            Text(widget.orderModel.paymentType),
//            Text(widget.orderModel.paymentTransactionId),
//            Text(widget.orderModel.pinCode),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, orderItemIndex) {
                  List<OrderItemModel> orderItem = widget.orderModel.orderItems;
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => OrderItemDetailsScreen(
                              orderItem: orderItem[orderItemIndex],
                            ),
                          ));
                    },
                    leading: Container(
                      width: 100,
//                      height: 200,
                      child: Hero(
                        tag: "images_${orderItem[orderItemIndex].partId}",
                        child: Image.asset(
                          IMAGE,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    title: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(orderItem[orderItemIndex].partName),
                        Flexible(
                          child: Row(
                            children: <Widget>[
                              tagStyle(str: orderItem[orderItemIndex].brandName),
                              tagStyle(str: orderItem[orderItemIndex].vehicleName),
                              tagStyle(
                                  str: orderItem[orderItemIndex].vehicleModel +
                                      " " +
                                      orderItem[orderItemIndex].vehicleYear),
                            ],
                          ),
                        ),
                        Text("Price: Rs. " + orderItem[orderItemIndex].partPrice),
//                        Text("Total Price: Rs. " +
//                            (double.parse(orderItem[orderItemIndex].partPrice) *
//                                    orderItem[orderItemIndex].orderQty)
//                                .toString()),
                        Text("Qty: " + orderItem[orderItemIndex].orderQty.toString()),
                        Text(
                          "Free shipping",
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, i) => Divider(),
                itemCount: widget.orderModel.orderItems.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
