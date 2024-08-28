import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../helpers/hive_helper.dart';
import '../../../models/weather_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  WeatherModel? weatherModel;

  void updateUi(int index) {
    weatherModel = HiveHelper.citiesList[index];
    emit(HomeUpdate());
  }
}
