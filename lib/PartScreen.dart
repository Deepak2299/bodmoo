import 'package:bodmoo/PartDetailsScreen.dart';
import 'package:bodmoo/get/getParts.dart';
import 'package:bodmoo/models/partsModel.dart';
import 'package:bodmoo/providers/ScreenProvider.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PartScreen extends StatefulWidget {
  @override
  _PartScreenState createState() => _PartScreenState();
}

class _PartScreenState extends State<PartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parts"),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 20),
              FutureBuilder(
                future: getParts(
                  category: Provider.of<ScreenProvider>(context)
                      .getScreenData
                      .catgName,
                  subCategory: Provider.of<ScreenProvider>(context)
                      .getScreenData
                      .subCatgName,
                  brandName: Provider.of<ScreenProvider>(context)
                      .getScreenData
                      .brandName,
                  vehicleName: Provider.of<ScreenProvider>(context)
                      .getScreenData
                      .vehicleName,
                  modelName: Provider.of<ScreenProvider>(context)
                      .getScreenData
                      .vm
                      .modelName,
                  year: Provider.of<ScreenProvider>(context)
                      .getScreenData
                      .vm
                      .manufactureYear,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    PartsModel pm = snapshot.data;
                    print(pm.id);
                    List<PartDetail> partsList = pm.details;

                    return Expanded(
                        child: ListView.separated(
                      itemCount: partsList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Hero(
                              tag: "images_${index}",
                              child: Image.asset(IMAGE)),
                          title: Text(
                            partsList[index].partName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Rs " + partsList[index].itemPrice.toString(),
//                                    style: textStyle,
                              ),
                              Text(
                                partsList[index].quantity.toString(),
//                                    style: textStyle,
                              ),
                              Text(
                                partsList[index].outOfStock
                                    ? "OutOfStock"
                                    : "Instock",
                                style: TextStyle(
                                  color: partsList[index].outOfStock
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            ],
                          ),
//                              isThreeLine: true,
                          trailing: FlatButton(
                            child: Text(
                              "View\n Details",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => PartDetailsScren(
                                            partModel: pm,
                                            pos: index,
                                          )));
                            },
                          ),
                          onTap: () async {
//                                await Navigator.push(
//                                    context,
//                                    CupertinoPageRoute(
//                                        builder: (context) =>
//                                            PartUpdateScreen(partsModel: pm, index: index - 1)));
//                                setState(() {});
                          },
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