import 'package:bodmoo/cartItemsScreen.dart';
import 'package:bodmoo/methods/prepareOrder.dart';
import 'package:bodmoo/models/orderItemModel.dart';
import 'package:bodmoo/models/partsModel.dart';
import 'package:bodmoo/providers/ScreenProvider.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:bodmoo/widgets/cartIcon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PartDetailsScren extends StatefulWidget {
  PartsModel partModel;
  int partIndex;
  PartDetailsScren({@required this.partModel, @required this.partIndex});
  @override
  _PartDetailsScrenState createState() => _PartDetailsScrenState();
}

class _PartDetailsScrenState extends State<PartDetailsScren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 18),
            child: CartIcon(),
          )
        ],
      ),
      body: ListView(
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
                    tag: "images_${widget.partIndex}",
                    child: Image.asset(IMAGE)),
              ),
              Text(
                widget.partModel.details[widget.partIndex].partName.toString(),
                style: TextStyle(fontSize: 25),
              ),

              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  // height: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  color: widget.partModel.details[widget.partIndex].outOfStock
                      ? Colors.red.shade50
                      : Colors.green.shade50,
                  onPressed: () {},
                  child: Text(
                    widget.partModel.details[widget.partIndex].outOfStock
                        ? "OutOfStock"
                        : "Instock",
//                textAlign: TextAlign.,
                    style: TextStyle(
                      color:
                          widget.partModel.details[widget.partIndex].outOfStock
                              ? Colors.red
                              : Colors.green,
                    ),
                  ),
                ),
              ),
//          SizedBox(
//            height: 10,
//          ),
              Text(
                "Rs " +
                    widget.partModel.details[widget.partIndex].itemPrice
                        .toString(),
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
          Divider(
            thickness: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(widget.partModel.details[widget.partIndex].description),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 15,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.07,
          child: Row(
            children: <Widget>[
              Provider.of<ScreenProvider>(context).getQty(
                        partId: widget.partModel.details[widget.partIndex].id,
                      ) ==
                      0
                  ? Expanded(
                      child: RaisedButton(
                        color: Colors.white,
                        onPressed: () {
                          OrderItemModel item = new OrderItemModel(
                              partId:
                                  widget.partModel.details[widget.partIndex].id,
                              brandName: widget.partModel.carBrand,
                              vehicleName: widget.partModel.carName,
                              vehicleModel: widget.partModel.carModel,
                              vehicleYear:
                                  widget.partModel.modelYear.toString(),
                              partName: widget
                                  .partModel.details[widget.partIndex].partName,
                              partPrice: widget
                                  .partModel.details[widget.partIndex].itemPrice
                                  .toString(),
                              orderQty: 1);
                          Provider.of<ScreenProvider>(context, listen: false)
                              .itemAdd(item);
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => CartItemsScreen()));
                        },
                        child: Center(
                          child: Text(
                            "ADD TO CART",
                            style: TextStyle(
                              // color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: RaisedButton(
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => CartItemsScreen()));
                        },
                        child: Center(
                          child: Text(
                            "GO TO CART",
                            style: TextStyle(
                              // color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
//              Expanded(
//                      child: Padding(
//                        padding: const EdgeInsets.symmetric(horizontal: 20),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: [
//                            IconButton(
//                                icon: Icon(Icons.remove),
//                                onPressed: () {
//                                  Provider.of<ScreenProvider>(context,
//                                          listen: false)
//                                      .updateQtyById(
//                                          Id: widget.partModel
//                                              .details[widget.partIndex].id,
//                                          qty: -1);
////                                  setState(() {});
//                                }),
//                            Text(Provider.of<ScreenProvider>(context)
//                                .getQty(
//                                  Id: widget
//                                      .partModel.details[widget.partIndex].id,
//                                )
//                                .toString()),
//                            IconButton(
//                                icon: Icon(Icons.add),
//                                onPressed: () {
//                                  Provider.of<ScreenProvider>(context,
//                                          listen: false)
//                                      .updateQtyById(
//                                          Id: widget.partModel
//                                              .details[widget.partIndex].id,
//                                          qty: 1);
////                                  setState(() {});
//                                }),
//                          ],
//                        ),
//                      ),
//                    ),
              Expanded(
                child: RaisedButton(
                  onPressed: () async {
                    List<OrderItemModel> item = List<OrderItemModel>();
                    item.add(new OrderItemModel(
                        partId: widget.partModel.details[widget.partIndex].id,
                        brandName: widget.partModel.carBrand,
                        vehicleName: widget.partModel.carName,
                        vehicleModel: widget.partModel.carModel,
                        vehicleYear: widget.partModel.modelYear.toString(),
                        partName:
                            widget.partModel.details[widget.partIndex].partName,
                        partPrice: widget
                            .partModel.details[widget.partIndex].itemPrice
                            .toString(),
                        orderQty: 1));
                    bool b = await prepareOrder(items: item);
                    if (b) {
                      //TODO:SHOW ORDER PLACED SUCCEFULLY
                    } else {
                      //TODO: ERROR WHILE PLACING ORDER
                    }
                  },
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      "BUY NOW",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
