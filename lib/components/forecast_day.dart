import 'package:flutter/material.dart';
import 'package:weather_app_last_edited/models/month_model.dart';
import 'package:weather_app_last_edited/models/weather_model.dart';

class ForecastDay extends StatelessWidget {
  ForecastDay({super.key, this.weatherModel, this.index});
  WeatherModel? weatherModel;
  int? index;
  @override
  Widget build(BuildContext context) {
    // double temp_day = ;
    return (weatherModel != null)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                MonthModel.getDayCast(
                    weatherModel!.forecastDays[index!]["date"])!,
                style: TextStyle(color: Colors.white),
              ),
              Image.network(
                  "http:${weatherModel!.forecastDays[index!]["day"]["condition"]["icon"]}"),
              Text(
                (index == 0)
                    ? "${weatherModel!.temp_now.toInt()}\u00B0"
                    : "${weatherModel!.forecastDays[index!]["day"]["avgtemp_c"].toInt()}\u00B0",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                " ${weatherModel!.forecastDays[index!]["day"]["maxwind_kph"]}\nkm/h",
                style: TextStyle(color: Colors.white),
              )
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Day 1",
                style: TextStyle(color: Colors.white),
              ),
              Image.network(
                  "http://cdn.weatherapi.com/weather/64x64/day/116.png"),
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
