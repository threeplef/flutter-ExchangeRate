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
    String findCountry = '';
    countries
        .where((e) => e.currencyCode == query)
        .toList()
        .forEach((e) {
      findCountry = e.country;
    });
    return findCountry;
  }

  String findImageUrl(String query) {
    String imageUrl = '';
    countries
        .where((e) => e.currencyCode == query)
        .toList()
        .forEach((e) {
      imageUrl = e.imageUrl;
    });
    return imageUrl;
  }
}