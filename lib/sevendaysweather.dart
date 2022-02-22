import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weatherapp2/cache.dart';

class SevendaysWeather extends StatefulWidget {
  final time;
  final String? temp;
  final String? day;
  final String? urlImage;

  SevendaysWeather({this.time, this.temp, this.day, this.urlImage});

  @override
  State<SevendaysWeather> createState() => _SevendaysWeatherState();
}

class _SevendaysWeatherState extends State<SevendaysWeather> {
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Daily Weather",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ],
      ),
      body: FutureBuilder(
          initialData: cache,
          builder: (context, AsyncSnapshot) {
            weatherData = AsyncSnapshot.data as Map<String, dynamic>;
            return Column(children: [
              Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.shade400,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blue.withOpacity(0.5),
                        offset: Offset(0, 35),
                        spreadRadius: -25),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.network(
                          "http://openweathermap.org/img/w/${weatherData["daily"][0]["weather"][0]["icon"]}.png",
                          color: Colors.white,
                          height: 250,
                          width: 130,
                          scale: 1,
                        ),
                        Text(
                          "Tommorrow",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sunrise",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      " ${getTimeFromTimestamp(weatherData["daily"][0]["sunrise"])}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sunset",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      " ${getTimeFromTimestamp(weatherData["daily"][0]["sunset"])}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                GlowText(
                                  " ${convertTemp(weatherData["daily"][0]["temp"]["day"])}°",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "${weatherData["daily"][0]["weather"][0]["description"]}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.wind,
                              color: Colors.white,
                            ),
                            Text(
                              "${weatherData["daily"][0]["wind_speed"]}km/h",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Wind Speed",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              WeatherIcons.humidity,
                              color: Colors.white,
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${weatherData["daily"][0]["humidity"]}%",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Humidity",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              WeatherIcons.barometer,
                              color: Colors.white,
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${weatherData["daily"][0]["pressure"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Visibility",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(""),
                    title: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                              "Day: ${convertTemp(weatherData["daily"][0]["temp"]["day"])}°"),
                          Image.network(
                            "http://openweathermap.org/img/w/${weatherData["daily"][0]["weather"][0]["icon"]}.png",
                            color: Colors.white,
                            scale: 1,
                          ),
                          Text(
                              "${weatherData["daily"][0]["weather"][0]["description"]}"),
                        ],
                      ),
                    ),
                    subtitle: Text(
                        "Night: ${convertTemp(weatherData["daily"][0]["temp"]["night"])}°"),
                    trailing: Text(
                        "${getTimeFromTimestamp(weatherData["daily"][0]["dt"])}"),
                  );
                }),
              ),
            ]);
          }),
    );
  }
}
