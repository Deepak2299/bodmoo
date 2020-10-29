import 'package:bodmoo/get/getBrands.dart';
import 'package:bodmoo/get/getCategories.dart';
import 'package:bodmoo/get/getSubCat.dart';
import 'package:bodmoo/get/getVehiclesbyBrand.dart';
import 'package:bodmoo/providers/ScreenProvider.dart';
import 'package:bodmoo/screenData.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:bodmoo/widgets/items_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool collapse = true;
  @override
  Widget build(BuildContext context) {
    print(context.watch<ScreenProvider>().getScreenData.catgName);
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
          context.watch<ScreenProvider>().getScreenData.catgName != null
              ? ItemView(
                  title: "Sub Categories",
                  futureFunction: getSubCategories(
                      catgName: context
                          .watch<ScreenProvider>()
                          .getScreenData
                          .catgName),
                  i: 1,
                )
              : Container(),
          SizedBox(
            height: 20,
          ),
          context.watch<ScreenProvider>().getScreenData.subCatgName != null
              ? ItemView(
                  title: "Brands",
                  futureFunction: getBrands(),
                  i: 2,
                )
              : Container(),
          SizedBox(
            height: 20,
          ),
          context.watch<ScreenProvider>().getScreenData.brandName != null
              ? ItemView(
                  title: "Vehicles",
                  futureFunction: getVehiclesByBrand(
                      brandName: context
                          .watch<ScreenProvider>()
                          .getScreenData
                          .brandName),
                  i: 3,
                )
              : Container(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
