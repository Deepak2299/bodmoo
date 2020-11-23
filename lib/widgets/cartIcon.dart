import 'package:bodmoo/Screens/realMeat/cartItemsScreen.dart';
import 'package:bodmoo/providers/ScreenProvider.dart';
import 'package:bodmoo/providers/cartProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

class CartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => CartItemsScreen()));
      },
      child: Badge(
        animationType: BadgeAnimationType.fade,
        badgeContent: Text(
          Provider.of<CartProvider>(context).cartItemsLength.toString(),
        ),
        child: Icon(
          Icons.shopping_cart,
        ),
      ),
    );
  }
}

class AddToCart extends StatelessWidget {
  double size;
  Color iconColor;
  AddToCart({@required this.size = 0, @required this.iconColor = Colors.white});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => CartItemsScreen()));
      },
      child: Stack(
        children: [
          Positioned(
            right: 15 - size / 1.5,
//          top: -size,
//          bottom: size * 3,
            height: size == 0 ? 20 : size * 3,
            child: CircleAvatar(
              radius: 9 + size / 2,
              backgroundColor: Colors.green,
              child: Text(
                Provider.of<CartProvider>(context).cartItemsLength.toString(),
                style: TextStyle(fontSize: 13, color: Colors.black),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: size,
              ),
              IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: iconColor,
                    size: 25 + size,
                  ),
                  onPressed: null),
            ],
          ),
        ],
      ),
    );
  }
}
