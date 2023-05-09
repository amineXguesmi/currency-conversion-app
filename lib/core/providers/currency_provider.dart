import 'package:currency_conversion/core/services/api_client.dart';
import 'package:flutter/cupertino.dart';

class CurrencyProvider extends ChangeNotifier {
  List<String> currencies = [];
  get getCurrencies => currencies;
  ApiClient client = ApiClient();

  Future<bool> GetCurrencies() async {
    currencies = await client.getCurrencies();
    notifyListeners();
    return true;
  }
}
