import 'dart:convert';
import 'package:exchange_rate/data/currency_code_data.dart';
import 'package:exchange_rate/model/country.dart';
import 'package:http/http.dart' as http;


class ExchangeRateApi {
  Future<Map<String, dynamic>> getConversionRates(String query) async {
    Uri url = Uri.parse(
        'https://v6.exchangerate-api.com/v6/e0e83f5a913f435442001e3c/latest/$query');

    http.Response response = await http.get(url);
    String jsonString = response.body;

    Map<String, dynamic> json = jsonDecode(jsonString);
    if (json['conversion_rates'] == null) {
      return {};
    }
    Map<String, dynamic> conversionRates = json['conversion_rates'];
    return conversionRates;
  }

  Future<List<Country>> getNationalName() async {
    await Future.delayed(const Duration(seconds: 1));
    String jsonString = data; //currencyCodeJson.dart

    Iterable json = jsonDecode(jsonString);
    return json.map((e) => Country.fromJson(e)).toList();
  }
}