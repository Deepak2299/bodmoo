import 'package:bodmoo/methods/get/getPartById.dart';
import 'package:bodmoo/models/orderItemModel.dart';
import 'package:bodmoo/utils/urls.dart';
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
    print(widget.orderItem.partId + " " + widget.orderItem.brandName);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: getPartById(
              brandName: widget.orderItem.brandName,
              partId: widget.orderItem.partId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  SizedBox(height: 20),
                  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    physics: ScrollPhysics(),
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Hero(
                            tag: "images_${widget.orderItem.partId}",
                            child: Image.asset(IMAGE)),
                      ),
                      Text(
                        widget.orderItem.partName.toString(),
                        style: TextStyle(fontSize: 25),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          // height: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          color: snapshot.data.details[0].outOfStock
                              ? Colors.red.shade50
                              : Colors.green.shade50,
                          onPressed: () {},
                          child: Text(
                            snapshot.data.details[0].outOfStock
                                ? "OutOfStock"
                                : "Instock",
//                textAlign: TextAlign.,
                            style: TextStyle(
                              color: snapshot.data.details[0].outOfStock
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Rs " + widget.orderItem.partPrice.toString(),
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(snapshot.data.details[0].description),
                  ),
                ],
              );
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
