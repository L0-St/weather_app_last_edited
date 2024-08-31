import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:weather_app_last_edited/helpers/hive_helper.dart';
import 'package:weather_app_last_edited/pages/home/home_page.dart';
import 'package:weather_app_last_edited/pages/search/cubit/search_cubit.dart';

class MyCity extends StatelessWidget {
  const MyCity({super.key});

  @override
  Widget build(BuildContext context) {
    final _myCityController = TextEditingController();
    final cubit = context.read<SearchCubit>();
    return (HiveHelper.citiesList.isNotEmpty)
        ? const HomePage()
        : Scaffold(
            backgroundColor: const Color(0xFF462363),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 3,
                  ),
                  const Text(
                    "Search",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      // color: Colors.white,
                      gradient: const LinearGradient(
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
                          ]),
                    ),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: _myCityController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search",
                          hintStyle: const TextStyle(color: Colors.white),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              await cubit.getWeather(_myCityController.text);
                              await cubit.addCity(_myCityController.text);
                              Get.offAll(const HomePage());
                            },
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                ],
              ),
            ),
          );
  }
}
