import 'package:bodmoo/Screens/realMeat/screenData.dart';
import 'package:flutter/foundation.dart';

class ScreenProvider extends ChangeNotifier {
//  ScreenProvider(value) : super(value);
  bool orderLoader = false;

  setOrderLoader(bool result) {
    orderLoader = result;
    notifyListeners();
  }

  ScreenData screenData =
      new ScreenData(catgName: null, subCatgName: null, brandName: null, vehicleName: null, vm: null);

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
        print("New value" + screenData.catgName);
        // screenData.brandName = null;
        // screenData.vehicleName = null;
        // screenData.vm = VariantsModel(modelName: '', manufactureYear: '');
        i = 1;
        break;
      case 1:
        screenData.subCatgName = dataValue;
        // screenData.brandName = null;
        // screenData.vehicleName = null;
        // screenData.vm = VariantsModel(modelName: '', manufactureYear: '');
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

//  List<OrderItemModel> cartItems = [];
//  List<OrderItemModel> get getCartItems => cartItems;
//
//  int get cartItemsLength => cartItems.length;
//  void itemAdd(OrderItemModel itemOrderModel) async {
//    cartItems.add(itemOrderModel);
//    await savePrefsForCarts(orderItems: cartItems);
//    notifyListeners();
//  }
//
//  void itemRemove({@required String Id}) async {
//    int index = findItemById(partId: Id);
//    if (index != -1) {
//      cartItems.removeAt(index);
//    }
//    await savePrefsForCarts(orderItems: cartItems);
//
//    notifyListeners();
//  }

//  int findItem({@required OrderItemModel item}) {
//    int i = cartItems.indexWhere((element) {
//      return element.partId == item.partId;
//    });
//
//    return i;
//  }

//  int findItemById({@required String partId}) {
//    int i = cartItems.indexWhere((element) {
//      return element.partId == partId;
//    });
//
//    return i;
//  }

//  int getQty({@required String partId}) {
//    int index = findItemById(partId: partId);
//    if (index != -1) {
//      return cartItems[index].orderQty;
//    }
//    return 0;
//  }
//
////  void updateQty({@required OrderItemModel item, @required int qty}) {
////    int index = findItem(item: item);
////    if (index != -1) {
////      if (cartItems[index].orderQty + qty > 0) {
////        cartItems[index].orderQty += qty;
////      } else
////        cartItems.removeAt(index);
////    }
////  }
//
//  void updateQtyById({@required String partId, @required int qty}) async {
//    int index = findItemById(partId: partId);
//    if (index != -1) {
//      if (cartItems[index].orderQty + qty > 0) {
//        cartItems[index].orderQty += qty;
//      } else
//        cartItems.removeAt(index);
//    }
//    await savePrefsForCarts(orderItems: cartItems);
//    notifyListeners();
//  }
//
//  void clearCart() {
//    cartItems.clear();
//    notifyListeners();
//  }
//
//  double getTotalPriceOfCart() {
//    double total = 0.0;
//    if (cartItems.length > 0)
//      for (int i = 0; i < cartItems.length; i++) {
//        total += (double.parse(cartItems[i].partPrice) * cartItems[i].orderQty);
//      }
//    return total;
//  }
}
