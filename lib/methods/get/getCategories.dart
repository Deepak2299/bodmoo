import 'dart:convert';

import 'package:bodmoo/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getCategories() async {
  print('GET CATG');
  print(GET_CATG_URL);
  List<dynamic> catg = [];

  var req = await http.get(GET_CATG_URL, headers: {'Content-type': 'application/json'});
  print(req.body);
  if (req.statusCode != 200) {
//    ScreenErrorData.catgError = jsonDecode(req.body)['message'];
//    print("200:" + ScreenErrorData.catgError);
  } else
//    ScreenErrorData.catgError = '';
    catg = json.decode(req.body)["output"];
  print(catg);
  return catg;
}
