import 'package:bodmoo/Screens/drawer/myAddresses/addressListScreen.dart';
import 'package:bodmoo/Screens/drawer/myOrders/1ordersListScreen.dart';
import 'package:bodmoo/Screens/login/phoneVerification.dart';
import 'package:bodmoo/Screens/realMeat/PartDetailsScreen.dart';
import 'package:bodmoo/Screens/realMeat/cartItemsScreen.dart';
import 'package:bodmoo/Screens/realMeat/homeScreen.dart';
import 'package:bodmoo/Screens/realMeat/recent_screen.dart';
import 'package:bodmoo/methods/get/getAllParts.dart';
import 'package:bodmoo/models/partsModel.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/utils.dart';
import 'package:bodmoo/utils/utils.dart';
import 'package:bodmoo/widgets/cartIcon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AllPartsHomeScreen extends StatelessWidget {
  listTile(int subPartIndex, List<PartDetail> parts, int partIndex,
      PartsModel pm, BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          width: 80,
          child: Center(
            widthFactor: 1,
            heightFactor: 0.8,
            child: Hero(
              tag: "images_${partIndex}_${subPartIndex}",
              child: parts[subPartIndex].productImages.isEmpty
                  ? Image.asset(IMAGE)
                  : CachedNetworkImage(
                      imageUrl: parts[subPartIndex].productImages[0],
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
            ),
          ),
        ),
        title: Text(
          parts[subPartIndex].partName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Rs " + parts[subPartIndex].itemPrice.toString(),
//                                    style: textStyle,
            ),
            Text(
              parts[subPartIndex].quantity.toString(),
//                                    style: textStyle,
            ),
            Text(
              parts[subPartIndex].outOfStock ? "OutOfStock" : "Instock",
              style: TextStyle(
                color:
                    parts[subPartIndex].outOfStock ? Colors.red : Colors.green,
              ),
            ),
          ],
        ),
//                              isThreeLine: true,
        trailing: Text(
          "View\nDetails",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
        ),
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => PartDetailsScren(
                        partModel: pm,
                        subPartIndex: subPartIndex,
                        PartIndex: partIndex,
                      )));
        },
      ),
    );
  }

  ScrollController sc = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ],
        ),
      ),
      body: ListView(
        physics: ClampingScrollPhysics(),
        // shrinkWrap: true,
        children: <Widget>[
          Provider.of<CustomerDetailsProvider>(context, listen: false)
                      .recentPartsList
                      .length >
                  0
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recently Viewed",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          FlatButton(
                            // height: 30,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
//                    padding: EdgeInsets.all(5),
                            color: Colors.blue,
                            onPressed: Provider.of<CustomerDetailsProvider>(
                                            context,
                                            listen: false)
                                        .recentPartsList
                                        .length >
                                    0
                                ? () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                RecentScreen()));
                                  }
                                : null,
                            child: Text(
                              "View All",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 250,
                      alignment: Alignment.centerLeft,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          PartsModel p = Provider.of<CustomerDetailsProvider>(
                                  context,
                                  listen: false)
                              .recentPartsList
                              .reversed
                              .elementAt(index);
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => PartDetailsScren(
                                            partModel: p,
                                            subPartIndex: 0,
                                            PartIndex: index,
                                            recent: 2,
                                          )));
                            },
                            child: Card(
                              child: Container(
                                height: 100,
                                width: 100,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                // padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Hero(
                                        tag: "images_${index}_${-2}",
                                        child:
                                            p.details[0].productImages.isEmpty
                                                ? Image.asset(IMAGE)
                                                : CachedNetworkImage(
                                                    imageUrl: p.details[0]
                                                        .productImages[0],
                                                    progressIndicatorBuilder: (context,
                                                            url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  )),
                                    Text(p.details[0].partName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Text("Rs " +
                                        p.details[0].itemPrice.toString() +
                                        "/-"),
                                    Divider(),
                                    Text('About:',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                    Text(p.carBrand),
                                    Text(p.carName),
                                    Text(
                                      p.carModel + "-" + p.modelYear.toString(),
                                      overflow: TextOverflow.clip,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: Provider.of<CustomerDetailsProvider>(context,
                                        listen: false)
                                    .recentPartsList
                                    .length >
                                6
                            ? 5
                            : Provider.of<CustomerDetailsProvider>(context,
                                    listen: false)
                                .recentPartsList
                                .length,
                      ),
                    ),
                  ],
                )
              : Container(),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10),
            child: Text(
              "All Parts",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder(
            future: getAllParts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<PartsModel> partsList = snapshot.data;
                return partsList.length == 0
                    ? Text(
                        "No Parts found",
                        style: TextStyle(color: Colors.grey),
                      )
                    : ListView.builder(
                        controller: sc,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        padding: EdgeInsets.all(8),
                        itemCount: partsList.length,
                        itemBuilder: (context, partIndex) {
                          PartsModel pm = partsList[partIndex];
                          print(pm.id);
                          List<PartDetail> parts = pm.details;
                          // return Text(parts[0].partName);

                          return ListView.builder(
                            shrinkWrap: true,
                            //                            padding: EdgeInsets.all(8),
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: parts.length,
                            itemBuilder: (context, subPartIndex) {
                              return subPartIndex == 0
                                  ? Column(
                                      children: [
                                        Row(
                                          children: [
                                            tagStyle(str: pm.carBrand),
                                            tagStyle(str: pm.carName),
                                            tagStyle(str: pm.carModel),
                                            tagStyle(
                                                str: pm.modelYear.toString()),
                                          ],
                                        ),
                                        listTile(subPartIndex, parts, partIndex,
                                            pm, context)
                                      ],
                                    )
                                  : listTile(subPartIndex, parts, partIndex, pm,
                                      context);
                            },
                            //                            separatorBuilder: (context, ind) => Divider(
                            //                              color: Colors.blue,
                            //                              thickness: 1,
                            //                            ),
                          );
                        },
                      );
              } else
                return shimmerLoader(context);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 15,
        icon: Icon(
          MdiIcons.filter,
          size: 27,
        ),
        label: Text(
          "Filter",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => HomeScreen()));
        },
      ),
    );
  }
}
