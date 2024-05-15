class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  Weather(
      {required this.cityName,
      required this.temperature,
      required this.mainCondition});

  // factory : Mot clé permettant de faire un return avec un constructeur qui ne le permet pas de base.
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        temperature: json['main']['temp'],
        mainCondition: json['weather'][0]['main']
    );
  }
}
