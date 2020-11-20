import 'package:bodmoo/Screens/drawer/myOrders/1ordersListScreen.dart';
import 'package:bodmoo/Screens/realMeat/addAddressScreen.dart';
import 'package:bodmoo/methods/get/getAddress.dart';
import 'package:bodmoo/methods/post/addAddress.dart';
import 'package:bodmoo/methods/prepareOrder.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController addController = TextEditingController();
  FocusNode addNode = FocusNode();

  bool tap = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Delivery Location"),
      ),
      body: FutureBuilder(
          future: getAddress(
              PhNo: Provider.of<CustomerDetailsProvider>(context, listen: false).phoneNumber, context: context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(Provider.of<CustomerDetailsProvider>(context, listen: false).deliveryAddress);
              return Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.add),
                    title: Text("Add Address"),
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => AddAddressScreen()));
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, i) {
                      // if (i == 0) {
                      //   ListTile(
                      //     title: Text("Add new address"),
                      //     onTap: () {},
                      //   );
                      // } else
                      return RadioListTile<String>(
                        value: snapshot.data[i],
                        groupValue: Provider.of<CustomerDetailsProvider>(context).deliveryAddress,
                        title: Text(snapshot.data[i]),
                        onChanged: (String value) {
                          Provider.of<CustomerDetailsProvider>(context, listen: false).setAddress(address: value);
                          // setState(() {});
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
                child: Text('Confirm Order', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
            onPressed: Provider.of<CustomerDetailsProvider>(context, listen: false).deliveryAddress != null
                ? () async {
                    bool b = await prepareOrder(
                        address: Provider.of<CustomerDetailsProvider>(context, listen: false).deliveryAddress,
                        context: context);
                    if (b) {
                      //TODO:SHOW ORDER PLACED SUCCEFULLY
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => OrderListScreen()));
                    } else {
                      //TODO: ERROR WHILE PLACING ORDER
                    }
                  }
                : null,
          ),
        ),
      ),
    );
  }
}
