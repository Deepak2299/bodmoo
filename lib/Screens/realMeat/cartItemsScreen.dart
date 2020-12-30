import 'package:bodmoo/Screens/Payment/confirmPayment.dart';
import 'package:bodmoo/Screens/login/phoneVerification.dart';
import 'package:bodmoo/Screens/realMeat/chooseAddressScreen.dart';
import 'package:bodmoo/models/orderItemModel.dart';
import 'package:bodmoo/providers/ScreenProvider.dart';
import 'package:bodmoo/providers/cartProvider.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    padding: EdgeInsets.all(8),
    child: Text(str, style: TextStyle(color: Colors.white, fontSize: 12)),
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
                Provider.of<CartProvider>(context, listen: false).clearCart();
              },
            )
          ],
        ),
        body: Provider.of<CartProvider>(context).cartItemsLength == 0
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
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    OrderItemModel itemModel =
                        Provider.of<CartProvider>(context).getCartItems[index];
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      key: UniqueKey(),
                      background: Container(
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        padding: EdgeInsets.all(10),
                        child: Text("Swipe left to Remove Item",
                            style: TextStyle(color: Colors.white)),
                      ),
                      onDismissed: (direction) {
                        Provider.of<CartProvider>(context, listen: false)
                            .itemRemove(Id: itemModel.partId);
                      },
                      child: Card(
                        child: ListTile(
                          leading: Container(
                              width: 50,

//                              height: 200,
                              child: itemModel.productImages.isEmpty
                                  ? Image.asset(IMAGE)
                                  : CachedNetworkImage(
                                      imageUrl: itemModel.productImages[0],
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    )),
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
                              SizedBox(height: 10),
                              Flexible(
                                child: Row(
//                            mainAxisAlignment: MainAxisAlignment.sp,
                                  children: <Widget>[
                                    Text("Item Price: Rs. " +
                                        itemModel.partPrice),
//                                Spacer(),
//                                Text("Total Price: Rs. " +
//                                    (double.parse(itemModel.partPrice) *
//                                            itemModel.orderQty)
//                                        .toString()),
                                  ],
                                ),
                              ),
                              Flexible(
                                  child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Total Price: Rs. " +
                                          (double.parse(itemModel.partPrice) *
                                                  itemModel.orderQty)
                                              .toString(),
                                    ),
                                  ),
//                                  Spacer(),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
//                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                                Icons.remove_circle_outline),
                                            onPressed: () {
                                              Provider.of<CartProvider>(context,
                                                      listen: false)
                                                  .updateQtyById(
                                                      partId: itemModel.partId,
                                                      qty: -1);
//                                  setState(() {});
                                            }),
                                        Text(itemModel.orderQty.toString()),
                                        IconButton(
                                            icon:
                                                Icon(Icons.add_circle_outline),
                                            onPressed: () {
                                              Provider.of<CartProvider>(context,
                                                      listen: false)
                                                  .updateQtyById(
                                                      partId: itemModel.partId,
                                                      qty: 1);
//                                  setState(() {});
                                            }),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                              Flexible(
                                child: Row(
                                  children: [
                                    Spacer(),
                                    FlatButton(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(width: 0.5)),
                                      onPressed: () {
                                        Provider.of<CartProvider>(context,
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
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: Provider.of<CartProvider>(context).cartItemsLength,
                ),
              ),
        bottomNavigationBar: BottomAppBar(
          elevation: 18,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.06,
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
                              Provider.of<CartProvider>(context)
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
                    onPressed: Provider.of<CartProvider>(context, listen: false)
                                .getTotalPriceOfCart() ==
                            0
                        ? null
                        : () async {
                            if (Provider.of<CustomerDetailsProvider>(context,
                                        listen: false)
                                    .token !=
                                null) {
                              Provider.of<CustomerDetailsProvider>(context,
                                      listen: false)
                                  .addOrderItems(
                                      orderItemsList: Provider.of<CartProvider>(
                                              context,
                                              listen: false)
                                          .cartItems);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChooseAddressScreen(
                                          cartOrder: true,
                                          amount:
                                              Provider.of<CartProvider>(context)
                                                  .getTotalPriceOfCart(),
                                        )),
                              );
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

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   savePrefsForCarts(context: context);
  // }
}
