import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  final Uri conversionUrl = Uri.https("api.fastforex.io", "/fetch-one",
      {"api_key": "1bdf149f27-d1d5770bf8-ruduxf"});
  final Uri currencyUrl = Uri.https("api.fastforex.io", "/currencies",
      {"api_key": "1bdf149f27-d1d5770bf8-ruduxf"});
  Future<List<String>> getCurrencies() async {
    http.Response res = await http.get(currencyUrl);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var list = body["currencies"];
      List<String> currencies = (list.keys).ToList();
      return currencies;
    } else {
      throw Exception("Fialed to Connect to Api");
    }
  }
}
