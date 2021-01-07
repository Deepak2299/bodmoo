import 'package:bodmoo/models/partsModel.dart';
import 'package:bodmoo/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RecentScreen extends StatelessWidget {
  listTile(int subPartIndex, List<PartDetail> part, int partIndex,
      PartsModel pm, BuildContext context) {
//    return Card(
//      child: ListTile(
//        leading: Container(
//          width: 80,
//          child: Center(
//            widthFactor: 1,
//            heightFactor: 0.8,
//            child: Hero(
//                tag: "images_${partIndex}_${subPartIndex}",
//                child: parts[subPartIndex].productImages.isEmpty
//                    ? Image.asset(IMAGE)
//                    : CachedNetworkImage(
//                  imageUrl: parts[subPartIndex].productImages[0],
//                  progressIndicatorBuilder:
//                      (context, url, downloadProgress) =>
//                      CircularProgressIndicator(
//                          value: downloadProgress.progress),
//                  errorWidget: (context, url, error) => Icon(Icons.error),
//                )),
//          ),
//        ),
//        title: Text(
//          parts[subPartIndex].partName,
//          style: TextStyle(fontWeight: FontWeight.bold),
//        ),
//        subtitle: Column(
//          mainAxisSize: MainAxisSize.min,
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Text(
//              "Rs " + parts[subPartIndex].itemPrice.toString(),
////                                    style: textStyle,
//            ),
//            Text(
//              parts[subPartIndex].quantity.toString(),
////                                    style: textStyle,
//            ),
//            Text(
//              parts[subPartIndex].outOfStock ? "OutOfStock" : "Instock",
//              style: TextStyle(
//                color:
//                parts[subPartIndex].outOfStock ? Colors.red : Colors.green,
//              ),
//            ),
//          ],
//        ),
////                              isThreeLine: true,
//        trailing: Text(
//          "View\nDetails",
//          textAlign: TextAlign.center,
//          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
//        ),
//        onTap: () {
//          Navigator.push(
//              context,
//              CupertinoPageRoute(
//                  builder: (context) => PartDetailsScren(
//                    partModel: pm,
//                    subPartIndex: subPartIndex,
//                    PartIndex: partIndex,
//                  )));
//        },
//      ),
//    );
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
