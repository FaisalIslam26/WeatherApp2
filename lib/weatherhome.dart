import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'custom widget/todayweather.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String baseUrl = "https://api.openweathermap.org/";
  final String apiKey = "f93e1a3255ce8fcd8e0a0090643d493c";
  final String lat = "23.777176";
  final String lon = "90.399452";

  final String api = "data/2.5/onecall?";

  Map weatherData = {};
  Future getWeather() async {
    final response = await http.get(Uri.parse(baseUrl +
        api +
        "lat=$lat" +
        "&" +
        "lon=$lon" +
        "&exclude=minutely" +
        "&appid=$apiKey"));
    if (response.statusCode == 200) {
      setState(() {
        weatherData = jsonDecode(response.body);
      });
    }
  }

  @override
  void initState() {
    getWeather();

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
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 500,
                padding: EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.cyan,
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.grid_view_rounded,
                            color: Colors.white,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                              Text(
                                "${weatherData["timezone"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.2, color: Colors.white),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Updating",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                      Image.network(
                        "http://openweathermap.org/img/w/${weatherData["current"]["weather"][0]["icon"]}.png",
                        color: Colors.white,
                        scale: 1,
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, top: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GlowText(
                                  "${convertTemp(weatherData["current"]["temp"])}°",
                                  style: TextStyle(
                                      color: Colors.white,
                                      height: 0.1,
                                      fontSize: 130,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Feels Like",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${convertTemp(weatherData["current"]["feels_like"])}°",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "${weatherData["current"]["weather"][0]["description"]}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${getTimeFromTimestamp(weatherData["current"]["dt"])}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.wind,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "${weatherData["current"]["wind_speed"]}km/h",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
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
                                        FaIcon(
                                          FontAwesomeIcons.cloudRain,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "${weatherData["current"]["humidity"]}%",
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
                                        FaIcon(
                                          FontAwesomeIcons.wind,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "${weatherData["current"]["visibility"]}",
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Todays Weather",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Row(
                  children: [
                    Text(
                      "7days",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    TodaysWeather(
                      hasDivider: index < 6 ? true : false,
                      temp: "${convertTemp(weatherData["hourly"][0]["temp"])}",
                      imageName: 'snow',
                      time:
                          "${getTimeFromTimestamp(weatherData["hourly"][1]["dt"])}",
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
