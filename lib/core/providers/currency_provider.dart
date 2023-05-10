import 'package:currency_conversion/core/services/api_client.dart';
import 'package:flutter/foundation.dart';

class CurrencyProvider extends ChangeNotifier {
  List<String> currencies = [];
  get getCurrencies => currencies;
  ApiClient client = ApiClient();

  Future<bool> fetchCurrencies() async {
    try {
      currencies = await client.getCurrencies();
      notifyListeners();
      return true;
    } catch (e) {
      throw Exception(
          "Error occured while fetching api , please try again later");
    }
  }
}
