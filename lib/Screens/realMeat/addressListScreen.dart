import 'package:bodmoo/Screens/drawer/myOrders/1ordersListScreen.dart';
import 'package:bodmoo/Screens/realMeat/addAddressScreen.dart';
import 'package:bodmoo/methods/get/getAddress.dart';

import 'package:bodmoo/models/addressModel.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/utils.dart';
//import 'package:bodmoo/utils/utils.dart';

import 'package:bodmoo/widgets/toastWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  int addressIndex = -1;
  List<AddressModel> addresses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Delivery Location"),
      ),
      body: FutureBuilder(
          future: getAddress(
              PhNo: Provider.of<CustomerDetailsProvider>(context, listen: false)
                  .phoneNumber,
              token:
                  Provider.of<CustomerDetailsProvider>(context, listen: false)
                      .token),
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
                      await Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => AddAddressScreen()));
                      setState(() {});
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, i) {
                      print(addresses[i].customerName);
//                      print(prepareAddress(addressModel: addresses[i])
//                          .runtimeType);
                      print(addresses[i].customerMobile);
                      return RadioListTile(
                        value: i,
                        // groupValue: Provider.of<CustomerDetailsProvider>(context).deliveryAddress,
                        groupValue: addressIndex,
                        title: Column(
                          children: <Widget>[
                            Text(addresses[i].customerName),
                            Text(prepareAddress(addressModel: addresses[i])),
                            Text(addresses[i].customerMobile),
                          ],
                        ),
                        onChanged: (int value) {
                          // Provider.of<CustomerDetailsProvider>(context, listen: false).setAddress(address: value);
                          setState(() {});
                          addressIndex = value;
                          print(value.toString());
                        },
                      );
                    },
                    itemCount: snapshot.data.length,
                  ),
                ],
              );
            } else
              return Container(
                child: Row(
                  children: <Widget>[
                    Text('Fetching saved Addresses'),
                    CircularProgressIndicator(),
                  ],
                ),
              );
          }),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: RaisedButton(
            color: Colors.green,
            child: Center(
                child: Text('Confirm Order',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
            onPressed: addressIndex != -1
                ? () async {
                    // bool b = await prepareOrder(
                    //   address: addresses[addressIndex],
                    //   context: context,
                    // );
                    bool b = true;
                    if (b) {
                      //TODO:SHOW ORDER PLACED SUCCEFULLY
                      Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => OrderListScreen()),
                        ModalRoute.withName('/parts'),
                      );
                    } else {
                      showToast(msg: 'Error in Order');
                    }
                  }
                : showToast(
                    msg: addresses.length > 0
                        ? 'Choose Delivery address'
                        : 'Add Address'),
          ),
        ),
      ),
    );
  }
}
