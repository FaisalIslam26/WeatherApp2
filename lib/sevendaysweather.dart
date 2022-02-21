import 'package:flutter/material.dart';

class SevendaysWeather extends StatelessWidget {
  const SevendaysWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
