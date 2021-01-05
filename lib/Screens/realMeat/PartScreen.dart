import 'package:bodmoo/Screens/realMeat/PartDetailsScreen.dart';
import 'package:bodmoo/methods/get/getParts.dart';
import 'package:bodmoo/models/partsModel.dart';
import 'package:bodmoo/providers/ScreenProvider.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:bodmoo/widgets/cartIcon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PartScreen extends StatefulWidget {
  @override
  _PartScreenState createState() => _PartScreenState();
}

class _PartScreenState extends State<PartScreen> {
  int partIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parts"),
        actions: [
          CartIcon(context: context),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FutureBuilder(
                future: getParts(
                  category: Provider.of<ScreenProvider>(context).getScreenData.catgName,
                  subCategory: Provider.of<ScreenProvider>(context).getScreenData.subCatgName,
                  brandName: Provider.of<ScreenProvider>(context).getScreenData.brandName,
                  vehicleName: Provider.of<ScreenProvider>(context).getScreenData.vehicleName,
                  modelName: Provider.of<ScreenProvider>(context).getScreenData.vm.modelName,
                  year: Provider.of<ScreenProvider>(context).getScreenData.vm.manufactureYear,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    PartsModel pm = snapshot.data;
                    print(pm.id);
                    List<PartDetail> partsList = pm.details;
                    return partsList.length == 0
                        ? Center(
                            child: Text(
                            "No Parts found",
                            style: TextStyle(color: Colors.grey),
                          ))
                        : Expanded(
                            child: ListView.separated(
                            padding: EdgeInsets.all(8),
                            itemCount: partsList.length,
                            itemBuilder: (context, subPartIndex) {
                              return Card(
                                child: ListTile(
                                  leading: Container(
                                    width: 80,
                                    child: Center(
                                      widthFactor: 1,
                                      heightFactor: 0.8,
                                      child: Hero(
                                          tag: "images_${partIndex}_${subPartIndex}",
                                          child: partsList[subPartIndex].productImages.isEmpty
                                              ? Image.asset(IMAGE)
                                              : CachedNetworkImage(
                                                  imageUrl: partsList[subPartIndex].productImages[0],
                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                      CircularProgressIndicator(value: downloadProgress.progress),
                                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                                )),
                                    ),
                                  ),
                                  title: Text(
                                    partsList[subPartIndex].partName,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Rs " + partsList[subPartIndex].itemPrice.toString(),
//                                    style: textStyle,
                                      ),
                                      Text(
                                        partsList[subPartIndex].quantity.toString(),
//                                    style: textStyle,
                                      ),
                                      Text(
                                        partsList[subPartIndex].outOfStock ? "OutOfStock" : "Instock",
                                        style: TextStyle(
                                          color: partsList[subPartIndex].outOfStock ? Colors.red : Colors.green,
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
                            },
                            separatorBuilder: (context, i) => Divider(
                              color: Colors.blue,
                              thickness: 1,
                            ),
                          ));
                  } else
                    return Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
//          deleteLoadingWidget(loadBoolValue: deleteLoading, context: context),
        ],
      ),
    );
  }
}
