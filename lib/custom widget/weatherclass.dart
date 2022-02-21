class Weather {
  final String? description;
  final double? temp;
  final double? feelLikeTemp;
  final int? cloudiness;
  final DateTime? date;

  Weather(
      {this.description,
      this.temp,
      this.feelLikeTemp,
      this.cloudiness,
      this.date});

  static Weather fromDailyJson(dynamic current) {
    var cloudiness = current['clouds'];
    var weather = current['weather'][0];

    return Weather(
        cloudiness: cloudiness,
        temp: current['temp']['day'].toDouble(),
        date: DateTime.fromMillisecondsSinceEpoch(current['dt'] * 1000,
            isUtc: true),
        feelLikeTemp: current['feels_like']['day'].toDouble());
  }
}
