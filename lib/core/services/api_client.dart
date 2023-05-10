import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  final Uri currencyUrl = Uri.https("api.fastforex.io", "/currencies",
      {"api_key": "1bdf149f27-d1d5770bf8-ruduxf"});

  Future<List<String>> getCurrencies() async {
    http.Response res = await http.get(currencyUrl);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var list = body["currencies"];
      List<String> currencies = (list.keys).toList();
      return currencies;
    } else {
      throw Exception("Fialed to Connect to Api");
    }
  }

  Future<double> getRate(String from, String to) async {
    final Uri conversionUrl = Uri.https("api.fastforex.io", "/fetch-one",
        {"api_key": "1bdf149f27-d1d5770bf8-ruduxf", "from": from, "to": to});
    http.Response res = await http.get(conversionUrl);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var result = body["result"];
      double rate = result[to].toDouble();
      return rate;
    } else {
      throw Exception("Failed to connect to API");
    }
  }
}
