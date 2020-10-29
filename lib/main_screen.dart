import 'package:bodmoo/get/getBrands.dart';
import 'package:bodmoo/get/getCategories.dart';
import 'package:bodmoo/get/getSubCat.dart';
import 'package:bodmoo/get/getVehiclesbyBrand.dart';
import 'package:bodmoo/screenData.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:bodmoo/widgets/items_view.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool collapse = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
//        physics: ScrollPhysics(),
        children: [
          SizedBox(
            height: 20,
          ),
          ItemView(
            title: "Categories",
            futureFunction: getCategories(),
            i: 0,
          ),
          SizedBox(
            height: 20,
          ),
//          ScreenData.catgName != null
//              ?
//          ItemView(
//            title: "Sub Categories",
//            futureFunction: getSubCategories(catgName: "oil"),
//            i: 1,
//          )
//              : null,
//          SizedBox(
//            height: 20,
//          ),
//          ScreenData.subCatgName!=null ? ItemView(title: "Brands", futureFunction: getBrands(),i: 2,):null,
//          SizedBox(
//            height: 20,
//          ),
//          ScreenData.brandName!=null? ItemView(title: "Vehicles", futureFunction: getVehiclesByBrand(brandName: ScreenData.brandName),i: 3,):null,
//          SizedBox(
//            height: 20,
//          ),
        ],
      ),
    );
  }
}
