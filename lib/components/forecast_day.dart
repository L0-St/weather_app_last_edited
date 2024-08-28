import 'package:flutter/material.dart';

class ForecastDay extends StatelessWidget {
  ForecastDay({super.key});
  static List forecastDays = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Day 1",
          style: TextStyle(color: Colors.white),
        ),
        Image.network("http://cdn.weatherapi.com/weather/64x64/day/116.png"),
        Text(
          "30\u00B0",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          "  1-5\n km/h",
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
