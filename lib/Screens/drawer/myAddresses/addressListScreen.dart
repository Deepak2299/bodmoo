import 'package:bodmoo/Screens/drawer/myAddresses/addAddressScreen.dart';
import 'package:bodmoo/Screens/drawer/myAddresses/editAddressScreen.dart';
import 'package:bodmoo/methods/get/getAddress.dart';
import 'package:bodmoo/models/addressModel.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressListScreen extends StatefulWidget {
  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  int addressIndex = -1;
  List<AddressModel> addresses = [];

  deleteAddress({
    @required int index,
  }) async {
    setState(() {
      deleteLoad = true;
    });
    await Future.delayed(Duration(seconds: 2), () {});
    setState(() {
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
                        ListTile(
                          leading: Icon(Icons.add),
                          title: Text("Add Address"),
                          onTap: () async {
                            await Navigator.push(context, CupertinoPageRoute(builder: (context) => AddAddressScreen()));
                            setState(() {});
                          },
                        ),
                        ListView.separated(
                          separatorBuilder: (context, i) => Divider(),
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, i) {
                            print(addresses[i].customerName);
//                      print(prepareAddress(addressModel: addresses[i])
//                          .runtimeType);
                            print(addresses[i].customerMobile);
                            return ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(addresses[i].customerName),
                                  Text(prepareAddress(addressModel: addresses[i])),
                                  Text(addresses[i].customerMobile),
                                ],
                              ),
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
                                      await deleteAddress(index: i);
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
