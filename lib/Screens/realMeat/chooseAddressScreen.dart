import 'package:bodmoo/Screens/drawer/myOrders/1ordersListScreen.dart';
import 'file:///D:/FLUTTERAPPS/bodmoo/lib/Screens/drawer/myAddresses/addAddressScreen.dart';
import 'package:bodmoo/methods/get/getAddress.dart';
import 'package:bodmoo/methods/prepareOrder.dart';

import 'package:bodmoo/models/addressModel.dart';
import 'package:bodmoo/providers/ScreenProvider.dart';
import 'package:bodmoo/providers/cartProvider.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/utils.dart';

import 'package:bodmoo/widgets/toastWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseAddressScreen extends StatefulWidget {
  bool cartOrder = false;
  ChooseAddressScreen({@required this.cartOrder});
  @override
  _ChooseAddressScreenState createState() => _ChooseAddressScreenState();
}

class _ChooseAddressScreenState extends State<ChooseAddressScreen> {
  List<AddressModel> addresses = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Delivery Location"),
      ),
      body: FutureBuilder(
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
                      return RadioListTile(
                        value: i,
                        // groupValue: Provider.of<CustomerDetailsProvider>(context).deliveryAddress,
                        groupValue: Provider.of<CustomerDetailsProvider>(context, listen: true).addressIndex,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(addresses[i].customerName),
                            Text(prepareAddress(addressModel: addresses[i])),
                            Text(addresses[i].customerMobile),
                          ],
                        ),
                        onChanged: (int value) {
                          Provider.of<CustomerDetailsProvider>(context, listen: false).setAddressINdex(value);
                          // setState(() {});
                          // addressIndex = value;
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
            onPressed: Provider.of<CustomerDetailsProvider>(context).addressIndex > 0
                ? () async {
                    // bool b = await prepareOrder(
                    //   address: addresses[Provider.of<CustomerDetailsProvider>(context, listen: false).addressIndex],
                    //   context: context,
                    // );
                    bool b = true;
                    if (b) {
                      // TODO:SHOW ORDER PLACED SUCCEFULLY
                      widget.cartOrder ? Provider.of<CartProvider>(context, listen: false).clearCart() : null;
                      ;
                      Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(builder: (context) => OrderListScreen()),
                        // ModalRoute.withName('/parts'),
                      );
                    } else {
                      showToast(msg: 'Error in Order');
                    }
                  }
                : showToast(msg: addresses.length > 0 ? 'Choose Delivery address' : 'Add Address'),
          ),
        ),
      ),
    );
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   savePrefsForCarts(context: context);
  // }
}
