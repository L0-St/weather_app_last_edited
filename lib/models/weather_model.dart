import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:weather_app_last_edited/components/forecast_day.dart';
part 'weather_model.g.dart';

@HiveType(typeId: 0)
class WeatherModel extends HiveObject {
  @HiveField(0)
  String cityName;
  @HiveField(1)
  String stateName;
  @HiveField(2)
  String image;
  @HiveField(3)
  double temp_now;
  @HiveField(4)
  int humidity;
  @HiveField(5)
  double feelsLike;
  @HiveField(6)
  double windSpeed;
  @HiveField(7)
  double temp_day;
  @HiveField(8)
  String date;
  @HiveField(9)
  List forecastDays;
  @HiveField(10)
  String sunset;
  @HiveField(11)
  String sunrise;
  WeatherModel({
    required this.cityName,
    required this.stateName,
    required this.temp_now,
    required this.humidity,
    required this.windSpeed,
    required this.feelsLike,
    required this.image,
    required this.temp_day,
    required this.date,
    required this.forecastDays,
    required this.sunrise,
    required this.sunset,
  });

  static WeatherModel getWeatherModel(Map json) {
    var day = json["forecast"]["forecastday"][0]["day"];
    return WeatherModel(
      cityName: json["location"]["name"],
      stateName: day["condition"]["text"],
      temp_day: day["avgtemp_c"],
      humidity: json["current"]["humidity"],
      windSpeed: day["maxwind_kph"],
      feelsLike: json["current"]["feelslike_c"],
      image: "http:" + day["condition"]["icon"],
      temp_now: json["current"]["temp_c"],
      date: json["location"]["localtime"],
      forecastDays: json["forecast"]["forecastday"],
      sunrise: json["forecast"]["forecastday"][0]["astro"]["sunrise"],
      sunset: json["forecast"]["forecastday"][0]["astro"]["sunset"],
    );
  }
}
