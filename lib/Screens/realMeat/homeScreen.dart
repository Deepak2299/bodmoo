import 'package:bodmoo/Screens/drawer/myAddresses/addressListScreen.dart';
import 'package:bodmoo/Screens/drawer/myOrders/1ordersListScreen.dart';
import 'package:bodmoo/Screens/login/phoneVerification.dart';
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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  int selectYear = null;
  yearDropdown(String header) {
    List<int> years = [];

    int num = 2000;
    while (num <= DateTime.now().year) {
      years.add(num);
      num++;
    }
    print(years);
    return DropdownButton<int>(
      value: selectYear,
      items: years
          .map((year) => DropdownMenuItem<int>(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ListTile(
                        // leading: Icon(Icons.card_giftcard),
                        title: Text(year.toString()))),
                value: year,
              ))
          .toList(),
      hint: Text('Select ${header}'),
      isExpanded: true,
      onChanged: (var val) {
        selectYear = val;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
//    print(context.watch<ScreenProvider>().getScreenData.catgName);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          actions: [
            CartIcon(context: context),
            SizedBox(
              width: 10,
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
                  ? Column(children: [
                      ListTile(
                        title: Text("My Orders"),
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => OrderListScreen()));
                        },
                      ),
                      ListTile(
                        title: Text("My Addresses"),
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => AddressListScreen()));
                        },
                      )
                    ])
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
                      title: Text("Phone Login"),
                      subtitle: Text('Register Phone number'),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => SignInWithPhoneNO()),
                          // (route) => false
                        );
                      },
                    ),
              // Align(
              //   alignment: Alignment.bottomLeft,
              //   child: ListTile(
              //     title: Text("Logout"),
              //     onTap: () {
              //       Navigator.pushAndRemoveUntil(
              //           context,

              //           MaterialPageRoute(builder: (context) => GoogleScreen()),
              //           (route) => false);
              //     },
              //   ),
              // )
            ],
          ),
        ),
        body: Consumer<ScreenProvider>(builder: (context, screenProvider, _) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
//              shrinkWrap: true,
//              physics: ScrollPhysics(),
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // ItemView(
                      //   context: context,
                      //   title: "Categories",
                      //   futureFunction: getCategories(),
                      //   i: 0,
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // screenProvider.getScreenData.catgName != null
                      //     ? ItemView(
                      //         context: context,
                      //         title: "Sub Categories",
                      //         futureFunction:
                      //             getSubCategories(catgName: Provider.of<ScreenProvider>(context).getScreenData.catgName),
                      //         i: 1,
                      //       )
                      //     : Container(),

                      DropdownUI(
                        futureFunction: getCategories(),
                        header: 'Category',
                        dropIndex: 0,
                      ),
                      screenProvider.getScreenData.catgName != null
                          ? DropdownUI(
                              futureFunction: getSubCategories(
                                  catgName: Provider.of<ScreenProvider>(context)
                                      .getScreenData
                                      .catgName),
                              header: 'Sub-Category',
                              dropIndex: 1,
                            )
                          : dummyDropdown('Sub-Category'),
                      DropdownUI(
                        futureFunction: getBrands(),
                        header: 'Brand',
                        dropIndex: 2,
                      ),
                      screenProvider.getScreenData.brandName != null
                          ? DropdownUI(
                              futureFunction: getVehiclesByBrand(
                                  brandName:
                                      screenProvider.getScreenData.brandName),
                              header: 'Vehicle',
                              dropIndex: 3,
                            )
                          : dummyDropdown('Vehicle'),
                      screenProvider.getScreenData.vehicleName != null
                          ? DropdownUI(
                              futureFunction: getVariants(
                                  Vehiclename:
                                      screenProvider.getScreenData.vehicleName),
                              header: 'Model',
                              dropIndex: 4,
                            )
                          : dummyDropdown('Model'),
                      screenProvider.getScreenData.vm != null
                          ? yearDropdown('Year')
                          : dummyDropdown('Year'),

// ---------------------------------

//               SizedBox(
//                 height: 20,
//               ),
//               screenProvider.getScreenData.subCatgName != null
//                   ? ItemView(
//                       context: context,
//                       title: "Brands",
//                       futureFunction: getBrands(),
//                       i: 2,
//                     )
//                   : Container(),
//               SizedBox(
//                 height: 20,
//               ),
//               screenProvider.getScreenData.brandName != null
//                   ? ItemView(
//                       context: context,
//                       title: "Vehicles",
//                       futureFunction: getVehiclesByBrand(brandName: screenProvider.getScreenData.brandName),
//                       i: 3,
//                     )
//                   : Container(),
//               SizedBox(
//                 height: 20,
//               ),
//               screenProvider.getScreenData.vehicleName != null
//                   ? ItemView(
//                       context: context,
//                       title: "Variants",
//                       futureFunction: getVariants(Vehiclename: screenProvider.getScreenData.vehicleName),
//                       i: 4,
//                     )
//                   : Container(),
//               SizedBox(
//                 height: 20,
//               ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
        bottomNavigationBar: BottomAppBar(
          child: GestureDetector(
            onTap: Provider.of<ScreenProvider>(context)
                            .getScreenData
                            .subCatgName !=
                        null &&
                    Provider.of<ScreenProvider>(context).getScreenData.vm !=
                        null
                ? () {
                    Navigator.pushNamed(
                      context,
                      '/parts',
                    );
                    // Navigator.of(context).push(CupertinoPageRoute(builder: (context) => PartScreen()));
                  }
                : null,
            child: Container(
              color: Provider.of<ScreenProvider>(context)
                              .getScreenData
                              .subCatgName !=
                          null &&
                      Provider.of<ScreenProvider>(context).getScreenData.vm !=
                          null
                  ? Colors.blue
                  : Colors.grey,
              height: MediaQuery.of(context).size.height * 0.09,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          textWidget(Provider.of<ScreenProvider>(context)
                              .getScreenData
                              .catgName),
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          textWidget(Provider.of<ScreenProvider>(context)
                              .getScreenData
                              .subCatgName),
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          textWidget(Provider.of<ScreenProvider>(context)
                              .getScreenData
                              .brandName),
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          textWidget(Provider.of<ScreenProvider>(context)
                              .getScreenData
                              .vehicleName),
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          Provider.of<ScreenProvider>(context)
                                      .getScreenData
                                      .vm !=
                                  null
                              ? Provider.of<ScreenProvider>(context)
                                      .getScreenData
                                      .vm
                                      .modelName +
                                  Provider.of<ScreenProvider>(context)
                                      .getScreenData
                                      .vm
                                      .manufactureYear
                              : '',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
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
