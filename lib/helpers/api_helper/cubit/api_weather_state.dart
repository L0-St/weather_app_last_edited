part of 'api_weather_cubit.dart';

@immutable
sealed class ApiWeatherState {}

final class ApiWeatherInitial extends ApiWeatherState {}

final class ApiWeatherLoading extends ApiWeatherState {}

final class ApiWeatherSuccess extends ApiWeatherState {}

final class ApiWeatherError extends ApiWeatherState {}
