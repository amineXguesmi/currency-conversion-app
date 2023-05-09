import 'package:flutter/foundation.dart';

import '../models/conversion.dart';

class ArchiveProvier extends ChangeNotifier {
  List<Conversion> conversionList = [];

  List<Conversion> getList() {
    return conversionList;
  }

  void AddConversion(Conversion conversion) {
    conversionList.add(conversion);
    notifyListeners();
  }

  void deleteConversion(time) {
    conversionList.removeWhere((conversion) => conversion.time == time);
    notifyListeners();
  }
}
