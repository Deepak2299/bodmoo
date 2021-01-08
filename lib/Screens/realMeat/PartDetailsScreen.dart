import 'package:bodmoo/Screens/Payment/confirmPayment.dart';
import 'package:bodmoo/Screens/login/phoneVerification.dart';
import 'package:bodmoo/Screens/realMeat/chooseAddressScreen.dart';
import 'package:bodmoo/Screens/realMeat/cartItemsScreen.dart';
import 'package:bodmoo/models/orderItemModel.dart';
import 'package:bodmoo/models/partsModel.dart';
import 'package:bodmoo/providers/ScreenProvider.dart';
import 'package:bodmoo/providers/cartProvider.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
//import 'package:bodmoo/utils/urls.dart';
import 'package:bodmoo/utils/utils.dart';
import 'package:bodmoo/widgets/cartIcon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PartDetailsScren extends StatefulWidget {
  PartsModel partModel;
  int subPartIndex;
  // int PartIndex;
  bool recent;
  PartDetailsScren(
      {@required this.partModel,
      @required this.subPartIndex,
      // this.PartIndex,
      this.recent});
  @override
  _PartDetailsScrenState createState() => _PartDetailsScrenState();
}

class _PartDetailsScrenState extends State<PartDetailsScren> {
  PageController pageController = PageController();
//  bool updateLoad = false;
  int page = 0;
  @override
  void initState() {
    print("details hero tag:");
    print(widget.recent
        ? widget.partModel.details[widget.subPartIndex].id + 'R'
        : widget.partModel.details[widget.subPartIndex].id + 'A');
    // TODO: implement initState
    super.initState();
    Provider.of<CustomerDetailsProvider>(context, listen: false).addRecentParts(PartsModel(
        id: widget.partModel.id,
        carBrand: widget.partModel.carBrand,
        carName: widget.partModel.carName,
        carModel: widget.partModel.carModel,
        modelYear: widget.partModel.modelYear,
        category: widget.partModel.category,
        subCategory: widget.partModel.subCategory,
        details: [widget.partModel.details[widget.subPartIndex]]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          CartIcon(context: context),
          SizedBox(
            width: 10,
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
                child: widget.partModel.details[widget.subPartIndex].productImages.isEmpty
                    ? Hero(
                        tag:
                            // "images_${widget.PartIndex}_${widget.subPartIndex - widget.recent}"
                            widget.recent
                                ? widget.partModel.details[widget.subPartIndex].id + 'R'
                                : widget.partModel.details[widget.subPartIndex].id + 'A',
                        child: Image.asset(
                          IMAGE,
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                      )
                    : Column(
                        children: [
//                          Align(
//                            alignment: Alignment.centerRight,
//                            child: RaisedButton(
//                              child: Row(
//                                children: [
//                                  Text("Next"),
//                                  Icon(Icons.arrow_forward_outlined),
//                                ],
//                                mainAxisSize: MainAxisSize.min,
//                              ),
//                              onPressed: () {
//                                pageController.animateToPage(
//                                  (page + 1) %
//                                      widget.partModel.details[widget.partIndex]
//                                          .productImages.length,
//                                  duration: Duration(milliseconds: 500),
//                                  curve: Curves.ease,
//                                );
//                              },
//                            ),
//                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: PageView(
                              physics: ScrollPhysics(),
                              controller: pageController,
                              onPageChanged: (p) {
                                page = p;
                                setState(() {});
                              },
                              children: [
                                for (int i = 0;
                                    i < widget.partModel.details[widget.subPartIndex].productImages.length;
                                    i++)
                                  i == 0
                                      ? Stack(
                                          children: [
                                            Center(
                                              child: Hero(
                                                  tag: widget.recent
                                                      ? widget.partModel.details[widget.subPartIndex].id + 'R'
                                                      : widget.partModel.details[widget.subPartIndex].id + 'A'
                                                  // "images_${widget.PartIndex}_${widget.subPartIndex - widget.recent}",
                                                  ,
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        widget.partModel.details[widget.subPartIndex].productImages[0],
                                                    // 'https://picsum.photos/250?image=9',
                                                    // placeholder: (context, url) =>
                                                    //     Container(child: CircularProgressIndicator()),
                                                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                        CircularProgressIndicator(value: downloadProgress.progress),
                                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                                  )),
                                            ),
                                          ],
                                        )
                                      : Center(
                                          child: CachedNetworkImage(
                                            imageUrl: widget.partModel.details[widget.subPartIndex].productImages[i],
                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                CircularProgressIndicator(value: downloadProgress.progress),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                        ),
                              ],
                            ),
                          ),
                          widget.partModel.details[widget.subPartIndex].productImages.length > 1
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (int i = 0;
                                        i < widget.partModel.details[widget.subPartIndex].productImages.length;
                                        i++)
                                      indicator(i == page ? true : false),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
              ),
              Text(
                widget.partModel.details[widget.subPartIndex].partName.toString(),
                style: TextStyle(fontSize: 25),
              ),

              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  // height: 20,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  color: widget.partModel.details[widget.subPartIndex].outOfStock
                      ? Colors.red.shade50
                      : Colors.green.shade50,
                  onPressed: () {},
                  child: Text(
                    widget.partModel.details[widget.subPartIndex].outOfStock ? "OutOfStock" : "Instock",
//                textAlign: TextAlign.,
                    style: TextStyle(
                      color: widget.partModel.details[widget.subPartIndex].outOfStock ? Colors.red : Colors.green,
                    ),
                  ),
                ),
              ),
//          SizedBox(
//            height: 10,
//          ),
              Text(
                "Rs " + widget.partModel.details[widget.subPartIndex].itemPrice.toString(),
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
          Divider(
            thickness: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(widget.partModel.details[widget.subPartIndex].description),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 15,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.06,
          child: Row(
            children: <Widget>[
              Provider.of<CartProvider>(context).getQty(
                        partId: widget.partModel.details[widget.subPartIndex].id,
                      ) ==
                      0
                  ? Expanded(
                      child: RaisedButton(
                        color: Colors.white,
                        onPressed: widget.partModel.details[widget.subPartIndex].outOfStock
                            ? null
                            : () {
                                OrderItemModel item = new OrderItemModel(
                                    partId: widget.partModel.details[widget.subPartIndex].id,
                                    brandName: widget.partModel.carBrand,
                                    vehicleName: widget.partModel.carName,
                                    vehicleModel: widget.partModel.carModel,
                                    vehicleYear: widget.partModel.modelYear.toString(),
                                    partName: widget.partModel.details[widget.subPartIndex].partName,
                                    partPrice: widget.partModel.details[widget.subPartIndex].itemPrice.toString(),
                                    orderQty: 1,
                                    productImages: widget.partModel.details[widget.subPartIndex].productImages);
                                Provider.of<CartProvider>(context, listen: false).itemAdd(item);
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => CartItemsScreen()));
                              },
                        child: Center(
                          child: Text(
                            "ADD TO CART",
                            style: TextStyle(
                              color: Colors.black,
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
                        onPressed: widget.partModel.details[widget.subPartIndex].outOfStock
                            ? null
                            : () {
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => CartItemsScreen()));
                              },
                        child: Center(
                          child: Text(
                            "GO TO CART",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
              Expanded(
                child: RaisedButton(
                  onPressed: widget.partModel.details[widget.subPartIndex].outOfStock
                      ? null
                      : () async {
                          List<OrderItemModel> item = List<OrderItemModel>();
                          item.add(new OrderItemModel(
                              partId: widget.partModel.details[widget.subPartIndex].id,
                              brandName: widget.partModel.carBrand,
                              vehicleName: widget.partModel.carName,
                              vehicleModel: widget.partModel.carModel,
                              vehicleYear: widget.partModel.modelYear.toString(),
                              partName: widget.partModel.details[widget.subPartIndex].partName,
                              partPrice: widget.partModel.details[widget.subPartIndex].itemPrice.toString(),
                              orderQty: 1,
                              productImages: widget.partModel.details[widget.subPartIndex].productImages));

                          if (Provider.of<CustomerDetailsProvider>(context, listen: false).token != null) {
                            Provider.of<CustomerDetailsProvider>(context, listen: false)
                                .addOrderItems(orderItemsList: item);
                            print("sndns" +
                                Provider.of<CustomerDetailsProvider>(context, listen: false)
                                    .orderItems
                                    .length
                                    .toString());

                            //TODO:SHOW ORDER PLACED SUCCEFULLY
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => ChooseAddressScreen(
                                          cartOrder: false,
                                          amount: double.parse(
                                              widget.partModel.details[widget.subPartIndex].itemPrice.toString()),
                                        )));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) => SignInWithPhoneNO(
                                          stored: true,
                                        )));
                          }
                        },
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      "BUY NOW",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
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
