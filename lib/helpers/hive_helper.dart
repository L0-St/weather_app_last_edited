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
