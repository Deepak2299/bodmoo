import 'package:bodmoo/models/partsModel.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/material.dart';

class PartDetailsScren extends StatefulWidget {
  PartsModel partModel;
  int pos;
  PartDetailsScren({@required this.partModel, @required this.pos});
  @override
  _PartDetailsScrenState createState() => _PartDetailsScrenState();
}

class _PartDetailsScrenState extends State<PartDetailsScren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        title: Text(widget.partModel.details[widget.pos].partName),
        actions: [
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
      body: ListView(
        shrinkWrap: true,
//        padding: EdgeInsets.symmetric(horizontal: 20),
        physics: ScrollPhysics(),
        children: [
          SizedBox(
            height: 20,
          ),
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20),
            physics: ScrollPhysics(),
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Hero(
                    tag: "images_${widget.pos}", child: Image.asset(IMAGE)),
              ),
//          SizedBox(
//            height: 15,
//          ),
              Text(
                widget.partModel.details[widget.pos].partName.toString(),
                style: TextStyle(fontSize: 25),
              ),

              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  height: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  color: widget.partModel.details[widget.pos].outOfStock
                      ? Colors.red.shade50
                      : Colors.green.shade50,
                  onPressed: () {},
                  child: Text(
                    widget.partModel.details[widget.pos].outOfStock
                        ? "OutOfStock"
                        : "Instock",
//                textAlign: TextAlign.,
                    style: TextStyle(
                      color: widget.partModel.details[widget.pos].outOfStock
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
                    widget.partModel.details[widget.pos].itemPrice.toString(),
                style: TextStyle(fontSize: 30),
              ),
//          SizedBox(
//            height: 10,
//          ),
//              Text(
//                "Quantity " +
//                    widget.partModel.details[widget.pos].quantity.toString(),
////                                    style: textStyle,
//              ),
            ],
          ),
          Divider(
            thickness: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(widget.partModel.details[widget.pos].description),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 15,
        child: Container(
          height: 50,
//          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Container(
//                height: 50,

                width: MediaQuery.of(context).size.width * 0.5,
                child: Center(
                  child: Text(
                    "ADD TO CART",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                color: Colors.red,
                child: Center(
                  child: Text(
                    "BUY NOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
