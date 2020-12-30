import 'package:bodmoo/Screens/drawer/myOrders/3orderItemDetailsScreen.dart';
import 'package:bodmoo/Screens/realMeat/cartItemsScreen.dart';
import 'package:bodmoo/models/orderItemModel.dart';
import 'package:bodmoo/models/orderModel.dart';
import 'package:bodmoo/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatefulWidget {
  OrderModel orderModel = OrderModel();
  OrderDetailsScreen({@required this.orderModel});
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  double getOrderTotal() {
    double sum = 0;
    widget.orderModel.orderItems.forEach((element) {
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
        body: ListView(
          shrinkWrap: true,
          children: [
            cardWidget(
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
                        child: orderItem[orderItemIndex].productImages.isEmpty
                            ? Image.asset(
                                IMAGE,
                                fit: BoxFit.fill,
                              )
                            : CachedNetworkImage(
                                imageUrl:
                                    orderItem[orderItemIndex].productImages[0],
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
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
                          SizedBox(height: 2),
                          Text(
                            "Qty: " +
                                orderItem[orderItemIndex].orderQty.toString(),
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, i) => Divider(),
                  itemCount: widget.orderModel.orderItems.length,
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
                  child: addressWidget(
                      addressModel: widget.orderModel.addressModel),
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
                        "Rs. " + getOrderTotal().toString(),
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
      ),
    );
  }
}
