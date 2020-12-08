import 'dart:convert';
import 'dart:io';
import 'package:bodmoo/Screens/Payment/confirmPayment.dart';
import 'package:http/http.dart' as http;
import 'package:bodmoo/Screens/Payment/paymentMethod.dart';
import 'package:bodmoo/Screens/Payment/paymentScreen.dart';
import 'package:bodmoo/Screens/drawer/myAddresses/addAddressScreen.dart';
import 'package:bodmoo/Screens/drawer/myAddresses/editAddressScreen.dart';
import 'package:bodmoo/Screens/drawer/myOrders/1ordersListScreen.dart';

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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ChooseAddressScreen extends StatefulWidget {
  bool cartOrder = false;
  double amount;
  ChooseAddressScreen({@required this.cartOrder, @required this.amount});
  @override
  _ChooseAddressScreenState createState() => _ChooseAddressScreenState();
}

class _ChooseAddressScreenState extends State<ChooseAddressScreen> {
  List<AddressModel> addresses = [];

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
                  Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Icon(Icons.add),
                      title: Text("Add Address"),
                      onTap: () async {
                        await Navigator.push(context, CupertinoPageRoute(builder: (context) => AddAddressScreen()));
                        setState(() {});
                      },
                    ),
                  ),
                  ListView.builder(
                    // separatorBuilder: (context, i) => Divider(
                    //   height: 4,
                    //   thickness: 1.5,
                    // ),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, i) {
                      return Card(
                        child: RadioListTile(
                          value: i,
                          // groupValue: Provider.of<CustomerDetailsProvider>(context).deliveryAddress,
                          groupValue: Provider.of<CustomerDetailsProvider>(context, listen: true).addressIndex,
                          secondary: Provider.of<CustomerDetailsProvider>(context, listen: true).addressIndex == i
                              ? EditAddressButton(
                                  i: i,
                                  addressModel: addresses[i],
                                )
                              : null,
                          title: Text(addresses[i].customerName),

                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 10),
                              Text(prepareAddress(addressModel: addresses[i])),
                              SizedBox(height: 10),
                              Text(addresses[i].customerMobile),
                            ],
                          ),
                          onChanged: (int value) {
                            Provider.of<CustomerDetailsProvider>(context, listen: false).setAddressINdex(value);
                            // setState(() {});
                            // addressIndex = value;
                          },
                        ),
                      );
                    },
                    itemCount: snapshot.data.length,
                  ),
                ],
              );
            } else
              return LoadingWidget(
                msg: 'Fetching saved Addresses',
              );
          }),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.06,
          child: RaisedButton(
              color: Colors.green,
              child: Center(
                  child: Text('Checkout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ))),
              onPressed: Provider.of<CustomerDetailsProvider>(context).addressIndex != -1
                  ? () async {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ConfirmPaymentScreen(
                              cartOrder: widget.cartOrder,
                              amount: widget.amount,
                              addressModel: addresses[Provider.of<CustomerDetailsProvider>(context).addressIndex],
                              items: Provider.of<CustomerDetailsProvider>(context, listen: false).orderItems,
                            ),
                          ));
                    }
                  : null
              // : showToast(msg: 'Choose Delivery address'),
              ),
        ),
      ),
    );
  }
}
