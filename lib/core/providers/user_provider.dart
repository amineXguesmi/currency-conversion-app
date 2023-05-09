import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  String userName = "";
  String defaultFrom = "";
  String defaultTo = "";

  void ChangeSettings(String userName, String defaultFrom, String defaultTo) {
    this.userName = userName;
    this.defaultFrom = defaultFrom;
    this.defaultTo = defaultTo;
    notifyListeners();
  }

  void setUsername(username) {
    this.userName = username;
    notifyListeners();
  }

  void setDefaulftFrom(from) {
    this.defaultFrom = from;
    notifyListeners();
  }

  void setDefaultTo(to) {
    this.defaultTo = to;
    notifyListeners();
  }
}
