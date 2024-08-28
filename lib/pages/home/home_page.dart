import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          backgroundColor: Colors.blue,
          appBar: AppBar(
            backgroundColor: Colors.blue,
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
          body: Center(
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
                  height: MediaQuery.sizeOf(context).height * 0.157,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFAAA5A5).withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ForecastDay(),
                      ForecastDay(),
                      ForecastDay(),
                      ForecastDay(),
                      ForecastDay(),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}

///\u2103
