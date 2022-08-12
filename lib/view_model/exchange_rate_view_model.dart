import 'package:exchange_rate/api/exchange_rate_api.dart';
import 'package:exchange_rate/model/country.dart';
import 'package:flutter/material.dart';

class ExchangeRateViewModel extends ChangeNotifier {
  final _exchangeRateApi = ExchangeRateApi();

  Map<String, dynamic> conversionRates = {};
  List<String> rates = [];
  List<Country> countries = [];

  Future fetchConversionRates(String query) async {
    conversionRates = await _exchangeRateApi.getConversionRates(query);
    rates = conversionRates.keys.toList();
    countries = await _exchangeRateApi.getNationalName();
    notifyListeners();
  }

  String findCountryName(String query) {
    String countryName = '';
    countries
        .where((element) => element.currencyCode == query)
        .toList()
        .forEach((element) {
      countryName = element.country;
    });
    return countryName;
  }

  String findImageUrl(String query) {
    String imageUrl = '';
    countries
        .where((element) => element.currencyCode == query)
        .toList()
        .forEach((element) {
      imageUrl = element.imageUrl;
    });
    return imageUrl;
  }
}