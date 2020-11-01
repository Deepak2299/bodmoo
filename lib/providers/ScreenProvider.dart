import 'package:bodmoo/models/itemOrderModel.dart';
import 'package:bodmoo/screenData.dart';
import 'package:flutter/foundation.dart';

class ScreenProvider extends ChangeNotifier {
//  ScreenProvider(value) : super(value);
  ScreenData screenData = new ScreenData();
  List<ItemOrderModel> items = [];

  bool click = false;
  int i = 0;

  // methods for ScreenData

  ScreenData get getScreenData => screenData;
  int get pos => i;
  void add(name, int im) {
    print(name);
//    remove();
//    notifyListeners();
//    if (click)
    switch (im) {
      case 0:
        screenData.catgName = name;
        screenData.subCatgName = null;
        screenData.brandName = null;
        screenData.vehicleName = null;
        screenData.vm = null;
        i = 1;
        break;
      case 1:
        screenData.subCatgName = name;
        screenData.brandName = null;
        screenData.vehicleName = null;
        screenData.vm = null;
        i = 2;
        break;
      case 2:
        screenData.brandName = name;
        screenData.vehicleName = null;
        screenData.vm = null;
        i = 3;
        break;
      case 3:
        screenData.vehicleName = name;
        screenData.vm = null;
        i = 4;
        break;
      case 4:
        screenData.vm = name;
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

  int get itemLength => items.length;

  List<ItemOrderModel> get getItems => items;

  void itemAdd(ItemOrderModel itemOrderModel) {
    items.add(itemOrderModel);
    print(items.length);
    notifyListeners();
  }

  void itemRemove(ItemOrderModel itemOrderModel) {
    items.remove(itemOrderModel);
    notifyListeners();
  }
}
