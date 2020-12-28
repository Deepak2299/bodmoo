import 'package:bodmoo/Screens/drawer/myAddresses/editAddressScreen.dart';
import 'package:bodmoo/models/addressModel.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String IMAGE = 'assets/bike.png';
final Color flipkartBlue = new Color(0XFF2874f0);
final OutlineInputBorder fieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.0),
    gapPadding: 2,
    borderSide:
        BorderSide(width: 1.8, color: flipkartBlue, style: BorderStyle.solid));
final OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.0),
    gapPadding: 2,
    borderSide: BorderSide(
        width: 1.8, color: Colors.redAccent, style: BorderStyle.solid));

pwdValidator(String pwd) {
  pwd = pwd.trim();
  if (pwd.isEmpty)
    return "Enter Password";
  else {
    if (pwd.length < 6) {
      return 'Minimum password length must be 6';
    }
  }
}

addressWidget({@required AddressModel addressModel}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 10),
      Text(
        addressModel.customerName.toString(),
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 10),
      Text(addressModel.houseno + ", " + addressModel.roadname + ","),
      Text(addressModel.city + ","),
      Text(addressModel.state + " " + (addressModel.pincode ?? '')),
      SizedBox(height: 10),
      Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Phone number : ",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
          Text(addressModel.customerMobile.toString(),
              style: TextStyle(
                color: Colors.black,
              )),
        ],
      ),
      // Text(addressModel.pincode ?? ''),
    ],
  );
}

String prepareAddress({@required AddressModel addressModel}) {
  return addressModel.houseno +
      "," +
      addressModel.roadname +
      "," +
      addressModel.city +
      "," +
      addressModel.state;
}

class LoadingWidget extends StatelessWidget {
  String msg;
  LoadingWidget({@required this.msg});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              msg ?? 'Loading',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 20),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class EditAddressButton extends StatelessWidget {
  int i;
  AddressModel addressModel;
  EditAddressButton({@required this.i, @required this.addressModel});
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        borderOnForeground: true,
        child: FlatButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => EditAddressScreen(
                          addressIndex: i,
                          addressModel: addressModel,
                        )));
          },
          child: Text(
            "Edit",
            style: TextStyle(color: flipkartBlue),
          ),
        ));
  }
}

cardWidget({@required List<Widget> children}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
    child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5))),
        elevation: 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        )),
  );
}

Widget indicator(bool isActive) {
  return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.blue : Colors.grey,
      ),
      height: 10,
      width: 10,
      margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 5));

  // return AnimatedContainer(
  //   duration: Duration(milliseconds: 500),
  //   margin: EdgeInsets.symmetric(horizontal: 8.0),
  //   height: 8.0,
  //   width: isActive ? 16.0 : 8.0,
  //   decoration: BoxDecoration(
  //     color: isActive ? Colors.blue : Colors.grey,
  //     borderRadius: BorderRadius.all(Radius.circular(12)),
  //   ),
  // );
}
