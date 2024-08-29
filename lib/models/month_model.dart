import 'package:intl/intl.dart';
import 'package:weather_app_last_edited/models/weather_model.dart';

class MonthModel {
  static String? fullDate;
  static int? day;
  static String? getFromApi(WeatherModel? weatherModel) {
    switch (DateTime.parse(weatherModel!.date).month) {
      case 1:
        fullDate = "Jan";
        break;
      case 2:
        fullDate = "Feb";
        break;
      case 3:
        fullDate = "Mar";
        break;
      case 4:
        fullDate = "Apr";
        break;
      case 5:
        fullDate = "May";
        break;
      case 6:
        fullDate = "Jun";
        break;
      case 7:
        fullDate = "Jul";
        break;
      case 8:
        fullDate = "Aug";
        break;
      case 9:
        fullDate = "Sep";
        break;
      case 10:
        fullDate = "Oct";
        break;
      case 11:
        fullDate = "Nov";
        break;
      case 12:
        fullDate = "Dec";
        break;
    }
    day = DateTime.parse(weatherModel.date).day;
    if (day! < 10) {
      fullDate = fullDate! + " 0" + day.toString();
    } else {
      fullDate = fullDate! + " " + day.toString();
    }

    return fullDate;
  }

  static String? getDayCast(String date) {
    DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
    String formattedDate = DateFormat('MMM d').format(parsedDate);

    return formattedDate;
  }
}
