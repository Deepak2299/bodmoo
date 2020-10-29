import 'package:bodmoo/screenData.dart';
import 'package:flutter/foundation.dart';

class ScreenProvider extends ChangeNotifier {
//  ScreenProvider(value) : super(value);
  ScreenData screenData = new ScreenData();
  bool click = false;
  ScreenData get getScreenData => screenData;
//  String get catgName =>screenData.catgName;
  void add(String name, int i) {
    print(name);
//    remove();
//    notifyListeners();
//    if (click)
    switch (i) {
      case 0:
        screenData.catgName = name;
        screenData.subCatgName = null;
        screenData.brandName = null;
        break;
      case 1:
        screenData.subCatgName = name;
        screenData.brandName = null;
        break;
      case 2:
        screenData.brandName = name;
        break;
      case 3:
        screenData.vehicleName = name;
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
}
