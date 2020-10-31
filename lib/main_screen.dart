import 'package:bodmoo/PartScreen.dart';
import 'package:bodmoo/get/getBrands.dart';
import 'package:bodmoo/get/getCategories.dart';
import 'package:bodmoo/get/getSubCat.dart';
import 'package:bodmoo/get/getVariants.dart';
import 'package:bodmoo/get/getVehiclesbyBrand.dart';
import 'package:bodmoo/providers/ScreenProvider.dart';

import 'package:bodmoo/widgets/items_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

textWidget(String str) {
  if (str != null)
    return str + '->';
  else
    return '';
}

class _MainScreenState extends State<MainScreen> {
  bool collapse = true;
  @override
  Widget build(BuildContext context) {
    print(context.watch<ScreenProvider>().getScreenData.catgName);
    return Scaffold(
      body: Consumer<ScreenProvider>(builder: (context, screenProvider, _) {
        return ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [
            SizedBox(
              height: 20,
            ),
            ItemView(
              context: context,
              title: "Categories",
              futureFunction: getCategories(),
              i: 0,
            ),
            SizedBox(
              height: 20,
            ),
            screenProvider.getScreenData.catgName != null
                ? ItemView(
                    context: context,
                    title: "Sub Categories",
                    futureFunction: getSubCategories(
                        catgName: Provider.of<ScreenProvider>(context)
                            .getScreenData
                            .catgName),
                    i: 1,
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
            screenProvider.getScreenData.subCatgName != null
                ? ItemView(
                    context: context,
                    title: "Brands",
                    futureFunction: getBrands(),
                    i: 2,
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
            screenProvider.getScreenData.brandName != null
                ? ItemView(
                    context: context,
                    title: "Vehicles",
                    futureFunction: getVehiclesByBrand(
                        brandName: screenProvider.getScreenData.brandName),
                    i: 3,
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
            screenProvider.getScreenData.vehicleName != null
                ? ItemView(
                    context: context,
                    title: "Variants",
                    futureFunction: getVariants(
                        Vehiclename: screenProvider.getScreenData.vehicleName),
                    i: 4,
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
          ],
        );
      }),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onTap: Provider.of<ScreenProvider>(context).getScreenData.vm != null
              ? () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (_) => PartScreen()));
                }
              : null,
          child: Container(
            color: Provider.of<ScreenProvider>(context).getScreenData.vm != null
                ? Colors.blue
                : Colors.grey,
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    "Show",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      textWidget(Provider.of<ScreenProvider>(context)
                          .getScreenData
                          .catgName),
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      textWidget(Provider.of<ScreenProvider>(context)
                          .getScreenData
                          .subCatgName),
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      textWidget(Provider.of<ScreenProvider>(context)
                          .getScreenData
                          .brandName),
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      textWidget(Provider.of<ScreenProvider>(context)
                          .getScreenData
                          .vehicleName),
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      Provider.of<ScreenProvider>(context).getScreenData.vm !=
                              null
                          ? Provider.of<ScreenProvider>(context)
                              .getScreenData
                              .vm
                              .modelName
                          : '',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
