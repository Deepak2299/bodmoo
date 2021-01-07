
import 'package:bodmoo/models/partsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

String RECENTS_KEY = 'recents';
Future<List<PartsModel>>loadRecents()
async{
  SharedPreferences prefs = await  SharedPreferences.getInstance();
  List<String> recentsList  =  await prefs.getStringList(RECENTS_KEY);
  List<PartsModel>parts = [];
  for(int i=0;i<recentsList.length;i++)
    {
      parts.add(
      PartsModel.fromJson(recentsList[i]));
    }
  return parts;
}

