import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:weatherapp2/custom%20widget/Extraweather.dart';
import 'package:weatherapp2/custom%20widget/todayweather.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 600,
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
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                              "Dhaka",
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
                    Image.asset(
                      "assets/images/thunder_2d.png",
                      scale: 1,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: Column(
                          children: [
                            GlowText(
                              "21°",
                              style: TextStyle(
                                  color: Colors.white,
                                  height: 0.1,
                                  fontSize: 130,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Thunderstorm",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Sunday, 20 Feb",
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
                            ExtraWeather(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
