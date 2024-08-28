import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'api_weather_state.dart';

class ApiWeatherCubit extends Cubit<ApiWeatherState> {
  ApiWeatherCubit() : super(ApiWeatherInitial());

  final _dio = Dio();
  Map<String, dynamic>? tempLest;
  void getWeather() async {
    final response = await _dio.get(
        "https://api.weatherapi.com/v1/forecast.json?key=c41fcb3ab8554f4ab0d45621242008&q=Ashmun&days=1&aqi=no&alerts=no");
    print("#" * 50);
    if (response.statusCode == 200) {
      // print(response);
      tempLest = response.data;
      emit(ApiWeatherSuccess());
    }
  }
}
