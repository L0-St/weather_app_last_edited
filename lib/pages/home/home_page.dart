import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_last_edited/helpers/hive_helper.dart';
import 'package:weather_app_last_edited/models/month_model.dart';
import 'package:weather_app_last_edited/pages/search/cubit/search_cubit.dart';

import '../../components/feature_data.dart';
import '../../components/forecast_day.dart';
import '../search/search_page.dart';
import 'cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    //TODO:add cubit for search
    final cubitSearch = context.read<SearchCubit>();

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        // TODO : check HiveHelper.citiesList
        return (HiveHelper.citiesList.isEmpty)
            ? SearchPage()
            : Scaffold(
                // backgroundColor: Color(0xFF301F4D),
                appBar: AppBar(
                  backgroundColor: const Color(0xFF301F4D),
                  title: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.01,
                      ),
                      Text(
                        cubit.weatherModel == null
                            ?
                            // TODO : add first cityName
                            HiveHelper.citiesList[0].cityName
                            : cubit.weatherModel!.cityName,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        //TODO:add update searchPage when open
                        cubitSearch.init();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchPage(
                                // updateUi: updateUi,
                                ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 28,
                      ),
                    )
                  ],
                ),
                body: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Color(0xFF301F4D),
                        Color(0xFF301F4D),
                        Color(0xFF301F4D),
                        Color(0xFF462363),
                        // Color(0xFF462363),
                        Color(0xFF462363),
                        // Color(0xFF020103),
                        Color(0xFF020103),
                        Color(0xFF020103)
                      ])),
                  child: Center(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Spacer(
                          flex: 2,
                        ),
                        Text(
                          cubit.weatherModel == null
                              ?
                              // TODO : add first date
                              MonthModel.getDayCast(HiveHelper
                                  .citiesList[0].forecastDays[0]["date"])!
                              : "${MonthModel.getFromApi(cubit.weatherModel)}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          cubit.weatherModel == null
                              ?
                              // TODO : Update date
                              "updated ${HiveHelper.citiesList[0].date}"
                              : "updated ${cubit.weatherModel!.date}",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        Image.network(
                          cubit.weatherModel == null
                              ?
                              // TODO : add image
                              HiveHelper.citiesList[0].image
                              : cubit.weatherModel!.image,
                        ),
                        Text(
                          cubit.weatherModel == null
                              ?
                              // TODO : add stateName
                              HiveHelper.citiesList[0].stateName
                              : cubit.weatherModel!.stateName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          cubit.weatherModel == null
                              ?
                              // TODO : add temp_now
                              "${HiveHelper.citiesList[0].temp_now.toInt()}\u00B0"
                              : "${cubit.weatherModel!.temp_now.toInt()}\u00B0",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        Container(
                          // color: Colors.green,
                          height: MediaQuery.sizeOf(context).height * 0.1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                FeatureData(
                                  icon: Icons.wb_sunny,
                                  propertyName: "Sunrise",
                                  percentage: cubit.weatherModel == null
                                      ?
                                      // TODO : add sunrise
                                      HiveHelper.citiesList[0].sunrise
                                      : cubit.weatherModel!.sunrise,
                                ),
                                FeatureData(
                                  icon: Icons.nights_stay_outlined,
                                  propertyName: "Sunset",
                                  percentage: cubit.weatherModel == null
                                      ?
                                      // TODO : add sunset
                                      HiveHelper.citiesList[0].sunset
                                      : cubit.weatherModel!.sunset,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          // color: Colors.red,
                          height: MediaQuery.sizeOf(context).height * 0.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FeatureData(
                                  icon: Icons.water_drop_outlined,
                                  propertyName: "Humidity",
                                  percentage: cubit.weatherModel == null
                                      ?
                                      // TODO : add humidity
                                      "${HiveHelper.citiesList[0].humidity}%"
                                      : "${cubit.weatherModel!.humidity}%"),
                              FeatureData(
                                  icon: CupertinoIcons.wind,
                                  propertyName: "Wind",
                                  percentage: cubit.weatherModel == null
                                      ?
                                      // TODO : add windSpeed
                                      "${HiveHelper.citiesList[0].windSpeed}km/h"
                                      : "${cubit.weatherModel!.windSpeed}km/h"),
                              FeatureData(
                                  icon: Icons.thermostat_outlined,
                                  propertyName: "Feals like",
                                  percentage: cubit.weatherModel == null
                                      ?
                                      // TODO : add feelsLike
                                      "${HiveHelper.citiesList[0].feelsLike.toInt()}\u00B0"
                                      : "${cubit.weatherModel!.feelsLike.toInt()}\u00B0"),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          height: MediaQuery.sizeOf(context).height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFFAAA5A5).withOpacity(0.4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (c, i) => (cubit.weatherModel !=
                                      null)
                                  ? ForecastDay(
                                      index: i,
                                      weatherModel: cubit.weatherModel,
                                    )
                                  : ForecastDay(
                                      // TODO : forecastDays
                                      index: i,
                                      weatherModel: HiveHelper.citiesList[0],
                                    ),
                              separatorBuilder: (c, i) => SizedBox(
                                  // width: MediaQuery.sizeOf(context).width * 0.001,
                                  ),
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}

///\u2103
