part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchAddCity extends SearchState {}

final class SearchRemoveCity extends SearchState {}

// TODO: add
final class SearchUpdateCities extends SearchState {}

// TODO: add api state
final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {}

final class SearchError extends SearchState {}
