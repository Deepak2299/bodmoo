import 'package:bodmoo/methods/post/addAddress.dart';
import 'package:bodmoo/models/addressModel.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/utils.dart';
import 'package:bodmoo/widgets/toastWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController hno = TextEditingController();
  TextEditingController colony = TextEditingController();

  GlobalKey<FormState> _key = GlobalKey<FormState>();

  tff({
    @required TextEditingController controller,
    @required String labelText,
    @required Function validator,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        autovalidate: true,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText + ' (Required)*',
          labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        validator: validator == null
            ? (String str) {
                if (str.length < 1)
                  return 'Pls provide the necessary details';
                else
                  return null;
              }
            : validator,
      ),
    );
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add delivery address'),
          backgroundColor: flipkartBlue,
        ),
        body: Stack(
          children: <Widget>[
            Form(
              key: _key,
              autovalidate: false,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  tff(
                    controller: name,
                    labelText: 'Full Name',
                    validator: null,
                  ),
                  tff(
                    controller: phone,
                    labelText: 'Phone Number',
                    validator: (String str) {
                      if (str.length < 1)
                        return 'Pls provide the necessary details';
                      else {
                        if (str[0] != '9' &&
                            str[0] != '8' &&
                            str[0] != '7' &&
                            str[0] != '6')
                          return 'Enter valid Phone Number';
                        else if (str.length != 10)
                          return 'Enter 10digit Phone Number';
                        else
                          return null;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(
                        child: tff(
                          controller: state,
                          labelText: 'State',
                          validator: null,
                        ),
                      ),
                      Flexible(
                        child: tff(
                          controller: city,
                          labelText: 'City',
                          validator: null,
                        ),
                      )
                    ],
                  ),
                  tff(
                      controller: hno,
                      labelText: 'House No./Building Name',
                      validator: null),
                  tff(
                      controller: colony,
                      labelText: 'Road Name/Area/Colony',
                      validator: null),
                ],
              ),
            ),
            loading ? Center(child: CircularProgressIndicator()) : Container(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.07,
            child: RaisedButton(
                color: Colors.redAccent,
                child: Text(
                  "Save Address",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () async {
                  if (_key.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    AddressModel ad = AddressModel(
                        customerName: name.text,
                        customerMobile: phone.text,
                        houseno: hno.text,
                        state: state.text,
                        city: city.text,
                        roadname: colony.text);
                    bool t = await addAddress(
                        token: Provider.of<CustomerDetailsProvider>(context,
                                listen: false)
                            .token,
                        addressModel: ad,
                        mobile: Provider.of<CustomerDetailsProvider>(context,
                                listen: false)
                            .phoneNumber);
                    if (t)
                      Navigator.pop(context);
                    else
                      showToast(msg: 'Error while adding');
                    if (mounted)
                      setState(() {
                        loading = false;
                      });
                  }
                }),
          ),
        ),
      ),
    );
  }
}
