import 'package:flutter/material.dart';

class TodaysWeather extends StatelessWidget {
  final bool? hasDivider;
  final String? imageName;
  final String? temp;
  final String? day;
  final String? date;
  final String? time;

  TodaysWeather(
      {Key? key,
      this.hasDivider,
      this.date,
      this.day,
      this.time,
      this.imageName,
      this.temp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/$imageName.png",
          width: 150,
          height: 75,
        ),
        Text(
          "$temp°",
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Text(
          "$time",
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
