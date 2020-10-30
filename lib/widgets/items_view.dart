import 'package:bodmoo/providers/ScreenProvider.dart';
import 'package:bodmoo/screenData.dart';
import 'package:bodmoo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ItemView extends StatefulWidget {
  BuildContext context;
  String title;
  Future<dynamic> futureFunction;
  int i = 0;
  ItemView(
      {@required this.context,
      @required this.title,
      @required this.futureFunction,
      @required this.i});
  @override
  _ItemViewState createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  bool collapse = true;
  bool gridView = false;

  Widget show(context, snapshots) {
    return collapse
        ? SizedBox(
            height: 100,
            child: ListView.separated(
//                            shrinkWrap: true,
//                            padding: EdgeInsets.all(8),

              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () => widget.context
                      .read<ScreenProvider>()
                      .add(snapshots.data[i], widget.i),
                  child: Container(
//                              height: 200,
                    width: 100,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        // ignore: missing_return
                        image: AssetImage(IMAGE),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black38, BlendMode.hardLight),
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
              },

              itemCount: snapshots.data.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, i) => SizedBox(
                width: 10,
              ),
            ),
          )
        : GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1),
            itemCount: snapshots.data.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () => widget.context
                    .read<ScreenProvider>()
                    .add(snapshots.data[i], widget.i),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      // ignore: missing_return
                      image: AssetImage(IMAGE),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black38, BlendMode.hardLight),
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
            });
  }

  Widget loading(context) {
    return Shimmer.fromColors(
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      padding: EdgeInsetsDirectional.only(top: 15),
                    )),
                itemCount: 6,
              ))
          : GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1),
              itemCount: 6,
              itemBuilder: (context, i) {
                return Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  padding: EdgeInsetsDirectional.only(top: 15),
                );
              }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: this,
      child: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title),
                gridView
                    ? FlatButton(
                        height: 30,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
//                    padding: EdgeInsets.all(5),
                        color: Colors.red,
                        onPressed: () {
                          setState(() {
                            collapse = !collapse;
                          });
                        },
                        child: Text(
                          !collapse ? "Collapse" : "View All",
                          style: TextStyle(color: Colors.white),
                        ))
                    : Container(),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: widget.futureFunction,
                builder: (context, snapshots) {
                  switch (snapshots.connectionState) {
                    case ConnectionState.waiting:
                      if (widget.i == context.watch<ScreenProvider>().pos)
                        return loading(context);
                      else {
//                        if (snapshots.data.length > 4)
//                          setState(() {
//                            gridView = true;
//                          });
                        return show(context, snapshots);
                      }
                      break;
                    default:
                      if (snapshots.hasError)
                        return loading(context);
                      else {
//                        if (snapshots.data.length > 4)
//                          setState(() {
//                            gridView = true;
//                          });
                        return show(context, snapshots);
                      }
                  }
                },
              )),
        ],
      ),
    );
  }
}
