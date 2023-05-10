import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/conversion.dart';

class ArchiveProvier extends ChangeNotifier {
  List<Conversion> conversionList = [];

  Future<bool> loadList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("archive") != null) {
      String? stringArchive = prefs.getString("archive");
      List conversionL = jsonDecode(stringArchive!);
      for (var conversion in conversionL) {
        conversionList.add(Conversion.fromJson(conversion));
      }
    }
    notifyListeners();
    return true;
  }

  Future<bool> addConversion(Conversion conversion) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    conversionList.add(conversion);
    List archive = conversionList.map((e) => e.toJson()).toList();
    prefs.setString("archive", jsonEncode(archive));
    notifyListeners();
    return true;
  }

  Future<bool> deleteConversion(time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    conversionList.removeWhere((conversion) => conversion.time == time);
    List archive = conversionList.map((e) => e.toJson()).toList();
    prefs.setString("archive", jsonEncode(archive));
    notifyListeners();
    return true;
  }
}
