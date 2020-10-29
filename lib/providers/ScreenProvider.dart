import 'package:bodmoo/screenData.dart';
import 'package:flutter/foundation.dart';

class ScreenProvider with ChangeNotifier {
  ScreenData screenData = new ScreenData();
  ScreenData get getScreenData => screenData;
//  String get catgName =>screenData.catgName;
  void add(String name, int i) {
    print(name);
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
    notifyListeners();
  }
}
