import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_last_edited/helpers/hive_helper.dart';
import 'package:weather_app_last_edited/models/month_model.dart';

import '../../components/feature_data.dart';
import '../../components/forecast_day.dart';
import '../../models/weather_model.dart';
import '../search/search_page.dart';
import 'cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xFF301F4D),
          appBar: AppBar(
            backgroundColor: Color(0xFF301F4D),
            title: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 28,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.01,
                ),
                Text(
                  cubit.weatherModel == null
                      ? "Paris"
                      : cubit.weatherModel!.cityName,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  var push = Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(
                            // updateUi: updateUi,
                            ),
                      ));
                },
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 28,
                ),
              )
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
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
                  Spacer(
                    flex: 2,
                  ),
                  Text(
                    cubit.weatherModel == null
                        ? "June 07"
                        : "${MonthModel.getFromApi(cubit.weatherModel)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    cubit.weatherModel == null
                        ? "updated 7/6/2023 4:55 pm "
                        : "updated ${cubit.weatherModel!.date}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Image.network(
                    cubit.weatherModel == null
                        ? "http://cdn.weatherapi.com/weather/64x64/day/116.png"
                        : cubit.weatherModel!.image,
                  ),
                  Text(
                    cubit.weatherModel == null
                        ? "Clear"
                        : cubit.weatherModel!.stateName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    cubit.weatherModel == null
                        ? "30\u00B0"
                        : "${cubit.weatherModel!.temp_now.toInt()}\u00B0",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Container(
                    // color: Colors.green,
                    height: MediaQuery.sizeOf(context).height * 0.09,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FeatureData(
                            icon: Icons.wb_sunny,
                            propertyName: "Sunrise",
                            percentage: cubit.weatherModel == null
                                ? "05:32 AM"
                                : cubit.weatherModel!.sunrise,
                          ),
                          FeatureData(
                            icon: Icons.nights_stay_outlined,
                            propertyName: "Sunset",
                            percentage: cubit.weatherModel == null
                                ? "05:32 AM"
                                : cubit.weatherModel!.sunset,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
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
                                ? "47%"
                                : "${cubit.weatherModel!.humidity}%"),
                        FeatureData(
                            icon: CupertinoIcons.wind,
                            propertyName: "Wind",
                            percentage: cubit.weatherModel == null
                                ? "4.53km/h"
                                : "${cubit.weatherModel!.windSpeed}km/h"),
                        FeatureData(
                            icon: Icons.thermostat_outlined,
                            propertyName: "Feals like",
                            percentage: cubit.weatherModel == null
                                ? "30"
                                : "${cubit.weatherModel!.feelsLike.toInt()}\u00B0"),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    height: MediaQuery.sizeOf(context).height * 0.174,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xFFAAA5A5).withOpacity(0.4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (c, i) => (cubit.weatherModel != null)
                            ? ForecastDay(
                                index: i,
                                weatherModel: cubit.weatherModel,
                              )
                            : ForecastDay(),
                        separatorBuilder: (c, i) => SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.04,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
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
