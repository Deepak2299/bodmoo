import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Model {
  Model({
    this.email,
    this.pwd,
    this.login,
  });

  String email;
  String pwd;
  bool login;

  factory Model.fromJson(String str) => Model.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Model.fromMap(Map<String, dynamic> json) => Model(
        email: json["email"] == null ? null : json["email"],
        pwd: json["pwd"] == null ? null : json["pwd"],
        login: json["login"] == null ? null : json["login"],
      );

  Map<String, dynamic> toMap() => {
        "email": email == null ? null : email,
        "pwd": pwd == null ? null : pwd,
        "login": login == null ? false : login,
      };
}

Future<bool> method({
  @required String inputEmail,
  @required String inputPwd,
}) async {
  print(inputPwd + inputEmail);

  Firestore firestore = Firestore.instance;
  CollectionReference users = Firestore.instance.collection('users');

  QuerySnapshot snapshot = await users.getDocuments();
  int index = -1;
  index = snapshot.documents.indexWhere((element) {
    Model model = Model.fromMap(element.data);
    if (model.email == inputEmail) return true;
    return false;
  }, 0);

  if (index != -1) {
    users.document(snapshot.documents[index].documentID).setData(
          Model(email: inputEmail, pwd: inputPwd, login: (Model.fromMap(snapshot.documents[index].data)).login).toMap(),
        );
    return (Model.fromMap(snapshot.documents[index].data)).login;
  } else {
    users.add(Model(login: false, email: inputEmail, pwd: inputPwd).toMap());
    return false;
  }
}
