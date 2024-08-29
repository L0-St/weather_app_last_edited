import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app_last_edited/pages/home/cubit/home_cubit.dart';
import 'package:weather_app_last_edited/pages/home/home_page.dart';
import 'package:weather_app_last_edited/pages/search/cubit/search_cubit.dart';
import 'package:weather_app_last_edited/pages/search/search_page.dart';

import 'helpers/api_helper/cubit/api_weather_cubit.dart';
import 'helpers/hive_helper.dart';
import 'models/weather_model.dart';

void main() async {
  // Ensures Flutter bindings are initialized

  await Hive.initFlutter();
  Hive.registerAdapter(WeatherModelAdapter());
  // Hive.registerAdapter(WeatherModelAdapter());
  var box = await Hive.openBox(HiveHelper.citiesBox);
  await HiveHelper.getAllCities(); // Now safe to retrieve data from the box

  // TODO : NoteApp with Hive
  // await Hive.initFlutter();
  // var box = await Hive.openBox(HiveHelpers.noteBox);
  // await HiveHelpers.getAllNotes();
  runApp(const WeatherApp()); // Run the app
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => ApiWeatherCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        theme: ThemeData(primarySwatch: Colors.red),
      ),
    );
  }
}
