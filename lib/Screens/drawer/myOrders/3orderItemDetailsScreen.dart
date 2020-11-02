import 'package:bodmoo/models/orderItemModel.dart';
import 'package:flutter/material.dart';

class OrderItemDetailsScreen extends StatefulWidget {
  OrderItemModel orderItem = OrderItemModel();
  OrderItemDetailsScreen({@required this.orderItem});
  @override
  _OrderItemDetailsScreenState createState() => _OrderItemDetailsScreenState();
}

class _OrderItemDetailsScreenState extends State<OrderItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(),
    );
  }
}
