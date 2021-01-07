import 'package:bodmoo/models/partsModel.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String RECENTS_KEY = 'recents';
loadRecents({@required BuildContext context}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> recentsList = await prefs.getStringList(RECENTS_KEY);
  List<PartsModel> parts = [];
  for (int i = 0; i < recentsList.length; i++) {
    parts.add(PartsModel.fromJson(recentsList[i]));
  }
  Provider.of<CustomerDetailsProvider>(context, listen: false).recentPartsList =
      parts;
//  return parts;
}

SaveRecents({@required List<PartsModel> parts}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> recentsList = [];
  for (int i = 0; i < parts.length; i++) {
    recentsList.add(parts[i].toJson());
  }
  await prefs.setStringList(RECENTS_KEY, recentsList);
}
