import 'package:dio/dio.dart';

class ApiHelper {
  static final _dio = Dio();
  static void getWeather() async {
    final response = await _dio.get(
        "https://api.weatherapi.com/v1/forecast.json?key=c41fcb3ab8554f4ab0d45621242008&q=Ashmun&days=1&aqi=no&alerts=no");
    print("#" * 50);
    print(response);
  }
}
