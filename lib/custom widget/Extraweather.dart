import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExtraWeather extends StatelessWidget {
  const ExtraWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            FaIcon(
              FontAwesomeIcons.wind,
              color: Colors.white,
            ),
            Text(
              "13km/h",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            Text(
              "Wind",
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
              "24%",
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
              "Chance of Rain",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            Text(
              "Wind",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
