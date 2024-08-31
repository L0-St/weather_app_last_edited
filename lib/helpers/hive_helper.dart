import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../models/weather_model.dart';

class HiveHelper {
  static List citiesList = [];
  static const citiesBox = "citiesBox";
  static const citiesBoxKey = "citiesBoxKey";
  static var box = Hive.box(citiesBox);

  static void addCity(WeatherModel weatherModel) {
    citiesList.add(weatherModel);
    box.put(citiesBoxKey, citiesList);
    print("=======================>${citiesList.length}");
  }

  static void removeCity(int index) {
    citiesList.removeAt(index);
    box.put(citiesBoxKey, citiesList);
    print("=======================>${citiesList.length}");
  }

  static Future<void> getAllCities() async {
    if (box.get(citiesBoxKey) != null) {
      citiesList = await box.get(citiesBoxKey);
    }
    print("=======================>${citiesList.length}");
  }

  // TODO: add +  /// TODO: Future
  static final _dio = Dio();
  static late Map<String, dynamic> tempList;
  static Future<void> getWeather(String c_name) async {
    final response = await _dio.get(
        "https://api.weatherapi.com/v1/forecast.json?key=c41fcb3ab8554f4ab0d45621242008&q=${c_name}&days=5&aqi=no&alerts=no");
    print("#" * 50);
    if (response.statusCode == 200) {
      print(response.data);
      tempList = response.data;
    }
  }

  static Future<void> updateAllCities() async {
    if (citiesList.isNotEmpty) {
      for (var i = 0; i < citiesList.length; i++) {
        await getWeather(citiesList[i].cityName);
        citiesList[i] = WeatherModel.getWeatherModel(tempList);
        box.put(citiesBoxKey, citiesList);
      }
    }
  }

  // TODO : update my city
  static void updateMyCity() async {
    if (citiesList.isNotEmpty) {
      await getWeather(citiesList[0].cityName);
      citiesList[0] = WeatherModel.getWeatherModel(tempList);
      box.put(citiesBoxKey, citiesList);
    }
  }
}

/*
WeatherModel(
          cityName: text,
          stateName: "Clear",
          temperature: 30,
          humidity: 47,
          windSpeed: 4.17,
          feelsLike: 30,
          image: 'http://cdn.weatherapi.com/weather/64x64/day/296.png'),
    )
* */
