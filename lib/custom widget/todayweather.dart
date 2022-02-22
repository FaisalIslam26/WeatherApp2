import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weatherapp2/cache.dart';

class TodaysWeather extends StatefulWidget {
  final String? lebel;
  final String? imageName;
  final String? temp;
  final bool primary;
  final Color? color;

  TodaysWeather(
      {Key? key,
      this.lebel,
      this.imageName,
      this.temp,
      this.primary = false,
      this.color})
      : super(key: key);

  @override
  State<TodaysWeather> createState() => _TodaysWeatherState();
}

class _TodaysWeatherState extends State<TodaysWeather> {
  final String baseUrl = "https://api.openweathermap.org/";
  final String apiKey = "f93e1a3255ce8fcd8e0a0090643d493c";
  final String lat = "23.777176";
  final String lon = "90.399452";

  final String api = "data/2.5/onecall?";

  Map weatherData = {};
  Future<Map<String, dynamic>> getWeather() async {
    final response = await http.get(Uri.parse(baseUrl +
        api +
        "lat=$lat" +
        "&" +
        "lon=$lon" +
        "&exclude=minutely" +
        "&appid=$apiKey"));
    if (response.statusCode == 200) {
      return weatherData = jsonDecode(response.body);
    }
    return <String, dynamic>{"failed": true};
  }

  @override
  void initState() {
    super.initState();
  }

  int convertTemp(temp) {
    int result = (temp - 273).toInt();
    return result;
  }

  String getTimeFromTimestamp(int timestamp) {
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = new DateFormat('h:mm a');
    return formatter.format(date);
  }

  String getDateFromTimestamp(int timestamp) {
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = new DateFormat('E');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        initialData: cache,
        builder: (context, AsyncSnapshot) {
          weatherData = AsyncSnapshot.data as Map<String, dynamic>;

          return Container(
            width: 92,
            height: 132,
            decoration: BoxDecoration(
              color: widget.primary ? null : Colors.white,
              gradient: widget.primary
                  ? LinearGradient(
                      colors: [Colors.redAccent, Colors.lightBlue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)
                  : null,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${widget.temp}",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: widget.primary ? Colors.white : Colors.black),
                ),
                Image.network(
                  "http://openweathermap.org/img/w/${weatherData["hourly"][0]["weather"][0]["icon"]}.png",
                  scale: 1,
                ),
                Text(
                  "${widget.lebel}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: widget.primary ? Colors.white : Colors.black),
                ),
              ],
            ),
          );
        });
  }
}
