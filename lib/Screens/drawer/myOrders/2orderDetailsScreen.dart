import 'package:bodmoo/models/orderItemModel.dart';
import 'package:bodmoo/models/orderModel.dart';
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
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(widget.orderModel.id),
            Text(widget.orderModel.orderDate.toIso8601String()),
            Text(widget.orderModel.orderNumber),
            Text(widget.orderModel.orderStatus),
            Text(widget.orderModel.paymentType),
            Text(widget.orderModel.paymentTransactionId),
            Text(widget.orderModel.pinCode),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, orderItemIndex) {
                  List<OrderItemModel> orderItem = widget.orderModel.orderItems;
                  return ListTile(
                    title: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(orderItem[orderItemIndex].brandName),
                        Text(orderItem[orderItemIndex].vehicleModel),
                        Text(orderItem[orderItemIndex].vehicleName),
                        Text(orderItem[orderItemIndex].vehicleYear),
                        Text(orderItem[orderItemIndex].partName),
                        Text(orderItem[orderItemIndex].partPrice),
                        Text(orderItem[orderItemIndex].orderQty.toString()),
                        Text(orderItem[orderItemIndex].partId),
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
