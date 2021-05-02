//import 'package:payment_app/models/VarinatModel.dart';

import 'package:bodmoo/models/VarinatModel.dart';
import 'package:flutter/cupertino.dart';

class ScreenData {
  String catgName;
  String subCatgName;
  String brandName;
  String vehicleName;
  VariantsModel vm;

  ScreenData({
    @required this.catgName,
    @required this.subCatgName,
    @required this.brandName,
    @required this.vehicleName,
    @required this.vm,
  });
}

bool listView = true;

class ScreenErrorData {
  static String catgError;
  static String subCatgError;
  static String brandError;
  static String vehicleError;
  static String modelError;
  static String partsError;
}
