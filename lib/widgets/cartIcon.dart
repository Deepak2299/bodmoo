import 'package:bodmoo/Screens/realMeat/cartItemsScreen.dart';
import 'package:bodmoo/providers/ScreenProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

class CartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => CartItemsScreen()));
      },
      child: Badge(
        animationType: BadgeAnimationType.fade,
        badgeContent: Text(
          Provider.of<ScreenProvider>(context).cartItemsLength.toString(),
        ),
        child: Icon(
          Icons.shopping_cart,
        ),
      ),
    );
  }
}
