import 'package:bodmoo/screenData.dart';
import 'package:flutter/foundation.dart';

class ScreenProvider extends ChangeNotifier {
//  ScreenProvider(value) : super(value);
  ScreenData screenData = new ScreenData();
  bool click = false;
  int i = 0;
  ScreenData get getScreenData => screenData;
  int get pos => i;
  void add(String name, int im) {
    print(name);
//    remove();
//    notifyListeners();
//    if (click)
    switch (im) {
      case 0:
        screenData.catgName = name;
        screenData.subCatgName = null;
        screenData.brandName = null;
        i = 1;
        break;
      case 1:
        screenData.subCatgName = name;
        screenData.brandName = null;
        i = 2;
        break;
      case 2:
        screenData.brandName = name;
        i = 3;
        break;
      case 3:
        screenData.vehicleName = name;
        i == -1;
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
