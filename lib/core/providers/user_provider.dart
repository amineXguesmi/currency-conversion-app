import 'package:currency_conversion/core/providers/rate_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String userName = "";
  String defaultFrom = "";
  String defaultTo = "";
  RateProvider rateProvider = RateProvider();

  void changeSettings(String userName, String defaultFrom, String defaultTo) {
    this.userName = userName;
    this.defaultFrom = defaultFrom;
    this.defaultTo = defaultTo;
    notifyListeners();
  }

  Future<bool> setUsername(username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = username;
    prefs.setString("username", userName);
    notifyListeners();
    return true;
  }

  Future<bool> setDefaulftFrom(from) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    defaultFrom = from;
    prefs.setString("defaultFrom", defaultFrom);
    notifyListeners();
    return true;
  }

  Future<bool> setDefaultTo(to) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    defaultTo = to;
    prefs.setString("defaultTo", defaultTo);
    notifyListeners();
    return true;
  }

  Future<bool> getStorageData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString("username") ?? "USD";
    defaultFrom = prefs.getString("defaultFrom") ?? "USD";
    defaultTo = prefs.getString("defaultTo") ?? "USD";
    return true;
  }

  void swipeDefault() {
    String temp = defaultFrom;
    defaultFrom = defaultTo;
    defaultTo = temp;
    notifyListeners();
  }
}
