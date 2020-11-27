import 'package:bodmoo/Screens/drawer/myAddresses/addAddressScreen.dart';
import 'package:bodmoo/Screens/drawer/myAddresses/editAddressScreen.dart';
import 'package:bodmoo/methods/get/getAddress.dart';
import 'package:bodmoo/models/addressModel.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressListScreen extends StatefulWidget {
  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  int addressIndex = -1;
  List<AddressModel> addresses = [];
  bool dismissFunction({@required BuildContext context}) {
    return false;
  }

  deleteAddress({@required int index, @required BuildContext context}) async {
    setState(() {
      deleteLoad = true;
    });
    await Future.delayed(Duration(seconds: 2), () {});
    setState(() {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Address removed")));

      deleteLoad = false;
    });
  }

  bool deleteLoad = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Addresses"),
        ),
        body: Stack(
          children: <Widget>[
            FutureBuilder(
                future: getAddress(
                    PhNo: Provider.of<CustomerDetailsProvider>(context, listen: false).phoneNumber,
                    token: Provider.of<CustomerDetailsProvider>(context, listen: false).token),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    addresses = snapshot.data;
                    return ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Card(
                          child: ListTile(
                            leading: Icon(Icons.add, color: Colors.blue),
                            title: Text("Add Address", style: TextStyle(fontWeight: FontWeight.w500)),
                            onTap: () async {
                              await Navigator.push(
                                  context, CupertinoPageRoute(builder: (context) => AddAddressScreen()));
                              setState(() {});
                            },
                          ),
                        ),
                        ListView.separated(
                          separatorBuilder: (context, i) => Divider(),
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, i) {
                            return Dismissible(
                              key: UniqueKey(),
                              // dismissThresholds: {
                              //   DismissDirection.endToStart: -MediaQuery.of(context).size.width * 0.5,
                              //   DismissDirection.startToEnd: MediaQuery.of(context).size.width * 0.5,
                              // },
                              secondaryBackground: Container(
                                padding: EdgeInsets.all(15),
                                color: Colors.redAccent,
                                child: Text("Swipe left to Delete", style: TextStyle(color: Colors.white)),
                                alignment: Alignment.centerRight,
                              ),
                              // direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.green,
                                child: Text("Swipe right to Edit", style: TextStyle(color: Colors.white)),
                                alignment: Alignment.centerLeft,
                              ),
                              movementDuration: Duration(seconds: 1),
                              onDismissed: (direction) async {
                                switch (direction) {
                                  case DismissDirection.endToStart:
                                    addresses.removeAt(i);
                                    await deleteAddress(context: context, index: i);
                                    break;

                                  case DismissDirection.startToEnd:
                                    AddressModel am = addresses[i];
                                    addresses.removeAt(i);
                                    setState(() {});
                                    await Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                                      return EditAddressScreen(
                                        addressModel: am,
                                        addressIndex: i,
                                      );
                                    }));
                                    setState(() {});
                                    break;
                                }
                              },
                              child: Card(
                                child: ListTile(
                                  title: addressWidget(addressModel: addresses[i]),
                                  trailing: PopupMenuButton(
                                    icon: Icon(Icons.more_vert),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    onSelected: (value) async {
                                      switch (value) {
                                        case 0:
                                          Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                                            return EditAddressScreen(
                                              addressModel: addresses[i],
                                              addressIndex: i,
                                            );
                                          }));
                                          break;
                                        case 1:
                                          await deleteAddress(index: i, context: context);
                                          break;
                                      }
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return <PopupMenuItem>[
                                        PopupMenuItem(
                                          child: Text('Edit'),
                                          value: 0,
                                        ),
                                        PopupMenuItem(
                                          child: Text('Delete'),
                                          value: 1,
                                        )
                                      ];
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: snapshot.data.length,
                        ),
                      ],
                    );
                  } else
                    return LoadingWidget(msg: 'Loading your addresses');
                }),
            deleteLoad ? LoadingWidget(msg: 'Deleting address') : Container(),
          ],
        ),
      ),
    );
  }
}
