part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeUpdate extends HomeState {}

// TODO : add
final class HomeFirstUpdate extends HomeState {}
