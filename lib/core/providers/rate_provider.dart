import 'package:currency_conversion/core/services/api_client.dart';
import 'package:flutter/foundation.dart';

class RateProvider extends ChangeNotifier {
  double rate = 0;
  get getRate => rate;
  ApiClient client = ApiClient();

  Future<bool> fetchRate(from, to) async {
    try {
      rate = await client.getRate(from, to);
      notifyListeners();
      return true;
    } catch (e) {
      throw Exception(
          "Error occured while fetching api , please try again later");
    }
  }
}
