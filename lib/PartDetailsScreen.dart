import 'package:bodmoo/models/partsModel.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(),
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
                child: Hero(tag: "images_${widget.partIndex}", child: Image.asset(IMAGE)),
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  color:
                      widget.partModel.details[widget.partIndex].outOfStock ? Colors.red.shade50 : Colors.green.shade50,
                  onPressed: () {},
                  child: Text(
                    widget.partModel.details[widget.partIndex].outOfStock ? "OutOfStock" : "Instock",
//                textAlign: TextAlign.,
                    style: TextStyle(
                      color: widget.partModel.details[widget.partIndex].outOfStock ? Colors.red : Colors.green,
                    ),
                  ),
                ),
              ),
//          SizedBox(
//            height: 10,
//          ),
              Text(
                "Rs " + widget.partModel.details[widget.partIndex].itemPrice.toString(),
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
              Expanded(
                child: RaisedButton(
                  color: Colors.white,
                  onPressed: () {},
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
              ),
              Expanded(
                child: RaisedButton(
                  onPressed: () {},
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
