import 'package:bodmoo/models/orderItemModel.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  // List<OrderItemModel> items;

  List<OrderItemModel> cartItems = [];
  List<OrderItemModel> get getCartItems => cartItems;

  int get cartItemsLength => cartItems.length;
  void itemAdd(OrderItemModel itemOrderModel) async {
    cartItems.add(itemOrderModel);
    await savePrefsForCarts(orderItems: cartItems);
    notifyListeners();
  }

  void itemRemove({@required String Id}) async {
    int index = findItemById(partId: Id);
    if (index != -1) {
      cartItems.removeAt(index);
    }
    await savePrefsForCarts(orderItems: cartItems);

    notifyListeners();
  }

  int findItemById({@required String partId}) {
    int i = cartItems.indexWhere((element) {
      return element.id == partId;
    });

    return i;
  }

  int getQty({@required String partId}) {
    int index = findItemById(partId: partId);
    if (index != -1) {
      return cartItems[index].orderQty;
    }
    return 0;
  }

//  void updateQty({@required OrderItemModel item, @required int qty}) {
//    int index = findItem(item: item);
//    if (index != -1) {
//      if (cartItems[index].orderQty + qty > 0) {
//        cartItems[index].orderQty += qty;
//      } else
//        cartItems.removeAt(index);
//    }
//  }

  void updateQtyById({@required String partId, @required int qty}) async {
    int index = findItemById(partId: partId);
    if (index != -1) {
      if (cartItems[index].orderQty + qty > 0) {
        cartItems[index].orderQty += qty;
      } else
        cartItems.removeAt(index);
    }
    await savePrefsForCarts(orderItems: cartItems);
    notifyListeners();
  }

  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }

  double getTotalPriceOfCart() {
    double total = 0.0;
    if (cartItems.length > 0)
      for (int i = 0; i < cartItems.length; i++) {
        total += (double.parse(cartItems[i].partPrice) * cartItems[i].orderQty);
      }
    return total;
  }
}
