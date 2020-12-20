import 'package:bodmoo/methods/get/getCategories.dart';
import 'package:bodmoo/providers/ScreenProvider.dart';
import 'package:bodmoo/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ItemView extends StatefulWidget {
  BuildContext context;
  String title;
  Future<dynamic> futureFunction;
  int i = 0;
  ItemView({@required this.context, @required this.title, @required this.futureFunction, @required this.i});
  @override
  _ItemViewState createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  bool collapse = true;

  Widget show(context, snapshots) {
//    print(widget.i.toString() + " : " + snapshots.data.length.toString());
//    print(snapshots.data);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title),
                snapshots.data.length > 4
                    ? FlatButton(
                        // height: 30,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                    padding: EdgeInsets.all(5),
                        color: Colors.red,
                        onPressed: () {
                          setState(() {
                            collapse = !collapse;
                          });
                        },
                        child: Text(
                          collapse ? "View All" : "Collapse",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : Container(),
              ],
            ),
            collapse
                ? SizedBox(
                    height: 100,
                    child: ListView.separated(
                      shrinkWrap: true,
//                            padding: EdgeInsets.all(8),
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () => widget.context
                              .read<ScreenProvider>()
                              .updateData(dataValue: snapshots.data[i], dataIndex: widget.i),
                          child: Container(
//                              height: 200,
                            width: 100,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                // ignore: missing_return
                                image: AssetImage(IMAGE),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(Colors.black38, BlendMode.hardLight),
                              ),
                            ),
                            padding: EdgeInsetsDirectional.only(top: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  widget.i == 4 ? snapshots.data[i].modelName.toString() : snapshots.data[i].toString(),
//                    style: textStyle,
                                ),
                              ],
                            ),
                          ),
                        );
                      },

                      itemCount: snapshots.data.length > 4 ? 4 : snapshots.data.length,
                      separatorBuilder: (context, i) => SizedBox(
                        width: 10,
                      ),
                    ),
                  )
                : Container(
                    // height: 200,
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 1),
                        itemCount: snapshots.data.length,
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () => widget.context
                                .read<ScreenProvider>()
                                .updateData(dataValue: snapshots.data[i], dataIndex: widget.i),
                            child: Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  // ignore: missing_return
                                  image: AssetImage(IMAGE),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(Colors.black38, BlendMode.hardLight),
                                ),
                              ),
                              padding: EdgeInsetsDirectional.only(top: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    widget.i == 4
                                        ? snapshots.data[i].modelName.toString()
                                        : snapshots.data[i].toString(),
//                    style: textStyle,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
          ],
        ));
  }

  Widget loading(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // shrinkWrap: true,
        // physics: ScrollPhysics(),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.title),
          SizedBox(height: 20),
          Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: collapse
                ? SizedBox(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, i) => SizedBox(
                        width: 10,
                      ),
                      shrinkWrap: true,
                      itemBuilder: (_, __) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
                            padding: EdgeInsetsDirectional.only(top: 15),
                          )),
                      itemCount: 6,
                    ))
                : GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 1),
                    itemCount: 6,
                    itemBuilder: (context, i) {
                      return Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
                        padding: EdgeInsetsDirectional.only(top: 15),
                      );
                    }),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.futureFunction,
      builder: (context, snapshots) {
        switch (snapshots.connectionState) {
          case ConnectionState.waiting:
            if (widget.i == context.watch<ScreenProvider>().pos)
              return loading(context);
            else {
              return snapshots.hasData ? show(context, snapshots) : Container();
            }
            break;
          default:
            if (snapshots.hasError)
              return Center(child: Text(snapshots.error.toString()));
            else if (snapshots.hasData) {
              return show(context, snapshots);
            }
            return loading(context);
        }
      },
    );
  }
}

class DropdownUI extends StatefulWidget {
  Future<dynamic> futureFunction;
  String header;
  DropdownUI({@required this.futureFunction, @required this.header});

  @override
  _DropdownUIState createState() => _DropdownUIState();
}

class _DropdownUIState extends State<DropdownUI> {
  String value = null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<DropdownMenuItem<String>> prepareDropdownItems(AsyncSnapshot snapshot) {
    print(snapshot.data);

    List<DropdownMenuItem<String>> items = [];
    for (int i = 0; i < snapshot.data.length; i++) {
      items.add(DropdownMenuItem<String>(
        value: snapshot.data[i].toString(),
        child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: ListTile(leading: Icon(Icons.card_giftcard), title: Text(snapshot.data[i].toString()))),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCategories(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return DropdownButton<String>(
              hint: Text('Select ${widget.header}'),
              items: prepareDropdownItems(snapshot),
              value: value,
              onChanged: (String str) {
                value = str;
                setState(() {});
              });
        } else
          return CircularProgressIndicator();
      },
    );
  }
}
