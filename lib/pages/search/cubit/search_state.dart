part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchAddCity extends SearchState {}

final class SearchRemoveCity extends SearchState {}
