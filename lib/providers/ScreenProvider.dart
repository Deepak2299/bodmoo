import 'package:bodmoo/models/itemOrderModel.dart';
import 'package:bodmoo/screenData.dart';
import 'package:flutter/foundation.dart';

class ScreenProvider extends ChangeNotifier {
//  ScreenProvider(value) : super(value);
  ScreenData screenData = new ScreenData();

  bool click = false;
  int i = 0;

  // methods for ScreenData
  ScreenData get getScreenData => screenData;
  int get pos => i;
  void updateData({@required dataValue, @required int dataIndex}) {
    switch (dataIndex) {
      case 0:
        screenData.catgName = dataValue;
        screenData.subCatgName = null;
        screenData.brandName = null;
        screenData.vehicleName = null;
        screenData.vm = null;
        i = 1;
        break;
      case 1:
        screenData.subCatgName = dataValue;
        screenData.brandName = null;
        screenData.vehicleName = null;
        screenData.vm = null;
        i = 2;
        break;
      case 2:
        screenData.brandName = dataValue;
        screenData.vehicleName = null;
        screenData.vm = null;
        i = 3;
        break;
      case 3:
        screenData.vehicleName = dataValue;
        screenData.vm = null;
        i = 4;
        break;
      case 4:
        screenData.vm = dataValue;
        i = -1;
        break;
      default:
        break;
    }
    click = true;
    notifyListeners();
  }

  void remove() {
    if (click) screenData = new ScreenData();
    notifyListeners();
  }

  // methods for ItemOrderModel

  List<OrderItemModel> cartItems = [];
  List<OrderItemModel> get getCartItems => cartItems;

  int get cartItemsLength => cartItems.length;
  void itemAdd(OrderItemModel itemOrderModel) {
    cartItems.add(itemOrderModel);
    print(cartItems.length);
    notifyListeners();
  }

  void itemRemove(OrderItemModel itemOrderModel) {
    cartItems.remove(itemOrderModel);
    notifyListeners();
  }

  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }
}
