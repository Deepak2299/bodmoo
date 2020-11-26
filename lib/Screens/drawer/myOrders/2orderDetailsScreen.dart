import 'package:bodmoo/Screens/drawer/myOrders/3orderItemDetailsScreen.dart';
import 'package:bodmoo/Screens/realMeat/cartItemsScreen.dart';
import 'package:bodmoo/models/orderItemModel.dart';
import 'package:bodmoo/models/orderModel.dart';
import 'package:bodmoo/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatefulWidget {
  OrderModel orderModel = OrderModel();
  OrderDetailsScreen({@required this.orderModel});
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

orderWidget({@required List<Widget> children}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
    child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5))),
        elevation: 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        )),
  );
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Order Details"),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            orderWidget(
              children: [
                Container(
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: Text(
                      "Order ID - " + widget.orderModel.orderNumber.toString(),
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
                Divider(
                  height: 2,
                  thickness: 1.2,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  itemBuilder: (context, orderItemIndex) {
                    List<OrderItemModel> orderItem =
                        widget.orderModel.orderItems;
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
                      leading: Hero(
                        tag: "images_${orderItem[orderItemIndex].partId}",
                        child: Image.asset(
                          IMAGE,
                          fit: BoxFit.fill,
                        ),
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
                                    str: orderItem[orderItemIndex].brandName),
                                tagStyle(
                                    str: orderItem[orderItemIndex].vehicleName),
                                tagStyle(
                                    str: orderItem[orderItemIndex]
                                            .vehicleModel +
                                        " " +
                                        orderItem[orderItemIndex].vehicleYear),
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
//                        Text("Total Price: Rs. " +
//                            (double.parse(orderItem[orderItemIndex].partPrice) *
//                                    orderItem[orderItemIndex].orderQty)
//                                .toString()),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Qty: " +
                                orderItem[orderItemIndex].orderQty.toString(),
                            style: TextStyle(fontSize: 14),
                          ),
//                            Text(
//                              "Free shipping",
//                              style:
//                                  TextStyle(color: Colors.green, fontSize: 14),
//                            ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, i) => Divider(),
                  itemCount: widget.orderModel.orderItems.length,
                )
              ],
            ),
            orderWidget(
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.orderModel.addressModel.customerName
                              .toString(),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.orderModel.addressModel.houseno,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          widget.orderModel.addressModel.roadname,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          widget.orderModel.addressModel.city,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          widget.orderModel.addressModel.state,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Phone number : ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500)),
                            Text(
                                widget.orderModel.addressModel.customerMobile
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            orderWidget(
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
                Container(
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "List price",
                            ),
                            Spacer(),
                            Text(
                              "Rs. 0",
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "Selling price",
                            ),
                            Spacer(),
                            Text(
                              "Rs. 0",
                            )
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Shipping price",
                            ),
                            Spacer(),
                            Text(
                              "Rs. 0",
                            )
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 2,
                  thickness: 1,
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
                        "Rs. 0",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 2,
                  thickness: 1.2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: Text("Credit Card:"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
