import 'package:bodmoo/methods/post/addAddress.dart';
import 'package:bodmoo/methods/post/editAddress.dart';
import 'package:bodmoo/models/addressModel.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/utils.dart';
import 'package:bodmoo/widgets/toastWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAddressScreen extends StatefulWidget {
  AddressModel addressModel;
  int addressIndex;
  EditAddressScreen({@required this.addressModel, @required this.addressIndex});
  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
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
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text = widget.addressModel.customerName;
    phone.text = widget.addressModel.customerMobile;
    state.text = widget.addressModel.state;
    city.text = widget.addressModel.city;
    hno.text = widget.addressModel.houseno;
    colony.text = widget.addressModel.roadname;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit address'),
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
                        if (str[0] != '9' && str[0] != '8' && str[0] != '7' && str[0] != '6')
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
                  tff(controller: hno, labelText: 'House No./Building Name', validator: null),
                  tff(controller: colony, labelText: 'Road Name/Area/Colony', validator: null),
                ],
              ),
            ),
            loading ? Center(child: CircularProgressIndicator()) : Container(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.065,
            child: RaisedButton(
                color: Colors.green,
                child: Text(
                  "Update Address",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
                      roadname: colony.text,
                    );
                    bool t = await editAddress(
                      token: Provider.of<CustomerDetailsProvider>(context, listen: false).token,
                      addressModel: ad,
                      mobile: Provider.of<CustomerDetailsProvider>(context, listen: false).phoneNumber,
                      addressIndex: widget.addressIndex,
                    );
                    if (t)
                      Navigator.pop(context);
                    else
                      showToast(msg: 'Error while editing');
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
