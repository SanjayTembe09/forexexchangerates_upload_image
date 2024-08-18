class ExchangeRate {
  final String base;
  final Map<String, double> conversionRates;

  ExchangeRate({required this.base, required this.conversionRates});

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    return ExchangeRate(
      base: json['base_code'],
      conversionRates: json['conversion_rates']
          .cast<String, dynamic>()
          .map((key, value) => MapEntry(key, value as double))
          .toMap(),
    );
  }
}
