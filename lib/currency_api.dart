import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CurrencyApi {
  dynamic fromCurrencyName;
  dynamic toCurrencyName;
  dynamic rate = 0.0;
  dynamic error = '';

  CurrencyApi(this.fromCurrencyName, this.toCurrencyName);

  Future<void> fetchExchangeRate() async {
    try {
      final exchangeRate = await exchangeRates();
      if (exchangeRate != {}){
        rate = exchangeRate[toCurrencyName] ?? 0.0;
      } else{
        rate = 0;
      }
    } catch (e) {
      error = e;
      rate = 0.0;
    }
  }

  Future<Map<String, dynamic>> exchangeRates() async {
    try {
      final url = Uri.https('open.er-api.com', '/v6/latest/$fromCurrencyName');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> decodedRate = convert.jsonDecode(response.body);
        return decodedRate['rates'];
      } else {
        error = 'Failed to load exchange rates. Status code: ${response.statusCode}';
        return {};
      }
    } catch (e) {
      error = e;
      rethrow;
    }
  }
}
