class Country {
  final String currencyCode;
  final String currencyName;
  final String country;
  final String imageUrl;

  Country({
    required this.currencyCode,
    required this.currencyName,
    required this.country,
    required this.imageUrl,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      currencyCode: json['currencyCode'] as String,
      currencyName: json['currencyName'] as String,
      country: json['country'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
