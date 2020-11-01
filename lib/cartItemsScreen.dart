import 'package:bodmoo/models/itemOrderModel.dart';
import 'package:bodmoo/providers/ScreenProvider.dart';
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
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            Provider.of<ScreenProvider>(context, listen: false)
                                .itemRemove(Id: itemModel.partId);
                          },
                        ),
                        Image.asset(IMAGE),
                      ],
                    ),
                    title: Text(itemModel.partName),
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                      ],
                    ),
                    trailing: Text(itemModel.totalPrice),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: Provider.of<ScreenProvider>(context).cartItemsLength,
              ),
      ),
    );
  }
}
