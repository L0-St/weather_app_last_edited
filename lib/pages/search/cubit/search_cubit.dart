import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import '../../../helpers/hive_helper.dart';
import '../../../models/weather_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  final _dio = Dio();
  late Map<String, dynamic> tempList;
  Future<void> getWeather(String c_name) async {
    final response = await _dio.get(
        "https://api.weatherapi.com/v1/forecast.json?key=c41fcb3ab8554f4ab0d45621242008&q=${c_name}&days=5&aqi=no&alerts=no");
    print("#" * 50);
    if (response.statusCode == 200) {
      print(response.data);
      tempList = response.data;
    }
  }

  Future<void> addCity(String text) async {
    await getWeather(text);
    // var day = tempList!["forecast"]["forecastday"][0]["day"];
    print("===========> City added ");
    HiveHelper.addCity(WeatherModel.getWeatherModel(tempList));
    emit(SearchAddCity());
  }

  void removeCity(int index) {
    HiveHelper.removeCity(index);
    emit(SearchRemoveCity());
  }

  // TODO: add
  void init() {
    print("=====================> Initial State");
    HiveHelper.updateAllCities();
    emit(SearchUpdateCities());
  }
}
