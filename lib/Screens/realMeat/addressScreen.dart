import 'package:bodmoo/Screens/drawer/myOrders/1ordersListScreen.dart';
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
              PhNo: Provider.of<CustomerDetailsProvider>(context, listen: false)
                  .phoneNumber,
              context: context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(Provider.of<CustomerDetailsProvider>(context, listen: false)
                  .deliveryAddress);
              return ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, i) {
                  if (i == 0) {
                    bool isEnabled = false;
                    return tap
                        ? Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 50,
                                ),
                                TextFormField(
//                    autofocus: true,
                                  controller: addController,
                                  onChanged: (String val) {
                                    val = val.trim();
                                    if (val == "")
                                      isEnabled = false;
                                    else
                                      isEnabled = true;
                                  },
                                  validator: (String val) {
                                    val = val.trim();
                                    if (val == "") return "Enter address";
                                  },
                                  showCursor: true,
                                  keyboardAppearance: Brightness.light,
                                  cursorColor: flipkartBlue,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  // keyboardType: TextInputType.streetAddress,
                                  decoration: InputDecoration(
                                    hintText: "Abc, India",
                                    labelText: "Address",
                                    focusColor: flipkartBlue,
                                    focusedBorder: fieldBorder,
                                    border: fieldBorder,
                                    enabledBorder: fieldBorder,
                                    errorBorder: errorBorder,
                                    errorStyle:
                                        TextStyle(color: Colors.redAccent),
                                    filled: true,
                                    fillColor: Colors.transparent,
                                  ),
                                  focusNode: addNode,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: GestureDetector(
                                    onTap: addController.text != ""
                                        ? () async {
                                            FocusScope.of(context).unfocus();
                                            print("pressed");
                                            await addAddress(
                                                Name: Provider.of<
                                                            CustomerDetailsProvider>(
                                                        context,
                                                        listen: false)
                                                    .customerName,
                                                PhNo: Provider.of<
                                                            CustomerDetailsProvider>(
                                                        context,
                                                        listen: false)
                                                    .phoneNumber,
                                                Addrees:
                                                    addController.text.trim(),
                                                context: context);

                                            setState(() {
                                              addController.clear();
                                              tap = false;
                                            });
                                          }
                                        : null,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "set Address",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: flipkartBlue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : ListTile(
                            title: Text("Add new address"),
                            onTap: () {
                              tap = true;
                              setState(() {});
                            },
                          );
                  }

                  return RadioListTile<String>(
                    value: snapshot.data[i - 1],
                    groupValue: Provider.of<CustomerDetailsProvider>(context)
                        .deliveryAddress,
                    title: Text(snapshot.data[i - 1]),
                    onChanged: (String value) {
                      Provider.of<CustomerDetailsProvider>(context,
                              listen: false)
                          .setAddress(address: value);
                      setState(() {});
                    },
                  );
                },
                itemCount: snapshot.data.length + 1,
              );
            } else
              return Container();
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
            onPressed:
                Provider.of<CustomerDetailsProvider>(context, listen: false)
                            .deliveryAddress !=
                        null
                    ? () async {
                        bool b = await prepareOrder(
                            address: Provider.of<CustomerDetailsProvider>(
                                    context,
                                    listen: false)
                                .deliveryAddress,
                            context: context);
                        if (b) {
                          //TODO:SHOW ORDER PLACED SUCCEFULLY
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => OrderListScreen()));
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
