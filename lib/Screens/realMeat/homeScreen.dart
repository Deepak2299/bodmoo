import 'package:bodmoo/Screens/drawer/myOrders/1ordersListScreen.dart';
import 'package:bodmoo/Screens/login/phoneVerification.dart';
import 'package:bodmoo/Screens/realMeat/PartScreen.dart';
import 'package:bodmoo/methods/get/getBrands.dart';
import 'package:bodmoo/methods/get/getCategories.dart';
import 'package:bodmoo/methods/get/getSubCat.dart';
import 'package:bodmoo/methods/get/getVariants.dart';
import 'package:bodmoo/methods/get/getVehiclesbyBrand.dart';
import 'package:bodmoo/providers/ScreenProvider.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/widgets/cartIcon.dart';

import 'package:bodmoo/widgets/items_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

textWidget(String str) {
  if (str != null)
    return str + '->';
  else
    return '';
}

class _HomeScreenState extends State<HomeScreen> {
  bool collapse = true;
  @override
  Widget build(BuildContext context) {
//    print(context.watch<ScreenProvider>().getScreenData.catgName);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 18),
              child: AddToCart(),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  Provider.of<CustomerDetailsProvider>(context).customerName !=
                          null
                      ? 'Hello ' +
                          Provider.of<CustomerDetailsProvider>(context)
                              .customerName
                              .toString()
                      : 'Hello! User,',
                ),
              ),
              Provider.of<CustomerDetailsProvider>(context).token != null
                  ? ListTile(
                      title: Text("My Orders"),
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => OrderListScreen()));
                      },
                    )
                  : Container(),
              Provider.of<CustomerDetailsProvider>(context, listen: false)
                          .token !=
                      null
                  ? ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text("Logout"),
                      onTap: () {
                        clearPrefsForLogin();
                        Provider.of<CustomerDetailsProvider>(context,
                                listen: false)
                            .clearCustomerDetails();
                        Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => SignInWithPhoneNO()),
                            (route) => true);
                      },
                    )
                  : ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text("Login"),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => SignInWithPhoneNO()),
                          // (route) => false
                        );
                      },
                    ),
            ],
          ),
        ),
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
                          Vehiclename:
                              screenProvider.getScreenData.vehicleName),
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
                    Navigator.pushNamed(
                      context,
                      // CupertinoPageRoute(builder: (_) => PartScreen())
                      '/parts',
                    );
                  }
                : null,
            child: Container(
              color:
                  Provider.of<ScreenProvider>(context).getScreenData.vm != null
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
      ),
    );
  }
}
