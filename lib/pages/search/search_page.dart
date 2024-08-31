import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:weather_app_last_edited/pages/home/home_page.dart';
import '../../helpers/api_helper/cubit/api_weather_cubit.dart';
import '../../helpers/hive_helper.dart';
import '../home/cubit/home_cubit.dart';
import 'cubit/search_cubit.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController _cityNameController = TextEditingController();

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return Scaffold(
      backgroundColor: const Color(0xFF262171),
      appBar: AppBar(
        backgroundColor: const Color(0xFF262171),
        leading: IconButton(
          onPressed: () {
            // TODO : update project
            if (HiveHelper.citiesList.isNotEmpty) {
              Get.back();
            } else if (HiveHelper.citiesList.length == 1) {
              Get.to(HomePage());
            }
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        // backgroundColor: const Color(0xFF),
        title: const Text(
          "Saved Locations",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _cityNameController.text = "";
                showAlertDialog(context, cubit: cubit);
              },
              icon: const Icon(
                // size: 28,
                Icons.search,
                color: Colors.white,
              ))
        ],
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return ListView.builder(
            // physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: HiveHelper.citiesList.length,
            itemBuilder: (context, index) => (index != 0)
                ? Slidable(
                    endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        // dismissible: DismissiblePane(onDismissed: () {}),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              cubit.removeCity(index);
                              // setState(() {});
                            },
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ]),
                    child: _buildCityContainer(index, context: context),
                  )
                : _buildCityContainer(index, context: context),
          );
        },
      ),
    );
  }

  Widget _buildCityContainer(
    int index, {
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () {
        context.read<HomeCubit>().updateUi(index);
        print(
          "=============>${context.read<HomeCubit>().weatherModel?.cityName ?? "City one"}",
        );
        // TODO : update project
        if (HiveHelper.citiesList.isNotEmpty) {
          Get.back();
        } else if (HiveHelper.citiesList.length == 1) {
          Get.to(HomePage());
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        height: 165,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFAAA5A5).withOpacity(0.5),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      HiveHelper.citiesList[index].cityName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      HiveHelper.citiesList[index].stateName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Image.network(HiveHelper.citiesList[index].image),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Humidity ${HiveHelper.citiesList[index].humidity.toInt()}%",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        // fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Wind ${HiveHelper.citiesList[index].windSpeed}km/h",
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  "${HiveHelper.citiesList[index].temp_now.toInt()}\u00B0",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, {required SearchCubit cubit}) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text(
        "OK",
        style: TextStyle(
            // color: Colors.white,
            ),
      ),
      onPressed: () async {
        context.read<ApiWeatherCubit>().getWeather();
        await cubit.getWeather(_cityNameController.text);
        await cubit.addCity(_cityNameController.text);
        // setState(() {});
        //TODO : use Getx to navigation
        // Navigator.pop(context);
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Container(
        decoration: BoxDecoration(
          // color: Color(0xFF262171),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextFormField(
          controller: _cityNameController,
          decoration: const InputDecoration(
            // label: Text("Search"),
            hintText: "Search",
            hintStyle: TextStyle(
                // color: Colors.white,
                ),
            border: InputBorder.none,
          ),
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
