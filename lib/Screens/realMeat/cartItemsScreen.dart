import 'package:bodmoo/Screens/login/phoneVerification.dart';
import 'package:bodmoo/Screens/realMeat/addressScreen.dart';
import 'package:bodmoo/methods/prepareOrder.dart';
import 'package:bodmoo/models/orderItemModel.dart';
import 'package:bodmoo/providers/ScreenProvider.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemsScreen extends StatefulWidget {
  @override
  _CartItemsScreenState createState() => _CartItemsScreenState();
}

tagStyle({@required String str}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(9),
      color: Colors.blue,
    ),
    margin: EdgeInsets.symmetric(horizontal: 5),
    padding: EdgeInsets.all(5),
    child: Text(str, style: TextStyle(color: Colors.white)),
  );
}

class _CartItemsScreenState extends State<CartItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<ScreenProvider>(context, listen: false).clearCart();
              },
            )
          ],
        ),
        body: Provider.of<ScreenProvider>(context).cartItemsLength == 0
            ? Center(
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "No Parts Added",
                    style: TextStyle(color: Colors.grey),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    child: Text("Continue Shopping",
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      //TODO:ROUTE TO MAINSCREEN.DART
                      Navigator.pop(context);
                    },
                  )
                ],
              ))
            : ListView.separated(
                itemBuilder: (context, index) {
                  OrderItemModel itemModel =
                      Provider.of<ScreenProvider>(context).getCartItems[index];
                  return ListTile(
                    leading: Container(
//                      width: 100,
//                      height: 200,
                      child: Image.asset(
                        IMAGE,
//                        fit: BoxFit.fill,
                      ),
                    ),
                    title: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(itemModel.partName),
                        Flexible(
                          child: Row(
                            children: <Widget>[
                              tagStyle(str: itemModel.brandName),
                              tagStyle(str: itemModel.vehicleName),
                              tagStyle(
                                  str: itemModel.vehicleModel +
                                      " " +
                                      itemModel.vehicleYear),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.sp,
                            children: <Widget>[
                              Text("Rs. " + itemModel.partPrice),
                              Spacer(),
                              Text("Rs. " +
                                  (double.parse(itemModel.partPrice) *
                                          itemModel.orderQty)
                                      .toString()),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Free shipping",
                                style: TextStyle(color: Colors.green),
                              ),
                              Spacer(),
                              Row(
//                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.remove_circle_outline),
                                      onPressed: () {
                                        Provider.of<ScreenProvider>(context,
                                                listen: false)
                                            .updateQtyById(
                                                partId: itemModel.partId,
                                                qty: -1);
//                                  setState(() {});
                                      }),
                                  Text(itemModel.orderQty.toString()),
                                  IconButton(
                                      icon: Icon(Icons.add_circle_outline),
                                      onPressed: () {
                                        Provider.of<ScreenProvider>(context,
                                                listen: false)
                                            .updateQtyById(
                                                partId: itemModel.partId,
                                                qty: 1);
//                                  setState(() {});
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Row(
                            children: [
                              Spacer(),
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 0.5)),
                                onPressed: () {
                                  Provider.of<ScreenProvider>(context,
                                          listen: false)
                                      .itemRemove(Id: itemModel.partId);
                                },
                                child: Text("Remove"),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: Provider.of<ScreenProvider>(context).cartItemsLength,
              ),
        bottomNavigationBar: BottomAppBar(
          elevation: 18,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.07,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Rs " +
                              Provider.of<ScreenProvider>(context)
                                  .getTotalPriceOfCart()
                                  .toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Total Cart",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    color: Colors.green,
                    child: Center(
                        child: Text('Confirm Order',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                    onPressed: Provider.of<ScreenProvider>(context,
                                    listen: false)
                                .getTotalPriceOfCart() ==
                            0
                        ? null
                        : () async {
                            if (Provider.of<CustomerDetailsProvider>(context,
                                        listen: false)
                                    .getCustomerPhone !=
                                null) {

                              Provider.of<CustomerDetailsProvider>(context,
                                  listen: false)
                                  .addOrder(orderItemModel: Provider.of<ScreenProvider>(context,
                                  listen: false)
                                  .cartItems);
                                //TODO:SHOW ORDER PLACED SUCCEFULLY
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddressScreen()));

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
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
