class Countries {
  final String flagUrl;
  final String countryCode;
  final String countryName;

  Countries({
    required this.flagUrl,
    required this.countryCode,
    required this.countryName,
  });

  factory Countries.fromJson(Map<String, dynamic> json) {
    return Countries(
      flagUrl: json['flags'] != null ? json['flags']['png'] : null,
      countryCode: json['cca2'],
      countryName: json['name'] != null ? json['name']['common'] : null,
    );
  }
}
